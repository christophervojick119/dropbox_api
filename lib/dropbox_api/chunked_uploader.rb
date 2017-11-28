module DropboxApi
  # Creates a new file.
  #
  # @example
  #   client = DropboxApi::Client.new
  #   file_object = File.open("local_image.png", 'r')
  #   uploader = DropboxApi::ChunkedUploader.new(client, file_object)
  #   uploader.upload
  #   uploader.finish("image.png")
  #   #=> #<DropboxApi::Metadata::File: @name="image.png" ...>
  # @param client [DropboxApi::Client] Api client
  # @param file_object [File] File object that will be uploaded
  class ChunkedUploader
    attr_accessor :file_object, :total_size, :cursor, :client

    def initialize(client, file_object)
      @client = client
      @file_object = file_object
      @total_size = file_object.stat.size
      @cursor = nil
    end

    # Uploads data from this ChunkedUploader's file_object in chunks, until
    # an error occurs. Throws an exception when an error occurs, and can
    # be called again to resume the upload.
    #
    # @param chunk_size [Integer] The chunk size for each individual upload.  Defaults to 4MB.
    def upload(chunk_size = 4*1024*1024)
      chunk = file_object.read(chunk_size)
      @cursor = client.upload_session_start(chunk)

      while cursor.offset < total_size
        begin
          chunk = file_object.read(chunk_size)
          client.upload_session_append_v2(cursor, chunk)
        rescue StandardError => error
          raise DropboxApi::Errors::ChunkedUploaderError, error
        end
      end
    end

    # Completes a file upload
    #
    # Args:
    # @param path [String] The directory path to upload the file to. If the destination
    # directory does not yet exist, it will be created.
    # @param mode [String]
    def finish(path, mode = 'overwrite')
      commit = DropboxApi::Metadata::CommitInfo.new({
        'path' => path,
        'mode' => mode
      })
      client.upload_session_finish(cursor, commit)
    end
  end
end

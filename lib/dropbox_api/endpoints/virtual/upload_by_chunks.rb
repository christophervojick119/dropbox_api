module DropboxApi
  class Client
    # TODO: Documentation pending...
    #
    # @!group virtual
    def upload_by_chunks(path, content, options = {})
      uploader = DropboxApi::ChunkedUploader.new(self, path, content, options)
      uploader.start
      uploader.upload
      uploader.finish
    end
  end
end

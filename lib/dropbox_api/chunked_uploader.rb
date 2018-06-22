module DropboxApi
  class ChunkedUploader
    include DropboxApi::OptionsValidator

    def initialize(client, path, content, options = {})
      @chunk_size = options.delete(:chunk_size) || 4 * 1024 * 1024 # 4 MiB

      @client = client
      @content = content

      init_commit_info(path, options)
    end

    def start
      chunk = @content.read @chunk_size

      @cursor = @client.upload_session_start chunk
    end

    def upload
      loop do
        chunk = @content.read @chunk_size
        break if chunk.nil?

        @client.upload_session_append_v2 @cursor, chunk
        break if chunk.size < @chunk_size
      end
    end

    def finish
      @client.upload_session_finish @cursor, @commit_info
    end

    private

    def init_commit_info(path, options)
      validate_options([
        :mode,
        :autorename,
        :client_modified,
        :mute
      ], options)

      options[:path] = path
      @commit_info = DropboxApi::Metadata::CommitInfo.build_from_options options
    end
  end
end

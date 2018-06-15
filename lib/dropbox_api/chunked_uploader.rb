module DropboxApi
  class ChunkedUploader
    def initialize(client, content, path, options = {})
      @client = client
      @content = content
      @path = path

      @options = {
        :mode => 'add',
        :chunk_size => 4 * 1024 * 1024 # 4 MiB
      }.merge(options)
    end

    def start
      chunk = @content.read @options[:chunk_size]

      @cursor = @client.upload_session_start chunk
    end

    def upload
      loop do
        chunk = @content.read @options[:chunk_size]
        break if chunk.nil?

        @client.upload_session_append_v2 @cursor, chunk
        break if chunk.size < @options[:chunk_size]
      end
    end

    def finish
      commit = DropboxApi::Metadata::CommitInfo.new({
        'path' => @path,
        'mode' => @options[:mode]
      })
      @client.upload_session_finish @cursor, commit
    end
  end
end

module DropboxApi::Results
  class GetThumbnailBatchResult < DropboxApi::Results::Base
    # A collection of files and directories.

    def entries
      @entries ||= @data["entries"].map do |entry|
        DropboxApi::Metadata::ThumbnailBatchResultEntry.new entry
      end
    end

  end
end

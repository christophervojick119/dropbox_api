module DropboxApi::Results
  class CreateFolderBatchJobStatus < DropboxApi::Results::Base
    def self.new(result_data)
      case result_data[".tag"]
      when "in_progress"
        :in_progress
      when "complete"
        @entries ||= result_data["entries"].map do |entry|
          if entry[".tag"] === "success"
            DropboxApi::Metadata::Folder.new entry["metadata"]
          else
            DropboxApi::Errors::CreateFolderError.build("Could not create folder", entry["failure"])
          end
        end
      when "failed"
        DropboxApi::Errors::CreateFolderBatchStatusError.build("Async job failed",
                                               result_data["failed"])
      else
        raise NotImplementedError, "Unknown result type: #{result_data[".tag"]}"
      end
    end
  end
end
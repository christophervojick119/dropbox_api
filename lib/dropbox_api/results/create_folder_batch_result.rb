module DropboxApi::Results
  class CreateFolderBatchResult < DropboxApi::Results::Base
    def self.new(result_data)
      case result_data[".tag"]
      when "async_job_id"
        result_data
      when "complete"
        result_data["entries"].map do |entry|
          if entry[".tag"] === "success"
            DropboxApi::Metadata::Folder.new entry["metadata"]
          else
            DropboxApi::Errors::CreateFolderError.build("Could not create folder", entry["failure"])
          end
        end
      else
        raise NotImplementedError, "Unknown result type: #{result_data[".tag"]}"
      end
    end
  end
end

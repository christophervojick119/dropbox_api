module DropboxApi::Results
  class DeleteBatchCheckJobStatus < DropboxApi::Results::Base
    def self.new(result_data)
      case result_data[".tag"]
      when "in_progress"
        :in_progress
      when "complete"
        @entries ||= result_data["entries"].map do |entry|
          if entry[".tag"] === "success"
            DropboxApi::Metadata::Resource.new entry["metadata"]
          else
            DropboxApi::Errors::DeleteError.build("Could not delete entry", entry["failure"])
          end
        end
      when "failed"
        DropboxApi::Errors::DeleteError.build("Async job failed",
                                               result_data["failed"])
      else
        raise NotImplementedError, "Unknown result type: #{result_data[".tag"]}"
      end
    end
  end
end
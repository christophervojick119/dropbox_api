module DropboxApi::Results
  class DeleteBatchResult < DropboxApi::Results::Base
    # NOT ABLE TO GET ANYTHING OTHER THAN ASYNC JOB ID ###
    #
    # Have implemented "complete" just because the dropbox api says so in the docs.
    #
    
    def self.new(result_data)
      case result_data[".tag"]
      when "async_job_id"
        result_data
      when "complete"
        @entries ||= result_data["entries"].map do |entry|
          if entry[".tag"] === "success"
            DropboxApi::Metadata::Resource.new entry["metadata"]
          else
            DropboxApi::Errors::DeleteError.build("Could not delete", entry["failure"])
          end
        end
      else
        raise NotImplementedError, "Unknown result type: #{result_data[".tag"]}"
      end
    end
  end
end
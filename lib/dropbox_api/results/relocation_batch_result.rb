module DropboxApi::Results
  class RelocationBatchResult < DropboxApi::Results::Base
    def self.new(result_data)
      case result_data[".tag"]
      when "in_progress"
        :in_progress
      when "complete"
        result_data["entries"].map do |entry|
          if entry[".tag"] == "success"
            DropboxApi::Metadata::Resource.new entry["success"]
          else
            DropboxApi::Errors::RelocationBatchEntryError
              .build(entry["failure"][".tag"].to_s, entry["failure"])
          end
        end
      else
        raise NotImplementedError, "Unknown result type: #{result_data['.tag']}"
      end
    end
  end
end

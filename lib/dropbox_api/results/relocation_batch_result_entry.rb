module DropboxApi::Results
  class RelocationBatchResultEntry < DropboxApi::Results::Base
    def self.new(result_data)
      case result_data['.tag']
      when 'success'
        DropboxApi::Metadata::Resource.new entry["success"]
      when 'failure'
        DropboxApi::Errors::RelocationBatchEntryError
          .build(entry['failure']['.tag'].to_s, entry['failure'])
      else
        raise NotImplementedError, "Unknown result type: #{result_data['.tag']}"
      end
    end
  end
end

module DropboxApi::Results
  class RelocationBatchResultEntry < DropboxApi::Results::Base
    def self.new(result_data)
      case result_data['.tag']
      when 'success'
        DropboxApi::Metadata::Resource.new result_data['success']
      when 'failure'
        DropboxApi::Errors::RelocationBatchEntryError
          .build(result_data['failure']['.tag'].to_s, result_data['failure'])
      else
        raise NotImplementedError, "Unknown result type: #{result_data['.tag']}"
      end
    end
  end
end

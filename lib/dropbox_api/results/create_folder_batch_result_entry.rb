module DropboxApi::Results
  class CreateFolderBatchResultEntry < DropboxApi::Results::Base
    def self.new(result_data)
      case result_data['.tag']
      when 'success'
        DropboxApi::Metadata::Folder.new result_data['metadata']
      when 'failure'
        DropboxApi::Errors::WriteError.new result_data['path']
      else
        raise NotImplementedError, "Unknown result type: #{result_data['.tag']}"
      end
    end
  end
end

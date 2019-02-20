module DropboxApi::Errors
  class CreateFolderBatchStatusError < BasicError
    ErrorSubtypes = {
      :too_many_files => TooManyFilesError
    }.freeze
  end
end
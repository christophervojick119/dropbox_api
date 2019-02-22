module DropboxApi::Endpoints::Files
  class DeleteBatch < DropboxApi::Endpoints::Rpc
    Method      = :post
    Path        = "/2/files/delete_batch".freeze
    ResultType  = DropboxApi::Results::DeleteBatchResult

    include DropboxApi::OptionsValidator

    # NOTE: No errors are returned by this endpoint.
    #
    # Delete multiple files/folders at once.
    #
    # This route is asynchronous, which returns a job ID immediately and runs the 
    #    delete batch asynchronously. Use delete_batch/check to check the job status.
    #
    #
    # @param entries [Array] List of (DeleteArg)
    #
    # DeleteArg
    #   path String(pattern="(/(.|[\r\n])*)|(ns:[0-9]+(/.*)?)|(id:.*)") Path in the user's Dropbox to delete.
    #   parent_rev String(min_length=9, pattern="[0-9a-f]+")? Perform delete if given "rev" matches 
    #       the existing file's latest "rev". This field does not support deleting a folder. This field is optional.
    #
    # @return Result returned by delete_batch that may either launch an asynchronous job or complete 
    #    synchronously. The value will be one of the following datatypes. New values may be introduced 
    #    as Dropbox API evolves.
    
    add_endpoint :delete_batch do |entries|
      perform_request({
        :entries => entries
      })
    end
  end
end

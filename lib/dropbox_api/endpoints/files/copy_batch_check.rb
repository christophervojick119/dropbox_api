module DropboxApi::Endpoints::Files
  class CopyBatchCheck < DropboxApi::Endpoints::Rpc
    Method      = :post
    Path        = "/2/files/copy_batch/check_v2".freeze
    ResultType  = DropboxApi::Results::RelocationBatchResult
    ErrorType   = DropboxApi::Errors::PollError

    # Description: Returns the status of an asynchronous job for copy_batch:2. 
    #   It returns list of results for each entry when status is complete.
    #
    # @param :async_job_id [String] Id of the asynchronous job. 
    #   This is the value of a response returned from the method that 
    #   launched the job.
    # 
    # @return :in_progress [Void] The asynchronous job is still in progress.
    # 
    # @return :complete [RelocationBatchResult]  The copy or move batch job
    # has finished.
    #
    # @error Error returned by methods for polling the status of asynchronous
    #   job. This datatype comes from an imported namespace originally defined
    #   in the async namespace. The value will be one of the following 
    #   datatypes. New values may be introduced as our API evolves.
    # 
    # @error :invalid_async_job_id [Void] The job ID is invalid.
    # 
    # @error :internal_error [Void] Something went wrong with the job on 
    #   Dropbox's end. You'll need to verify that the action you were
    #   taking succeeded, and if not, try again.
    #   This should happen very rarely.

    add_endpoint :copy_batch_check do |async_job_id|
      perform_request({
        :async_job_id => async_job_id
      })
    end
  end
end
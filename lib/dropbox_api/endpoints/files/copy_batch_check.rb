module DropboxApi::Endpoints::Files
  class CopyBatchCheck < DropboxApi::Endpoints::Rpc
    Method      = :post
    Path        = "/2/files/copy_batch/check_v2".freeze
    ResultType  = DropboxApi::Results::CopyBatchCheckResult
    ErrorType   = DropboxApi::Errors::PollError

    # 
    # @param async_job_id [String] Id of the asynchronous job. 
    #   This is the value of a response returned from the method that launched the job.
    # 
    # @return Returns the status of an asynchronous job for copy_batch:2. 
    # It returns list of results for each entry.  
    #

    add_endpoint :copy_batch_check do |async_job_id|
      perform_request({
        :async_job_id => async_job_id
      })
    end
  end
end
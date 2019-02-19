module DropboxApi::Endpoints::Files
  class CopyBatch < DropboxApi::Endpoints::Rpc
    Method      = :post
    Path        = "/2/files/copy_batch_v2".freeze
    ResultType  = DropboxApi::Results::CopyBatchResult
    
    include DropboxApi::OptionsValidator

    # NOTE: No errors are returned by this endpoint.

    # Copy multiple files or folders to different
    # locations at once in the user's Dropbox.
    # This route will replace copy_batch_v1. 
    # The main difference is this route will return status for each entry,
    # while copy_batch raises failure if any entry fails. 
    # This route will either finish synchronously, or return a job ID 
    # and do the async copy job in background.
    # Please use copy_batch/check:2 to check the job status.
    #
    # @param entries [Array] List of (RelocationPath, min_items=1) 
    # List of entries to be moved or copied. Each entry is RelocationPath.
    #
    # RelocationPath
    #   from_path String(pattern="(/(.|[\r\n])*)|(ns:[0-9]+(/.*)?)|(id:.*)") Path in the user's Dropbox to be copied or moved.
    #   to_path String(pattern="(/(.|[\r\n])*)|(ns:[0-9]+(/.*)?)|(id:.*)") Path in the user's Dropbox that is the destination.
    #
    # @option options autorename [Boolean] If there's a conflict with any file, 
    # have the Dropbox server try to autorename that file to avoid the conflict. 
    # The default for this field is False. 
    
    add_endpoint :copy_batch do |entries, options = {}|
      validate_options([
        :autorename
      ], options)
      options[:autorename] ||= false
      
      perform_request(options.merge({
        :entries => entries
      }))
    end
  end
end

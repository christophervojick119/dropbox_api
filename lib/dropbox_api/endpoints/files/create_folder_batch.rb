module DropboxApi::Endpoints::Files
  class CreateFolderBatch < DropboxApi::Endpoints::Rpc
    Method      = :post
    Path        = "/2/files/create_folder_batch".freeze
    ResultType  = DropboxApi::Results::CreateFolderBatchResult

    include DropboxApi::OptionsValidator

    # NOTE: No errors are returned by this endpoint.
    # 
    # Create multiple folders at once.
    # This route is asynchronous for large batches, which returns a job ID
    # immediately and runs the create folder batch asynchronously. Otherwise, 
    # creates the folders and returns the result synchronously for smaller inputs.
    # You can force asynchronous behaviour by using the 
    # CreateFolderBatchArg.force_async flag. Use create_folder_batch/check to 
    # check the job status. 
    # 
    # @param paths [Array] List of (String(pattern="(/(.|[\r\n])*)|(ns:[0-9]+(/.*)?)")) 
    #    List of paths to be created in the user's Dropbox. 
    #    Duplicate path arguments in the batch are considered only once. 
    # 
    # @option autorename [Boolean] If there's a conflict, have the Dropbox server try to autorename 
    #    the folder to avoid the conflict. The default for this field is False.
    # 
    # @option force_async [Boolean] Whether to force the create to happen asynchronously. 
    #      The default for this field is False. 
    # 
    # @returns Result returned by create_folder_batch that may either launch an asynchronous job 
    #      or complete synchronously. The value will be one of the following datatypes. New values 
    #      may be introduced as Dropbox API evolves. 
    #

    add_endpoint :create_folder_batch do |paths, options = {}|
      validate_options([
        :autorename,
        :force_async,
      ], options)
      options[:autorename] ||= false
      options[:force_async] ||= false
      
      perform_request(options.merge({
        :paths => paths
      }))
    end
  end
end
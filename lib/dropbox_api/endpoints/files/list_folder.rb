module DropboxApi::Endpoints::Files
  class ListFolder < DropboxApi::Endpoints::Rpc
    Method      = :post
    Path        = "/2/files/list_folder".freeze
    ResultType  = DropboxApi::Results::ListFolderResult
    ErrorType   = DropboxApi::Errors::ListFolderError

    include DropboxApi::Endpoints::OptionsValidator

    # Returns the contents of a folder.
    #
    # @param path [String] The path to the folder you want to read.
    # @option recursive [Boolean] If `true`, the list folder operation will be
    #   applied recursively to all subfolders and the response will contain
    #   contents of all subfolders. The default for this field is `false`.
    # @option include_media_info [Boolean] If `true`, FileMetadata.media_info
    #   is set for photo and video. The default for this field is `false`.
    # @option include_deleted [Boolean] If `true`, DeletedMetadata will be
    #   returned for deleted file or folder, otherwise LookupError.not_found
    #   will be returned. The default for this field is `false`.
    add_endpoint :list_folder do |path, options = {}|
      validate_options([
        :recursive,
        :include_media_info,
        :include_deleted,
        :shared_link,
        :include_has_explicit_shared_members
      ], options)
      options[:recursive] ||= false
      options[:include_media_info] ||= false
      options[:include_deleted] ||= false

      perform_request options.merge({
        :path => path
      })
    end
  end
end

module DropboxApi::Endpoints::Sharing
  class CreateSharedLinkWithSettings < DropboxApi::Endpoints::Rpc
    Method      = :post
    Path        = "/2/sharing/create_shared_link_with_settings".freeze
    ResultType  = DropboxApi::Metadata::SharedLinkMetadata
    ErrorType   = DropboxApi::Errors::CreateSharedLinkWithSettingsError

    include DropboxApi::OptionsValidator

    # Create a shared link with custom settings. If no settings are given then
    # the default visibility is :public. (The resolved
    # visibility, though, may depend on other aspects such as team and shared
    # folder settings).
    #
    # @param path [String] The path to be shared by the shared link.
    # @param settings [SharedLinkSettings] The requested settings for the newly
    #   created shared link This field is optional.
    # @return [DropboxApi::Metadata::SharedLinkMetadata]
    #
    # @option requested_visibility takes three arguments types 'public', 'team_only' and 'password'
    # @option link_password is required if requested_visibility option has 'password' value.
    # @option expires takes timestamp in format Timestamp(format="%Y-%m-%dT%H:%M:%SZ"). 
    # If option expires is provided the link will expire after provided time.
    add_endpoint :create_shared_link_with_settings do |path, settings = {}|
    # NOTE: SETTINGS only work for pro, business or enterprise accounts. It will return no permission error otherwise.

      validate_options([
        :requested_visibility,
        :link_password,
        :expires
      ], settings)
      settings[:requested_visibility] ||= 'public'
      settings[:link_password] ||= nil
      settings[:expires] ||= nil

      perform_request({
        :path => path,
        :settings=> settings
      })
    end
  end
end

module DropboxApi::Endpoints::Files
  class Upload < DropboxApi::Endpoints::ContentUpload
    Method      = :post
    Path        = "/2/files/upload".freeze
    ResultType  = DropboxApi::Metadata::File
    ErrorType   = DropboxApi::Errors::UploadError

    include DropboxApi::OptionsValidator

    # Creates a new file.
    #
    # Do not use this to upload a file larger than 150 MB.
    #
    # TODO: Link to `#upload_by_chunks`
    #
    # @example
    #   client = DropboxApi::Client.new
    #   file_content = IO.read "local_image.png"
    #   client.upload "/image.png", file_content
    #   #=> #<DropboxApi::Metadata::File: @name="image.png" ...>
    # @example
    #   client = DropboxApi::Client.new
    #   client.upload "/file.txt", "Contents of a plain text file."
    #   #=> #<DropboxApi::Metadata::File: @name="file.txt" ...>
    # @example
    #   client = DropboxApi::Client.new
    #   client.upload "/file.txt", "File contents...", :mode => :add
    #   #=> #<DropboxApi::Metadata::File: @name="file (1).txt" ...>
    # @param path [String] Path in the user's Dropbox to save the file.
    # @param content The contents of the file that will be uploaded. This
    #   could be the result of the +IO::read+ method.
    # @option options mode [DropboxApi::Metadata::WriteMode] Selects what to
    #   do if the file already exists. The default is +add+.
    # @option options autorename [Boolean] If there's a conflict, as determined
    #   by +mode+, have the Dropbox server try to autorename the file to avoid
    #   conflict. The default for this field is +false+.
    # @option options client_modified [DateTime] The value to store as the
    #   +client_modified+ timestamp. Dropbox automatically records the time at
    #   which the file was written to the Dropbox servers. It can also record
    #   an additional timestamp, provided by Dropbox desktop clients, mobile
    #   clients, and API apps of when the file was actually created or
    #   modified.
    # @see DropboxApi::Metadata::WriteMode
    add_endpoint :upload do |path, content, options = {}|
      validate_options([
        :mode,
        :autorename,
        :client_modified,
        :mute
      ], options)

      options[:mode] = build_write_mode_param(options[:mode]) if options[:mode]
      options[:client_modified] = options[:client_modified].utc.strftime("%FT%TZ") if options[:client_modified]

      perform_request(options.merge({
        :path => path
      }), content)
    end
  end
end

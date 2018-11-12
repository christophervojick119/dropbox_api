module DropboxApi::Results
  class SharedLinkMetadata < DropboxApi::Results::Base
    def url
      @data['url']
    end

    def name
      @data['name']
    end

    def path_lower
      @data['path_lower']
    end

    def id
      @data['id']
    end
  end
end

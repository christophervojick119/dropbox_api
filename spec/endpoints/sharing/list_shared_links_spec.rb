describe DropboxApi::Client, "#list_shared_links" do
  before :each do
    @client = DropboxApi::Client.new
  end

  context "on a file" do
    it "returns a file link", :cassette => "list_shared_links/success_file" do
      result = @client.list_shared_links :path => "/some_folder/file.txt"

      expect(result.links.last).to be_a(DropboxApi::Metadata::FileLinkMetadata)
    end

    it "lists all shared links", :cassette => "list_shared_links/success_file" do
      links = @client.list_shared_links(:path => "/some_folder/file.txt").links

      expect(links.map &:url).to match_array(%w(
        https://www.dropbox.com/sh/5b0bmldpa1qi772/AAAwKkKiTdb1A78bzHCKQLeHa?dl=0
        https://www.dropbox.com/s/sp5cuhaxfn8126z/file.txt?dl=0
      ))
    end

    it "gets the direct shared link", :cassette => "list_shared_links/success_file_direct_only" do
      links = @client.list_shared_links({
        :path => "/some_folder/file.txt",
        :direct_only => true
      }).links

      expect(links.map &:url).to match_array(%w(
        https://www.dropbox.com/s/sp5cuhaxfn8126z/file.txt?dl=0
      ))
    end
  end

  context "on a folder" do
    it "returns a folder link", :cassette => "list_shared_links/success_folder" do
      result = @client.list_shared_links :path => "/some_folder/another_folder"

      expect(result.links.last).to be_a(DropboxApi::Metadata::FolderLinkMetadata)
    end

    it "lists all shared links", :cassette => "list_shared_links/success_folder" do
      links = @client.list_shared_links(:path => "/some_folder/another_folder").links

      expect(links.map &:url).to match_array(%w(
        https://www.dropbox.com/sh/5b0bmldpa1qi772/AAAwKkKiTdb1A78bzHCKQLeHa?dl=0
        https://www.dropbox.com/sh/h3slcnfcs3w7sdk/AADlUYcssd70EWHX3n9CJCWwa?dl=0
      ))
    end
  end
end

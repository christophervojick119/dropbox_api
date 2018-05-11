describe DropboxApi::Client, "#create_shared_link_with_settings" do
  before :each do
    @client = DropboxApi::Client.new
  end

  context "on a file" do
    it "creates a shared link", :cassette => "create_shared_link_with_settings/success_file" do
      link = @client.create_shared_link_with_settings "/file_for_sharing.docx"

      expect(link).to be_a(DropboxApi::Metadata::FileLinkMetadata)
    end

    it "raises an error if already shared", :cassette => "create_shared_link_with_settings/already_shared" do
      expect {
        @client.create_shared_link_with_settings "/file_for_sharing.docx"
      }.to raise_error(DropboxApi::Errors::SharedLinkAlreadyExistsError)
    end
  end

  context "on a folder" do
    it "creates a shared link", :cassette => "create_shared_link_with_settings/success_folder" do
      link = @client.create_shared_link_with_settings "/folder_for_sharing"

      expect(link).to be_a(DropboxApi::Metadata::FolderLinkMetadata)
    end
  end
end

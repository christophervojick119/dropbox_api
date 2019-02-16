describe DropboxApi::Client, "#delete" do
  let(:path_prefix) { DropboxScaffoldBuilder.prefix_for :delete }
  before :each do
    @client = DropboxApi::Client.new
  end

  it "returns the deleted file", :cassette => "delete/success_file" do
    file = @client.delete "#{path_prefix}/will_be_deleted.txt"

    expect(file).to be_a(DropboxApi::Metadata::File)
    expect(file.name).to eq("will_be_deleted.txt")
  end

  it "won't delete the file if `parent_rev` doesn't match", :cassette => "delete/invalid_parent_rev" do
    expect {
      @client.delete "#{path_prefix}/wont_be_deleted.txt", :parent_rev => "1c0576c68d6"
    }.to raise_error(DropboxApi::Errors::FileConflictError)
  end

  it "returns the deleted folder", :cassette => "delete/success_folder" do
    folder = @client.delete "#{path_prefix}/folder"

    expect(folder).to be_a(DropboxApi::Metadata::Folder)
    expect(folder.name).to eq("folder")
  end

  it "raises an error if the name is invalid", :cassette => "delete/not_found" do
    expect {
      @client.delete "/unexisting folder"
    }.to raise_error(DropboxApi::Errors::NotFoundError)
  end
end

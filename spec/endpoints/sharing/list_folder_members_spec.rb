describe DropboxApi::Client, "#list_folder_members" do
  before :each do
    @client = DropboxApi::Client.new
  end

  it "lists folder members", :cassette => "list_folder_members/success" do
    result = @client.list_folder_members "1231273663"

    expect(result).to be_a(DropboxApi::Results::SharedFolderMembers)
  end

  it "lists folder members including member actions", :cassette => "list_folder_members/success_with_actions" do
    result = @client.list_folder_members "1231273663", [:remove, :make_owner]

    expect(result).to be_a(DropboxApi::Results::SharedFolderMembers)
  end
end

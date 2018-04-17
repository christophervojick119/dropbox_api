describe DropboxApi::Client, "#list_file_members" do
  before :each do
    @client = DropboxApi::Client.new
  end

  it "lists file members", :cassette => "list_file_members/success" do
    result = @client.list_file_members "1231273663"

    expect(result).to be_a(DropboxApi::Results::SharedMembers)
  end

  it "lists file members including member actions", :cassette => "list_file_members/success_with_actions" do
    result = @client.list_file_members "1231273663", [:remove, :make_owner]

    expect(result).to be_a(DropboxApi::Results::SharedMembers)
  end
end

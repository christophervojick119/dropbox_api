describe DropboxApi::Client, "#create_file_request" do
  before :each do
    @client = DropboxApi::Client.new
  end

  it "returns the new file request on success", :cassette => "create_file_request/success" do
    file_request = @client.create_file_request 'Arizona, baby', '/arizona_baby'

    expect(file_request).to be_a(DropboxApi::Metadata::FileRequest)
    expect(file_request.title).to eq("Arizona, baby")
  end
end

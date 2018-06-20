describe DropboxApi::Client, "#create_file_request" do
  let(:path_prefix) { DropboxScaffoldBuilder.prefix_for :create_file_request }
  before :each do
    @client = DropboxApi::Client.new
  end

  it "returns the new file request on success", :cassette => "create_file_request/success" do
    file_request = @client.create_file_request 'Arizona, baby', "#{path_prefix}/arizona_baby"

    expect(file_request).to be_a(DropboxApi::Metadata::FileRequest)
    expect(file_request.title).to eq("Arizona, baby")
  end

  it "raises something if wrong path", :cassette => "create_file_request/not_a_folder" do
    expect {
      @client.create_file_request 'Arizona, baby', "#{path_prefix}/regular_file.txt"
    }.to raise_error(DropboxApi::Errors::CreateFileRequestError)
  end
end

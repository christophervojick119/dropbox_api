describe DropboxApi::Client, "#token_revoke" do
  before :each do
    @client = DropboxApi::Client.new
  end

  it "revokes the token", :cassette => "token_revoke/success" do
    account = @client.token_revoke

    #endpoint has no response to test
  end
end

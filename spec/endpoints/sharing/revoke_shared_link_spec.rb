describe DropboxApi::Client, "#revoke_shared_link" do
  before :each do
    @client = DropboxApi::Client.new
  end

  context "revoke shared link access" do
    it "revoke a shared link", :cassette => "revoke_shared_link/success" do
      link = @client.revoke_shared_link "https://www.dropbox.com/sh/t0ebpiojwy4l1bn/AAAcU6qf20b8R-SG5_PJCBOQa?dl=0"

      # The endpoint doesn't have any return values, can't test the output!
    end

    it "raises an error if link is not found", :cassette => "revoke_shared_link/not_found" do
      expect {
        @client.revoke_shared_link "https://www.dropbox.com/sh/t0ebpiojwy4l1bn/AAAcU6qf20b8R-SG5_PJCBOQa?dl=0"
      }.to raise_error(DropboxApi::Errors::SharedLinkNotFoundError)
    end

    it "raises access denied error if not permitted", :cassette => "revoke_shared_link/access_denied" do
      expect {
        @client.revoke_shared_link "https://www.dropbox.com/s/al0w4e11j0e1kp3/file_for_sharing.docx?dl=0"
      }.to raise_error(DropboxApi::Errors::SharedLinkAccessDeniedError)
    end

    it "raises shared link malformed error if link is malformed", :cassette => "revoke_shared_link/malformed_shared_link" do
      expect {
        @client.revoke_shared_link "https://www.dropbox.com/al0w4e11j0e1kp3/file_for_sharing.docx?dl=0"
      }.to raise_error(DropboxApi::Errors::SharedLinkMalformedError)
    end
  end
end

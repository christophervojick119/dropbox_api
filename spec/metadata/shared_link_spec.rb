describe DropboxApi::Metadata::SharedLink do
  describe "#to_hash" do
    it "works with a string URL" do
      url = "http://www.dropbox.com/my/cats/name/s/mittens"
      shared_link = described_class.new url

      expect(shared_link.to_hash)
        .to eq({:url => url})
    end

    it "works with a hash URL" do
      url = "http://www.dropbox.com/my/cats/name/s/mittens"
      shared_link = described_class.new url: url

      expect(shared_link.to_hash)
        .to eq({:url => url})
    end

    it "works with a hash URL and password" do
      param = {
        :url => "http://www.dropbox.com/my/cats/name/s/mittens",
        :password => "jibiri"
      }
      shared_link = described_class.new param

      expect(shared_link.to_hash)
        .to eq(param)
    end

    it "fails with invalid options" do
      param = {
        :url => "http://www.dropbox.com/my/cats/name/s/mittens",
        :jibiri => "jibiri"
      }

      expect {
        shared_link = described_class.new param
      }.to raise_error(ArgumentError)
    end
  end
end

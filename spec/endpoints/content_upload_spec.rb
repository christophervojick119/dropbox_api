describe DropboxApi::Endpoints::ContentUpload do
  subject { described_class.new(DropboxApi::ConnectionBuilder.new("bearer")) }

  context 'Content-Length header' do
    context 'for String body' do
      it "is calculated and appended to headers" do
        body = IO.read(File.expand_path "#{__FILE__}/../../fixtures/img.png")

        _, headers = subject.build_request({}, body)

        expect(headers['Content-Length']).to eq("3975")
      end
    end

    context 'for File body' do
      it "is calculated and appended to headers" do
        begin
          content = "tested content"
          file = Tempfile.new('dropbox_api')
          file << content

          _, headers = subject.build_request({}, file)

          expect(headers['Content-Length']).to eq(content.length.to_s)
        ensure
          file.close
        end
      end
    end

    context 'for nil' do
      it 'is not in headers' do
        body = nil

        _, headers = subject.build_request({}, body)

        expect(headers).to_not have_key("Content-Length")
      end
    end
  end
end

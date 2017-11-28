module DropboxApi
  describe ChunkedUploader do
    let(:path_prefix) { DropboxScaffoldBuilder.prefix_for :chunked_uploader }

    before :each do
      @client = DropboxApi::Client.new
    end

    it 'uploads a file' do
      file = File.open(File.join(File.dirname(__FILE__), './fixtures/file.txt'), 'r')
      uploader = DropboxApi::ChunkedUploader.new(@client, file)

      VCR.use_cassette('chunked_uploader/upload') do
        uploader.upload
      end

      VCR.use_cassette('chunked_uploader/finish_upload') do
        file_data = uploader.finish("#{path_prefix}/new_file.txt")
        expect(file_data).to be_a(DropboxApi::Metadata::File)
        expect(file_data.name).to eq('new_file.txt')
      end
    end
  end
end

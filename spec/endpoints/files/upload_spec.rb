describe DropboxApi::Client, "#upload" do
  let(:path_prefix) { DropboxScaffoldBuilder.prefix_for :upload }
  before :each do
    @client = DropboxApi::Client.new
  end

  it "uploads a file", :cassette => "upload/success" do
    file = @client.upload("#{path_prefix}/file.txt", "Hello Dropbox!")

    expect(file).to be_a(DropboxApi::Metadata::File)
    expect(file.name).to eq("file.txt")
  end

  it "works with an IO object", :cassette => "upload/success_io" do
    content = File.open(File.join(DropboxScaffoldBuilder.fixtures_path, "file.txt"))
    file = @client.upload("#{path_prefix}/file_io.txt", content)

    expect(file).to be_a(DropboxApi::Metadata::File)
    expect(file.name).to eq("file_io.txt")
    expect(file.content_hash).to eq("709a5cf259366d6ca6b2fa4d3b53c02f5ce2b2764e9d580711e3ffd24d79f5e9")
  end

  it "uploads a file with `add` write mode", :cassette => "upload/success_add" do
    file = @client.upload("#{path_prefix}/file.txt", "Hola Dropbox!", {
      :autorename => true,
      :mode => :add
    })

    expect(file).to be_a(DropboxApi::Metadata::File)
    expect(file.name).to eq("file (1).txt")
  end

  it "uploads a file with `overwrite` write mode", :cassette => "upload/success_overwrite" do
    file = @client.upload("#{path_prefix}/file.txt", "Hola Dropbox!", {
      :autorename => true,
      :mode => :overwrite
    })

    expect(file).to be_a(DropboxApi::Metadata::File)
    expect(file.name).to eq("file.txt")
  end

  it "uploads a file with `update` write mode", :cassette => "upload/success_update" do
    rev = @client.get_metadata("#{path_prefix}/file.txt").rev
    file = @client.upload("#{path_prefix}/file.txt", "Hallo Dropbox!", {
      :autorename => true,
      :mode => DropboxApi::Metadata::WriteMode.new(:update, rev)
    })

    expect(file).to be_a(DropboxApi::Metadata::File)
    expect(file.name).to eq("file.txt")
  end

  it "uploads a file with `overwrite` write mode", :cassette => "upload/success_client_modified" do
    modified_at = Time.utc 2016, 12, 25, 12, 0

    file = @client.upload("#{path_prefix}/another_file.txt", "Our country is a mess!", {
      :client_modified => modified_at
    })

    expect(file).to be_a(DropboxApi::Metadata::File)
    expect(file.name).to eq("another_file.txt")
    expect(file.client_modified).to eq(modified_at)
  end

  context "when too many write operations" do
    it "raises a DropboxApi::Errors::TooManyWriteOperations exception", :cassette => "upload/too_many_write_operations" do
      expect {
        100.times.map do |n|
          Thread.new do
            @client.upload("#{path_prefix}/file_#{n}.txt", "Hello Dropbox!")
          end
        end.each(&:join)

      }.to raise_error(DropboxApi::Errors::TooManyWriteOperationsError)
    end

    it "raises an exception with info to retry", :cassette => "upload/too_many_write_operations" do
      expect {
        100.times.map do |n|
          Thread.new do
            @client.upload("#{path_prefix}/file_#{n}.txt", "Hello Dropbox!")
          end
        end.each(&:join)
      }.to raise_error { |error|
        expect(error.retry_after).to eq(1)
      }
    end
  end
end

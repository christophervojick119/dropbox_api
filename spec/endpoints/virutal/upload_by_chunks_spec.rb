describe DropboxApi::Client, "#upload" do
  let(:path_prefix) { DropboxScaffoldBuilder.prefix_for :upload_by_chunks }
  before :each do
    @client = DropboxApi::Client.new
  end

  it "uploads a file", :cassette => "upload_by_chunks/success" do
    file = @client.upload_by_chunks("#{path_prefix}/file.txt", "Hello Dropbox!")

    expect(file).to be_a(DropboxApi::Metadata::File)
    expect(file.name).to eq("file.txt")
  end

  it "works with an IO object", :cassette => "upload_by_chunks/success_io" do
    content = File.open(File.join(DropboxScaffoldBuilder.fixtures_path, "file.txt"))
    file = @client.upload_by_chunks("#{path_prefix}/file_io.txt", content)

    expect(file).to be_a(DropboxApi::Metadata::File)
    expect(file.name).to eq("file_io.txt")
    expect(file.content_hash).to eq("709a5cf259366d6ca6b2fa4d3b53c02f5ce2b2764e9d580711e3ffd24d79f5e9")
  end

  it "uploads a file with `add` write mode", :cassette => "upload_by_chunks/success_add" do
    file = @client.upload_by_chunks("#{path_prefix}/file.txt", "Hola Dropbox!", {
      :autorename => true,
      :mode => :add
    })

    expect(file).to be_a(DropboxApi::Metadata::File)
    expect(file.name).to eq("file (1).txt")
  end
end

#encoding: utf-8
describe DropboxApi::Client, "#upload_session_append_v2" do
  before :each do
    @client = DropboxApi::Client.new
  end

  it 'can be used to append an upload', :cassette => 'upload_session_append_v2/success' do
    chunks = ['123456789', 'Olá Dropbox!']

    cursor = @client.upload_session_start(chunks.first)

    @client.upload_session_append_v2(cursor, chunks.last)

    commit = DropboxApi::Metadata::CommitInfo.new(
      'path' => '/target.txt',
      'mode' => :add
    )

    expect { @client.upload_session_finish(cursor, commit) }.not_to raise_error
  end

  it "will raise error if the cursor can't be found", :cassette => "upload_session_append_v2/not_found" do
    cursor = DropboxApi::Metadata::UploadSessionCursor.new({
      "session_id" => "INVALID_CURSOR",
      "offset" => 0
    })

    expect {
      @client.upload_session_append_v2(cursor, "Hello Dropbox!")
    }.to raise_error(DropboxApi::Errors::NotFoundError)
  end

  it "will raise error if the offset is wrong", :cassette => "upload_session_append_v2/offset_error" do
    chunk = "123456789"

    cursor = @client.upload_session_start(chunk)

    # Set an incorrect offset deliberately so Dropbox will return an error
    cursor.instance_variable_set :@offset, 42

    expect {
      @client.upload_session_append_v2(cursor, "Hello Dropbox!")
    }.to raise_error(DropboxApi::Errors::UploadSessionOffsetError)
  end
end

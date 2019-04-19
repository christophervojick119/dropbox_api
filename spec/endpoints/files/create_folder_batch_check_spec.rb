describe DropboxApi::Client, "#create_folder_batch_check" do
  before :each do
    @client = DropboxApi::Client.new
  end

  it "returns mixed results with failure and success status for each entry", :cassette => "create_folder_batch_check/mixed_entries" do
    async_result = @client.create_folder_batch_check("dbjid:AAA8ixe2PLtuFEtS216inFdIa5J8PM5f8c9IcRimbLVqQ-0-bzq0yFEv1yu4UeCSUyZqQn80SjL5cbY-Ow9RBNQE")

    expect(async_result).to include(a_kind_of(DropboxApi::Metadata::Folder))
    expect(async_result).to include(a_kind_of(DropboxApi::Errors::MalformedPathError))
    expect(async_result).to include(a_kind_of(DropboxApi::Errors::FolderConflictError))
  end

  it "raises an error with an invalid async job id", :cassette => "create_folder_batch_check/invalid_async_job_id" do
    expect {
      @client.create_folder_batch_check("dbjid:AAA8ixe2PLtuFEtS216inFdIa5J8PM5f8c9IcRimbLVqQ-0-bzq0yFEv1yu4UeCSUyZqQn80SjL5cbY-Ow9RBNQT")
    }.to raise_error(DropboxApi::Errors::InvalidIdError)
  end
end
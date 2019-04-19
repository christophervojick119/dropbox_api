describe DropboxApi::Client, "#delete_batch_check" do
  before :each do
    @client = DropboxApi::Client.new
  end

  it "returns mixed results when complete", :cassette => "delete_batch_check/mixed_entries" do
    async_result = @client.delete_batch_check("dbjid:AAC2JUPMEtK-kEg7QVrNEemnX-FfQkJ_0r_tJJ2UpHhwvrUGrpw19CH4U5cfZKWPLxLVJoKgffTOy_zSKk6W953h")

    expect(async_result).to include(a_kind_of(DropboxApi::Metadata::Folder))
    expect(async_result).to include(a_kind_of(DropboxApi::Metadata::File))
    expect(async_result).to include(a_kind_of(DropboxApi::Errors::FileConflictError))
    expect(async_result).to include(a_kind_of(DropboxApi::Errors::NotFoundError))
  end

  it "raises an error with an invalid async job id", :cassette => "delete_batch_check/invalid_async_job_id" do
    expect {
      @client.delete_batch_check("dbjid:AAA8ixe2PLtuFEtS216inFdIa5J8PM5f8c9IcRimbLVqQ-0-bzq0yFEv1yu4UeCSUyZqQn80SjL5cbY-Ow9RBNQT")
    }.to raise_error(DropboxApi::Errors::InvalidIdError)
  end
end
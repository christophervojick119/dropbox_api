describe DropboxApi::Client, "#copy_batch_check" do
  before :each do
    @client = DropboxApi::Client.new
  end

  it "returns all types of entries", :cassette => "copy_batch_check/complete" do
    result = @client.copy_batch_check "dbjid:AADOVgzSRvtiBJ9dZaE8VUp07JT-zO7k9TrjEfwnzTfGGDuEi1pTRB2vFufnQfX9Yf-N_tzVl52rGEK4GYI8zzsU"

    expect(result).to include(a_kind_of(DropboxApi::Metadata::Folder))
    expect(result).to include(a_kind_of(DropboxApi::Metadata::File))
    expect(result).to include(a_kind_of(DropboxApi::Errors::NotFoundError))
  end

  it "returns 'invalid_async_job_id' error", :cassette => "copy_batch_check/invalid_async_job_id" do
    expect {
      @client.copy_batch_check "dbjid:AADOVgzSRvtiBJ9dZaE8VUp07JT-zO7k9TrjEfwnzTfGGDuEi1pTRB2vFufnQfX9Yf-N_tzVl52rGEK4GYI8zzsE"
    }.to raise_error(DropboxApi::Errors::InvalidIdError)
  end
end
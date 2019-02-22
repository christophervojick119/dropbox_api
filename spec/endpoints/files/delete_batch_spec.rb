describe DropboxApi::Client, "#delete" do
  before :each do
    @client = DropboxApi::Client.new
  end

  ### NOT ABLE TO GET ANYTHING OTHER THAN ASYNC JOB ID IN RESPONSE FROM DROPBOX ###

  it "returns async_job_id for multiple entries", :cassette => "delete_batch/multiple_entry_success" do
    entries = [{ :path => "/folder_to_delete_1" }, { :path => "/folder_to_delete_2" }]
    async_result = @client.delete_batch entries

    expect(async_result).to be_a(Hash)
    expect(async_result).to have_key("async_job_id")
  end

  it "returns async_job_id for single entry too", :cassette => "delete_batch/single_entry_success" do
    entries = [{ :path => "/folder_to_delete/file_to_delete.docx", :parent_rev => "1c0576c68d6" }]
    async_result = @client.delete_batch entries

    expect(async_result).to be_a(Hash)
    expect(async_result).to have_key("async_job_id")
  end
end

describe DropboxApi::Client, "#create_folder_batch" do
  before :each do
    @client = DropboxApi::Client.new
  end
  
  it "returns the created folders synchronously", :cassette => "create_folder_batch/synchronous_result_success" do
    result = @client.create_folder_batch ["/Create Batch", "/Create Batch 1"]

    expect(result.first).to be_a(DropboxApi::Metadata::Folder)
    expect(result.last).to be_a(DropboxApi::Metadata::Folder)
  end

  it "returns async_job_id when large entries are passed", :cassette => "create_folder_batch/large_entries" do
    paths = []
    100.times { |i| paths << "/Folder #{i}"}

    async_result = @client.create_folder_batch(paths)
    expect(async_result).to be_a(Hash)
    expect(async_result).to have_key("async_job_id")
  end

  it "returns async_job_id when force_async is true", :cassette => "create_folder_batch/force_async_true" do
    async_result = @client.create_folder_batch(["/Create Batch 2", "/Create Batch 3"], { :force_async => true })
    
    expect(async_result).to be_a(Hash)
    expect(async_result).to have_key("async_job_id")
  end
  
  it "when autorename is true, does not return error for repeated entries", :cassette => "create_folder_batch/autorename_true" do
    result = @client.create_folder_batch(["/Create Batch 1", "/Create Batch 1"], { :autorename => true })

    expect(result).not_to include(a_kind_of(DropboxApi::Errors::FolderConflictError))
  end

  it "raises error, when invalid option is passed", :cassette => "create_folder_batch/invalid_option" do
    expect {
      @client.create_folder_batch(["/Create Batch 4", "/Create Batch 5"], { :async => true })
    }.to raise_error(ArgumentError)
  end
end
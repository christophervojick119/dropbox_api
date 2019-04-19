describe DropboxApi::Client, "#copy_batch" do
  let(:path_prefix) { DropboxScaffoldBuilder.prefix_for :copy_batch }
  before :each do
    @client = DropboxApi::Client.new
  end

  it "returns an async job id", :cassette => "copy_batch/success" do
    result = @client.copy_batch [{
      :from_path => "#{path_prefix}/regular_file.txt",
      :to_path => "#{path_prefix}/regular_file_renamed.txt"
    }]

    expect(result.async_job_id)
      .to eq("dbjid:AAA6b4uwc19nEau5k-OBI_h-hjrR7pNDaUA3_0hOwV-UZ2pkw_zXWp3FSuVZrQ0d9IXKGkwB5JdYI4mJZumLc6qZ")
  end

  it "if autorename option is true, returns an async job id", :cassette => "copy_batch/autorename_success" do
    result = @client.copy_batch([{
      :from_path => "#{path_prefix}/regular_file_2.txt",
      :to_path => "#{path_prefix}/regular_file_2_renamed.txt"
    }], :autorename => true)

    expect(result.async_job_id)
      .to eq("dbjid:AABe-bOUUq5nrybciMJxIxaGAD16nGCKByGyY3Z_2m6kshGW903XTikVT3_5V6JQQu20p3QxoCfws7_hT40deF6q")
  end
end

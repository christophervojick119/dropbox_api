describe DropboxApi::Client, "#copy_batch" do
  before :each do
    @client = DropboxApi::Client.new
  end

  it "returns an async job id", :cassette => "copy_batch/success" do
    result = @client.copy_batch [{:from_path => "/folder 1/photo1.png", :to_path => "/folder 2/photo1.png"}]
    
    expect(result.async_job_id).to eq("dbjid:AABG1I-LPa5wH5dIqNL2_IY_LxQHTfdv_btYeCoTdOhGt-cUERJCj1xJkYWoxpX-jZau6_eCR2IjVJu3uhhLr9tr")
  end

  it "if autorename option is true, returns an async job id", :cassette => "copy_batch/autorename_success" do
    result = @client.copy_batch([{:from_path => "/folder 2/photo1.png", :to_path => "/folder 3/photo1.png"}], :autorename => true)
    
    expect(result.async_job_id).to eq("dbjid:AACFpNAiWBhdsxpppngzE8Ob3IJhYpFVJxzzBZmdLFwGwG2urEnxwfLrSDh2m1fYTxRYc6PllgijNUnxKuQZl920")
  end
end
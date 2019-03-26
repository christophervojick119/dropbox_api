describe DropboxApi::Metadata::CommitInfo do
  it "can be initialized from a Hash" do
    commit_info_hash = {
      "path" => "/Homework/math/Matrices.txt",
      "mode" => {
        ".tag" => "update",
        "update" => "a1c10ce0dd78"
      },
      "autorename" => false,
      "mute" => false
    }

    commit = described_class.new commit_info_hash
    expect(commit.path).to eq("/Homework/math/Matrices.txt")
  end
end

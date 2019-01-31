context DropboxApi::Metadata::File do
  def build_file_hash(attrs = {})
    {
      ".tag" => "file",
      "name" => "visrez-video.mp4",
      "path_lower" => "/visrez-video.mp4",
      "path_display" => "/visrez-video.mp4",
      "id" => "id:ARSNw7QJjrAAAAAAAAAAAQ",
      "client_modified" => "2016-05-22T09:31:26Z",
      "server_modified" => "2016-05-22T09:31:26Z",
      "rev" => "2c824061bdd",
      "size" => 1136802
    }.merge(attrs)
  end

  it "can be initialized from a hash" do
    file_hash = build_file_hash

    file = DropboxApi::Metadata::File.new file_hash
    expect(file).to be_a(DropboxApi::Metadata::File)
    expect(file.name).to eq("visrez-video.mp4")
    expect(file.path_lower).to eq("/visrez-video.mp4")
    expect(file.path_display).to eq("/visrez-video.mp4")
    expect(file.id).to eq("id:ARSNw7QJjrAAAAAAAAAAAQ")
    expect(file.client_modified).to eq(Time.utc(2016, 5, 22, 9, 31, 26))
    expect(file.server_modified).to eq(Time.utc(2016, 5, 22, 9, 31, 26))
    expect(file.rev).to eq("2c824061bdd")
    expect(file.size).to eq(1136802)
  end

  it "includes the content_hash field" do
    file_hash = build_file_hash({
      "content_hash" =>
        "2a846fa617c3361fc117e1c5c1e1838c336b6a5cef982c1a2d9bdf68f2f1992a"
    })

    file = DropboxApi::Metadata::File.new file_hash
    expect(file).to be_a(DropboxApi::Metadata::File)
    expect(file.content_hash).to eq("2a846fa617c3361fc117e1c5c1e1838c336b6a5cef982c1a2d9bdf68f2f1992a")
  end

  it "works if metadata is pending" do
    file_hash = build_file_hash({
      "media_info" => {
        ".tag" => "pending"
      }
    })

    file = DropboxApi::Metadata::File.new file_hash

    expect(file)
      .to be_a(DropboxApi::Metadata::File)
    expect(file.media_info)
      .to eq(:pending)
  end

  context "with photo" do
    it "includes the media_info field" do
      file_hash = build_file_hash({
        "media_info" => {
          ".tag" => "metadata",
          "metadata" => {
            ".tag" => "photo",
            "dimensions" => {
              "height" => 700,
              "width" => 1050
            },
            "time_taken" => "2013-01-10T22:10:13Z",
            "location" => {
              "latitude" => 10.1234,
              "longitude" => 5.1234
            }
          }
        }
      })

      file = DropboxApi::Metadata::File.new file_hash

      expect(file)
        .to be_a(DropboxApi::Metadata::File)
      expect(file.media_info)
        .to be_a(DropboxApi::Metadata::PhotoMetadata)

      expect(file.media_info.dimensions)
        .to be_a(DropboxApi::Metadata::Dimensions)
      expect(file.media_info.dimensions.height)
        .to eq(700)
      expect(file.media_info.dimensions.width)
        .to eq(1050)

      expect(file.media_info.time_taken)
        .to eq(Time.utc(2013, 1, 10, 22, 10, 13))

      expect(file.media_info.location)
        .to be_a(DropboxApi::Metadata::Location)
      expect(file.media_info.location.latitude)
        .to eq(10.1234)
      expect(file.media_info.location.longitude)
        .to eq(5.1234)
    end
  end

  context "with video" do
    it "includes the media_info field" do
      file_hash = build_file_hash({
        "media_info" => {
          ".tag" => "metadata",
          "metadata" => {
            ".tag" => "video",
            "dimensions" => {
              "height" => 1920,
              "width" => 1080
            },
            "time_taken" => "2017-07-10T19:54:57Z",
            "duration" => 12642
          }
        }
      })

      file = DropboxApi::Metadata::File.new file_hash

      expect(file)
        .to be_a(DropboxApi::Metadata::File)
      expect(file.media_info)
        .to be_a(DropboxApi::Metadata::VideoMetadata)

      expect(file.media_info.dimensions)
        .to be_a(DropboxApi::Metadata::Dimensions)
      expect(file.media_info.dimensions.height)
        .to eq(1920)
      expect(file.media_info.dimensions.width)
        .to eq(1080)

      expect(file.media_info.time_taken)
        .to eq(Time.utc(2017, 7, 10, 19, 54, 57))

      expect(file.media_info.duration)
        .to eq(12642)
    end
  end

  it "can be converted back to a hash" do
    file_hash = build_file_hash

    file = DropboxApi::Metadata::File.new file_hash

    expect(file.to_hash).to eq(file_hash)
  end

  it "works without path data" do
    file_hash = build_file_hash.reject { |k, _| %w(path_display path_lower).include?(k) }
    file = DropboxApi::Metadata::File.new(file_hash)
    expect(file).to be_a(DropboxApi::Metadata::File)
  end

end

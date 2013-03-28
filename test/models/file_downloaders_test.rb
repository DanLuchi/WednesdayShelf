require 'test_helper'

describe FileDownloader do

  before do
    VCR.insert_cassette(__name__)
    @file_downloader = FactoryGirl.build(:file_downloader)
  end

  after do
    VCR.eject_cassette
  end

  describe '#get_source_file' do
    it "Returns a source File" do
      fd_gsf = @file_downloader.get_source_file
      fd_gsf.uri.to_s.must_equal BASE_URL + @file_downloader.url
      fd_gsf.class.must_equal Mechanize::File
    end

  end

  describe '#file_body' do
    it "returns the body of the file as a string" do
      fd_fb = @file_downloader.file_body
      fd_fb.class.must_equal String
    end
  end

end

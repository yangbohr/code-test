require 'spec_helper'
require 'open-uri'

describe UserComment do

  describe "fetch_comments" do
    it "should fetch comments from the remote api" do
      VCR.use_cassette('successfully_fetch') do
        UserComment.fetch_comments(UserComment::URL)
        UserComment.all.count.should eq 8
      end
    end

    it 'should handle errors' do
    end

  end
end
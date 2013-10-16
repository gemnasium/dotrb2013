require 'spec_helper'

describe PullRequestFetcher do
  let(:fetcher) { described_class.new }

  let :url do
    case state
    when :merged
      'https://api.github.com/repos/resque/resque/pulls/1082'
    when :open
      'https://api.github.com/repos/resque/resque/pulls/1131'
    when :missing
      'https://api.github.com/repos/resque/resque/pulls/9999'
    end
  end

  describe "#metadata_for" do
    subject do
      VCR.use_cassette('github') do
        fetcher.metadata_for url
      end
    end

    context "with valid pull request" do
      let(:state) { :merged }

      it "gives metadata" do
        expect(subject).to eql(
          {
            "url"=>"https://api.github.com/repos/resque/resque/pulls/1082",
            "html_url"=>"https://github.com/resque/resque/pull/1082",
            "number"=>1082,
            "title"=>"100% yardoc.",
            "body"=>"100% yard documentation.",
            "merged_at"=>"2013-07-13T16:57:20Z"
          }
        )
      end
    end

    context "with missing pull request" do
      let(:state) { :missing }

      it "gives no metadata" do
        expect(subject).to eql({})
      end
    end
  end

  describe "#merged_at_for" do
    subject do
      VCR.use_cassette('github') do
        fetcher.merged_at_for url
      end
    end

    context "with merged pull request" do
      let(:state) { :merged }

      it "gives datetime" do
        expect(subject).to eql("2013-07-13T16:57:20Z")
      end
    end

    context "with open pull request" do
      let(:state) { :open }

      it "gives no datetime" do
        expect(subject).to eql(nil)
      end
    end

    context "with missing pull request" do
      let(:state) { :missing }

      it "gives no datetime" do
        expect(subject).to eql(nil)
      end
    end
  end
end

class PullRequestLoader
  @queue = :load

  def self.perform id
    pull_request = PullRequest.find id
    self.new(pull_request).call
  end

  attr_reader :pull_request
  attr_reader :fetcher

  def initialize(pull_request, fetcher=nil)
    @pull_request = pull_request
    @fetcher = fetcher || PullRequestFetcher.new
  end

  def call
    metadata = fetcher.metadata_for pull_request.url
    pull_request.attributes = metadata
    pull_request.save!
  end
end

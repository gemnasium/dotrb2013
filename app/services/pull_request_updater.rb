class PullRequestUpdater
  @queue = :update

  def self.perform id
    pull_request = PullRequest.find id
    self.new(pull_request).call
  end

  attr_reader :pull_request
  attr_reader :fetcher
  attr_reader :observer

  def initialize(pull_request, fetcher=nil, observer=nil)
    @pull_request = pull_request
    @fetcher = fetcher || PullRequestFetcher.new
    @observer = observer || PullRequestObserver.new
  end

  def call
    if pull_request.has_metadata? && pull_request.open?
      merged_at = fetcher.merged_at_for pull_request.url
      if merged_at
        pull_request.merged_at = merged_at
        pull_request.save!
        notify
      end
    end
  end

  private

  def notify
    observer.on_merged pull_request if observer
  end
end

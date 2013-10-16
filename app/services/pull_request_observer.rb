class PullRequestObserver
  def on_merged pull_request
    Resque.enqueue PullRequestMergeNotifier, pull_request.id
  end
end

class PullRequestMergeNotifier
  @queue = :notify

  def self.perform id
    pull_request = PullRequest.find id
    pull_request.create_notifications
  end
end

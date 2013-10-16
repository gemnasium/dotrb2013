class PullRequestBatchUpdater
  @queue = :batch_update

  def self.perform
    PullRequest.not_merged.pluck(:id).each do |id|
      Resque.enqueue PullRequestUpdater, id
    end
  end
end

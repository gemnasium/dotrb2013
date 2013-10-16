class PullRequest < ActiveRecord::Base
  has_many :subscriptions, dependent: :destroy
  has_many :subscribers, through: :subscriptions, source: :user

  scope :not_merged, -> { where(merged_at: nil) }

  def create_notifications
    subscribers.each do |subscriber|
      attributes = {pull_request_id: id, user_id: subscriber.id}
      Notification.find_or_create_by(attributes)
    end
  end

  def short_name
    # TODO move to some kind of presenter object
    "#{repo_owner_login}/#{repo_name} ##{number}"
  end
  alias :to_s :short_name

  def has_metadata?
    !title.nil?
  end

  def open?
    merged_at.nil?
  end

  def merged?
    !open?
  end
end

class User < ActiveRecord::Base
  has_many :subscriptions, dependent: :delete_all
  has_many :notifications, dependent: :delete_all

  has_many :watched_pull_requests, through: :subscriptions, source: :pull_request
  has_many :pending_pull_requests, through: :notifications, source: :pull_request

  def has_pending_pull_requests?
    pending_pull_requests.count > 0
  end
end

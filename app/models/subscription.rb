class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :pull_request

  default_scope -> { order('created_at DESC') }
end

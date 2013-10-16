class SubscriberMailer
  @queue = :mail

  def self.perform user_id
    user = User.find user_id
    self.new(user).call
  end

  attr_reader :user

  def initialize user
    @user = user
  end

  def call
    if has_pending_pulls?
      deliver_email
      clear_notifications
    end
  end

  private

  def deliver_email
    mail = UserMailer.merged_pull_requests_email(user, pending_pulls)
    mail.deliver
  end

  def has_pending_pulls?
    user.has_pending_pull_requests?
  end

  def pending_pulls
    user.pending_pull_requests
  end

  def clear_notifications
    user.notifications.delete_all
  end

end


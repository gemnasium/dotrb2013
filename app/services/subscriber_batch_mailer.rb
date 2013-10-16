class SubscriberBatchMailer
  @queue = :batch_mail

  def self.perform
    pending_subscribers.each do |user_id|
      deliver_mail_to_subscriber user_id
    end
  end

  private

  def self.pending_subscribers
    Notification.pluck(:user_id).uniq
  end

  def self.deliver_mail_to_subscriber user_id
    Resque.enqueue SubscriberMailer, user_id
  end

end

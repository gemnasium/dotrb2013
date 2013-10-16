class UserMailer < ActionMailer::Base
  default from: "notifier@ilovepullrequests.com"
  layout 'email'

  def merged_pull_requests_email(user, pull_requests)
    @pull_requests = pull_requests
    subject = "Pull Requests merged"
    mail(to: user.email, subject: subject)
  end
end

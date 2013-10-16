class SubscriptionManager
  attr_reader :user

  unless defined? AlreadySubscribed
    AlreadySubscribed = Class.new(StandardError)
  end

  def initialize user
    @user = user
  end

  def list
    user.subscriptions
  end

  def add_url html_url
    attributes = PullRequestHtmlUrl.new(html_url).parse.to_hash
    pull_request = PullRequestBuilder.from_attributes attributes
    if user.subscriptions.find_by(pull_request_id: pull_request.id)
      raise AlreadySubscribed, 'User has already subscribed to pull request #{pull_request}'
    end
    user.subscriptions.create!(pull_request_id: pull_request.id)
  end

  def remove_id subscription_id
    subscription = user.subscriptions.where(id: subscription_id).first
    pull_request = subscription.pull_request
    subscription.destroy
    # TODO remove pending notifications
    # TODO remove pull request if there is no attached subscription?
  end

end

class PullRequestBuilder
  def self.from_attributes attributes
    unless pull_request = find_by_url(attributes[:url])
      pull_request = PullRequest.create(attributes)
      Resque.enqueue PullRequestLoader, pull_request.id
    end
    pull_request
  end

  private

  def self.find_by_url url
    PullRequest.find_by({url: url})
  end
end

class PullRequestHtmlUrl
  attr_reader :html_url
  attr_reader :repo_owner_login, :repo_name, :number

  unless defined? ParsingError
    ParsingError = Class.new(StandardError)
  end

  def initialize html_url
    @html_url = html_url
  end

  def parse
     pattern = Regexp.new 'https://github.com/(?<owner>[^/]+)/(?<repo>[^/]+)/pull/(?<number>\d+)'
     unless match = html_url.match(pattern)
       raise ParsingError, 'Not a GitHub Pull Request HTML URL'
     end
     @repo_owner_login, @repo_name, @number = match.captures
     self
  end

  def url
    "https://api.github.com/repos/#{repo_owner_login}/#{repo_name}/pulls/#{number}"
  end

  def to_hash
    {
      url: url,
      html_url: url,
      repo_owner_login: repo_owner_login,
      repo_name: repo_name,
      number: number
    }
  end
end

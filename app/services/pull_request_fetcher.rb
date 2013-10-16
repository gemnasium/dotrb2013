require 'faraday'
require 'json'

# fetch pull request data for given API url

class PullRequestFetcher

  def metadata_for url
    raw = get_json(url)
    raw.select { |k,v| metadata_keys.include? k }
  end

  def merged_at_for url
    raw = get_json(url)
    raw['merged_at']
  end

  private

  def metadata_keys
    %w{url html_url number title body merged_at}
  end

  def get_json url
    body = client.get(url).body
    JSON.parse body
  end

  def client
    Faraday
  end
end

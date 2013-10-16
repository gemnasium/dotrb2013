Rails.application.config.middleware.use OmniAuth::Builder do
  # provider :developer unless Rails.env.production?
  provider :github, ENV['GITHUB_CLIENT_ID'], ENV['GITHUB_CLIENT_SECRET'], scope: 'user:email'

  on_failure do |env|
    request = Rack::Request.new(env)
    url = request.url.sub('callback', 'errback')
    [302, {'Location' => url}, []]
  end
end

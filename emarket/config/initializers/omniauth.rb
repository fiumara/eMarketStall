Rails.application.config.middleware.use OmniAuth::Builder do
  provider :oauth2, ENV['CLIENT_ID'], ENV['CLIENT_SECRET'],
           client_options: {
             site: 'https://example.com',
             authorize_url: '/oauth/authorize',
             token_url: '/oauth/token'
           },
           setup: lambda { |env|
             strategy = env['omniauth.strategy']
             strategy.options[:state] = SecureRandom.hex(24)
           }
end


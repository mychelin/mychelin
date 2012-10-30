ENV['OMNIAUTH_PROVIDER_KEY'] = '431080720288920'
ENV['OMNIAUTH_PROVIDER_SECRET'] = 'f5f70aec3ed9d8378f0419698843f4d6'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['OMNIAUTH_PROVIDER_KEY'], ENV['OMNIAUTH_PROVIDER_SECRET']
end

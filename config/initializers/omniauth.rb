Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV["GOOGLE_CLIENT_ID"], ENV["GOOGLE_CLIENT_SECRET"], {
    :name => "google",
    :scope => ['contacts.readonly', 'email', 'profile'],
    :prompt => "select_account",
    :access_type => 'offline'
  }
end

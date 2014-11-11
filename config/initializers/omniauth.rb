Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '674683422629380', '7fde92c865a3bb3494dc92629ff82b42'
           # :scope => 'email, user_birthday, read_stream', :display => 'popup'
end
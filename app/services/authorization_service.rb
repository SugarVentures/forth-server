class AuthorizationService
  def self.check_facebook(token)
    graph = Koala::Facebook::API.new(token, facebook_config['app_secret'])
    profile = graph.get_object('me', fields: 'name, email, id, age_range')
    { name: profile['name'],
      avatar: graph.get_picture('me', type: 'large'),
      email: profile['email'],
      fb_id: profile['id'],
      min_age: profile['age_range']['min'],
      metadata: { fb_token: token } }
  rescue Koala::Facebook::AuthenticationError, Koala::Facebook::ClientError
    raise AppException::InvalidFacebookToken
  end

  def self.update_facebook(data)
    user = User.where('email = ? OR fb_id = ? ', data[:email], data[:fb_id]).first
    user = User.new(email: data[:email]) if user.nil?
    attributes = { fb_id: data[:fb_id], min_age: data[:min_age], password: Devise.friendly_token[0, 20] }
    attributes.merge!(name: data[:name]) if user.name.blank?
    # attributes.merge!(remote_avatar_url: data[:avatar]) if user.avatar.blank?
    user.confirm! unless user.confirmed?
    user.update_attributes attributes
    user
  end

  def self.check_twitter(token, secret)
    client = TwitterOAuth::Client.new(
      consumer_key:     twitter_config['consumer_key'],
      consumer_secret:  twitter_config['consumer_secret'],
      token:            token,
      secret:           secret
    )
    return unless client.authorized?
    { name:         client.info['name'],
      avatar:       client.info['profile_image_url'].try(:gsub, '_normal', ''),
      screen_name:  client.info['screen_name']
    }
  end

  def self.update_twitter(data, params)
    user = User.find_by(fabric_id: params[:fabric_id])
    user = User.new(fabric_id: params[:fabric_id], email: SecureRandom.uuid + '@example.com', password: Devise.friendly_token[0, 20]) if user.nil?

    attributes = { fabric_auth_token:         params[:fabric_auth_token],
                   fabric_auth_token_secret:  params[:fabric_auth_token_secret] } # ,
    # fabric_screen_name:        data[:screen_name] }
    attributes.merge!(name: data[:name]) if user.name.blank?
    # attributes.merge!(remote_avatar_url: data[:avatar]) if user.avatar.blank?
    user.confirm! unless user.confirmed?
    user.update_attributes attributes
    user
  end

  def self.twitter_config
    Rails.application.secrets.twitter
  end

  def self.facebook_config
    Rails.application.secrets.twitter
  end
end

module ApiHelper
  def auth(api_user = user)
    { 'HTTP_X_AUTH_TOKEN' => api_user.try(:auth_token) || api_user }
  end
end

authenticator do
  token = ApiToken.where(:token => request.headers['X-Auth-Token'], :secret => request.headers['X-Auth-Secret']).first
  if token.is_a?(ApiToken)
    token
  else
    error :access_denied, "Invalid API credentials provided"
  end
end

default_access do
  auth.is_a?(ApiToken)
end

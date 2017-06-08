authenticator :default do
  lookup do
    token = ApiToken.where(:token => request.headers['X-Auth-Token'], :secret => request.headers['X-Auth-Secret']).first
    if token.is_a?(ApiToken)
      token
    else
      error :access_denied, "Invalid API credentials provided"
    end
  end

  rule :default, "AccessDenied", "Must be authenticated." do
    identity.is_a?(ApiToken)
  end
end


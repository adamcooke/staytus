
SAML SSO can be used instead of local accounts by adding a new initializer. For example the following can be used in `config/initializers/omniauth_saml.rb` to use samal instead of default auth.

    ENV['OMNIAUTH_SAML'] = '1'
    Rails.application.config.middleware.use OmniAuth::Builder do
      provider :saml,
        :assertion_consumer_service_url     => "https://nameofsite/auth/saml/callback",
        :issuer                             => "https://nameofsite",
        :idp_sso_target_url                 => "https://samalidp",
        :idp_cert                           => /path/to/cert
    end

More info about seting up saml can be found [here](https://github.com/omniauth/omniauth-saml)

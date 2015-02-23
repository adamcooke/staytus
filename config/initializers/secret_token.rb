if ENV['SECRET_KEY_BASE']
  Rails.application.config.secret_token = ENV['SECRET_KEY_BASE']
else
  unless File.exists?("config/secret_token.yml")
    puts ">> Generating new secret token in config/secret_token.yml"
    File.open("config/secret_token.yml", "w") do |f|
      f.write SecureRandom.hex(128).to_yaml
    end
  end
  Rails.application.config.secret_token = YAML.load(File.read("config/secret_token.yml"))
end


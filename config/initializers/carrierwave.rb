CarrierWave.configure do |config|
  if Rails.env.production?

    # Fog setup for comm with S3
    config.storage = :fog
    config.fog_credentials = {
      provider:               'AWS',
      aws_access_key_id:      ENV['AWS_ACCESS_KEY_ID'],
      aws_secret_access_key:  ENV['AWS_SECRET_ACCESS_KEY']
    }

    config.fog_directory      = 'android-dev-photobucket'
    config.fog_public         = false

  else

    # Don't upload to anything for non-prod
    config.storage = :file

  end
end

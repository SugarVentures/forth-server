CarrierWave.configure do |config|
  if Rails.env.development? || Rails.env.test?
    config.storage = :file
  else
    config.fog_directory = Rails.env.production? ? "firth.tv" : "staging.forth.tv"
    config.asset_host = Rails.application.secrets.aws['asset_host']
    fog_credentials = {
      :provider               => 'AWS',
      :region                 => Rails.application.secrets.aws['region'],
      :path_style             => true,
      :endpoint               => "https://s3-ap-southeast-1.amazonaws.com"
    }
    config.storage = :fog
    fog_credentials[:use_iam_profile] = true
    config.fog_credentials = fog_credentials
  end
end

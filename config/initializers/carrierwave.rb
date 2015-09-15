CarrierWave.configure do |config|
  if Rails.env.development? || Rails.env.test?
    config.storage = :file
    # config.enable_processing = false

    if Rails.env.test?
      ImageUploader
      VideoUploader

      CarrierWave::Uploader::Base.descendants.each do |klass|
        next if klass.anonymous?
        klass.class_eval do
          def cache_dir
            "#{Rails.root}/spec/support/uploads/tmp"
          end

          def store_dir
            "#{Rails.root}/spec/support/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
          end
        end
      end
    end
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

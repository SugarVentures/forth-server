Aws.config(Rails.application.secrets.aws) if Rails.application.secrets.aws

module Net
  class SMTP
    def tls?
      true
    end
  end
end

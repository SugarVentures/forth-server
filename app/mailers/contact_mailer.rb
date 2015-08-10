class ContactMailer < ActionMailer::Base
  default from: 'contact@forth.tv'

  def send_to_admin(contact)
    @contact = contact
    mail(to: 'van.pham@sugar.sg', subject: 'Contact form')
  end
end

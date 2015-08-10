class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(params['contact'])

    if @contact.valid?
      ContactMailer.send_to_admin(@contact).deliver
      flash[:success] = 'Thank you for your message!'
    else
      flash[:error] = 'Unable to submit your message. Please try again.'
      render :new
      return
    end
    if current_user
      redirect_to root_path
    else
      redirect_to root_path
    end
  end
end

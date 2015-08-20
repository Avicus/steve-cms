class Admin::SessionsController < Admin::BaseController
  layout 'admin/sessions'

  def login

  end

  def logout

  end

  def password_reset
    if request.post?
      @email = params[:email]
    end
  end

  def register

  end
end
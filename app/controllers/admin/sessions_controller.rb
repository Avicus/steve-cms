class Admin::SessionsController < Admin::BaseController
  layout 'admin/sessions'
  skip_before_filter :check_admin

  def login
    auth = @config.get(:authentication)

    identifiers = []

    auth.each do |name,config|
      identifiers += [name]
    end

    @identifier_names = identifiers.join(' or ').capitalize

    if request.post?
      user = nil
      identifiers.each do |name|
        if user == nil
          user = User.find_by_identifier(name, params[:identifier])
        end
      end

      if user == nil
        flash.now[:error] = "We couldn't find that user."
      elsif user.authenticate(params[:password])
        if params[:remember_me]
          cookies.signed[:user_id] = {value: user.id, expires: 2.weeks.from_now}
        else
          # expires at the end of the browser session
          cookies.signed[:user_id] = user.id
        end

        flash[:notice] = "Welcome back, #{user.name}!"
        redirect_to session[:redirect] || '/'
        session.delete :redirect
      else
        flash.now[:error] = "The account and password combination you entered don't match."
      end
    end
  end

  def logout
    cookies.delete(:user_id)
    flash[:warning] = 'You have signed out of your account.'
    redirect_to '/'
  end

  def password_reset
    if request.post?
      @email = params[:email]
    end
  end

  def register
    @user = User.new

    if request.post?
      @user = User.new(registration_params)
      if @user.save
        flash[:notice] = 'Success! Your account has been created.'
        redirect_to login_path
      end
    end
  end

  def registration_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
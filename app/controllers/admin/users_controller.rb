class Admin::UsersController < Admin::BaseController

  def index

  end

  def search
    @users = User.search_by_identifier(params[:search_type].downcase, params[:search])
    render :layout => nil
  end

end
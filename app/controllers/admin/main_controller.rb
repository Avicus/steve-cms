class Admin::MainController < Admin::BaseController

  def index
  end

  def not_found
    render :text => '404'
  end

end
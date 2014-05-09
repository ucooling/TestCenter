class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter  :get_group
  helper :all


  # def get_version
  #   @versions = {}
  #   items = Version.find(:all)
  #   items.each do |obj|
  #     if(@versions[obj.work_year])
  #       @versions[obj.work_year] << obj.identifer
  #     else
  #       @versions[obj.work_year] = [obj.identifer]
  #     end
  #   end
  # end

  def get_group
    @groups_all = Group.find(:all)
  end

  # def login
  #   if user = User.find_by_up(params[:name],params[:password])
  #       session[:current_user_id] = user.id
  #       redirect_to :controller => 'docs', :action=>'index'
  #     else
  #       redirect_to :controller => 'users', :action => 'login'
  #       flash[:notice] = t(:name_password_invalid)
  #     end
  # end


end

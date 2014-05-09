class UsersController < ActionController::Base
  layout "home_index"

  def index
    @users = User.find(:all)
    @groups_all = Group.find(:all)
  end

  def create_user
    user = User.new()
    username = params[:username]
    password = params[:password]
    user.username = username
    user.password = password
    user.save
    redirect_to :back
  end 

  def update_user
    user = User.find_by_id(params[:id])
    user.username = params[:username]
    user.password = params[:password]
    user.save
    redirect_to :action=>"index"
  end

  def get_info
    @rsc = User.find(params[:id])
    render :json=>{
      :username => @rsc.username,
      :password => @rsc.password
    }
  end

  def delete
    user = User.find(params[:id])
    user.delete
    redirect_to :back
  end

  def dologin
    
  end


end
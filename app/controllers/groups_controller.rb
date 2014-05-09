class GroupsController < ApplicationController
  layout "home_index"

  def index
    @group = Group.find(:all)
  end

  def new
    @group = Group.new()
  end

  def create_group
    group = Group.new()
    group.group_name = params[:group_name]
    group.save
    redirect_to :action=>"index"
  end

  def delete
    group = Group.find(params[:id])
    group.delete
    redirect_to :back
  end

  def update_group
    group = Group.find_by_id(params[:id])
    group.group_name = params[:group_name]
    group.save
    redirect_to :action=>"index"
  end

  def get_info
    @rsc = Group.find(params[:id])
    render :json=>{
      :group_name => @rsc.group_name
    }
  end
end

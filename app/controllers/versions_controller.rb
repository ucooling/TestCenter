class VersionsController < ActionController::Base
  layout "home_index"
  
  
  def index
    @versions = Version.paginate(:page=>params[:page],:per_page=>14)
    @groups_all = Group.find(:all)
  end

  def new
    @groups_all = Group.find(:all)
    @version = Version.new();
  end

  def create
    version = Version.new(params[:version])
    version.save
    redirect_to :action=>"new"
  end

  def update_version
    version = Version.find_by_id(params[:id])
    version.work_year = params[:work_year]
    version.identifer = params[:identifer]
    version.save
    redirect_to :action=>"index"
  end

  def get_info
    @rsc = Version.find(params[:id])
    render :json=>{
      :work_year => @rsc.work_year,
      :identifer => @rsc.identifer
    }
  end

  def create_version
    version = Version.new()
    work_year = params[:work_year]
    identifer = params[:identifer]
    version.work_year = work_year
    version.identifer = identifer
    version.save
    redirect_to :back
  end
end
class ProjectController < ApplicationController
  require 'zip'
  layout "home_index"
  before_filter "project_search"
  #index page
  def index
    @project = Project.paginate(:page=>params[:page],:per_page=>15)
    @projects = @project
    @project_new = Project.new
    version = Version.find(:all)
    @group_items = []
    group = Group.find(:all)
    group.each do |item|
      @group_items << item.group_name
    end
    @work_year = []
    @identifers = []
    @identifer = {}
    version.each do |obj|
      @work_year << obj.work_year
      @identifers << obj.identifer
      if(@identifer[obj.work_year])
        @identifer[obj.work_year] << obj.identifer
      else
        @identifer[obj.work_year] = [obj.identifer]
      end
    end
    @work_year.uniq!
  end

  #add new method
  def new
    @project = Project.new

  end

  def create
    @project = Project.new(params[:project])
    #group = Group.find(:first, :conditions=>{:group_name=>"#{params[:project][:group_id]}"})
    @project.group_id = params[:group_id]
    @project.save
    id = @project.id
    project_name = @project.project_name
    #在public目录下新建相应的文件夹
    Dir.mkdir("#{Rails.root}/public/attachment_file/#{project_name}_#{id}")
    redirect_to :back
  end

  def show
    @project = Project.find(params[:id])
    @test_file= TestFile.find(:all, :conditions=>{:project_id=>"#{@project.id}"})
    @attachment_all = Attachment.find(:all,:conditions=>{:project_id=>"#{@project.id}"})
  end

  def destroy
    project = Project.find(params[:id])
    test_file = TestFile.find(:all, :conditions=>{:project_id=>"#{project.id}"})
    project.destroy
    # test_file.each do |item|
    #   Dir.rmdir("#{Rails.root}/public/attachment_file/#{project.project_name}_#{project.id}/#{item.test_file_name}_#{item.id}")
    # end
    #   Dir.rmdir("#{Rails.root}/public/attachment_file/#{project.project_name}_#{project.id}")
    redirect_to :back
  end

  def get_identifer
    @rsc = {}
    option = []
    items = Version.where("work_year=?",params[:id])
    items.each do |item|
      option << item.identifer
    end

    option.each_with_index do |item,index|
      @rsc[index]=item
    end
    render :json=>@rsc
  end

  def get_project
    work_y = params[:work_year]
    ident = params[:identifer]
    @project = Project.where("work_year=? and identifer=?",work_y,ident)
  end

  def find_project_group
   @group_id = params[:group_id]
   @project = Project.where("group_id=?", @group_id).paginate(:page=>params[:page],:per_page=>15)
   version = Version.find(:all)
   @work_year = []
    @identifers = []
    @identifer = {}
    version.each do |obj|
      @work_year << obj.work_year
      @identifers << obj.identifer
      if(@identifer[obj.work_year])
        @identifer[obj.work_year] << obj.identifer
      else
        @identifer[obj.work_year] = [obj.identifer]
      end
    end
    @work_year.uniq!
    @project_new = Project.new()
  end

  def project_search
    work_y = params[:work_y]
    identi = params[:identifer]
    group_id = params[:group_name]
    @project_search = Project.where("group_id=? and work_year=? and identifer=?",group_id,work_y,identi)
    version = Version.find(:all)
   @work_year = []
    @identifers = []
    @identifer = {}
    version.each do |obj|
      @work_year << obj.work_year
      @identifers << obj.identifer
      if(@identifer[obj.work_year])
        @identifer[obj.work_year] << obj.identifer
      else
        @identifer[obj.work_year] = [obj.identifer]
      end
    end
    @work_year.uniq!
  end

  #update project
  def edit_project
    project = Project.find_by_id(params[:id])
    project_name_1 = project.project_name
    project.project_name = params[:project_name]
    project_name_2=params[:project_name]
    project.description = params[:description]
    project.save
    File.rename("#{Rails.root}/public/attachment_file/#{project_name_1}_#{project.id}","#{Rails.root}/public/attachment_file/#{project_name_2}_#{project.id}")
    # File.rename("#{Rails.root}/public/attachment_file/#{project_name}_#{id}")
    redirect_to :back

  end

  def get_info
    @rsc = Project.find(params[:id])
    render :json=>{
      :project_name => @rsc.project_name,
      :description => @rsc.description
    }
  end

  def diagram
    #case 统计部分
    @project = Project.find(params[:id])
    test_files = @project.test_files
    @files_count  = test_files.size
    test_cases = []
    @diagram_data = {}
    @diagram_data[:file_data] = []
    total_count = 0
    total_ok_count = 0
    total_ng_count = 0
    total_ng_ok_count = 0
    #get every test file's data
    test_files.each do|test_file|
      case_count = 0
      ok_count = 0
      ng_count = 0
      ng_ok_count = 0
      case_count = test_file.get_test_case_count
      ok_count = test_file.get_ok_count
      ng_count = test_file.get_ng_count
      ng_ok_count = test_file.get_ng_ok_count
      file_data = {:file_name=>test_file.test_file_name,
                   :file_id=>test_file.id,
                   :case_count=>case_count,
                   :ok_count=>ok_count,
                   :ng_count=>ng_count,
                   :ng_ok_count=>ng_ok_count}
      total_count += case_count
      total_ok_count += ok_count
      total_ng_count += ng_count
      total_ng_ok_count += ng_ok_count
      @diagram_data[:file_data] << file_data
    end
    @diagram_data[:total_count] = total_count
    @diagram_data[:total_ok_count] = total_ok_count
    @diagram_data[:total_ng_count] = total_ng_count
    @diagram_data[:total_ng_ok_count] = total_ng_ok_count

    #每个人测试的case总数的统计

    #用一个数组来保存改作业的所有case
    # example_count=[]
    # member=[]
    # member_count=[]
    # test_files.each do |test_file|
    #   examples=[]
    #   examples = Example.where("test_file_id",test_file.id)
    #   example_count << examples
    # end
    # xx = []
    # example_count.each do |item|
    #   item.each do |item1|
    #     xx << item1
    #   end
    # end
    example_case=[]
    @result={}
    @examples=[]
    test_files.each do |item1|
      example = Example.where("test_file_id=?",item1.id)
      example_case << example
    end
    @examples = example_case.flatten!
    #定义一个数组来保存所有的测试人员
    member=[]
    @examples.each do |item2|
      member << item2.implement_people
      @result[item2.implement_people] = @result[item2.implement_people].blank? ? 1 : @result[item2.implement_people] + 1 unless item2.implement_people.blank?
    end
  end

  # def download
  #   project = Project.find(params[:id])
  #   folder = "#{Rails.root}/public/attachment_file/#{project.project_name}_#{project.id}"   #要解压/压缩文件的目录路径
  #   input_filenames = ['01_Available_Resource_Lserver_migrate_26','02_Available_Resource_VM_27']

  #   zipfile_name = "#{Rails.root}/public/attachment_file/#{project.project_name}_#{project.id}/#{project.project_name}_#{project.id}.zip"   #需要的zip文件路径和这个文件的名字

  #   Zip::File.open(zipfile_name, Zip::File::CREATE) do |zipfile|
  #     input_filenames.each do |filename|
  #     # add方法中要有两个参数:
  #     # - filename 压缩包中文件名
  #     # - folder就是路径，‘/’后是要解压/压缩的文件的名称
  #       zipfile.add(filename, folder + '/' + filename)
  #     end
  #   end
  #   send_file "#{Rails.root}/public/attachment_file/#{project.project_name}_#{project.id}/#{project.project_name}_#{project.id}.zip"
  # end

  def add_to_zip_file(zip_file_name,file_path)
    def self.add_file(start_path,file_path,zip)
      if File.directory?(file_path)
        zip.mkdir(file_path)
        Dir.foreach(file_path) do |filename|
          add_file("#{start_path}/#{filename}","#{file_path}/#{filename}",zip) unless filename=="." or filename==".."
        end
      else
        zip.add(start_path,file_path)

      end
    end
    if File.exist?(zip_file_name)
      #      puts "文件已存在，将会删除此文件并重新建立。"
      File.delete(zip_file_name)
    end
    # 取得要压缩的目录父路径，以及要压缩的目录名
    chdir,tardir = File.split(file_path)
    # 切换到要压缩的目录
    Dir.chdir(chdir) do
      # 创建压缩文件
      #      puts "开始创建压缩文件"
      Zip::File.open(zip_file_name,Zip::File::CREATE) do |zipfile|
        #        puts "文件创建成功，开始添加文件..."
        # 调用add_file方法，添加文件到压缩文件
        #        puts "已添加文件列表如下:"
        add_file(tardir,tardir,zipfile)
      end
    end
  end

  def download
    project = Project.find(params[:id])
    test_files =TestFile.where("project_id=?",project.id)
    test_files.each do |item|
      aa = download_testfile(item.id)
     FileUtils.cp("#{Rails.root}/public/test.html", "#{Rails.root}/public/test1.html")
      f = FileUtils.mv("#{Rails.root}/public/test1.html", "#{Rails.root}/public/attachment_file/#{project.project_name}_#{project.id}/#{item.test_file_name}_#{item.id}/test_file/#{item.test_file_name}.html")
      File.open("#{Rails.root}/public/attachment_file/#{project.project_name}_#{project.id}/#{item.test_file_name}_#{item.id}/test_file/#{item.test_file_name}.html","wb") do |f|
        f.write(aa)
      end
    end
    if (File.exist?("#{Rails.root}/public/attachment_file/#{project.project_name}_#{project.id}.zip"))
      File.delete("#{Rails.root}/public/attachment_file/#{project.project_name}_#{project.id}.zip")
    end
    add_to_zip_file("#{Rails.root}/public/attachment_file/#{project.project_name}_#{project.id}.zip","#{Rails.root}/public/attachment_file/#{project.project_name}_#{project.id}")
    send_file "#{Rails.root}/public/attachment_file/#{project.project_name}_#{project.id}.zip"
  end

  #获得文件流
  def download_testfile(xxx)
    @example = Example.find_all_by_test_file_id(xxx)
    @test_file_id = xxx
    @test_file = TestFile.find(@test_file_id)
    test_file = TestFile.find(@test_file_id)
    project = Project.find(test_file.project_id)
    example_case = []
    @example.each do |example|
      str = example.content
      str_s = str.split(",")
      str_case = []
      str_s.each do |str|
        str_case << str.to_i
      end
      example_case << str_case
    end
    arr = []
    example_case.each do |example|
      example.each do |e|
       if(arr.include?(e))
        next
      else
        arr << e
      end
      end

    end
    @arr={}
    divisor = []
    arr.each do |arr|
      divisor << Divisor.find_by_id(arr)
    end

    divisor.each do |d|
      @arr["#{d.id}"] = "#{d.divisor_name}"
    end
    aa = render_to_string :layout=>nil
  end
end

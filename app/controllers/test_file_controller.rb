class TestFileController < ApplicationController
	layout 'home_index'

	#添加测试文件的方法
	def index
	  @test_file = TestFile.find(:all)
	end
	def new
		project_id = params[:project_id]
		@test_file_new = TestFile.new
		@test_file.project_id = project_id
	end

	def create
    @test_file = TestFile.new()
    @test_file.test_file_name = params[:test_file_name]
    @test_file.project_id = params[:project_id]
		@test_file.save
		project = Project.find(params[:project_id])
		if(project.test_file_id.blank?)
			project.test_file_id = (@test_file.id).to_s

	  else
      project.test_file_id +=(","+(@test_file.id).to_s)
	  end
    #在public相应的作业目录下创建相应的作业文件夹
		Dir.mkdir("#{Rails.root}/public/attachment_file/#{project.project_name}_#{project.id}/#{@test_file.test_file_name}_#{@test_file.id}")
    Dir.mkdir("#{Rails.root}/public/attachment_file/#{project.project_name}_#{project.id}/#{@test_file.test_file_name}_#{@test_file.id}/test_file")
    Dir.mkdir("#{Rails.root}/public/attachment_file/#{project.project_name}_#{project.id}/#{@test_file.test_file_name}_#{@test_file.id}/test_file/screenshot")
		project.save
		id = @test_file.id
		redirect_to :controller=>"project" ,:action=>"show", :id=>@test_file.project_id
	end

	#show test_file just now
	def show
		@test_file = TestFile.find(params[:id])
		project = Project.find_by_id(@test_file.project_id)
		@project_name = project.project_name;
    @project_id = project.id
		@factor= Factor.find(:all, :conditions=>{:test_file_id=>"#{@test_file.id}"},:order=>:queue)
	end

	def destroy
    test_file = TestFile.find(params[:id])
    project = Project.find_by_id(test_file.project_id)
    test_file.destroy
    File.directory?("#{Rails.root}/public/attachment_file/#{project.project_name}_#{project.id}/#{test_file.test_file_name}_#{test_file.id}")
    File.directory?("#{Rails.root}/public/attachment_file/#{project.project_name}_#{project.id}/#{test_file.test_file_name}_#{test_file.id}/test_file")
    File.directory?("#{Rails.root}/public/attachment_file/#{project.project_name}_#{project.id}/#{@test_file.test_file_name}_#{@test_file.id}/evidence")
    redirect_to :back
	end

	def edit_test_file
    test_file = TestFile.find_by_id(params[:id])
    project = Project.find(test_file.project_id)
    test_file_name_1 = test_file.test_file_name
    test_file.test_file_name = params[:test_file_name]
    test_file_name_2 = params[:test_file_name]
    test_file.save
    File.rename("#{Rails.root}/public/attachment_file/#{project.project_name}_#{project.id}/#{test_file_name_1}_#{test_file.id}","#{Rails.root}/public/attachment_file/#{project.project_name}_#{project.id}/#{test_file_name_2}_#{test_file.id}")
    redirect_to :back
	end

	def get_info
    @rsc = TestFile.find(params[:id])
    render :json=>{
      :test_file_name => @rsc.test_file_name,
    }
  end

  #下载相应的测试文件
  def download_testfile
    @example = Example.find_all_by_test_file_id(params[:test_file_id])
    @test_file_id = params[:test_file_id]
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
    # Dir.delete("#{Rails.root}/public/attachment_file/#{project.project_name}_#{project.id}/#{test_file.test_file_name}_#{test_file.id}/test_file")
    # rescue Errno::ENOTEMPTY
    #Dir.mkdir("#{Rails.root}/public/attachment_file/#{project.project_name}_#{project.id}/#{test_file.test_file_name}_#{test_file.id}/test_file")
    FileUtils.cp("#{Rails.root}/public/test.html", "#{Rails.root}/public/test1.html")
    f = FileUtils.mv("#{Rails.root}/public/test1.html", "#{Rails.root}/public/attachment_file/#{project.project_name}_#{project.id}/#{test_file.test_file_name}_#{test_file.id}/test_file/#{test_file.test_file_name}.html")
    File.open("#{Rails.root}/public/attachment_file/#{project.project_name}_#{project.id}/#{test_file.test_file_name}_#{test_file.id}/test_file/#{test_file.test_file_name}.html","wb") do |f|
      f.write(aa)
    end
    send_file "#{Rails.root}/public/attachment_file/#{project.project_name}_#{project.id}/#{test_file.test_file_name}_#{test_file.id}/test_file/#{test_file.test_file_name}.html"
    # send_file "#{Rails.root}/public/attachment_file/#{project.project_name}_#{project.id}/#{test_file.test_file_name}_#{test_file.id}/screenshot"
  end

  def xx
    puts "xx"
  end

end

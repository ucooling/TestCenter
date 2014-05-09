class DivisorController < ApplicationController
	layout "home_index"

	#添加测试文件的方法
	def index
	end
	def new
		@divisor = Divisor.new
		@divisor.factor_id= params[:factor_id]
	end

	def create
    @divisor = Divisor.new()
    @divisor.divisor_name = params[:factor_divistor_name]
    @divisor.queue = params[:queue]
    @divisor.factor_id = params[:test_file_or_factor]
		@divisor.save
		# factor = Factor.find(params[:factor_id])
		redirect_to :back
	end

	def destroy
    arr = params[:divisor_arr]
    arr_1 = arr.split(",")
    p arr_1
    arr_1.each do |i|
      divisor=nil
      divisor = Divisor.find(i.to_i)
      divisor.destroy
    end
    redirect_to :back
	end

  def edit
    divisor = Divisor.find_by_id(params[:id])
    divisor.divisor_name = params[:factor_divistor_name]
    queue = params[:queue]
    divisor_queue_1 = []
    divisor_queue_1 = Divisor.where("factor_id=?",divisor.factor_id)
    divisor_queue_1.map do |item|
      if item.queue >= (queue.to_i)
        item.queue +=1
        item.save
      end
    end
    divisor.queue = params[:queue]
    divisor.save
    redirect_to :back
  end

  def get_info_update
    @rsc = Divisor.find(params[:id])
    render :json=>{
      :factor_divistor_name => @rsc.divisor_name,
      :queue => @rsc.queue
    }
  end

  def get_info_create
    rsc = Divisor.where("factor_id=?", params[:id])
    rsc_max_1 = []
    rsc.each do |item|
      rsc_max_1 << item.queue
    end
    rsc_max = rsc_max_1.sort.last
    render :json=>{
      :queue => rsc_max
    }
  end

end
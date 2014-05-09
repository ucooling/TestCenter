class FactorController < ApplicationController
  layout 'home_index'

  def new
  	@factor = Factor.new()
    @factor.test_file_id = params[:test_file_id]
  end

  def create
  	@factor = Factor.new(params[:factor])
   #  @factor.test_file_id=params[:test_file_id]
    @factor.factor_name = params[:factor_divistor_name]
    @factor.test_file_id = params[:test_file_or_factor]
  	@factor.save
  	redirect_to :controller=>"test_file", :action=>"show", :id=>"#{@factor.test_file_id}"
  end

  def destroy
    factor = Factor.find(params[:id])
    factor.destroy
    redirect_to :back
  end

  def get_info
    p params[:id]
    divisors = Divisor.where("factor_id=?",params[:id])
    @rsc={ 
      :divisors=>divisors
    }

  end

  def get_info_update
    @rsc = Factor.find(params[:id])
    render :json=>{
      :factor_divistor_name => @rsc.factor_name,
      :queue => @rsc.queue
    }
  end

  def edit
    factor = Factor.find_by_id(params[:id])
    factor.factor_name = params[:factor_divistor_name]
    queue = params[:queue]
    factor_queue_1 = []
    factor_queue_1 = Factor.where("test_file_id=?",factor.test_file_id)
    factor_queue_1.map do |item|
      if item.queue >= (queue.to_i)
        item.queue +=1
        item.save
      end
    end
    factor.queue = params[:queue]
    factor.save
    redirect_to :back
  end

  def get_info_create
    rsc = Factor.where("test_file_id=?", params[:id])
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
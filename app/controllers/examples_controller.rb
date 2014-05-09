class ExamplesController < ApplicationController
  layout 'home_index'
  def show
    @example = Example.find_all_by_test_file_id(params[:test_file_id])
    @test_file_id = params[:test_file_id]
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
  end

  def edit_case
    example = Example.find(params[:example_id])
    example.status = params[:status]
    example.affirm = params[:affirm]
    example.result = params[:result]
    example.implement_time = params[:implement_time]
    example.implement_people = params[:implement_people]
    example.remark = params[:remark]
    example.again_implement_time = params[:again_implement_time]
    example.again_implement_people = params[:again_implement_people]
    example.save
    redirect_to :action=>"show", :test_file_id=>params[:test_file_id]
  end

  def set_default
    test_file_id = params[:test_file_id]
    example = Example.find_all_by_test_file_id(test_file_id)
    status = params[:status]
    affirm = params[:affirm]
    result = params[:result]
    implement_time = params[:implement_time]
    implement_people = params[:implement_people]
    remark = params[:remark]
    again_implement_time = params[:again_implement_time]
    again_implement_people = params[:again_implement_people]
    example.each do |e|
      e.status = status unless status.blank?
      e.affirm = affirm unless affirm.blank?
      e.result = result unless result.blank?
      e.implement_time = implement_time unless implement_time.blank?
      e.implement_people = implement_people unless implement_people.blank?
      e.remark = remark unless remark.blank?
      e.again_implement_time = again_implement_time  unless again_implement_time.blank?
      e.again_implement_people = again_implement_people unless again_implement_people.blank?
      e.save
    end
    redirect_to :action=>"show", :test_file_id=>params[:test_file_id]

  end

  def get_info
    @rsc = Example.find(params[:id])
    test_file = @rsc.test_file
    project = test_file.project
    result_data = {
            :example_id => @rsc.id,
            :status => @rsc.status,
            :affirm =>@rsc.affirm,
            :result =>@rsc.result,
            :implement_time =>@rsc.implement_time,
            :implement_people =>@rsc.implement_people,
            :remark =>@rsc.remark,
            :again_implement_time =>@rsc.again_implement_time,
            :again_implement_people =>@rsc.again_implement_people
          }
    evidence = @rsc.evidence
    if evidence
      if evidence.example_id != evidence.evidence_id
        result_data[:flag] = true
        result_data[:evidence_uri] = "/attachment_file/#{project.project_name}_#{project.id}/#{test_file.test_file_name}_#{test_file.id}/test_file/screenshot/#{evidence.evidence_id}.png"
      else
        result_data[:flag] = false
        result_data[:evidence_uri] = "/attachment_file/#{project.project_name}_#{project.id}/#{test_file.test_file_name}_#{test_file.id}/test_file/screenshot/#{evidence.example_id}.png"
      end
    end

    render :json => result_data
  end


  def cancel_edit
    key = params[:id]
    example = Example.find(key)
    example.remark="1"
    example.save!
    render :json=>{
      :remark=>example.remark
    }
  end

  def able_edit
    key = params[:id]
    example = Example.find(key)
    example.remark="0"
    example.save!
    render :json=>{
      :remark=>example.remark
    }
  end

  def delete_case
    example_id = params[:example_id]
    # position = params[:table_position]
    example = Example.find(example_id)
    # test_file_id = example.test_file_id
    example.delete
    # redirect_to :action=>'show', :id=>example_id, :test_file_id=>test_file_id, :position_table=>position
    redirect_to :back
  end

  #delete all case
  def delete_all_case
    key = params[:delete_case]
    key_id = key.split(",")
    test_file_id = Example.find(key_id[0]).test_file_id
    key_id.each do |item|
      example = Example.find(item)
      example.delete
    end
    redirect_to :back
  end

  def save_example
    redirect_to :back
  end

  def upload_img
    example = Example.find(params[:id])
    test_file = example.test_file
    project = test_file.project
    evidence = example.evidence
    if evidence.blank?
      evidence = Evidence.new
      evidence.example_id = example.id
      evidence.project_id = project.id
      evidence.test_file_id = test_file.id
      evidence.evidence_id = example.id
      evidence.save
    end
    File.open("#{Rails.root}/public/attachment_file/#{project.project_name}_#{project.id}/#{test_file.test_file_name}_#{test_file.id}/test_file/screenshot/#{params[:id]}.png", "wb") do |f|
      f.write(params[:upload_file].read)
    end
    render :json=>{
      :success=>"success"
    }
  end

  def edit_evidence
    example = Example.find(params[:id])
    test_file = example.test_file
    project = test_file.project
    evidence = example.evidence
    if evidence.blank?
      evidence = Evidence.new
      evidence.example_id = example.id
      evidence.project_id = project.id
      evidence.test_file_id = test_file.id
    end
    if test_file.examples[params[:evidence_id].to_i-1]
      evidence.evidence_id = test_file.examples[params[:evidence_id].to_i-1].id
      evidence.save
      render :json=>{
        :success=>"success"
      }
    else
      render :json=>{
        :success=>"failed"
      }
    end

  end

end

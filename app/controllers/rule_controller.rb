class RuleController < ApplicationController
 
  #create case 
  def create
  	test_file= TestFile.find(params[:test_file])
    xx = params[:data]
    example_case=eval(xx)

    str = "example_case[0]"
     (1..example_case.length-1).each{|i|str+=".product(example_case[#{i}])"}
      rule = eval(str)
      rules=[]
      rule.each do |r|
        rules << r.flatten
      end

      rules.each do |r|
        str=nil
        example=nil
        str= r.join(",")
        example=Example.new
        example.content=str
        example.test_file_id= test_file.id
        example.save
      end
      @item= []
      rules.each do |r|
        item= nil
        r.each do |j|
          item = Divisor.find_by_id(j) 
          @item << item

        end
      end  	
  	  redirect_to :controller=>"examples", :action=>"show",:test_file_id=>test_file.id
  end
end
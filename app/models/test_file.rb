class TestFile < ActiveRecord::Base
  attr_accessible :test_file_name
  has_many :factors , :foreign_key=>"test_file_id", :dependent=>:destroy
  has_many :rules, :foreign_key=>"test_file_id", :dependent=>:destroy
  has_many :examples, :foreign_key=>"test_file_id", :dependent=>:destroy
  belongs_to :project

  def get_test_case_count
    return examples.size
  end

  def get_ok_count
    return examples.map{|item|item if item.result == "OK"}.compact.size
  end

  def get_ng_count
   return examples.map{|item|item if item.result == "NG"}.compact.size
  end

  def get_ng_ok_count
    return examples.map{|item|item if item.result == "NG-OK"}.compact.size
  end
end

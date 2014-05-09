class Example < ActiveRecord::Base
  attr_accessible :affirm, :again_implement_people, :again_implement_time, :content, :implement_people, :implement_time, :remark, :result, :status
  has_one :evidence, :foreign_key=>"example_id", :dependent=>:destroy
  belongs_to :test_file
  validates :content, :uniqueness=>true
end

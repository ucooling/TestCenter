class Factor < ActiveRecord::Base
  attr_accessible :factor_name
  has_many :divisors, :foreign_key=>"factor_id", :dependent=>:destroy
  belongs_to :test_file
end

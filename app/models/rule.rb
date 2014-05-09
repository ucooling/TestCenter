class Rule < ActiveRecord::Base
  attr_accessible :content
  belongs_to :test_file
end

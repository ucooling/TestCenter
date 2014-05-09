class Divisor < ActiveRecord::Base
  attr_accessible :divisor_name, :factor_id
  belongs_to :factor

end

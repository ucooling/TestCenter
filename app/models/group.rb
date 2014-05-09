class Group < ActiveRecord::Base
  attr_accessible :group_name
  has_many :projects

  validates :group_name, :presence=>true, :uniqueness=>true
end

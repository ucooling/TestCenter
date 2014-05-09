class Project < ActiveRecord::Base
  attr_accessible :description, :project_name, :test_file_id, :work_year, :identifer, :group_id
  has_many :test_files, :foreign_key=>"project_id", :dependent=>:destroy
  belongs_to :group

  # def add_file_to_public(project_id)
  #   Dir.mkdir("#{Rails.root}/public/attachment_file/#{project_id}")
  # end
end

class Attachment < ActiveRecord::Base
  attr_accessible :file_name, :file_url, :project_id
end

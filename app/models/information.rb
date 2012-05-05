class Information < ActiveRecord::Base
  attr_accessible :message, :project_id, :user_id
  
  belongs_to :project
end

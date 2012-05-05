class Member < ActiveRecord::Base
  attr_accessible :email, :project_id, :user_id
  
  belongs_to :project
end

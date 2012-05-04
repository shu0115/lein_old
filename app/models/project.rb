class Project < ActiveRecord::Base
  attr_accessible :description, :email, :image, :supporter_count, :title, :url, :user_id
  
  has_many :supporters
  belongs_to :user
end

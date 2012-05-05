class Project < ActiveRecord::Base
  attr_accessible :description, :email, :image, :supporter_count, :title, :url, :user_id
  
  belongs_to :user
  has_many :supporters
  has_many :members
end

class Project < ActiveRecord::Base
  attr_accessible :description, :email, :image, :supporter_count, :title, :url, :user_id, :hash_tag
  
  belongs_to :user
  has_many :supporters
  has_many :members
  has_many :information
end

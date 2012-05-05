# coding: utf-8
class Supporter < ActiveRecord::Base
  attr_accessible :payment, :project_id, :user_id
  
  belongs_to :project
  belongs_to :user

  scope :payment_ok, lambda { where( payment: true ) }
  
  private
  
  #------------------#
  # self.add_support #
  #------------------#
  def self.add_support( project_id, user_id )
    if self.where( project_id: project_id, user_id: user_id ).exists?
      alert = "既にサポーターになっています。"
    else
      if self.create( project_id: project_id, user_id: user_id )
        notice = "サポーターになりました。"
        
        # サポーター数カウント
        self.supporter_count( project_id )
      else
        alert = "サポーター登録に失敗しました。"
      end
    end
    
    return notice, alert
  end
  
  #---------------------#
  # self.delete_support #
  #---------------------#
  def self.delete_support( project_id, user_id )
    supporter = self.where( project_id: project_id, user_id: user_id ).first
    
    if supporter.blank?
      alert = "既にサポーターではありません。"
    else
      if supporter.destroy
        notice = "サポーターをやめました。"
        
        # サポーター数カウント
        self.supporter_count( project_id )
      else
        alert = "サポーター登録削除に失敗しました。"
      end
    end
    
    return notice, alert
  end
  
  #----------------------#
  # self.supporter_count #
  #----------------------#
  def self.supporter_count( project_id )
    project = Project.where( id: project_id ).first
    project.update_attributes( supporter_count: self.payment_ok.count.to_i )
  end
end

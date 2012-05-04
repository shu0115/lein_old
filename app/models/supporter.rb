# coding: utf-8
class Supporter < ActiveRecord::Base
  attr_accessible :payment, :project_id, :user_id
  
  belongs_to :project
  belongs_to :user

  private
  
  #------------------#
  # self.add_support #
  #------------------#
  def self.add_support( project_id, user_id )
    if Supporter.where( project_id: project_id, user_id: user_id ).exists?
      alert = "既にサポーターになっています。"
    else
      if Supporter.create( project_id: project_id, user_id: user_id )
        notice = "サポーターになりました。"
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
    supporter = Supporter.where( project_id: project_id, user_id: user_id ).first
    
    if supporter.blank?
      alert = "既にサポーターではありません。"
    else
      if supporter.destroy
        notice = "サポーターをやめました。"
      else
        alert = "サポーター登録削除に失敗しました。"
      end
    end
    
    return notice, alert
  end
end

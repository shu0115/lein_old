# coding: utf-8
class ProjectsController < ApplicationController

  #-------#
  # index #
  #-------#
  def index
    @projects = Project.includes( :user, { :supporters => :user } ).all
  end

  #--------#
  # recent #
  #--------#
  def recent
    @projects = Project.order( "created_at DESC" ).includes( :user, { :supporters => :user } ).all
    render action: "index"
  end

  #---------#
  # popular #
  #---------#
  def popular
    @projects = Project.order( "supporter_count DESC" ).includes( :user, { :supporters => :user } ).all
    render action: "index"
  end

  #------#
  # show #
  #------#
  def show
    @project = Project.where( id: params[:id] ).includes( :supporters, :members, :information ).first
    
    supporter = Supporter.where( project_id: @project.id, user_id: session[:user_id] ).first
    
    unless supporter.blank?
      begin
        recurring = PaypalApi.get_recurring_profile( supporter.profile_id )
      rescue Paypal::Exception::APIError => e
        flash.now[:alert] = e.message
      end
    end
  end

  #-----#
  # new #
  #-----#
  def new
    @project = Project.new
    
    @submit = "create"
  end

  #------#
  # edit #
  #------#
  def edit
    @project = Project.where( id: params[:id], user_id: session[:user_id] ).first
    
    @submit = "update"
  end

  #--------#
  # create #
  #--------#
  def create
    @project = Project.new( params[:project] )
    @project.user_id = session[:user_id]
    @project.hash_tag = "#" + @project.hash_tag.to_s

    if @project.save
      redirect_to( { action: "index" }, notice: "Project was successfully created." )
    else
      render action: "new"
    end
  end

  #--------#
  # update #
  #--------#
  def update
    @project = Project.where( id: params[:id], user_id: session[:user_id] ).first

    if @project.update_attributes( params[:project] )
      redirect_to( { action: "show", id: params[:id] }, notice: "Project was successfully updated." )
    else
      render action: "edit", id: params[:id]
    end
  end

  #---------#
  # destroy #
  #---------#
  def destroy
    @project = Project.where( id: params[:id], user_id: session[:user_id] ).first
    @project.destroy

    redirect_to action: "index"
  end

  #---------------#
  # add_supporter #
  #---------------#
  def add_supporter
    project_id = params[:project_id]
    token = params[:token]
    
    if token.blank?
      success_calback_url = request.url
      cancel_calback_url = url_for( controller: "projects", action: "show", id: project_id )
      
      # PayPal取引開始
      redirect_uri = PaypalApi.set_express_checkout( success_calback_url, cancel_calback_url )
      
      redirect_to redirect_uri and return
    else
      # PayPal定期支払作成
      profile_id = PaypalApi.create_recurring( token )

      if profile_id.blank?
        redirect_to( { action: "show", id: project_id }, alert: "ERROR!!" )
      end
    end

    notice, alert = Supporter.add_support( project_id, session[:user_id], profile_id )
    
    redirect_to( { action: "show", id: project_id }, notice: notice, alert: alert )
  end

  #------------------#
  # delete_supporter #
  #------------------#
  def delete_supporter
    project_id = params[:project_id]
    
    supporter = Supporter.where( project_id: project_id, user_id: session[:user_id] ).first
    response = PaypalApi.cancel_recurring( supporter.try(:profile_id) )
    
    if response == "Success"
      notice, alert = Supporter.delete_support( project_id, session[:user_id] )
    else
      alert = "PayPalのキャンセルに失敗しました。"
    end
    
    redirect_to( { action: "show", id: project_id }, notice: notice, alert: alert )
  end
  
  #------------#
  # add_member #
  #------------#
  def add_member
    member = Member.new( params[:member] )
    member.user_id = session[:user_id]

    unless member.save
      alert = "メンバー登録に失敗しました。"
    end
    
    redirect_to( { action: "show", id: member.project_id }, alert: alert )
  end
  
  #-----------------#
  # add_information #
  #-----------------#
  def add_information
    info = Information.new( params[:information] )
    info.user_id = session[:user_id]

    unless info.save
      alert = "インフォメーション発信に失敗しました。"
    end
    
    redirect_to( { action: "show", id: info.project_id }, alert: alert )
  end

end

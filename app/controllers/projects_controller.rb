# coding: utf-8
class ProjectsController < ApplicationController

  #-------#
  # index #
  #-------#
  def index
    @projects = Project.includes( :user, { :supporters => :user } ).all
  end

  #------#
  # show #
  #------#
  def show
    @project = Project.where( id: params[:id], user_id: session[:user_id] ).first
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
    notice, alert = Supporter.add_support( project_id, session[:user_id] )
    
    redirect_to( { action: "show", id: project_id }, notice: notice, alert: alert )
  end

  #------------------#
  # delete_supporter #
  #------------------#
  def delete_supporter
    project_id = params[:project_id]
    notice, alert = Supporter.delete_support( project_id, session[:user_id] )
    
    redirect_to( { action: "show", id: project_id }, notice: notice, alert: alert )
  end
end

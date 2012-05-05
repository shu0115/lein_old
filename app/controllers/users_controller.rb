# coding: utf-8
class UsersController < ApplicationController

  #-------#
  # index #
  #-------#
  def index
    @users = User.order( "created_at DESC" ).all
  end

  #------#
  # show #
  #------#
  def show
    @user = User.where( id: params[:id] ).includes( :projects, { :supportes => :project } ).first
  end

end

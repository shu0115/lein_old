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
    @user = User.where( id: params[:id] ).includes( :projects, { :supporters => { :project => :information } } ).first
  end

end

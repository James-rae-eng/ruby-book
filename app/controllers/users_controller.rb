class UsersController < ApplicationController
  #DONT NEED ANY OF THE DEFAULT CREATE ETC ACTIONS AS DEVISE HANDLES THESE.
  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
    @user = current_user
  end

end

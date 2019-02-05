class UserController < ApplicationController
  def index
    @users = User.all
    json_response(@users)
  end

  def create
    @user = User.new(user_params)

    @user.save

    json_response(@user)
  end

  def show
    @user = User.find(params[:id])

    json_response(@user)
  end

  def update
    
  end

  def user_params
    params.permit(:firstName, :lastName, :email, :password, :age, :country, :city)
  end
end

class UserController < ApplicationController
  def create
    @user = User.new(params[:firstName], params[:lastName], params[:email], params[:password], params[:age], params[:country], params[:city])

    @user.save

    render json: @user
  end

  def show
    @user = User.find(params[:id])

    render json: @user
  end
end

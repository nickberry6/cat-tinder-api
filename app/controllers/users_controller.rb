class UsersController < ApplicationController
  def index
    @users = User.all
    render json: @users, status: 200
  end

  def show
    @user = User.find(user_params[:id])
    render json: @user, status: 200
  end

  def create
    user = User.create(user_params.except(:id))
    render json: {message: 'user successfully created'}, status: 201
  end

  def update
    user = User.update(user_params.except(:id))
    render json: user, status: 201
  end

  def destroy
    user = User.find(user_params[:id])
    user.destroy!
    render json: { message: 'user successfully deleted' }, status: 201
  end


  private

  def user_params
    params.permit(:username, :email, :id)
  end
end

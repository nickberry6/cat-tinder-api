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
    user = User.new(user_params.except(:id))
    if user.save
      # TODO add email sending method here
      render json: { status: 'user successfully created' }, status: 201
    else
      render json: { errors: user.errors.full_messages }, status: 400
    end
  end

  # def update
  #   user = User.update(user_params.except(:id))
  #   render json: user, status: 201
  # end
  #
  # def destroy
  #   user = User.find(user_params[:id])
  #   user.destroy!
  #   render json: { message: 'user successfully deleted' }, status: 201
  # end

  def login
    user = User.find_by(email: user_params[:email].to_s.downcase)
    if user && user.authenticate(user_params[:password])
      auth_token = JsonWebToken.encode({user_id: user.id})
      render json: {auth_token: auth_token}, status: 200
    else
      render json: {error: 'Invalid username / password'}, status: :unauthorized
    end
  end

  private

  def user_params
    params.permit(:username, :email, :password, :password_confirmation, :id)
  end
end

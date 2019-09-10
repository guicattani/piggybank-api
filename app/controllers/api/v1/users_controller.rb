# frozen_string_literal: true

# V1 Users controller
class Api::V1::UsersController < ApplicationController
  respond_to :json

  def show
    @user = User.find(params[:id])

    render json: serialize(@user).serialized_json, status: :ok
  rescue ActiveRecord::RecordNotFound
    head :not_found
  end

  def create
    @user = User.new(user_params)

    render json: serialize(@user).serialized_json, status: :created if @user.save
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def serialize(user)
    V1::UserSerializer.new(user)
  end
end

# frozen_string_literal: true

# V1 Users controller
class Api::V1::UsersController < ApplicationController
  before_action :set_user
  before_action -> { authenticate(%w[user]) }

  respond_to :json

  def update
    if @user.update(user_params)
      render json: serialize(@user).serialized_json, status: :ok
    else
      render json: { errors: @user.errors }, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end

  def serialize(user)
    V1::UserSerializer.new(user)
  end
end

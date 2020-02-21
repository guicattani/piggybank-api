# frozen_string_literal: true

class Api::V1::SavingsController < ApplicationController
  before_action :set_saving, only: %i[show update destroy]
  before_action -> { authenticate(%w[user]) }

  respond_to :json

  def index
    @savings = Saving.by_user(current_user.id).all

    render json: @savings
  end

  def show
    render json: serialize(@saving).serialized_json, status: :ok
  end

  def create
    @saving = Saving.new(saving_params.merge(user_id: current_user.id))

    if @saving.save
      render json: serialize(@saving).serialized_json, status: :created
    else
      render json: { errors: @saving.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @saving.update(saving_params)
      render json: serialize(@saving).serialized_json, status: :ok
    else
      render json: { errors: @saving.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @saving.destroy
  end

  private

  def set_saving
    @saving = Saving.by_user(current_user.id).find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render_not_found
  end

  def saving_params
    params.permit(:value_in_cents, :currency, :objective_date, :objective_value_in_cents, :color)
  end

  def serialize(saving)
    V1::SavingSerializer.new(saving)
  end
end

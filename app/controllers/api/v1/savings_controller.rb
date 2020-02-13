# frozen_string_literal: true

class Api::V1::SavingsController < ApplicationController
  before_action :set_saving, only: %i[show update destroy]

  def index
    @savings = Saving.all

    render json: @savings
  end

  def create
    @saving = Saving.new(saving_params).merge(current_user.id)

    if @saving.save
      render json: @saving, status: :created, location: @saving
    else
      render json: @saving.errors, status: :unprocessable_entity
    end
  end

  def update
    if @saving.update(saving_params)
      render json: @saving
    else
      render json: @saving.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @saving.destroy
  end

  private

  def set_saving
    @saving = Saving.by_user.find(params[:id])
  end

  def saving_params
    params.permit(:value_in_cents, :objetive_date, :objective_value_in_cents, :color)
  end
end

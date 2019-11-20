# frozen_string_literal: true

class Api::V1::SavingsController < ApplicationController
  before_action :set_saving, only: %i[show update destroy]

  # GET /savings
  def index
    @savings = Saving.all

    render json: @savings
  end

  # GET /savings/1
  def show
    render json: @saving
  end

  # POST /savings
  def create
    @saving = Saving.new(saving_params)

    if @saving.save
      render json: @saving, status: :created, location: @saving
    else
      render json: @saving.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /savings/1
  def update
    if @saving.update(saving_params)
      render json: @saving
    else
      render json: @saving.errors, status: :unprocessable_entity
    end
  end

  # DELETE /savings/1
  def destroy
    @saving.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_saving
    @saving = Saving.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def saving_params
    params.require(:saving).permit(:users_id, :value_in_cents, :objetive_date, :objective_value_in_cents, :color)
  end
end

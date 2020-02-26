# frozen_string_literal: true

class Api::V1::SavingSchedulesController < ApplicationController
  before_action :set_saving_schedule, only: %i[show update destroy]
  before_action -> { authenticate(%w[user]) }

  respond_to :json

  def index
    @saving_schedule_schedules = SavingSchedule.by_user(current_user.id).all

    render json: @saving_schedule_schedules
  end

  def show
    render json: serialize(@saving_schedule).serialized_json, status: :ok
  end

  def create
    @saving_schedule = SavingSchedule.new(saving_schedule_params.merge(user_id: current_user.id))

    if @saving_schedule.save
      render json: serialize(@saving_schedule).serialized_json, status: :created
    else
      render json: { errors: @saving_schedule.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @saving_schedule.update(saving_schedule_params)
      render json: serialize(@saving_schedule).serialized_json, status: :ok
    else
      render json: { errors: @saving_schedule.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @saving_schedule.destroy
  end

  private

  def set_saving
    @saving_schedule = SavingSchedule.by_user(current_user.id).find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render_not_found
  end

  def saving_schedule_params
    params.permit(:description, :active, :period, :value_in_cents, :period_value)
  end

  def serialize(saving)
    V1::SavingScheduleSerializer.new(saving)
  end
end

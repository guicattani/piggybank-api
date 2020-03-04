# frozen_string_literal: true

class Api::V1::SavingTransactionsController < ApplicationController
  before_action :set_saving, only: %i[index create]
  before_action :set_saving_transaction, only: :destroy
  before_action -> { authenticate(%w[user]) }

  respond_to :json

  def index
    @saving_transactions = SavingTransaction.where(saving_id: @saving.id)

    render json: serialize(@saving_schedule).serialized_json, status: :ok
  end

  def create
    @saving_transaction = SavingTransaction.create(
      saving_transaction_params.merge(saving_id: @saving.id)
    )

    if @saving_transaction.save
      @saving.value_in_cents += params[:value_in_cents]
      @saving.save

      render json: serialize(@saving_transaction).serialized_json, status: :created
    else
      render json: { errors: @saving_transaction.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @saving_transaction.destroy
  end

  private

  def saving_transaction_params
    params.permit(:value_in_cents)
  end

  def set_saving
    @saving = Saving.by_user(current_user.id).find(params[:saving_id])
  rescue ActiveRecord::RecordNotFound
    render_not_found
  end

  def set_saving_transaction
    saving = Saving.by_user(current_user.id).find(params[:saving_id])
    @saving_transaction = SavingTransaction.where(saving_id: saving.id).find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render_not_found
  end

  def serialize(saving_transaction)
    V1::SavingTransactionSerializer.new(saving_transaction)
  end
end

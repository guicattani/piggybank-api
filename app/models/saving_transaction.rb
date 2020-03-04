# frozen_string_literal: true

class SavingTransaction < ApplicationRecord
  belongs_to :saving
  validates :value_in_cents, numericality: { greater_than: 0 }
  validates_presence_of :value_in_cents
end

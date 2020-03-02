# frozen_string_literal: true

require './config/boot'
require './config/environment'
require 'clockwork'
require 'sidekiq'

module Clockwork
  configure do |config|
    config[:sleep_timeout] = 4
    config[:tz] = 'America/Sao_Paulo'
  end

  every(1.day, 'day_pass.job', at: '00:01') do
    DayPassWorker.perform_async
  end
end

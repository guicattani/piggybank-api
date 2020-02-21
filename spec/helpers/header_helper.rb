# frozen_string_literal: true

module HeaderHelper
  def piggybank_header(version)
    {
      'Accept' => "application/vnd.piggybank.#{version}",
      'Content-Type' => Mime[:json].to_s
    }
  end
end

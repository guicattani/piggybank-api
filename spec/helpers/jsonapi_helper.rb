# frozen_string_literal: true

module JsonAPIHelper
  def parsed_attributes
    parsed_response["data"]["attributes"]
  end

  def parsed_response
    JSON.parse(response.body)
  end
end

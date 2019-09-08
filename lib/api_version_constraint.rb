# frozen_string_literal: true

# Used in routes to prevent wrong usages of API versions
class ApiVersionConstraint
  def initialize(options)
    @version = options[:version]
    @default = options[:default]
  end

  def matches?(req)
    @default || accept_headers(req)
  end

  private

  def accept_headers
    req.headers['Accept'].include?("application/vnd.piggybank.v#{@version}")
  end
end

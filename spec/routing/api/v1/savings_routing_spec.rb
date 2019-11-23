# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::SavingsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "savings").to route_to("api/v1/savings#index", format: :json)
    end

    it "routes to #show" do
      expect(get: "savings/1").to route_to("api/v1/savings#show", id: "1", format: :json)
    end

    it "routes to #create" do
      expect(post: "savings").to route_to("api/v1/savings#create", format: :json)
    end

    it "routes to #update via PUT" do
      expect(put: "savings/1").to route_to("api/v1/savings#update", id: "1", format: :json)
    end

    it "routes to #update via PATCH" do
      expect(patch: "savings/1").to route_to("api/v1/savings#update", id: "1", format: :json)
    end

    it "routes to #destroy" do
      expect(delete: "savings/1").to route_to("api/v1/savings#destroy", id: "1", format: :json)
    end
  end
end

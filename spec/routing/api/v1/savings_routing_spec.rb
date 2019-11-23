# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::SavingsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      skip("skip")
      expect(get: "savings").to route_to("api/v1/savings#index")
    end

    it "routes to #show" do
      skip("skip")
      expect(get: "savings/1").to route_to("api/v1/savings#show", id: "1")
    end

    it "routes to #create" do
      skip("skip")
      expect(post: "savings").to route_to("api/v1/savings#create")
    end

    it "routes to #update via PUT" do
      skip("skip")
      expect(put: "savings/1").to route_to("api/v1/savings#update", id: "1")
    end

    it "routes to #update via PATCH" do
      skip("skip")
      expect(patch: "savings/1").to route_to("api/v1/savings#update", id: "1")
    end

    it "routes to #destroy" do
      skip("skip")
      expect(delete: "savings/1").to route_to("api/v1/savings#destroy", id: "1")
    end
  end
end

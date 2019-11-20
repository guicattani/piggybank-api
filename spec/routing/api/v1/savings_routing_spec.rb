# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::SavingsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      skip("skip")
      expect(get: "v1/savings").to route_to("api/v1/savings#index")
    end

    it "routes to #show" do
      skip("skip")
      expect(get: "v1/savings/1").to route_to("api/v1/savings#show", id: "1")
    end

    it "routes to #create" do
      skip("skip")
      expect(post: "v1/savings").to route_to("api/v1/savings#create")
    end

    it "routes to #update via PUT" do
      skip("skip")
      expect(put: "v1/savings/1").to route_to("api/v1/savings#update", id: "1")
    end

    it "routes to #update via PATCH" do
      skip("skip")
      expect(patch: "v1/savings/1").to route_to("api/v1/savings#update", id: "1")
    end

    it "routes to #destroy" do
      skip("skip")
      expect(delete: "v1/savings/1").to route_to("api/v1/savings#destroy", id: "1")
    end
  end
end

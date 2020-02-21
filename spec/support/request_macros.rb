# frozen_string_literal: true

module RequestMacros
  def login_user
    before(:all) do
      user = FactoryBot.create(:user)
      sign_in user
    end
  end
end

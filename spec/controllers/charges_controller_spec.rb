require 'rails_helper'

RSpec.describe ChargesController, type: :controller do
  let(:user) { create(:user, role: :premium) }

  describe "DELETE destroy" do
    before do
      sign_in user
    end

    it "redirects to wiki#index" do
      delete :destroy, id: user.id
      expect(response).to redirect_to(wikis_path)
    end
  end
end

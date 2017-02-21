require 'rails_helper'

RSpec.describe ChargesController, type: :controller do
  let(:user) { create(:user, role: :premium) }
  let(:wiki) { create(:wiki, user: user, private: true) }

  describe "DELETE destroy" do
    before do
      sign_in user
    end

    it "redirects to wiki#index" do
      delete :destroy, id: user.id
      expect(response).to redirect_to(wikis_path)
    end

    it "converts user to a standard status after downgrading" do
      expect{delete :destroy, id: user.id}.to change{user.standard?}.from(false).to(true)
    end

    it "converts all private wikis to public when premium user downgrades" do
      expect{delete :destroy, id: user.id}.to change{wiki.private}.from(true).to(false)
    end
  end
end

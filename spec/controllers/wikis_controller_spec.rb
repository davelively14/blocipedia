require 'rails_helper'

RSpec.describe WikisController, type: :controller do
  let(:user) { create(:user) }
  let(:wiki) { create(:wiki, user: user) }

  context "guest" do
    describe "GET show" do
      it "not accessible to signed out user" do
        expect{get :show, {id: wiki.id}}.to raise_error(NoMethodError)
      end
    end
  end

  context "user" do
    before do
      sign_in user
    end

    describe "GET show" do
      it "renders the #show view" do
        get :show, {id: wiki.id}
        expect(response).to have_http_status(:success)
      end
    end
  end
end

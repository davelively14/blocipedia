require 'rails_helper'

RSpec.describe WikisController, type: :controller do
  let(:user) { create(:user) }
  let(:wiki) { create(:wiki, user: user) }

  context "guest" do
    before do
      sign_out user
    end

    describe "GET show" do
      it "is not accessible to unregistered user" do
        expect{get :show, {id: wiki.id}}.to raise_error(UncaughtThrowError)
      end
    end

    describe "GET index" do
      it "is not accessible to unregistered user" do
        expect{get :index}.to raise_error(UncaughtThrowError)
      end
    end
  end

  context "user" do
    before do
      sign_in user
    end

    describe "GET show" do
      it "returns http success" do
        get :show, {id: wiki.id}
        expect(response).to have_http_status(:success)
      end

      it "renders the #show view" do
        get :show, {id: wiki.id}
        expect(response).to render_template(:show)
      end

      it "assigns wiki to @wiki" do
        get :show, {id: wiki.id}
        expect(assigns(:wiki)).to eq(wiki)
      end
    end

    describe "GET index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end

      it "renders the #index view" do
        get :index
        expect(response).to render_template(:index)
      end

      it "assigns all wikis to @wiki" do
        get :index
        expect(assigns(:wikis)).to eq([wiki])
      end
    end
  end
end

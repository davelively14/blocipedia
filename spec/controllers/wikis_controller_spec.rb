require 'rails_helper'
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

    describe "GET new" do
      it "is not accessible to unregistered user" do
        expect{get :new}.to raise_error(UncaughtThrowError)
      end
    end

    describe "POST create" do
      it "is not accessible to unregistered user" do
        expect{post :create, wiki: {title: Faker::Hacker.say_something_smart, body: Faker::Hipster.paragraph, private: false}}.to raise_error(UncaughtThrowError)
      end
    end

    describe "GET edit" do
      it "is not accessible to unregistered user" do
        expect{get :edit, id: wiki.id}.to raise_error(UncaughtThrowError)
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

    describe "GET new" do
      it "returns http success" do
        get :new
        expect(response).to have_http_status(:success)
      end

      it "renders the #new view" do
        get :new
        expect(response).to render_template(:new)
      end

      it "instantiates @wiki" do
        get :new
        expect(assigns(:wiki)).to_not be_nil
      end
    end

    describe "POST create" do
      it "increases the number of wikis by 1" do
        expect{post :create, wiki: {title: Faker::Hacker.say_something_smart, body: Faker::Hipster.paragraph, private: false}}.to change(Wiki, :count).by(1)
      end

      it "assigns the new wiki to @wiki" do
        post :create, wiki: {title: Faker::Hacker.say_something_smart, body: Faker::Hipster.paragraph, private: false}
        expect(assigns(:wiki)).to eq(Wiki.last)
      end

      it "redirects to the new wiki" do
        post :create, wiki: {title: Faker::Hacker.say_something_smart, body: Faker::Hipster.paragraph, private: false}
        expect(response).to redirect_to(Wiki.last)
      end
    end

    describe "GET edit" do
      it "returns http success" do
        get :edit, id: wiki.id
        expect(response).to have_http_status(:success)
      end

      it "renders the #edit view" do
        get :edit, id: wiki.id
        expect(response).to render_template(:edit)
      end

      it "assigns wiki to be udpated to @wiki" do
        get :edit, id: wiki.id
        wiki_instance = assigns(:wiki)

        expect(wiki_instance.id).to eq(wiki.id)
        expect(wiki_instance.title).to eq(wiki.title)
        expect(wiki_instance.body).to eq(wiki.body)
        expect(wiki_instance.private).to eq(wiki.private)
        expect(wiki_instance.user_id).to eq(wiki.user_id)
      end
    end
  end
end

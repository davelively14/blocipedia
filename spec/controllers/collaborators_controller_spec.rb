require 'rails_helper'

RSpec.describe CollaboratorsController, type: :controller do
  let(:owner) { create(:user, role: :premium) }
  let(:admin) { create(:user, role: :admin) }
  let(:standard) { create(:user) }

  let(:wiki) { create(:wiki, private: true, user: owner) }

  let(:collaborator) { create(:collaborator, wiki_id: wiki.id, user_id: owner.id) }

  shared_examples_for Collaborator do
    describe "POST create" do
      it "increases the number of collaborators by 1" do
        expect{post :create, collaborator: {wiki_id: wiki.id, user_id: standard.id}}.to change(Collaborator, :count).by(1)
      end

      it "assigns the new collaborator to @collaborator" do
        post :create, collaborator: {wiki_id: wiki.id, user_id: standard.id}
        expect(assigns(:collaborator)).to eq(Collaborator.last)
      end

      it "redirects to :back" do
        post :create, collaborator: {wiki_id: wiki.id, user_id: standard.id}
        expect(response).to redirect_to(edit_wiki_path(wiki))
      end
    end

    describe "DELETE destroy" do
      it "deletes a collaborator" do
        delete :destroy, id: collaborator.id
        expect(Collaborator.where({id: collaborator.id}).size).to eq(0)
      end

      it "redirects to show wiki" do
        delete :destroy, id: collaborator.id
        expect(response).to redirect_to(edit_wiki_path(wiki))
      end
    end
  end

  context "owner" do
    before do
      sign_in owner
      request.env["HTTP_REFERER"] = edit_wiki_path(wiki)
    end

    it_behaves_like Collaborator
  end

  context "admin" do
    before do
      sign_in admin
      request.env["HTTP_REFERER"] = edit_wiki_path(wiki)
    end

    it_behaves_like Collaborator
  end

  context "standard" do
    before do
      sign_in standard
      request.env["HTTP_REFERER"] = edit_wiki_path(wiki)
    end

    describe "POST create" do
      it "denies standard user access" do
        expect{post :create, collaborator: {wiki_id: wiki.id, user_id: standard.id}}.to change(Collaborator, :count).by(0)
      end
    end

    describe "DELETE destroy" do
      it "denies standard useres access" do
        delete :destroy, id: collaborator.id
        expect(Collaborator.where({id: collaborator.id}).size).to eq(1)
      end
    end
  end
end

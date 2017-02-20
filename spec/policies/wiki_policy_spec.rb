require 'rails_helper'

RSpec.describe WikiPolicy do
  let(:user) { create(:user) }
  let(:wiki) { create(:wiki, user: user) }
  let(:other_user) { create(:user) }
  let(:admin) { create(:user, role: :admin) }

  subject { described_class }

  permissions :index?, :show? do
    it "allows all users to view index and show" do
      expect(subject).to permit(user, wiki)
      expect(subject).to permit(nil, wiki)
    end
  end

  permissions :edit?, :update? do
    it "allows any user to edit a wiki" do
      expect(subject).to permit(user, wiki)
    end

    it "does not allow a non-user to edit a wiki" do
      expect(subject).to_not permit(nil, wiki)
    end
  end

  permissions :new?, :create? do
    it "allows any user to create a wiki" do
      expect(subject).to permit(user, wiki)
    end

    it "does not allow a non-user to create a wiki" do
      expect(subject).to_not permit(nil, wiki)
    end
  end

  permissions :destroy? do
    it "allows only admin and post creators to delete a wiki" do
      expect(subject).to permit(user, wiki)
      expect(subject).to permit(admin, wiki)
    end

    it "does not allow a non-user or other user to delete a wiki" do
      expect(subject).to_not permit(other_user, wiki)
      expect(subject).to_not permit(nil, wiki)
    end
  end
end

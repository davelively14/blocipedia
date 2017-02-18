require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  # Shoulda test for emails
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_length_of(:email).is_at_least(3) }
  it { is_expected.to validate_uniqueness_of(:email) }
  it { is_expected.to allow_value("dave@unique.io").for(:email)}

  # Shoulda test for password
  it { is_expected.to validate_presence_of(:password) }
  it { is_expected.to validate_length_of(:password).is_at_least(6) }

  describe "attributes" do
    it "has email attribute" do
      expect(user).to have_attributes(email: user.email)
    end
  end

  describe "invalid user" do
    let(:invalid_user_email) { build(:user, email: "") }

    it "should be an invalid user for a blank email" do
      expect(invalid_user_email).to_not be_valid
    end
  end
end

require 'rails_helper'

RSpec.describe Wiki, type: :model do
  let(:user) {User.create!(email: "blochead@bloc.io", password: "password")}
  let(:wiki) {Wiki.create!(title: "New Wiki Title", body: "New Wiki Body For The Good Wiki", private: false, user: user)}

  it {is_expected.to validate_presence_of(:title)}
  it {is_expected.to validate_presence_of(:body)}
  it {is_expected.to validate_presence_of(:user)}

  it {is_expected.to validate_length_of(:title).is_at_least(5)}
  it {is_expected.to validate_length_of(:body).is_at_least(15)}

  describe "attributes" do
    it "has title, body, and user attributes" do
      expect(wiki).to have_attributes(title: wiki.title, body: wiki.body, user: user)
    end
  end

end

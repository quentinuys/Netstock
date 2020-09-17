require 'rails_helper'

RSpec.describe "members/index", type: :view do
  before(:each) do
    assign(:members, [
      Member.create!(
        name: "Name",
        surname: "Surname",
        email: "Email",
        birthday: "",
        games_played: 2,
        rank: 3
      ),
      Member.create!(
        name: "Name",
        surname: "Surname",
        email: "Email",
        birthday: "",
        games_played: 2,
        rank: 3
      )
    ])
  end

  it "renders a list of members" do
    render
    assert_select "tr>td", text: "Name".to_s, count: 2
    assert_select "tr>td", text: "Surname".to_s, count: 2
    assert_select "tr>td", text: "Email".to_s, count: 2
    assert_select "tr>td", text: "".to_s, count: 2
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: 3.to_s, count: 2
  end
end

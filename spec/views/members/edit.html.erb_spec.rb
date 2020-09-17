require 'rails_helper'

RSpec.describe "members/edit", type: :view do
  before(:each) do
    @member = assign(:member, Member.create!(
      name: "MyString",
      surname: "MyString",
      email: "MyString",
      birthday: "",
      games_played: 1,
      rank: 1
    ))
  end

  it "renders the edit member form" do
    render

    assert_select "form[action=?][method=?]", member_path(@member), "post" do

      assert_select "input[name=?]", "member[name]"

      assert_select "input[name=?]", "member[surname]"

      assert_select "input[name=?]", "member[email]"

      assert_select "input[name=?]", "member[birthday]"

      assert_select "input[name=?]", "member[games_played]"

      assert_select "input[name=?]", "member[rank]"
    end
  end
end

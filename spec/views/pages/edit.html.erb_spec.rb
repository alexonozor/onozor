require 'rails_helper'

RSpec.describe "pages/edit", type: :view do
  before(:each) do
    @page = assign(:page, Page.create!(
      :name => "MyString",
      :address => "MyText",
      :zip_code => "MyString",
      :phone => "MyString",
      :privacy_id => 1,
      :website => "MyString",
      :long_description => "MyText",
      :short_description => "MyText",
      :cover_picture => "MyString",
      :logo => "MyString",
      :user_id => 1,
      :page_type_id => 1
    ))
  end

  it "renders the edit page form" do
    render

    assert_select "form[action=?][method=?]", page_path(@page), "post" do

      assert_select "input#page_name[name=?]", "page[name]"

      assert_select "textarea#page_address[name=?]", "page[address]"

      assert_select "input#page_zip_code[name=?]", "page[zip_code]"

      assert_select "input#page_phone[name=?]", "page[phone]"

      assert_select "input#page_privacy_id[name=?]", "page[privacy_id]"

      assert_select "input#page_website[name=?]", "page[website]"

      assert_select "textarea#page_long_description[name=?]", "page[long_description]"

      assert_select "textarea#page_short_description[name=?]", "page[short_description]"

      assert_select "input#page_cover_picture[name=?]", "page[cover_picture]"

      assert_select "input#page_logo[name=?]", "page[logo]"

      assert_select "input#page_user_id[name=?]", "page[user_id]"

      assert_select "input#page_page_type_id[name=?]", "page[page_type_id]"
    end
  end
end

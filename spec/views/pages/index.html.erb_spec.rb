require 'rails_helper'

RSpec.describe "pages/index", type: :view do
  before(:each) do
    assign(:pages, [
      Page.create!(
        :name => "Name",
        :address => "MyText",
        :zip_code => "Zip Code",
        :phone => "Phone",
        :privacy_id => 1,
        :website => "Website",
        :long_description => "MyText",
        :short_description => "MyText",
        :cover_picture => "Cover Picture",
        :logo => "Logo",
        :user_id => 2,
        :page_type_id => 3
      ),
      Page.create!(
        :name => "Name",
        :address => "MyText",
        :zip_code => "Zip Code",
        :phone => "Phone",
        :privacy_id => 1,
        :website => "Website",
        :long_description => "MyText",
        :short_description => "MyText",
        :cover_picture => "Cover Picture",
        :logo => "Logo",
        :user_id => 2,
        :page_type_id => 3
      )
    ])
  end

  it "renders a list of pages" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Zip Code".to_s, :count => 2
    assert_select "tr>td", :text => "Phone".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Website".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Cover Picture".to_s, :count => 2
    assert_select "tr>td", :text => "Logo".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end

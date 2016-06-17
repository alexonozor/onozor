require 'rails_helper'

RSpec.describe "pages/show", type: :view do
  before(:each) do
    @page = assign(:page, Page.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Zip Code/)
    expect(rendered).to match(/Phone/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Website/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Cover Picture/)
    expect(rendered).to match(/Logo/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
  end
end

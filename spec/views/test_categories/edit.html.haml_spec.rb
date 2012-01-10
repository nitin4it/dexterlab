require 'spec_helper'

describe "test_categories/edit.html.haml" do
  before(:each) do
    @test_category = assign(:test_category, stub_model(TestCategory,
      :name => "MyString",
      :description => "MyText",
      :is_active => false,
      :references => ""
    ))
  end

  it "renders the edit test_category form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => test_categories_path(@test_category), :method => "post" do
      assert_select "input#test_category_name", :name => "test_category[name]"
      assert_select "textarea#test_category_description", :name => "test_category[description]"
      assert_select "input#test_category_is_active", :name => "test_category[is_active]"
      assert_select "input#test_category_references", :name => "test_category[references]"
    end
  end
end

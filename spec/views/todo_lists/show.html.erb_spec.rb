require 'rails_helper'

RSpec.describe "todo_lists/show", type: :view do
  before(:each) do
    @todo_list = assign(:todo_list, TodoList.create!(
      title: "Title",
      description: "MyText",
      status: "Status"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Status/)
  end
end

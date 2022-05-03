class TodoItem
  include Mongoid::Document
  field :content, type: String
  belongs_to :todo_list
end

class TodoList
  include Mongoid::Document
  field :title, type: String
  field :description, type: String
  field :status, type: String

  belongs_to :user
end

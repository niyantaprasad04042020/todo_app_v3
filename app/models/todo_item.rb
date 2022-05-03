class TodoItem
  include Mongoid::Document
  field :content, type: String
  field :completed_at, tytpe: DateTime
  belongs_to :todo_list

  def completed?
  	!completed_at.blank?
  end
end

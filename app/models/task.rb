class Task < ApplicationRecord
  belongs_to :user
  validates :title, :due_date, :priority, :completed, :description, presence: true
end

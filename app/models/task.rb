class Task < ApplicationRecord
  belongs_to :user
  validates :title, :due_date, :priority, :description, presence: true
  validates :title, length: { minimum: 5 }
end

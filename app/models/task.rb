class Task < ApplicationRecord
  belongs_to :project

  validates :name, presence: true
  validates :status, presence: true, inclusion: { in: %w[todo in_progress done] }

  scope :todo, -> { where(status: "todo") }
  scope :in_progress, -> { where(status: "in_progress") }
  scope :done, -> { where(status: "done") }
end

class Project < ApplicationRecord
  has_many :tasks, dependent: :destroy

  validates :name, presence: true

  scope :with_task_counts, -> {
    left_joins(:tasks)
      .group("projects.id")
      .select("projects.*, COUNT(tasks.id) as task_count, SUM(CASE WHEN tasks.status = 'done' THEN 1 ELSE 0 END) as done_count")
  }
end

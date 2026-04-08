require "test_helper"

class TaskTest < ActiveSupport::TestCase
  test "valid task can be created" do
    project = Project.create!(name: "My Project")
    task = project.tasks.new(name: "My Task", status: "todo")
    assert task.save
    assert task.persisted?
  end

  test "invalid task without name raises error" do
    project = Project.create!(name: "My Project")
    task = project.tasks.new(status: "todo")
    refute task.valid?
    assert_includes task.errors[:name], "can't be blank"
  end

  test "invalid task without status raises error" do
    project = Project.create!(name: "My Project")
    task = project.tasks.new(name: "My Task")
    refute task.valid?
    assert_includes task.errors[:status], "can't be blank"
  end

  test "invalid task with invalid status raises error" do
    project = Project.create!(name: "My Project")
    task = project.tasks.new(name: "My Task", status: "invalid_status")
    refute task.valid?
    assert_includes task.errors[:status], "is not included in the list"
  end

  test "task belongs to project" do
    project = Project.create!(name: "My Project")
    task = project.tasks.create!(name: "My Task", status: "todo")

    assert_equal project, task.project
  end

  test "task scopes work correctly" do
    project = Project.create!(name: "My Project")
    task_todo = project.tasks.create!(name: "Todo Task", status: "todo")
    task_in_progress = project.tasks.create!(name: "In Progress Task", status: "in_progress")
    task_done = project.tasks.create!(name: "Done Task", status: "done")

    assert_equal 1, project.tasks.todo.count
    assert_includes project.tasks.todo, task_todo

    assert_equal 1, project.tasks.in_progress.count
    assert_includes project.tasks.in_progress, task_in_progress

    assert_equal 1, project.tasks.done.count
    assert_includes project.tasks.done, task_done
  end

  test "task can have due date" do
    project = Project.create!(name: "My Project")
    due_date = Date.today + 7.days
    task = project.tasks.create!(name: "My Task", status: "todo", due_date:)

    assert_equal due_date, task.due_date
  end
end

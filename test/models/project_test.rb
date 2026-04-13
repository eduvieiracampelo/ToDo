require "test_helper"

class ProjectTest < ActiveSupport::TestCase
  test "valid project can be created" do
    project = Project.new(name: "My Project")
    assert project.save
    assert project.persisted?
  end

  test "invalid project without name raises error" do
    project = Project.new
    refute project.valid?
    assert_includes project.errors[:name], "não pode estar em branco"
  end

  test "project can have description" do
    project = Project.new(name: "My Project", description: "A test project")
    assert project.save
    assert_equal "A test project", project.description
  end

  test "project has many tasks" do
    project = Project.create!(name: "My Project")
    task1 = project.tasks.create!(name: "Task 1", status: "todo")
    task2 = project.tasks.create!(name: "Task 2", status: "done")

    assert_equal 2, project.tasks.count
    assert_includes project.tasks, task1
    assert_includes project.tasks, task2
  end

  test "destroying project destroys tasks" do
    project = Project.create!(name: "My Project")
    project.tasks.create!(name: "Task 1", status: "todo")

    assert_difference "Task.count", -1 do
      project.destroy
    end
  end
end

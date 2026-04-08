require "test_helper"

class ProjectsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get projects_url
    assert_response :success
  end

  test "should create project" do
    assert_difference "Project.count", 1 do
      post projects_url, params: { project: { name: "Test Project" } }
    end
    assert_redirected_to project_path(Project.last)
  end

  test "should show project" do
    project = Project.create!(name: "Test Project")
    get project_url(project)
    assert_response :success
  end

  test "should get new" do
    get new_project_url
    assert_response :success
  end

  test "should get edit" do
    project = Project.create!(name: "Test Project")
    get edit_project_url(project)
    assert_response :success
  end

  test "should update project" do
    project = Project.create!(name: "Test Project")
    patch project_url(project), params: { project: { name: "Updated Project" } }
    assert_redirected_to project_path(project)
    assert_equal "Updated Project", project.reload.name
  end

  test "should destroy project" do
    project = Project.create!(name: "Test Project")
    assert_difference "Project.count", -1 do
      delete project_url(project)
    end
    assert_redirected_to projects_path
  end
end

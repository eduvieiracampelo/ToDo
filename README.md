# Project Manager

A simple project and task management application built with Ruby on Rails 8.

## Features

- **Projects**: Create, edit, and delete projects
- **Tasks**: Manage tasks within each project with status tracking
- **Status Workflow**: Track tasks through To Do → In Progress → Done
- **Due Dates**: Set deadlines for tasks
- **Dashboard**: View all projects with task statistics

## Tech Stack

- Ruby 3.4.7
- Rails 8.1.3
- SQLite3
- Hotwire (Turbo + Stimulus)
- CSS (no framework)

## Getting Started

### Prerequisites

- Ruby 3.4.7
- Bundler

### Installation

```bash
# Install dependencies
bin/setup

# Run migrations
bin/rails db:migrate

# Start the server
bin/dev
```

Visit `http://localhost:3000` to use the application.

## Usage

1. **Create a Project**: Click "New Project" and fill in the name and description
2. **Add Tasks**: On the project page, click "Add Task" to create tasks
3. **Update Status**: Use the dropdown to change task status (To Do / In Progress / Done)
4. **Edit/Delete**: Use the buttons to edit or delete projects and tasks

## Running Tests

```bash
bin/rails test
```

## Code Quality

```bash
# Run RuboCop linter
bin/rubocop

# Run security scans
bin/brakeman --no-pager
bin/bundler-audit
```

## CI/CD

The project includes GitHub Actions for:
- Ruby security scanning (Brakeman)
- Gem vulnerability scanning (bundler-audit)
- JavaScript dependency audit
- RuboCop linting
- Test suite

## License

This project is available for educational purposes.

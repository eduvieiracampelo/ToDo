# AGENTS.md - Development Guidelines

## Project Overview
- **Framework**: Ruby on Rails 8.x with Hotwire (Turbo + Stimulus)
- **Database**: SQLite3
- **JavaScript**: ES Modules via Import Maps, Stimulus controllers
- **Ruby Version**: 3.4.7

---

## Essential Commands

### Setup & Development
```bash
bin/setup           # Install dependencies, setup database
bin/dev             # Start development server (rails server)
```

### Testing
```bash
# Run all tests
bin/rails test

# Run a single test file
bin/rails test test/models/some_model_test.rb

# Run a specific test by line number
bin/rails test test/models/user_test.rb:15

# Run tests with verbose output
bin/rails test -v

# Run system tests
bin/rails test:system
```

### Linting & Code Quality
```bash
# RuboCop linting (Rails omakase style)
bin/rubocop

# Auto-correct linting issues
bin/rubocop -A

# Run specific rubocop check on one file
bin/rubocop app/models/user.rb

# Security scanning
bin/brakeman --no-pager              # Static analysis for Rails vulnerabilities
bin/bundler-audit                    # Scan gems for known security issues
bin/importmap audit                  # Scan JS dependencies
```

### CI Pipeline (runs all checks)
```bash
bin/ci
```

---

## Code Style Guidelines

### Ruby/Rails Conventions (RuboCop Rails Omakase)

**Files & Structure**
- Use 2-space indentation (no tabs)
- Max line length: 120 characters
- Use `snake_case` for file names and methods
- Use `CamelCase` for class names and modules
- Use `SCREAMING_SNAKE_CASE` for constants

**Naming Conventions**
```ruby
# Models: singular, CamelCase
class User < ApplicationRecord
class OrderItem < ApplicationRecord
end

# Controllers: plural, CamelCase with Controller suffix
class UsersController < ApplicationController
class OrdersController < ApplicationController
end

# Views: matching controller/action hierarchy
# app/views/users/index.html.erb
# app/views/orders/show.html.erb

# Database tables: plural, snake_case
# users, order_items, categories

# Methods: snake_case, descriptive verbs
def find_user_by_email(email)
def calculate_total_price
end

# Variables: snake_case, descriptive nouns
user_data = {}
order_items = []
end

# Boolean methods: end with ? or prefix with is_
user.active?
is_valid = true
```

**Imports/Requires**
```ruby
# Rails autoloading handles most imports automatically
# Only explicitly require gems or stdlib when needed
require "ostruct"

# Use require_relative for local files in same directory
require_relative "application_record"
```

**Formatting**
```ruby
# Hashes: prefer inline style for small hashes
config.forgery_protection_origin_check = true

# Use trailing commas in multi-line hashes/arrays
user_attributes = {
  name: "John",
  email: "john@example.com",
}

# Align hash rockets when values are related
create_table :users do |t|
  t.string :name
  t.string :email
  t.datetime :created_at
end

# Methods with many parameters: one per line
def create_user(
      name:,
      email:,
      role: "user",
      send_welcome_email: true
    )
  # ...
end
```

**Conditionals**
```ruby
# Prefer modifier if/unless for single-line body
redirect_to user_url and return if user.nil?

# Use guard clauses for early returns
def destroy
  return head :not_found unless current_user.admin?
  resource.destroy
  head :no_content
end

# Use consistent control flow patterns
if condition
  do_something
else
  do_something_else
end
```

**Classes & Modules**
```ruby
# One class per file, filename matches class name
# app/models/user.rb -> class User

# Use explicit return statements when the method's result is its purpose
def full_name
  "#{first_name} #{last_name}"
end

# Use private for internal methods
private

def validate_email_format
  # ...
end
```

---

## JavaScript Conventions (ESM + Stimulus)

**File Structure**
- Use ES Modules (`import`/`export`)
- Import Stimulus controllers in `app/javascript/controllers/index.js`
- Controller files: `app/javascript/controllers/*_controller.js`

**Stimulus Controllers**
```javascript
// app/javascript/controllers/task_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "list"]
  static values = { apiUrl: String }

  connect() {
    // Lifecycle callback
  }

  submit(event) {
    event.preventDefault()
    // ...
  }
}
```

**General JavaScript**
```javascript
// Use const by default, let only when reassignment is needed
const controller = "tasks"

// Use template literals for string interpolation
const message = `User ${name} created`

// Use arrow functions for callbacks
items.map(item => item.name)

// Use async/await over .then() chains
async loadData() {
  const response = await fetch(this.apiUrlValue)
  return response.json()
}
```

---

## Testing Conventions

**Test File Naming**
- Location: `test/` directory mirroring `app/` structure
- Name: `*_test.rb`
- Example: `test/models/user_test.rb`

**Test Structure (Minitest)**
```ruby
require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "valid user can be created" do
    user = User.new(name: "John", email: "john@example.com")
    assert user.save
    assert user.persisted?
  end

  test "invalid user without email raises error" do
    user = User.new(name: "John")
    refute user.valid?
    assert_includes user.errors[:email], "can't be blank"
  end

  test "email must be unique" do
    User.create!(name: "John", email: "john@example.com")
    duplicate = User.new(name: "Jane", email: "john@example.com")
    refute duplicate.valid?
  end
end
```

**Controller Tests**
```ruby
test "GET #index returns success" do
  get users_url
  assert_response :success
end

test "POST #create creates a new user" do
  assert_difference "User.count", 1 do
    post users_url, params: { user: { name: "John", email: "john@example.com" } }
  end
  assert_redirected_to user_path(User.last)
end
```

---

## Error Handling

**Rails Patterns**
```ruby
# Use find! (bang) when the record MUST exist
user = User.find!(params[:id])

# Use find_by when record may not exist
user = User.find_by(email: params[:email])

# Return appropriate HTTP status codes
head :not_found          # 404
head :unprocessable_entity  # 422
head :forbidden          # 403
head :no_content         # 204
render json: { error: "message" }, status: :bad_request

# Rescue specific exceptions when needed
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
```

---

## Database & Models

**Migrations**
```ruby
# Generate: bin/rails generate migration AddFieldsToUsers
# Use change for simple alterations
class AddFieldsToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :role, :string, default: "member"
    add_index :users, :email, unique: true
  end
end
```

**Model Associations**
```ruby
class User < ApplicationRecord
  has_many :orders, dependent: :destroy
  belongs_to :company

  validates :email, presence: true, uniqueness: true
  scope :active, -> { where(active: true) }
end
```

---

## Security Best Practices

- **Never commit secrets**: Use `config/credentials.yml.enc` for API keys
- **Use strong parameters** in controllers
- **Sanitize user input** before database operations
- **CSRF protection**: Rails enables this by default
- **SQL injection**: Rails handles escaping; avoid raw SQL
- **Mass assignment**: Use `permit` in strong parameters

---

## General Guidelines

1. **Follow Rails conventions** - "Convention over Configuration"
2. **Keep controllers thin, models rich**
3. **Use service objects** for complex business logic
4. **Write tests first** when adding new features
5. **Run `bin/rubocop -A` before committing** to auto-fix style issues
6. **Use ` Zeitwerk` conventions** for autoloading (file paths = class names)
7. **Environment variables**: Use `ENV.fetch("VAR_NAME")` for required vars

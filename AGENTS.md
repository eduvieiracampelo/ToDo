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
bin/dev             # Start development server
```

### Testing
```bash
bin/rails test                              # Run all tests
bin/rails test test/models/user_test.rb     # Run single test file
bin/rails test test/models/user_test.rb:15  # Run test by line number
bin/rails test -v                           # Verbose output
bin/rails test:system                       # System tests
```

### Linting & Code Quality
```bash
bin/rubocop           # Lint all files
bin/rubocop -A        # Auto-fix issues
bin/rubocop app/models/user.rb  # Single file
bin/brakeman --no-pager          # Security scan
bin/bundler-audit                # Check gems for vulnerabilities
bin/ci                           # Run full CI pipeline
```

---

## Code Style Guidelines (RuboCop Rails Omakase)

### Naming Conventions
- **Files**: snake_case (`user.rb`, `task_controller.rb`)
- **Classes/Modules**: CamelCase (`User`, `TasksController`)
- **Methods/Variables**: snake_case (`find_user`, `order_items`)
- **Constants**: SCREAMING_SNAKE_CASE
- **Database tables**: plural snake_case (`users`, `order_items`)
- **Models**: singular (`User`, `OrderItem`)
- **Controllers**: plural with Controller suffix (`UsersController`)
- **Boolean methods**: end with `?` (`user.active?`)

### Formatting
- 2-space indentation, max 120 chars per line
- Use trailing commas in multi-line hashes/arrays
- Prefer modifier `if/unless` for single-line body
- Use guard clauses for early returns

```ruby
redirect_to user_url and return if user.nil?

def destroy
  return head :not_found unless current_user.admin?
  resource.destroy
  head :no_content
end
```

### Imports
- Rails autoloading handles most imports automatically
- Explicitly require gems/stdlib only when needed

---

## JavaScript Conventions (ESM + Stimulus)

- Use ES Modules (`import`/`export`)
- Import Stimulus controllers in `app/javascript/controllers/index.js`
- Controller files: `app/javascript/controllers/*_controller.js`

```javascript
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "list"]
  static values = { apiUrl: String }

  connect() { }
}
```

---

## Testing Conventions (Minitest)

- Location: `test/` directory mirroring `app/` structure
- File naming: `*_test.rb`

```ruby
require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "valid user can be created" do
    user = User.new(name: "John", email: "john@example.com")
    assert user.save
  end
end
```

---

## Error Handling

```ruby
# Use find! when record MUST exist
user = User.find!(params[:id])

# Use find_by when record may not exist
user = User.find_by(email: params[:email])

# Return appropriate HTTP status codes
head :not_found              # 404
head :unprocessable_entity   # 422
render json: { error: "msg" }, status: :bad_request
```

---

## Database & Models

```ruby
class User < ApplicationRecord
  has_many :orders, dependent: :destroy
  validates :email, presence: true, uniqueness: true
  scope :active, -> { where(active: true) }
end
```

---

## Security Best Practices

- Never commit secrets - use `config/credentials.yml.enc`
- Use strong parameters in controllers
- Use `permit` in strong parameters for mass assignment

---

## General Guidelines

1. Follow Rails conventions ("Convention over Configuration")
2. Keep controllers thin, models rich
3. Run `bin/rubocop -A` before committing
4. Use Zeitwerk conventions (file paths = class names)

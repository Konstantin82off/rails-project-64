# Collective Blog (Habr-like)

[![CI](https://github.com/Konstantin82off/rails-project-64/actions/workflows/ci.yml/badge.svg)](https://github.com/Konstantin82off/rails-project-64/actions/workflows/ci.yml)
[![Hexlet Check](https://github.com/Konstantin82off/rails-project-64/actions/workflows/hexlet-check.yml/badge.svg)](https://github.com/Konstantin82off/rails-project-64/actions/workflows/hexlet-check.yml)

Educational project on Ruby on Rails. A collective blog where users can create posts, publish them in categories, comment, and rate other authors' publications.

## Deployment

The application is available at: [https://rails-project-64-vtkz.onrender.com](https://rails-project-64-vtkz.onrender.com)

## Tech Stack

- **Ruby** 3.4.4
- **Rails** 8.1.2
- **Database:** SQLite (development/test), PostgreSQL (production)
- **Frontend:** Bootstrap 5, esbuild
- **Template Engine:** Slim
- **Forms:** Simple Form
- **Linters:** RuboCop, Slim-Lint
- **Testing:** Minitest, Power Assert
- **Error Tracking:** Honeybadger
- **Deployment:** Render.com

## Project Requirements

- Model names and attributes must match those given in the steps
- Routing must match the demo project
- Ruby 3.4.4
- Rails 8.0+

## Local Development

```bash
# Clone the repository
git clone https://github.com/Konstantin82off/rails-project-64.git
cd rails-project-64

# Install dependencies
bundle install
yarn install

# Create and setup database
bin/rails db:create
bin/rails db:migrate
bin/rails db:seed

# Start development server
bin/dev
```

The application will be available at: [http://localhost:3000](http://localhost:3000/)

## **Database Structure**

The project uses the following models:

- **User** — users (authentication via Devise)
- **Post** — posts (belongs to user through creator)
- **Category** — categories (posts belong to category)
- **PostComment** — comments for posts (belongs to user and post, has tree structure via ancestry)
- **PostLike** — likes for posts (belongs to user and post, uses counter_cache)

Key associations:

- User has many posts (as creator), comments, and likes
- Post belongs to creator (User), belongs to category, has many comments and likes
- PostComment belongs to user and post, has ancestry for nested comments
- PostLike belongs to user and post (with uniqueness validation)

## **Testing**

```bash
# Run all tests
bin/rails test

# Run system tests
bin/rails test:system

# Run linters
bundle exec rubocop
bundle exec slim-lint app/views
```

## **Deployment on Render**

The project is configured for deployment on [Render.com](https://render.com/) via render.yaml. Pushing to main or development branch automatically triggers build and deployment.

## **CI/CD**

GitHub Actions is configured for automatic code checks:

- Linters (RuboCop, Slim-Lint)
- Security checks (Brakeman, bundler-audit)
- Tests (minitest)
- System tests

The status badges at the top show the latest build status for both CI and Hexlet checks.

## **Features Implemented**

- ✅ User authentication (Devise with Russian localization)
- ✅ Creating and viewing posts
- ✅ Post categories
- ✅ Nested comments (via ancestry gem)
- ✅ Post likes with counter_cache
- ✅ Russian interface localization
- ✅ Responsive Bootstrap design
- ✅ Full test coverage

## **License**

Educational project from Hexlet

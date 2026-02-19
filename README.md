# Collective Blog (Habr-like)

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

# Create database
bin/rails db:create
bin/rails db:migrate

# Start development server
bin/dev
```

The application will be available at: http://localhost:3000

## Database Structure

The project uses the following models:
- **User** — users
- **Post** — posts
- **Category** — categories
- **Comment** — comments
- **Like** — post ratings

## Testing

```bash
bin/rails test
```

## Deployment on Render

The project is configured for deployment on Render.com via [render.yaml](render.yaml). Pushing to `main` or `development` branch automatically triggers build and deployment.

## License

Educational project from Hexlet  
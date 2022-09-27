# Aronnax Docs

### Requirements

- Ruby 3.1.2
- Bundler 2.3.22
- Node.js
- Yarn
- PostgreSQL

### Installation

#### Clone the repository

```bash
git clone git@github.com:AronnaxSpace/docs.git
```

#### Install dependencies

```bash
bundle install && yarn install
```

#### Set environment variables

Check if you have direnv installed:

```bash
direnv --version
```

direnv installation instructions:
https://direnv.net/docs/installation.html

Create an .envrc file

```bash
touch .envrc
```

Adjust and set the following variables:

```
export PORT=4005

export DOCS_DATABASE_HOST=localhost
export DOCS_DATABASE_PORT=5432
export DOCS_DATABASE_USERNAME=postgres
export DOCS_DATABASE_PASSWORD=postgres

export ARONNAX_APP_ID=aronnax_app_id
export ARONNAX_APP_SECRET=aronnax_app_secret
export ARONNAX_APP_URL=http://localhost:4000/
```

Approve the .envrc content

```bash
direnv allow
```

#### Setup the database

```bash
rails db:create
rails db:schema:load
rails db:seed
```

or

```bash
rails db:setup
```

#### Launch the application

```bash
foreman s -f Procfile.dev
```

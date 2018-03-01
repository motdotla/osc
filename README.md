# Open Source Citizen (OSC)

<img src="https://raw.githubusercontent.com/motdotla/osc/master/osc.png" alt="OSC Logo" align="right" />

OSC is an economic citizenship experiment aiming to increase economic participation in open source software.

## Development

### Setup

1. Configure `.env` credentials

```
cp .env.example .env
```

2. Install dependencies

```
bundle install
bundle exec rake db:create db:migrate
```

3. Run Server

```
bin/rails s
```

4. Visit platform

```
http://localhost:3000
```

### Running Tests

1. Create test database

```
bundle exec rake db:create db:migrate RAILS_ENV=test
```

2. Run specs

```
bin/rspec
```

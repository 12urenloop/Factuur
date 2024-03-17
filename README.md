# Factuur

Onze huisgemaakte factuurgeneratie-applicatie.

## Hoe start ik?

1. Installeer:
    - Ruby 3.3.0
    - Bundler
    - yarn
2. `bundle install`
3. `npm install`
4. `docker compose -f docker-compose.dev.yml up -d`
5. `bundle exec rails db:setup`
6. `bundle exec rails s`
7. Browse to `http://localhost:3000`

## Deployment
1. Push changes to `master` on GitHub
2. Run `bundle exec cap production deploy` locally from your device

## Testen
Run `bundle exec rake`


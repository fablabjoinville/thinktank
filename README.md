# Think Tank

## Resources

* Project Miro: [https://miro.com/app/board/uXjVMJXOtMo=/](https://miro.com/app/board/uXjVMJXOtMo=/)
* Issues: https://github.com/fablabjoinville/thinktank/issues

## Dependencies

* ruby >= 3.2.2
* node --lts (v14.16.0)
* npm >= 9.6.6
* PostgreSQL >= 14.8

```sh
brew install postgresql libpq
rbenv install 3.2.2
nvm install --lts
nvm use --lts
node -p "process.arch" # > arm64
npm install yarn -g
yarn install
```

## Development

We use PostgreSQL for development and testing.

```bash
brew services start postgresql
```

To configure the environment, run:

```bash
rails db:drop
rails db:create
rails db:migrate
rails db:seed
```

To run the server:

```bash
./bin/dev
```

Access [http://127.0.0.1:3000/admin](http://127.0.0.1:3000/admin). See the default User credentials on `db/seed.rb`.

## Tests

We don't have any tests yet.

## Staging

Tested on Heroku:

```bash
heroku login
heroku apps:create --stack=heroku-22
git push heroku main
heroku run rails db:migrate
heroku run rails db:seed
heroku ps:scale web=1
heroku open
```

## Production

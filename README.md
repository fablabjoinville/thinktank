# Think Tank

Sistema de gestão do projeto Think Tank. Desenvolvido em Ruby on Rails 7 e [ActiveAdmin](https://activeadmin.info/5-forms.html).

## Recursos

* Projeto Miro: [https://miro.com/app/board/uXjVMJXOtMo=/](https://miro.com/app/board/uXjVMJXOtMo=/)
* Tarefas: https://github.com/fablabjoinville/thinktank/issues

## Dependências

* ruby >= 3.2.2
* node --lts (v14.16.0)
* npm >= 9.6.6
* PostgreSQL >= 14.8

Instalando as dependências em um macOS:

```bash
brew install postgresql libpq
rbenv install 3.2.2
nvm install --lts
nvm use --lts
node -p "process.arch" # > arm64
npm install yarn -g
yarn install
```

## Desenvolvimento

Nós usamos PostgreSQL para desenvolvimento e testes:

```bash
brew services start postgresql
```

Para configurar o ambiente, execute:

```bash
rails db:drop
rails db:create
rails db:migrate
rails db:seed
```

Para rodar o servidor de desenvolvimento, execute:

```bash
./bin/dev
```

Acesse [http://127.0.0.1:3000/admin](http://127.0.0.1:3000/admin).
Veja as credenciais do usuário padrão em `db/seed.rb`.

## Testes

> Sorry, nothing to see here.

## Staging

Fazendo deploy na Heroku:

```bash
heroku login
heroku git:remote -a thinktank
git push heroku main
heroku run rails db:migrate
heroku run rails db:seed
heroku open
```

Abrirá [https://thinktank.herokuapp.com](https://thinktank.herokuapp.com).

## Produção

TODO

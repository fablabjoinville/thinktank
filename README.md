# Think Tank

Sistema de gestão do projeto Think Tank. Desenvolvido em Ruby on Rails 7 e [ActiveAdmin](https://activeadmin.info/5-forms.html).

## Recursos

* Projeto Miro: [https://miro.com/app/board/uXjVMJXOtMo=/](https://miro.com/app/board/uXjVMJXOtMo=/)
* Tarefas: https://github.com/fablabjoinville/thinktank/issues

## Dependências

* Ruby = 3.3.0
* Node.js =  20.11.0
* PostgreSQL >= 14.8

Instalando as dependências em um macOS:

```bash
brew install postgresql libpq
rbenv install 3.3.0
nvm use
```

## Desenvolvimento

Nós usamos PostgreSQL para desenvolvimento e testes:

```bash
brew services start postgresql
```

Para preparar o banco de desenvolvimento, execute:

```bash
./bin/db-reset
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
heroku addons:create heroku-postgresql:mini
git push heroku main
heroku buildpacks:add heroku/nodejs -i 1
heroku run rails db:migrate
heroku ps:scale web=1
heroku run rails db:seed
heroku open
```

## Produção

TODO

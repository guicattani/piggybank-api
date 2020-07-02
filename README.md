# Piggybank-API

Piggybank is a personal project to create a habit of saving money. You can specify how much you will save in each time period and have the application asynchronously save this value for you each time this period passes.

While the interface has not been finished, a mock-up interface was made by Clarissa Vasconcelos and is acessible here: [Figma](https://www.figma.com/proto/TOg7AfVMKRtWYeKaiMuxeg/Piggy-Project?scaling=scale-down&node-id=9%3A313)

# Getting Started
### Windows
1. Install WSL
2. Install Ubuntu
3. Install RVM
4. Install Ruby 2.5.1 through RVM
5. Install Postgres with
`sudo apt-get -y install postgresql postgresql-contrib libpq-dev`
6. Set up Postgres user as `postgres`, password `postgres`
```
su -l postgres
psql

\password postgres
```
7. Install bundler with `gem install bundler`
8. Bundle install with `bundle`
9. Run `rails db:create`
10. Run `rails db:migrate && rails db:migrate RAILS_ENV=test`
11. Copy .env.sample  and rename it to .env
12. Run test suite with `bundle exec guard` and press Enter

Bonus: If using VSCODE use the WSL Remote extension to run the console directly in WSL

### Linux
1. Install RVM
2. Install Ruby 2.5.1 through RVM
3. Install Postgres with
`sudo apt-get -y install postgresql postgresql-contrib libpq-dev`
4. Set up Postgres user as `postgres`, password `postgres`
```
su -l postgres
psql

\password postgres
```
5. Install bundler with `gem install bundler`
6. Bundle install with `bundle`
7. Run `rails db:create`
8. Run `rails db:migrate && rails db:migrate RAILS_ENV=test`
9. Copy .env.sample  and rename it to .env
10. Run test suite with `bundle exec guard` and press Enter

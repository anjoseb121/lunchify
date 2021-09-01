##### Prerequisites

The setups steps expect following tools installed on the system.

- Git
- Ruby 2.6.2
- Rails 6.1.4

##### 1. Check out the repository

```bash
git clone git@github.com:anjoseb121/lunchify.git
```
##### 2. Install dependencies

```bash
bundle install
yarn install
```

##### 3. Create and setup the database

Run the following commands to create and setup the database.

```ruby
rails db:create
rails db:migrate
```
##### 4. Execute seeds

Run the following commands to create sample data

```ruby
rails db:seed
```

##### 5. Start the Rails server

You can start the rails server using the command given below.

```ruby
rails s
```

And now you can visit the site with the URL http://localhost:3000

You should be able to login with the tests users:
- admin: antonio@lunchify.com, password: password
- employee: employee@lunchify.com, password: password

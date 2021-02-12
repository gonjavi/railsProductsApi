# README

This is a public API for users with associations of Products, and Products with associations of Categories. The propject was built with Ruby on Rails and deployed on Heroku. The API allows CRUD actions with Users, Products, and Categories.

## Endpoints to test the API

url: https://products-categories-api.herokuapp.com/

user endpoints
- get: users {{url}}/api/v1/users/
- get: a user {{url}}/api/v1/users/:id
- put: update a user {{url}}/api/v1/users/:id
- post: create a user {{url}}/api/v1/users/
- delete: delete a user {{url}}/api/v1/products/:id

products endpoints
- get: products {{url}}/api/v1/products/
- get: a product {{url}}/api/v1/products/:id
- put: update a product {{url}}/api/v1/products/:id
- post: create a product {{url}}/api/v1/products/
- delete: delete a product {{url}}/api/v1/products/:id

categories endpoints
- get: users {{url}}/api/v1/users/
- put: update a user {{url}}/api/v1/users/:id
- post: create a user {{url}}/api/v1/users/
- delete: delete a category {{url}}/api/v1/categories/:id

You can download the file productionProductsAPis.json and import it in postman to test the API.

### Prerequisites
- npm 6.14.10
- node 14.15.4

## Built With

- Ruby 2.7.2
- Rails 6.0.3
- FastJsonApi 1.1

## Installation

```bash
$ bundle install
```
* Create PostgreQSL database:
```bash
$ rails db:create
```
* Migrate the database:
```bash
$ rails db:migrate
```
* Simply run the app with :
```bash
$ rails s
```

# RSpec Tests

For RSpec testing run the following commands:

- $rspec --format documentation


## Author:
👤 **Gonza Javier Mancilla**

- Github: [@gonjavi](https://github.com/gonjavi)
- Linkedin: [@g-javier-mancilla](https://www.linkedin.com/in/g-mancillla)


## 🤝 Contributing

Contributions, issues and feature requests are welcome!


## Show your support

Give a ⭐️ if you like this project!


## 📝 License

This project is [MIT](lic.url) licensed.

# SKU project's README

git clone

Create new file application.yml under /config and add these followings.
#
sku_admin_email: "admin@email.com"
sku_admin_password: "password"
#
create database as database.yml
migrate and rails db:seed

For API calls,
you can use api_auth_skip=1 or change ur local host to "api.sku.dev" and get access_id from ApiToken table.
eg- api.sku.dev:3000/v1/inventories?api_key=7664


# Mongosh Commands

Command reference: https://www.mongodb.com/docs/mongodb-shell/

## Connect

Connect to a local mongo instance on the default port:
```
mongosh --username [username] --password [password]
```

## Databases

List the database you are using: `db`

List the databases in the instance: `show dbs`

Switch databases: `use [database]`

## Collections

List the collections in the database: `show collections`

## Index

Create a text search index:

```
db.[collection].createIndex({[column-name]: "text"})
```

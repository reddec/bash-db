bash-db
=======

Very simple Key-Value database on bash script

Install
=======

```bash
chmod +x db.sh
cp db.sh /usr/local/bin/db
```

Usage
=======
`db <method> <database> [arguments...]`

Methods:

* `put` - Insert or update record.
 * **key** (required) - Record unique key. Can be used any value (also spaces if value in bracets)
 * **value** (optional) - Record value.  Can be used any value (also spaces if value in bracets). If value not set, STDIN will be used.
* `get` - Get value of record by key
 * **key** (required) - Record unique key. Can be used any value (also spaces if value in bracets)
* `list` - Get all keys in database
* `delete` - Delete record by key
 * **key** (required) - Record unique key. Can be used any value (also spaces if value in bracets)

Examples
========

Put some value
```bash
db put test.db name 'Red Dec'
```

Get

```bash
db get test.db name
```

Update

```bash
db put test.db name 'New Red Dec'
```

List


```bash
db list test.db
```

Delete

```bash
db delete test.db name
```

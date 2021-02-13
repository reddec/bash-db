bash-db
=======

Very simple Key-Value database on bash script. Depends on pre-installed software only (tested on Ubuntu 14.04 LTS):
* sed
* bash
* grep
* base64
* xargs

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

### PUT

Insert or update record.

| Arg               | Description  |
|-------------------| -------------|
| `key` (required)  | Unique key. Can be used any value (also spaces if value in bracets)
| `value` (optional)| Value of record.  Can be used any value (also spaces if value in bracets). If value not set, STDIN will be used.

#### Example:

```bash
db put test.db name 'Red Dec'
```

### GET

Get value of record by key

| Arg               | Description  |
|-------------------| -------------|
| `key` (required)  | Unique key. Can be used any value (also spaces if value in bracets)

#### Example:

```bash
db get test.db name
```

### LIST

Get all keys in database

**No arguments**

#### Example:

```bash
db list test.db
```

### LAST

Get the value of the last added record

**No arguments**

#### Example:

```bash
db last test.db
```

### DELETE

Delete record by key

| Arg               | Description  |
|-------------------| -------------|
| `key` (required)  | Unique key. Can be used any value (also spaces if value in bracets)

#### Example:

```bash
db delete test.db name
```

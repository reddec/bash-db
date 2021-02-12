#!/bin/bash

# Get value by key
get () {
   db=$1;
   key=$(echo -n "$2" | base64 -w 0);
   sed -nr "s/^$key\ (.*$)/\1/p" $db | base64 -d
}

# List all keys
list () {
   db=$1;
   sed -nr "s/(^[^\ ]+)\ (.*$)/\1/p" $db | xargs -n 1 sh -c 'echo `echo -n $0 | base64 -d`'
}

# Get last added value 
last () {
    db=$1;
    sed -nr "\$s/(.*)\ (.*$)/\2/p;d" $db | base64 -d
}

# Put or updated record
put () {
    db=$1;
    key=$(echo -n "$2" | base64 -w 0);
    value=$3;
    if [ -z "$3" ]
    then
       value=$(base64 -w 0 <&0);
    else
       value=$(echo -n "$value" | base64 -w 0);
    fi

    if [ ! -f "$1" ]; then touch "$db"; fi;
    if [[ $(grep "^"$key"\ " $db) == "" ]]; then
        #Insert
        echo "$key $value" >> $db
    else
        #Replace
        sed -ir "s/^$key\ .*/$key $value/g" $db
    fi;
}

# Remove record by key
delete () {
   db=$1;
   key=$(echo -n "$2" | base64 -w 0);
   sed -ri "/^"$key"\ .*/d" "$db"
}

# Start
"$@"

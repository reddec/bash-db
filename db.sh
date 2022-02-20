#!/bin/bash

# Get value by key
get () {
   if [[ -z "$1" ]];
   then
      echo "No database provided"
   elif [[ "$1" == "--help" ]];
   then
      echo "Usage: db get <database> <key>"
   elif [[ -z "$2" ]];
   then
      echo "No key provided"
   else
      db=$1;
      key=$(echo -n "$2" | base64 -w 0);
      sed -nr "s/^$key\ (.*$)/\1/p" $db | base64 -d
   fi
}

# List all keys
list () {
   if [[ -z "$1" ]];
   then
      echo "No database provided"
   elif [[ "$1" == "--help" ]];
   then
      echo "Usage: db list <database>"
   else
      db=$1;
      sed -nr "s/(^[^\ ]+)\ (.*$)/\1/p" $db | xargs -n 1 sh -c 'echo `echo -n $0 | base64 -d`'
   fi
}

# Get last added value 
last () {
   if [[ -z "$1" ]];
   then
      echo "No database provided"
   elif [[ "$1" == "--help" ]];
   then
      echo "Usage: db last <database>"
   else
      db=$1;
      sed -nr "\$s/(.*)\ (.*$)/\2/p;d" $db | base64 -d
   fi
}

# Put or updated record
put () {
   if [[ -z "$1" ]];
   then
      echo "No database provided"
   elif [[ "$1" == "--help" ]];
   then
      echo "Usage: db put <database> <key> ?<value>"
   elif [[ -z "$2" ]];
   then
      echo "No key provided"
   else
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
   fi;
}

# Remove record by key
delete () {
   if [[ -z "$1" ]];
   then
      echo "No database provided"
   elif [[ "$1" == "--help" ]];
   then
      echo "Usage: db delete <database> <key>"
   elif [[ -z "$2" ]];
   then
      echo "No key provided"
   else
      db=$1;
      key=$(echo -n "$2" | base64 -w 0);
      sed -ri "/^"$key"\ .*/d" "$db"
   fi
}

# Start
if [[ -z "$1" || "$1" == "--help" ]];
then
   echo "Usage: db <method> <database> [arguments...]"
else
   if [[ "$1" =~ (get|list|last|put|delete) ]];
   then
      "$@"
   else
      echo "Usage: db <get|list|last|put|delete> <database> [arguments...]"
   fi
fi

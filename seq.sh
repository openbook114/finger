#!/bin/sh
psql -h 192.168.99.100 -p 5432 -U postgres --password -c "\ds" | grep sequence | cut -d'|' -f2 | tr -d '[:blank:]' |
while read sequence_name; do
  table_name=${sequence_name%_id_seq}

  psql -h 192.168.99.100 -p 5432 -U postgres -c "select setval('$sequence_name', (select max(id) from $table_name))"
done
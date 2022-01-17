#!/bin/bash
set -e

DATE="$(date)"
MYSQL_MASTER="docker exec -i mysql_master mysql -p111"
MYSQL_SLAVE="docker exec -i mysql_slave mysql -p111"
DB=mydb
TABLE="$DB.my_text"
DUMP="show create table $TABLE\G select * from $TABLE\G show table status FROM $DB\G"

CREATE="
DROP DATABASE IF EXISTS mydb;
CREATE DATABASE mydb CHARSET=utf8mb3;
USE mydb;
DROP TABLE IF EXISTS my_text;
CREATE TABLE my_text (
   id int primary key auto_increment,
   my_value text
) CHARSET=utf8mb3 ROW_FORMAT=COMPACT;
"

ALTER="
ALTER TABLE mydb.my_text
MODIFY my_value TEXT CHARACTER SET utf8mb4,
DEFAULT CHARACTER SET utf8mb4,
ROW_FORMAT=Dynamic;"

INSERT="
INSERT INTO mydb.my_text VALUES
(2, \"$DATE: Ṡѻмḗƫḧȉᴨɡ шᶖḉ𝞌ề𝙙 тḧḭʂ ш𝒂ყ 𝖈ȫᵯⱸ𝗌 ⬅️  ⬆️  ⬇️ \");"

### Replication with same character set
echo "=== Test 1: Same charset"
echo "Creating the DB"
$MYSQL_MASTER -e "$CREATE"
echo "Waiting for replication"
sleep 2;
echo "Inserting utf8 text"
$MYSQL_MASTER -e "$INSERT"
echo "Dumping via $DUMP to mydb-same-chartset.log"
$MYSQL_SLAVE -e "$DUMP" mydb > mydb-same-charset.log

### Replication with different character set
echo "=== Test 2: Different charset"
echo "Creating the DB"
$MYSQL_MASTER -e "$CREATE"
echo "Waiting for replication"
sleep 2;
echo "Alterting the replica table to utf8mb4"
$MYSQL_SLAVE -e "$ALTER"
echo "Inserting utf8 text"
$MYSQL_MASTER -e "$INSERT"
echo "Dumping via $DUMP to mydb-diff-chartset.log"
$MYSQL_SLAVE -e "$DUMP" mydb > mydb-diff-charset.log

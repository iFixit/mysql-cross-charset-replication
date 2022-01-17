DB=mydb
TABLE="$DB.my_text"
DUMP="show create table $TABLE\G select * from $TABLE\G show table status FROM $DB\G"
# Create the DB and table
echo "=== Test 1: Same charset"
echo "Creating the DB"
cat 1.create.sql | docker exec -i  mysql_master mysql -p111 
echo "Waiting for replication"
sleep 2;
echo "Inserting utf8 text"
cat 3.insert_utf8.sql | docker exec -i  mysql_master mysql -p111 
echo "Dumping via $DUMP to mydb-same-chartset.sql "
docker exec -i  mysql_slave mysql -p111 -e "$DUMP" mydb > mydb-same-charset.sql

echo "=== Test 2: Different charset"
echo "Creating the DB"
cat 1.create.sql | docker exec -i  mysql_master mysql -p111 
echo "Waiting for replication"
sleep 2;
echo "Alterting the replica table to utf8mb4"
cat 2.alter_utf8mb4.sql | docker exec -i  mysql_slave mysql -p111 
echo "Inserting utf8 text"
cat 3.insert_utf8.sql | docker exec -i  mysql_master mysql -p111 
echo "Dumping via $DUMP to mydb-diff-chartset.sql "
docker exec -i  mysql_slave mysql -p111 -e "$DUMP" > mydb-diff-charset.sql

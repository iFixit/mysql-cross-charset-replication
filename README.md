Mysql utf8mb3 -> utf8mb4 replication

====================

Shows how mysql acts when replicating from columns that are utf8mb3 to utf8mb4.

1. `./build.sh` - Sets up docker containers for replication
2. `./run.bash`
   1. Replicate an utf8mb3 table and dump the results from the replica
   1. Replicate an utf8mb3 table to a utf8mb4 table and dump the results from the replica.
3. `diff ./mydb-same-charset.log ./mydb-diff-charset.log`


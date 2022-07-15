Mysql utf8mb3 -> utf8mb4 replication
===

Shows how mysql acts when replicating across servers from columns that are
utf8mb3 to those that are utf8mb4. The results are that it's fine to replicate
across charsets so long as the destination is a super-set of the source (as is
the case with utf8mb3 and utf8mb4)

1. `(cd docker-mysql-master-slave && ./build.sh)` - Sets up docker containers for replication
2. `./run.bash`
   1. Replicates a utf8mb3 table and dump the results from the replica
   1. Replicates a utf8mb3 table to a utf8mb4 table and dump the results from the replica.
3. `diff ./mydb-same-charset.log ./mydb-diff-charset.log`
   1. Should be no differences


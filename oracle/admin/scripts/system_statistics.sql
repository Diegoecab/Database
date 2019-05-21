--system_statistics.sql

select sname, pname, pval1
from sys.aux_stats$;

prompt CPUSPEEDNW, IOSEEKTIM, and IOTFRSPEED are noworkload statistics
prompt SREADTIM, MREADTIM, CPUSPEED, MBRC, MAXTHR, and SLAVETHR represent workload statistics


prompt If both workload and noworkload statistics are available, the optimizer uses workload statistics.
prompt
prompt  _SREADTIM -> single block read time (milliseconds) -> is the average time Oracle takes to read a single block.
prompt
prompt 	_MREADTIM -> multiblock read time (milliseconds) -> is the average time taken to read sequentially.
prompt
prompt 	_MBRC -> multiblock read count  -> is the blocks, on average, read during multiblock sequential reads. 
prompt The CBO uses MBRC instead of the db_ multiblock_read_count parameter during query optimization to compute costs for table and fast full index scans.
prompt 	_MAXTHR -> maximum I/O system throughput—is captured only if the database runs parallel queries.
prompt
prompt 	_SLAVETHR -> maximum slave I/O throughput—is captured only if the database runs parallel queries. 
prompt
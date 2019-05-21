/*
DBMS_STATS.GATHER_TABLE_STATS (
   ownname          VARCHAR2, 
   tabname          VARCHAR2, 
   partname         VARCHAR2 DEFAULT NULL,
   estimate_percent NUMBER   DEFAULT to_estimate_percent_type 
                                                (get_param('ESTIMATE_PERCENT')), 
   block_sample     BOOLEAN  DEFAULT FALSE,
   method_opt       VARCHAR2 DEFAULT get_param('METHOD_OPT'),
   degree           NUMBER   DEFAULT to_degree_type(get_param('DEGREE')),
   granularity      VARCHAR2 DEFAULT GET_PARAM('GRANULARITY'), 
   cascade          BOOLEAN  DEFAULT to_cascade_type(get_param('CASCADE')),
   stattab          VARCHAR2 DEFAULT NULL, 
   statid           VARCHAR2 DEFAULT NULL,
   statown          VARCHAR2 DEFAULT NULL,
   no_invalidate    BOOLEAN  DEFAULT  to_no_invalidate_type (
                                     get_param('NO_INVALIDATE')),
   force            BOOLEAN DEFAULT FALSE);

   
   
   
Parameter Description 

ownname
 Schema of table to analyze
 
tabname
 Name of table
 
partname
 Name of partition
 
estimate_percent
 Percentage of rows to estimate (NULL means compute) The valid range is [0.000001,100]. Use the constant DBMS_STATS.AUTO_SAMPLE_SIZE to have Oracle determine the appropriate sample size for good statistics. This is the default.The default value can be changed using the SET_PARAM Procedure.
 
block_sample
 Whether or not to use random block sampling instead of random row sampling. Random block sampling is more efficient, but if the data is not randomly distributed on disk, then the sample values may be somewhat correlated. Only pertinent when doing an estimate statistics.
 
method_opt
 Accepts:
FOR ALL [INDEXED | HIDDEN] COLUMNS [size_clause]
FOR COLUMNS [size clause] column|attribute [size_clause] [,column|attribute [size_clause]...]
size_clause is defined as size_clause := SIZE {integer | REPEAT | AUTO | SKEWONLY}

- integer : Number of histogram buckets. Must be in the range [1,254].
- REPEAT : Collects histograms only on the columns that already have histograms.
- AUTO : Oracle determines the columns to collect histograms based on data distribution and the workload of the columns.
- SKEWONLY : Oracle determines the columns to collect histograms based on the data distribution of the columns. The default is FOR ALL COLUMNS SIZE AUTO.The default value can be changed using the SET_PARAM Procedure.
 
degree
 Degree of parallelism. The default for degree is NULL. The default value can be changed using the SET_PARAM Procedure NULL means use the table default value specified by the DEGREE clause in the CREATE TABLE or ALTER TABLE statement. Use the constant DBMS_STATS.DEFAULT_DEGREE to specify the default value based on the initialization parameters. The AUTO_DEGREE value determines the degree of parallelism automatically. This is either 1 (serial execution) or DEFAULT_DEGREE (the system default value based on number of CPUs and initialization parameters) according to size of the object.
 
granularity
 Granularity of statistics to collect (only pertinent if the table is partitioned).
'ALL' - gathers all (subpartition, partition, and global) statistics
'AUTO'- determines the granularity based on the partitioning type. This is the default value.
'DEFAULT' - gathers global and partition-level statistics. This option is obsolete, and while currently supported, it is included in the documentation for legacy reasons only. You should use the 'GLOBAL AND PARTITION' for this functionality. Note that the default value is now 'AUTO'.
'GLOBAL' - gathers global statistics
'GLOBAL AND PARTITION' - gathers the global and partition level statistics. No subpartition level statistics are gathered even if it is a composite partitioned object.
'PARTITION '- gathers partition-level statistics
'SUBPARTITION' - gathers subpartition-level statistics.
 
cascade
 Gather statistics on the indexes for this table. Index statistics gathering is not parallelized. Using this option is equivalent to running the GATHER_INDEX_STATS Procedure on each of the table's indexes. Use the constant DBMS_STATS.AUTO_CASCADE to have Oracle determine whether index statistics to be collected or not. This is the default. The default value can be changed using the SET_PARAM Procedure.
 
stattab
 User statistics table identifier describing where to save the current statistics
 
statid
 Identifier (optional) to associate with these statistics within stattab
 
statown
 Schema containing stattab (if different than ownname)
 
no_invalidate
 Does not invalidate the dependent cursors if set to TRUE. The procedure invalidates the dependent cursors immediately if set to FALSE. Use DBMS_STATS.AUTO_INVALIDATE. to have Oracle decide when to invalidate dependent cursors. This is the default. The default can be changed using the SET_PARAM Procedure.
 
force
 Gather statistics of table even if it is locked
 
   
*/
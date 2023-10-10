set lines 300
col owner for a20 truncate
col table_name for a40 truncate
select owner, table_name, num_rows, AVG_SPACE,  CHAIN_CNT, AVG_ROW_LEN , round((CHAIN_CNT * 100) / num_rows,2) pct_chain,
chain_cnt * avg_row_len tot_chain, BLOCKS, EMPTY_BLOCKS, BLOCKS - EMPTY_BLOCKS, NUM_ROWS / BLOCKS                
from dba_tables where chain_cnt > 0;
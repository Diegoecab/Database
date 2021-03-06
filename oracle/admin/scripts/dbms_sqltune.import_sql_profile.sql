
/*
set serveroutput on
DECLARE
cl_sql_text CLOB;
BEGIN
SELECT sql_text
  INTO cl_sql_text from dba_hist_sqltext  where sql_id='99yy6cragv5cu';
DBMS_SQLTUNE.IMPORT_SQL_PROFILE(sql_text => cl_sql_text, 
 profile => sqlprof_attr('OUTLINE_LEAF(@"SEL$1")','INDEX_RS_ASC(@"SEL$1" "TB9"@"SEL$1" ("SM_CNTB9"."SUBSIDIARIA" "SM_CNTB9"."BRANCH_CODE" "SM_CNTB9"."CCY"))','INDEX(@"SEL$1" "BAL"@"SEL$1" ("SM_ACC_BALANCES"."SUBSIDIARIA" "SM_ACC_BALANCES"."BRANCH_CODE" "SM_ACC_BALANCES"."CCY" "SM_ACC_BALANCES"."CURRENT_ACCOUNT" "SM_ACC_BALANCES"."REPORT_DATE"))','FULL(@"SEL$1" "BRANCH"@"SEL$1")','INDEX_RS_ASC(@"SEL$1" "ACC"@"SEL$1" ("SM_BRAC"."CURRENT_ACCOUNT"))','INDEX_RS_ASC(@"SEL$1" "PL"@"SEL$1" ("SM_BRPL"."REPORT_DATE" "SM_BRPL"."POOL_CODE"))','INDEX_RS_ASC(@"SEL$1" "PC"@"SEL$1" ("DW_GL"."GL_CODE"))','LEADING(@"SEL$1" "TB9"@"SEL$1" "BAL"@"SEL$1" "BRANCH"@"SEL$1" "ACC"@"SEL$1" "PL"@"SEL$1" "PC"@"SEL$1")','USE_NL(@"SEL$1" "BAL"@"SEL$1")','USE_HASH(@"SEL$1" "BRANCH"@"SEL$1")','USE_NL(@"SEL$1" "ACC"@"SEL$1")','USE_NL(@"SEL$1" "PL"@"SEL$1")','USE_NL(@"SEL$1" "PC"@"SEL$1")','END_OUTLINE_DATA'), 
 name=>'BRAZIL20120802', 
 force_match => TRUE); 
end;
/   
*/


set serveroutput on
DECLARE
cl_sql_text CLOB;
BEGIN
SELECT sql_text
  INTO cl_sql_text from dba_hist_sqltext  where sql_id ='3af0k1s3pz3gf';
DBMS_SQLTUNE.IMPORT_SQL_PROFILE(sql_text => cl_sql_text, 
 profile => sqlprof_attr('OUTLINE_LEAF(@"SEL$1")','OUTLINE_LEAF(@"SEL$2")','OUTLINE_LEAF(@"SEL$3")','OUTLINE_LEAF(@"SET$FCA7A018")','OUTLINE_LEAF(@"SEL$741D3B59")','UNNEST(@"SET$1")','OUTLINE(@"SEL$1")','OUTLINE(@"SEL$2")','OUTLINE(@"SEL$3")','OUTLINE(@"SET$1")','OUTLINE(@"SET$FCA7A018")','OUTLINE(@"DEL$1")','NO_ACCESS(@"SEL$741D3B59" "VW_NSO_1"@"SEL$741D3B59")','INDEX(@"SEL$741D3B59" "A"@"DEL$1" ("PAL_BALANCES_PERIODIC"."PAL_CATEGORY"','"PAL_BALANCES_PERIODIC"."PAL_PERIOD" "PAL_BALANCES_PERIODIC"."LEGAL_VEHICLE"))','LEADING(@"SEL$741D3B59" "VW_NSO_1"@"SEL$741D3B59" "A"@"DEL$1")','USE_HASH(@"SEL$741D3B59" "A"@"DEL$1")','FULL(@"SEL$3" "D"@"SEL$3")','FULL(@"SEL$2" "C"@"SEL$2")','FULL(@"SEL$1" "B"@"SEL$1")','END_OUTLINE_DATA'), 
 name=>'COL_DW_DELETE_ISSUE', 
 force_match => TRUE); 
end;
/

commit;



set serveroutput on
DECLARE
cl_sql_text CLOB;
BEGIN
SELECT sql_text
  INTO cl_sql_text from dba_hist_sqltext  where sql_id ='g5jhxqmtc4300';
DBMS_SQLTUNE.IMPORT_SQL_PROFILE(sql_text => cl_sql_text, 
 profile => sqlprof_attr('OUTLINE_LEAF(@"SEL$2")','OUTLINE_LEAF(@"SEL$1")','OUTLINE(@"SEL$2")','OUTLINE(@"SEL$1")','INDEX_RS_ASC(@"SEL$1" "ADJ"@"SEL$1" ("SM_ACCT_227"."AS_OF_DATE"))','NO_ACCESS(@"SEL$1" "CTR"@"SEL$1")','FULL(@"SEL$1" "CY"@"SEL$1")','LEADING(@"SEL$1" "ADJ"@"SEL$1" "CTR"@"SEL$1" "CY"@"SEL$1")','USE_HASH(@"SEL$1" "CTR"@"SEL$1")','USE_HASH(@"SEL$1" "CY"@"SEL$1")','SWAP_JOIN_INPUTS(@"SEL$1" "CTR"@"SEL$1")','SWAP_JOIN_INPUTS(@"SEL$1" "CY"@"SEL$1")','INDEX_RS_ASC(@"SEL$2" "A"@"SEL$2" ("SM_ACCT_227"."AS_OF_DATE"))','FULL(@"SEL$2" "B"@"SEL$2")','LEADING(@"SEL$2" "A"@"SEL$2" "B"@"SEL$2")','USE_HASH(@"SEL$2" "B"@"SEL$2")','END_OUTLINE_DATA'), 
 name=>'BRFC_DW_DERIV_ISSUE', 
 force_match => TRUE); 
end;
/

commit;


set serveroutput on
DECLARE
cl_sql_text CLOB;
BEGIN
SELECT sql_text
  INTO cl_sql_text from v$sql  where sql_id ='7g2mh36ftg0y1';
DBMS_SQLTUNE.IMPORT_SQL_PROFILE(sql_text => cl_sql_text, 
 profile => sqlprof_attr('OUTLINE_LEAF(@"SEL$2")','OUTLINE_LEAF(@"SEL$3")','OUTLINE_LEAF(@"SET$2")','OUTLINE_LEAF(@"SEL$4")','OUTLINE_LEAF(@"SEL$5")','OUTLINE_LEAF(@"SET$3")','OUTLINE_LEAF(@"SEL$6")','OUTLINE_LEAF(@"SEL$7")','OUTLINE_LEAF(@"SET$4")','OUTLINE_LEAF(@"SEL$8")','OUTLINE_LEAF(@"SEL$9")','OUTLINE_LEAF(@"SET$5")','OUTLINE_LEAF(@"SEL$1")','OUTLINE_LEAF(@"SEL$11")','OUTLINE_LEAF(@"SEL$12")','OUTLINE_LEAF(@"SET$6")','OUTLINE_LEAF(@"SEL$13")','OUTLINE_LEAF(@"SEL$14")','OUTLINE_LEAF(@"SET$7")','OUTLINE_LEAF(@"SEL$15")','OUTLINE_LEAF(@"SEL$16")','OUTLINE_LEAF(@"SET$8")','OUTLINE_LEAF(@"SEL$17")','OUTLINE_LEAF(@"SEL$18")','OUTLINE_LEAF(@"SET$9")','OUTLINE_LEAF(@"SEL$10")','OUTLINE_LEAF(@"SEL$20")','OUTLINE_LEAF(@"SEL$21")','OUTLINE_LEAF(@"SET$10")','OUTLINE_LEAF(@"SEL$22")','OUTLINE_LEAF(@"SEL$23")','OUTLINE_LEAF(@"SET$11")','OUTLINE_LEAF(@"SEL$19")','OUTLINE_LEAF(@"SEL$25")','OUTLINE_LEAF(@"SEL$26")','OUTLINE_LEAF(@"SET$12")','OUTLINE_LEAF(@"SEL$27")','OUTLINE_LEAF(@"SEL$28")','OUTLINE_LEAF(@"SET$13")','OUTLINE_LEAF(@"SEL$29")','OUTLINE_LEAF(@"SEL$30")','OUTLINE_LEAF(@"SET$14")','OUTLINE_LEAF(@"SEL$31")','OUTLINE_LEAF(@"SEL$32")','OUTLINE_LEAF(@"SET$15")','OUTLINE_LEAF(@"SEL$24")','OUTLINE_LEAF(@"SET$1")','OUTLINE_LEAF(@"INS$1")','OUTLINE(@"SEL$2")','OUTLINE(@"SEL$3")','OUTLINE(@"SET$2")','OUTLINE(@"SEL$4")','OUTLINE(@"SEL$5")','OUTLINE(@"SET$3")','OUTLINE(@"SEL$6")','OUTLINE(@"SEL$7")','OUTLINE(@"SET$4")','OUTLINE(@"SEL$8")','OUTLINE(@"SEL$9")','OUTLINE(@"SET$5")','OUTLINE(@"SEL$1")','OUTLINE(@"SEL$11")','OUTLINE(@"SEL$12")','OUTLINE(@"SET$6")','OUTLINE(@"SEL$13")','OUTLINE(@"SEL$14")','OUTLINE(@"SET$7")','OUTLINE(@"SEL$15")','OUTLINE(@"SEL$16")','OUTLINE(@"SET$8")','OUTLINE(@"SEL$17")','OUTLINE(@"SEL$18")','OUTLINE(@"SET$9")','OUTLINE(@"SEL$10")','OUTLINE(@"SEL$20")','OUTLINE(@"SEL$21")','OUTLINE(@"SET$10")','OUTLINE(@"SEL$22")','OUTLINE(@"SEL$23")','OUTLINE(@"SET$11")','OUTLINE(@"SEL$19")','OUTLINE(@"SEL$25")','OUTLINE(@"SEL$26")','OUTLINE(@"SET$12")','OUTLINE(@"SEL$27")','OUTLINE(@"SEL$28")','OUTLINE(@"SET$13")','OUTLINE(@"SEL$29")','OUTLINE(@"SEL$30")','OUTLINE(@"SET$14")','OUTLINE(@"SEL$31")','OUTLINE(@"SEL$32")','OUTLINE(@"SET$15")','OUTLINE(@"SEL$24")','OUTLINE(@"SET$1")','OUTLINE(@"INS$1")','FULL(@"INS$1" "LRE_OPERATIONS"@"INS$1")','NO_ACCESS(@"SEL$24" "FXR"@"SEL$24")','NO_ACCESS(@"SEL$24" "COA"@"SEL$24")','NO_ACCESS(@"SEL$24" "CUS"@"SEL$24")','NO_ACCESS(@"SEL$24" "CTR"@"SEL$24")','FULL(@"SEL$24" "C"@"SEL$24")','FULL(@"SEL$24" "B"@"SEL$24")','LEADING(@"SEL$24" "FXR"@"SEL$24" "COA"@"SEL$24" "CUS"@"SEL$24" "CTR"@"SEL$24" "C"@"SEL$24" "B"@"SEL$24")','USE_HASH(@"SEL$24" "COA"@"SEL$24") ','USE_HASH(@"SEL$24" "CUS"@"SEL$24") ','USE_HASH(@"SEL$24" "CTR"@"SEL$24") ','USE_NL(@"SEL$24" "C"@"SEL$24") ','USE_NL(@"SEL$24" "B"@"SEL$24") ','USE_HASH_AGGREGATION(@"SEL$24")','INDEX_RS_ASC(@"SEL$19" "B"@"SEL$19" ("LRE_CB_MAPPING_M"."REPORT_CODE" "LRE_CB_MAPPING_M"."SUBREPORT_CODE"))','NO_ACCESS(@"SEL$19" "COA"@"SEL$19")','INDEX_RS_ASC(@"SEL$19" "C"@"SEL$19" ("LRE_CB_MAPPING_M"."REPORT_CODE" "LRE_CB_MAPPING_M"."SUBREPORT_CODE"))','NO_ACCESS(@"SEL$19" "CUST"@"SEL$19")','LEADING(@"SEL$19" "B"@"SEL$19" "COA"@"SEL$19" "C"@"SEL$19" "CUST"@"SEL$19")','USE_NL(@"SEL$19" "COA"@"SEL$19")','USE_NL(@"SEL$19" "C"@"SEL$19") ','USE_HASH(@"SEL$19" "CUST"@"SEL$19")','SWAP_JOIN_INPUTS(@"SEL$19" "CUST"@"SEL$19")','NO_ACCESS(@"SEL$10" "FXR"@"SEL$10")','NO_ACCESS(@"SEL$10" "COA"@"SEL$10")','NO_ACCESS(@"SEL$10" "CTR"@"SEL$10")','NO_ACCESS(@"SEL$10" "CUST"@"SEL$10")','INDEX_RS_ASC(@"SEL$10" "C"@"SEL$10" ("LRE_CB_MAPPING_M"."REPORT_CODE" "LRE_CB_MAPPING_M"."SUBREPORT_CODE"))','INDEX(@"SEL$10" "B"@"SEL$10" ("LRE_CB_MAPPING_M"."REPORT_CODE" "LRE_CB_MAPPING_M"."SUBREPORT_CODE"))','LEADING(@"SEL$10" "FXR"@"SEL$10" "COA"@"SEL$10" "CTR"@"SEL$10" "CUST"@"SEL$10" "C"@"SEL$10" "B"@"SEL$10")','USE_HASH(@"SEL$10" "COA"@"SEL$10") ','USE_HASH(@"SEL$10" "CTR"@"SEL$10") ','USE_HASH(@"SEL$10" "CUST"@"SEL$10")','USE_NL(@"SEL$10" "C"@"SEL$10") ','USE_NL(@"SEL$10" "B"@"SEL$10") ','USE_HASH_AGGREGATION(@"SEL$10")','INDEX_RS_ASC(@"SEL$1" "MAP1"@"SEL$1" ("LRE_CB_MAPPING_M"."REPORT_CODE" "LRE_CB_MAPPING_M"."SUBREPORT_CODE"))','NO_ACCESS(@"SEL$1" "COA"@"SEL$1")','NO_ACCESS(@"SEL$1" "OVDF"@"SEL$1") ','NO_ACCESS(@"SEL$1" "FXR"@"SEL$1")','NO_ACCESS(@"SEL$1" "CUST"@"SEL$1") ','FULL(@"SEL$1" "ACCT"@"SEL$1")','INDEX_RS_ASC(@"SEL$1" "MAP2"@"SEL$1" ("LRE_CB_MAPPING_M"."REPORT_CODE" "LRE_CB_MAPPING_M"."SUBREPORT_CODE"))','LEADING(@"SEL$1" "MAP1"@"SEL$1" "COA"@"SEL$1" "OVDF"@"SEL$1" "FXR"@"SEL$1" "CUST"@"SEL$1" "ACCT"@"SEL$1" "MAP2"@"SEL$1")','USE_NL(@"SEL$1" "COA"@"SEL$1") ','USE_HASH(@"SEL$1" "OVDF"@"SEL$1")','USE_HASH(@"SEL$1" "FXR"@"SEL$1")','USE_HASH(@"SEL$1" "CUST"@"SEL$1")','USE_HASH(@"SEL$1" "ACCT"@"SEL$1")','USE_NL(@"SEL$1" "MAP2"@"SEL$1")','SWAP_JOIN_INPUTS(@"SEL$1" "OVDF"@"SEL$1")','SWAP_JOIN_INPUTS(@"SEL$1" "FXR"@"SEL$1")','SWAP_JOIN_INPUTS(@"SEL$1" "CUST"@"SEL$1")','SWAP_JOIN_INPUTS(@"SEL$1" "ACCT"@"SEL$1")','USE_HASH_AGGREGATION(@"SEL$1") ','INDEX_FFS(@"SEL$9" "LRE_FX_RATES_H"@"SEL$9" ("LRE_FX_RATES_H"."ACTIVITY_ID" "LRE_FX_RATES_H"."SUB_PROCESS_ID" "LRE_FX_RATES_H"."BOOK_DATE" "LRE_FX_RATES_H"."BRANCH" "LRE_FX_RATES_H"."CCY_FROM" "LRE_FX_RATES_H"."CCY_TO" "LRE_FX_RATES_H"."COUNTRY_CODE" "LRE_FX_RATES_H"."LEGAL_VEHICLE"))','INDEX(@"SEL$8" "LRE_FX_RATES"@"SEL$8" ("LRE_FX_RATES"."ACTIVITY_ID" "LRE_FX_RATES"."SUB_PROCESS_ID" "LRE_FX_RATES"."BOOK_DATE" "LRE_FX_RATES"."BRANCH" "LRE_FX_RATES"."CCY_FROM" "LRE_FX_RATES"."CCY_TO" "LRE_FX_RATES"."COUNTRY_CODE" "LRE_FX_RATES"."LEGAL_VEHICLE"))','FULL(@"SEL$7" "LRE_OVERDRAFTS_H"@"SEL$7")','FULL(@"SEL$6" "LRE_OVERDRAFTS"@"SEL$6")','FULL(@"SEL$5" "LRE_CUSTOMERS_H"@"SEL$5")','FULL(@"SEL$4" "LRE_CUSTOMERS"@"SEL$4") ','FULL(@"SEL$3" "LRE_COA_DAILY_ADJ"@"SEL$3") ','INDEX_SS(@"SEL$2" "LRE_COA_MONTHLY_ADJ"@"SEL$2" ("LRE_COA_MONTHLY_ADJ"."ACCOUNT_NUMBER" "LRE_COA_MONTHLY_ADJ"."GL_CODE" "LRE_COA_MONTHLY_ADJ"."BOOK_DATE"))','FULL(@"SEL$18" "LRE_FX_RATES_H"@"SEL$18")','FULL(@"SEL$17" "LRE_FX_RATES"@"SEL$17")','FULL(@"SEL$16" "LRE_CUSTOMERS_H"@"SEL$16") ','FULL(@"SEL$15" "LRE_CUSTOMERS"@"SEL$15")','FULL(@"SEL$14" "LRE_CONTRACTS_H"@"SEL$14") ','FULL(@"SEL$13" "LRE_CONTRACTS"@"SEL$13")','FULL(@"SEL$12" "LRE_COA_DAILY_ADJ"@"SEL$12")','INDEX_SS(@"SEL$11" "LRE_COA_MONTHLY_ADJ"@"SEL$11" ("LRE_COA_MONTHLY_ADJ"."ACCOUNT_NUMBER" "LRE_COA_MONTHLY_ADJ"."GL_CODE" "LRE_COA_MONTHLY_ADJ"."BOOK_DATE"))','FULL(@"SEL$23" "LRE_CUSTOMERS_H"@"SEL$23") ','FULL(@"SEL$22" "LRE_CUSTOMERS"@"SEL$22")','FULL(@"SEL$21" "LRE_COA_DAILY_ADJ"@"SEL$21")','INDEX_SS(@"SEL$20" "LRE_COA_MONTHLY_ADJ"@"SEL$20" ("LRE_COA_MONTHLY_ADJ"."ACCOUNT_NUMBER" "LRE_COA_MONTHLY_ADJ"."GL_CODE" "LRE_COA_MONTHLY_ADJ"."BOOK_DATE"))','FULL(@"SEL$32" "LRE_FX_RATES_H"@"SEL$32")','FULL(@"SEL$31" "LRE_FX_RATES"@"SEL$31")','FULL(@"SEL$30" "LRE_CONTRACTS_H"@"SEL$30") ','FULL(@"SEL$29" "LRE_CONTRACTS"@"SEL$29")','FULL(@"SEL$28" "LRE_CUSTOMERS_H"@"SEL$28") ','FULL(@"SEL$27" "LRE_CUSTOMERS"@"SEL$27")','FULL(@"SEL$26" "LRE_COA_DAILY_ADJ"@"SEL$26")','INDEX_SS(@"SEL$25" "LRE_COA_MONTHLY_ADJ"@"SEL$25" ("LRE_COA_MONTHLY_ADJ"."ACCOUNT_NUMBER" "LRE_COA_MONTHLY_ADJ"."GL_CODE" "LRE_COA_MONTHLY_ADJ"."BOOK_DATE"))','END_OUTLINE_DATA'), 
 name=>'BARTOLO_ISSUE', 
 force_match => TRUE); 
end;
/

commit;





set serveroutput on
DECLARE
cl_sql_text CLOB;
BEGIN
SELECT distinct(sql_text)
  INTO cl_sql_text from v$sql  where sql_id ='1rhxt2dwq2kx7';
DBMS_SQLTUNE.IMPORT_SQL_PROFILE(sql_text => cl_sql_text, 
 profile => sqlprof_attr('OUTLINE_LEAF(@"SEL$1")','INDEX_RS_ASC(@"SEL$1" "TDABB"@"SEL$1" ("TP_DW_ACCOUNT_BALANCES"."BOOK_DATE" "TP_DW_ACCOUNT_BALANCES"."LEGAL_VEHICLE"))','INDEX_RS_ASC(@"SEL$1" "DABBL"@"SEL$1" ("DW_ACCOUNT_BALANCES"."ACCOUNT_NUMBER" "DW_ACCOUNT_BALANCES"."BOOK_DATE" "DW_ACCOUNT_BALANCES"."BASE_NUMBER" "DW_ACCOUNT_BALANCES"."BRANCH" "DW_ACCOUNT_BALANCES"."CONTRACT_NUMBER" "DW_ACCOUNT_BALANCES"."CURRENCY_SWIFT_CODE" "DW_ACCOUNT_BALANCES"."GL_CODE" "DW_ACCOUNT_BALANCES"."COUNTRY_CODE" "DW_ACCOUNT_BALANCES"."MODULE_CODE" "DW_ACCOUNT_BALANCES"."LOCAL_PROD_MIS" "DW_ACCOUNT_BALANCES"."LEGAL_VEHICLE"))','LEADING(@"SEL$1" "TDABB"@"SEL$1" "DABBL"@"SEL$1")','USE_NL(@"SEL$1" "DABBL"@"SEL$1")','USE_HASH_AGGREGATION(@"SEL$1")','END_OUTLINE_DATA'), 
 name=>'CUSCA_1rhxt2dwq2kx7', 
 force_match => TRUE); 
end;
/

commit;







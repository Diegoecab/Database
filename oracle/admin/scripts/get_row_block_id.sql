PROMPT  Just an example;
PROMPT  
PROMPT  select empno, ename,
PROMPT  dbms_rowid.rowid_relative_fno(rowid) fileno,
PROMPT  dbms_rowid.rowid_block_number(rowid) block_no
PROMPT  from scott.emp where empno = 7521;

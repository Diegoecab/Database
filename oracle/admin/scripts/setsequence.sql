--SQL implementation (user schema):
-----------------------------------

accept Seq_Owner prompt "Enter sequence owner: "
accept Seq_Name prompt "Enter sequence name: "
accept Seq_Value prompt "Enter desire value: "


col Max_Value   new_value Seq_MaxValue format 9999999999999999999999999999
col Min_Value   new_value Seq_MinValue
col Cur_VALUE   new_value Seq_CurValue
col CYCLE_FLAG  new_value Seq_CYCLE
col CACHE_SIZE  new_value Seq_CacheSize
col INCREMENT_BY new_value Seq_IncrementBy
col DesireValue new_value Seq_DesireValue

-- Get Info
select
        DECODE(MAX_VALUE,'999999999999999999999999999','NOMAXVALUE','MAXVALUE '||MAX_VALUE) MAX_VALUE,
        MIN_VALUE,
        DECODE(CACHE_SIZE,'0','NOCACHE','Cache '||CACHE_SIZE)
CACHE_SIZE,
        DECODE(CYCLE_FLAG,'Y','CYCLE','NOCYCLE') CYCLE_FLAG,
        INCREMENT_BY,
        TO_NUMBER(&Seq_Value) - MIN_VALUE DesireValue
from
        dba_sequences
where
        sequence_owner= upper('&Seq_Owner')
and     sequence_name=  UPPER('&Seq_Name')
and     rownum<2
;

-- No CACHE Values for Next Seq Numbers
alter sequence &Seq_Owner..&Seq_Name NoCACHE;


-- Get Current Value Number
select
        LAST_NUMBER - INCREMENT_BY Cur_VALUE
from
        dba_sequences
where
        sequence_owner= upper('&Seq_Owner')
and     sequence_name=  UPPER('&Seq_Name')
and     rownum<2
;

-- Cycle with MaxValue as CurValue
alter sequence &Seq_Owner..&Seq_Name CYCLE MaxValue &Seq_CurValue;

-- Reset to Min
select &Seq_Owner..&Seq_Name..NextVal from dual;


--------------------------------------------
-- Return CYCLE & maxvalue
alter sequence &Seq_Owner..&Seq_Name &Seq_Cycle &Seq_MaxValue;

-- Set to desired value
alter sequence &Seq_Owner..&Seq_Name increment by &Seq_DesireValue;
select &Seq_Owner..&Seq_Name..NextVal from dual;
--------------------------------------------



-- Return All Rules BACK
alter sequence &Seq_Owner..&Seq_Name &Seq_MaxValue &Seq_CacheSize &Seq_Cycle INCREMENT BY &Seq_IncrementBy;

--Check After All manipualtions:
--------------------------------
select * from dba_sequences where sequence_name=UPPER('&Seq_Name') and sequence_owner=UPPER('&Seq_Owner') and rownum<2;
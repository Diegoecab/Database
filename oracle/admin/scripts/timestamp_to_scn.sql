select timestamp_to_scn(to_timestamp('10-08-2020 23:59:59','dd-mm-yyyy hh24:mi:ss')) scn from dual;


select scn_to_timestamp(686933430832) as timestamp from dual;









SQL> select timestamp_to_scn(to_timestamp('04-08-2020 23:59:59','dd-mm-yyyy hh24:mi:ss')) scn from dual;

                   SCN
----------------------
          689784269522

SQL>


select scn_to_timestamp(690758970397) as timestamp from dual;


TIMESTAMP
---------------------------------------------------------------------------
04-AUG-20 11.59.57.000000000 PM


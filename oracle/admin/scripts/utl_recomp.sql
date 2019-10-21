-- Schema level.
EXEC UTL_RECOMP.recomp_serial('SCOTT');
EXEC UTL_RECOMP.recomp_parallel(4, 'SCOTT');

-- Database level.
EXEC UTL_RECOMP.recomp_serial();
EXEC UTL_RECOMP.recomp_parallel(4);

-- Using job_queue_processes value.
EXEC UTL_RECOMP.recomp_parallel();
EXEC UTL_RECOMP.recomp_parallel(NULL, 'SCOTT');


EXEC DBMS_UTILITY.compile_schema(schema => 'SCOTT', compile_all => false);
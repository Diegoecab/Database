select pid,locktype,fastpath,l.relation,t.relname FROM
            pg_locks l
            JOIN pg_class t ON l.relation = t.oid
                AND t.relkind = 'r'
        WHERE
 pid <> pg_backend_pid() and fastpath='f';

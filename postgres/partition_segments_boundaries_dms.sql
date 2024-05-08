select nt,max(code),count(*)
                                from (SELECT code, Ntile(4) over(ORDER BY code) nt FROM articles3)st
                                group by nt
                                order by nt;

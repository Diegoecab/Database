SELECT
    dia,
    SUM(opt_exec_delta) opt_exec,
    SUM(temp_exec_delta) temp_exec,
    SUM(total_exec_delta) total_exec
FROM
    (
        SELECT
            TO_CHAR(s.begin_interval_time,'dd/mm') dia,
            wa.snap_id,
            wa.instance_number,
            wa.opt_exec - LAG(
                wa.opt_exec,
                1,
                wa.opt_exec
            ) OVER(
                ORDER BY
                    wa.instance_number,
                    wa.snap_id
            ) opt_exec_delta,
            wa.temp_exec - LAG(
                wa.temp_exec,
                1,
                wa.temp_exec
            ) OVER(
                ORDER BY
                    wa.instance_number,
                    wa.snap_id
            ) temp_exec_delta,
            wa.total_exec - LAG(
                wa.total_exec,
                1,
                wa.total_exec
            ) OVER(
                ORDER BY
                    wa.instance_number,
                    wa.snap_id
            ) total_exec_delta
        FROM
            (
                SELECT
                    snap_id,
                    instance_number,
                    SUM(optimal_executions) opt_exec,
                    SUM(onepass_executions) + SUM(multipasses_executions) temp_exec,
                    SUM(total_executions) total_exec
                FROM
                    dba_hist_sql_workarea_hstgrm
                GROUP BY
                    snap_id,
                    instance_number
            ) wa,
            dba_hist_snapshot s
        WHERE
                s.snap_id = wa.snap_id
            AND
                s.instance_number = wa.instance_number
            AND
                s.snap_id > 20000
    )
WHERE
    total_exec_delta > 0
GROUP BY
    dia
ORDER BY dia;
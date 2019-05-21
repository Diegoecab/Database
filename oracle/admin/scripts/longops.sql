n Oracle 9i Database and below, you can issue the query

SELECT USED_UREC
FROM V$TRANSACTION;

which returns the number of undo records used by the current transaction, and if executed repeatedly, will show continuously reduced values because the rollback process will release the undo records as it progresses. You can then calculate the rate by taking snapshots for an interval and then extrapolate the result to estimate the finishing time.

Although there is a column called START_TIME in the view V$TRANSACTION, the column shows only the starting time of the entire transaction (that is, before the rollback was issued). Therefore, extrapolation aside, there is no way for you to know when the rollback was actually issued.

Extended Statistics for Transaction Rollback

In Oracle Database 10g, this exercise is trivial. When a transaction rolls back, the event is recorded in the view V$SESSION_LONGOPS, which shows long running transactions. For rollback purpose, if the process takes more than six seconds, the record appears in the view. After the rollback is issued, you would probably conceal your monitor screen from prying eyes and issue the following query:

select time_remaining time_remaining_in_secs
from v$session_longops
where sid = <sid of the session doing the rollback>;

Now that you realize how important this view V$SESSION_LONGOPS is, let's see what else it has to offer. This view was available pre-Oracle Database 10g, but the information on rollback transactions was not captured. To show all the columns in a readable manner, we will use the PRINT_TABLE function described by Tom Kyte at AskTom.com. This procedure simply displays the columns in a tabular manner rather than the usual line manner.


select SID, time_remaining,ELAPSED_SECONDS
from v$session_longops
WHERE USERNAME='NEXUS_DW'
AND TIME_REMAINING > 0;


select *
from v$session_longops
WHERE USERNAME='NEXUS_DW'
AND TIME_REMAINING > 0;
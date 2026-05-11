
RUNSTATS README
===============

This archive contains variations on Tom Kyte's runstats utility as follows:

1. runstats_pkg.simple.sql
--------------------------
PL/SQL-only version of the utility (no GTT or view required) for Oracle 9.2 and above.

This uses invoker rights and dynamic SQL to workaround the common issue whereby developers are not given explicit grants on the required V$ views but have V$ access via a role. This version of runstats also enables "pause and resume" functionality.

See description in package header for more details and usage information.


2. runstats_pkg.advanced.sql
----------------------------
As runstats_pkg.simple.sql but with advanced reporting options and a slightly new report format. This is for Oracle 10.1 and above.

See description in package header for more details and usage information.


3. runstats_pkg.gtt.sql
-----------------------
Same functionality as above except it uses a global temporary table to store results (instead of associative arrays). For this reason, it supports versions from Oracle 9.0 onwards.

See description in package header for more details and usage information.


4. runstats.anon.sql
--------------------
This version is the original Tom Kyte runstats_pkg but written as an anonymous PL/SQL block and designed to work with sqlplus only. The rationale behind this was that I was working on a site where I couldn't get the grants needed to compile the runstats view (yet I had SELECT_CATALOG_ROLE). The quickest solution was to redevelop runstats as a standalone .sql script. This version supports the same Oracle releases as Tom Kyte's original (at least as far back as 8i).

See description in script header for usage information.


CREDITS
=======
Credit of course must go to Tom Kyte. His runstats tool has proved invaluable to Oracle developers worldwide. All I've done here is re-factor it to work under different circumstances, extend the reporting capability and include pause/resume functionality.

Adrian Billington
www.oracle-developer.net

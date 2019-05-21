Rem	Copyright (c) 2001, 2003 Oracle Corporation. All rights reserved.
Rem
Rem	NAME
Rem		CreateQueues.sql - Creates IFS_IN and IFS_OUT.
Rem


set serveroutput on;

whenever sqlerror exit sql.sqlcode

rem Create Queue table, Queues, Subscribers

rem ====================================================
rem Create a queue table  ifs_in_table and ifs_out_table
rem ====================================================

DECLARE
    err_num NUMBER;
BEGIN
    dbms_output.put_line ('Creating Queue Table ifs_in_table...');

    dbms_aqadm.CREATE_queue_table(
        queue_table => 'ifs_in_table',
        multiple_consumers => TRUE,
        queue_payload_type => 'IfsQueueMessage',
        compatible => '9.0.0',
        comment => 'Creating input queue table');

    dbms_output.put_line ('Created Queue Table ifs_in_table.');

EXCEPTION
    when others then
        err_num := SQLCODE;
        if( err_num = -24001 ) then
    		dbms_output.put_line ('ifs_in_table already exists. Continue ...');
        else
            raise;
        end if;
END;
/

DECLARE
    err_num NUMBER;
BEGIN
    dbms_output.put_line ('Creating Queue Table ifs_out_table...');

    dbms_aqadm.CREATE_queue_table(
        queue_table => 'ifs_out_table',
        multiple_consumers => TRUE,
        queue_payload_type => 'IfsQueueMessage',
        compatible => '9.0.0',
        comment => 'Creating output queue table');

    dbms_output.put_line ('Created Queue Table ifs_out_table.');
EXCEPTION
    when others then
        err_num := SQLCODE;
        if( err_num = -24001 ) then
    		dbms_output.put_line ('ifs_out_table already exists. Continue ...');
        else
            raise;
        end if;
END;
/

rem ==========================================
rem Create queues ifs_in and ifs_out
rem ==========================================

DECLARE
    err_num NUMBER;
BEGIN
    dbms_output.put_line ('Creating Queue ifs_in...');

    dbms_aqadm.CREATE_queue(
        queue_name => 'ifs_in',
        queue_table => 'ifs_in_table',
        comment => 'Demo Queue');

    dbms_output.put_line ('Created Queue ifs_in.');
EXCEPTION
    when others then
        err_num := SQLCODE;
        if( err_num = -24006 ) then
    		dbms_output.put_line ('ifs_in queue already exists. Continue ...');
        else
            raise;
        end if;
END;
/

DECLARE
    err_num NUMBER;
BEGIN
    dbms_output.put_line ('Creating Queue ifs_out...');

    dbms_aqadm.CREATE_queue(
        queue_name => 'ifs_out',
        queue_table => 'ifs_out_table',
        comment => 'Demo Queue');

    dbms_output.put_line ('Created Queue ifs_out.');
EXCEPTION
    when others then
        err_num := SQLCODE;
        if( err_num = -24006 ) then
    		dbms_output.put_line ('ifs_out queue already exists. Continue ...');
        else
            raise;
        end if;
END;
/

rem ====================================
rem Start input queue ifs_in
rem ====================================

DECLARE
BEGIN
    dbms_output.put_line('starting queue ifs_in...');

    dbms_aqadm.start_queue(
        queue_name => 'ifs_in');

    dbms_output.put_line ('Started Queue ifs_in.');

    dbms_output.put_line('starting queue ifs_out...');

    dbms_aqadm.start_queue(
        queue_name => 'ifs_out');

    dbms_output.put_line ('Started Queue ifs_out.');

END;
/

rem ========================================
rem Create queue subscribers
rem ========================================

DECLARE
    subscriber sys.aq$_agent;
    err_num NUMBER;
BEGIN
    dbms_output.put_line('Adding subscriber ifs to ifs_in queue...');
    subscriber := sys.aq$_agent('ifs', NULL, NULL);
    dbms_aqadm.add_subscriber(
        queue_name => 'ifs_in',
        subscriber => subscriber);
    dbms_output.put_line ('Added subscriber ifs to ifs_in.');
EXCEPTION
    when others then
        err_num := SQLCODE;
        if( err_num = -24034 ) then
    		dbms_output.put_line ('Subscriber ifs already exists. Continue ...');
        else
            raise;
        end if;
END;
/

exit;
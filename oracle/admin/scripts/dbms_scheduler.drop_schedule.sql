--dbms_scheduler.drop_schedule
BEGIN
    dbms_scheduler.drop_schedule( schedule_name => '&owner_schedule_name',
                                  force => &force );
END;
/
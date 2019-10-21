
BEGIN
  DBMS_RESOURCE_MANAGER.clear_pending_area();
  DBMS_RESOURCE_MANAGER.create_pending_area();

  -- Create plan
  DBMS_RESOURCE_MANAGER.create_plan(
    plan    => 'pga_plan',
    comment => 'Plan for a combination of high and low PGA usage.');

  -- Create consumer groups
  DBMS_RESOURCE_MANAGER.create_consumer_group(
    consumer_group => 'high_pga_cg',
    comment        => 'High PGA usage allowed');

  DBMS_RESOURCE_MANAGER.create_consumer_group(
    consumer_group => 'low_pga_cg',
    comment        => 'Low PGA usage allowed');

  DBMS_RESOURCE_MANAGER.create_consumer_group(
    consumer_group => 'maint_subplan',
    comment        => 'Low PGA usage allowed');

  -- Assign consumer groups to plan and define priorities
  DBMS_RESOURCE_MANAGER.create_plan_directive (
    plan              => 'pga_plan',
    group_or_subplan  => 'high_pga_cg',
    session_pga_limit => 100);

  DBMS_RESOURCE_MANAGER.create_plan_directive (
    plan              => 'pga_plan',
    group_or_subplan  => 'low_pga_cg',
    session_pga_limit => 20);

  DBMS_RESOURCE_MANAGER.create_plan_directive (
    plan              => 'pga_plan',
    group_or_subplan  => 'maint_subplan',
    session_pga_limit => NULL);

  DBMS_RESOURCE_MANAGER.create_plan_directive (
    plan              => 'pga_plan',
    group_or_subplan  => 'OTHER_GROUPS',
    session_pga_limit => NULL);

  DBMS_RESOURCE_MANAGER.validate_pending_area;
  DBMS_RESOURCE_MANAGER.submit_pending_area();
END;
/



BEGIN
DBMS_RESOURCE_MANAGER.clear_pending_area();
DBMS_RESOURCE_MANAGER.CREATE_PENDING_AREA();
  DBMS_RESOURCE_MANAGER.SET_CONSUMER_GROUP_MAPPING(  
    ATTRIBUTE      => DBMS_RESOURCE_MANAGER.ORACLE_USER, 
    VALUE          => 'DCABRERA', 
    CONSUMER_GROUP => 'LOW_GROUP');
 DBMS_RESOURCE_MANAGER.validate_pending_area;
  DBMS_RESOURCE_MANAGER.submit_pending_area();
END;
/

-- ------------------------------------------------------------------------------
-- File       : resource_manager_steps.sql
-- Purpose    : Oracle administration helper: resource manager steps.
-- Category   : utilities
-- Author     : Diego Cabrera
-- Created    : Unknown
-- Version    : 1.0
-- Usage      : @resource_manager_steps.sql
-- Parameters : Review ACCEPT variables and substitution variables before running.
-- Requires   : SQL*Plus or SQLcl and privileges required by referenced dictionary views.
-- Oracle Ver.: Review compatibility before production use.
-- Risk       : READ ONLY
-- Output     : SQL*Plus/SQLcl console or spool output.
-- Notes      : Validate in a non-production session before operational use.
-- Source     : internal
-- Change Log : 
-- 2026-05-11 : Diego Cabrera - Header normalization.
-- ------------------------------------------------------------------------------
--
Resource Manager implementation steps

Here is a general guideline of the steps in implementing a Database Resource Manager plan:

1. Create resource plans 
2. Create resource consumer groups 
3. Create resource plan directives 
4. Grant switch privilege for resource consumer groups to users or roles 
5. Assign users to resource consumer groups 
6. Specify a plan to be used by the instance
Using package DBMS_RESOURCE_MANAGER to create or change resource manager schemas:
create_pending_area() 
            creates a "scratch" area for plan schema changes

create_rm_object()/delete_rm_object()/update_rm_object() 
            specifies the schema changes, where rm_object = plan, consumer_group and plan_directive

validate_pending_area() 
            checks for errors

submit_pending_area() 
            makes the changes permanent

clear_pending_area() 
            deletes the work from "scratch" area

set_initial_consumer_group() 
            assigns the initial resource consumer group for a user

switch_consumer_group_for_sess() 
            changes the resource consumer group of a specific session

switch_consumer_group_for_user() 
            changes the resource consumer group for all of the users sessions

Altough the submit_pending_area() will execute both validate and submit, it is good practice to view the modifications 
from the data dictionary before making the changes permanent with submit_pending_area()
All objects
 PRETTY
 BOOLEAN
 If TRUE, format the output with indentation and line feeds. Defaults to TRUE
dbms_metadata.set_transform_param( DBMS_METADATA.SESSION_TRANSFORM, 'PRETTY', TRUE); 
 
All objects
 SQLTERMINATOR
 BOOLEAN
 If TRUE, append a SQL terminator (; or /) to each DDL statement. Defaults to FALSE.
dbms_metadata.set_transform_param( DBMS_METADATA.SESSION_TRANSFORM, 'SQLTERMINATOR', TRUE ); 
 
TABLE
 SEGMENT_ATTRIBUTES
 BOOLEAN
 If TRUE, emit segment attributes (physical attributes, storage attributes, tablespace, logging). Defaults to TRUE.
dbms_metadata.set_transform_param( DBMS_METADATA.SESSION_TRANSFORM, 'SEGMENT_ATTRIBUTES', false ); 
 
TABLE
 STORAGE
 BOOLEAN
 If TRUE, emit storage clause. (Ignored if SEGMENT_ATTRIBUTES is FALSE.) Defaults to TRUE.
dbms_metadata.set_transform_param( DBMS_METADATA.SESSION_TRANSFORM, 'STORAGE', false); 
 
TABLE
 TABLESPACE
 BOOLEAN
 If TRUE, emit tablespace. (Ignored if SEGMENT_ATTRIBUTES is FALSE.) Defaults to TRUE.
dbms_metadata.set_transform_param( DBMS_METADATA.SESSION_TRANSFORM, 'TABLESPACE', TRUE ); 
 
TABLE
 CONSTRAINTS
 BOOLEAN
 If TRUE, emit all non-referential table constraints. Defaults to TRUE.
dbms_metadata.set_transform_param( DBMS_METADATA.SESSION_TRANSFORM, 'CONSTRAINTS', TRUE ); 
 
TABLE
 REF_CONSTRAINTS
 BOOLEAN
 If TRUE, emit all referential constraints (foreign keys). Defaults to TRUE.
dbms_metadata.set_transform_param( DBMS_METADATA.SESSION_TRANSFORM, 'REF_CONSTRAINTS', TRUE ); 
 
TABLE
 CONSTRAINTS_AS_ALTER
 BOOLEAN
 If TRUE, emit table constraints as separate ALTER TABLE (and, if necessary, CREATE INDEX) statements.
If FALSE, specify table constraints as part of the CREATE TABLE statement. Defaults to FALSE. Requires that CONSTRAINTS be TRUE.
dbms_metadata.set_transform_param( DBMS_METADATA.SESSION_TRANSFORM, 'CONSTRAINTS_AS_ALTER', TRUE ); 
 
TABLE
 OID
 BOOLEAN
 If TRUE, emit the OID clause for object tables. Defaults to FALSE.
dbms_metadata.set_transform_param( DBMS_METADATA.SESSION_TRANSFORM, 'OID', false); 
 
TABLE
 SIZE_BYTE_KEYWORD
 BOOLEAN
 If TRUE, emit the BYTE keyword as part of the size specification of CHAR and VARCHAR2 columns that use byte semantics.
If FALSE, omit the keyword. Defaults to FALSE.
dbms_metadata.set_transform_param( DBMS_METADATA.SESSION_TRANSFORM, 'SIZE_BYTE_KEYWORD', false ); 
 
INDEX, CONSTRAINT, ROLLBACK_SEGMENT, 
CLUSTER, TABLESPACE 
 SEGMENT_ATTRIBUTES
 BOOLEAN
 If TRUE, emit segment attributes (physical attributes, storage attributes, tablespace, logging). Defaults to TRUE.
dbms_metadata.set_transform_param( DBMS_METADATA.SESSION_TRANSFORM, 'SEGMENT_ATTRIBUTES', false ); 
 
INDEX, CONSTRAINT, ROLLBACK_SEGMENT,
CLUSTER
 STORAGE
 BOOLEAN
 If TRUE, emit storage clause. (Ignored if SEGMENT_ATTRIBUTES is FALSE.) Defaults to TRUE.
dbms_metadata.set_transform_param( DBMS_METADATA.SESSION_TRANSFORM, 'STORAGE', false ); 
 
INDEX, CONSTRAINT, ROLLBACK_SEGMENT,
CLUSTER
 TABLESPACE
 BOOLEAN
 If TRUE, emit tablespace. (Ignored if SEGMENT_ATTRIBUTES is FALSE.) Defaults to TRUE.
dbms_metadata.set_transform_param( DBMS_METADATA.SESSION_TRANSFORM, 'TABLESPACE', TRUE ); 
 
TYPE
 SPECIFICATION
 BOOLEAN
 If TRUE, emit the type specification. Defaults to TRUE.
dbms_metadata.set_transform_param( DBMS_METADATA.SESSION_TRANSFORM, 'SPECIFICATION', TRUE ); 
 
TYPE
 BODY
 BOOLEAN
 If TRUE, emit the type body. Defaults to TRUE.
dbms_metadata.set_transform_param( DBMS_METADATA.SESSION_TRANSFORM, 'BODY', TRUE ); 
 
TYPE
 OID
 BOOLEAN
 If TRUE, emit the OID clause. Defaults to FALSE.
dbms_metadata.set_transform_param( DBMS_METADATA.SESSION_TRANSFORM, 'OID', TRUE ); 
 
PACKAGE
 SPECIFICATION
 BOOLEAN
 If TRUE, emit the package specification. Defaults to TRUE.
dbms_metadata.set_transform_param( DBMS_METADATA.SESSION_TRANSFORM, 'SPECIFICATION', TRUE ); 
 
PACKAGE
 BODY
 BOOLEAN
 If TRUE, emit the package body. Defaults to TRUE.
dbms_metadata.set_transform_param( DBMS_METADATA.SESSION_TRANSFORM, 'BODY', TRUE ); 
 
VIEW
 FORCE
 BOOLEAN
 If TRUE, use the FORCE keyword in the CREATE VIEW statement. Defaults to TRUE.
dbms_metadata.set_transform_param( DBMS_METADATA.SESSION_TRANSFORM, 'FORCE', TRUE ); 
 
OUTLINE
 INSERT
 BOOLEAN
 If TRUE, emit the INSERT statements into the OL$ dictionary tables that will create the outline and its hints.
If FALSE, emit a CREATE OUTLINE statement. Defaults to FALSE.
dbms_metadata.set_transform_param( DBMS_METADATA.SESSION_TRANSFORM, 'INSERT', TRUE ); 

Note: This object type is being deprecated.
 
All objects
 DEFAULT
 BOOLEAN
 Calling SET_TRANSFORM_PARAM with this parameter set to TRUE has the effect of resetting all parameters for the transform to their default values.
Setting this FALSE has no effect. There is no default.
dbms_metadata.set_transform_param( DBMS_METADATA.SESSION_TRANSFORM, 'DEFAULT', false ); 
 
All objects
 INHERIT
 BOOLEAN
 If TRUE, inherits session-level parameters. Defaults to FALSE. If an application calls ADD_TRANSFORM to add the DDL transform, 
then by default the only transform parameters that apply are those explicitly set for that transform handle.
This has no effect if the transform handle is the session transform handle.
dbms_metadata.set_transform_param( DBMS_METADATA.SESSION_TRANSFORM, 'INHERIT', TRUE ); 
 
ROLE
 REVOKE_FROM
 Text
 The name of a user from whom the role must be revoked. If this is a non-null string and if the CREATE ROLE statement grants you the role,
a REVOKE statement is emitted after the CREATE ROLE.
dbms_metadata.set_transform_param( DBMS_METADATA.SESSION_TRANSFORM, 'REVOKE_FROM', 'SCOTT' ); 

Note: When you issue a CREATE ROLE statement, Oracle may grant you the role. You can use this transform parameter to undo the grant.

Defaults to null string.
 
TABLESPACE
 REUSE
 BOOLEAN
 If TRUE, include the REUSE parameter for datafiles in a tablespace to indicate that existing files can be reused.
dbms_metadata.set_transform_param( DBMS_METADATA.SESSION_TRANSFORM, 'REUSE', TRUE ); 

Defaults to FALSE.
 
CLUSTER, INDEX,
ROLLBACK_SEGMENT,
TABLE, TABLESPACE 
 PCTSPACE
 NUMBER
 A number representing the percentage by which space allocation for the object type is to be modified. 
The value is the number of one-hundreths of the current allocation. For example, 100 means 100%.
dbms_metadata.set_transform_param( DBMS_METADATA.SESSION_TRANSFORM, 'PCTSPACE', 85); 

If the object type is TABLESPACE, the following size values are affected:

- in file specifications, the value of SIZE

- MINIMUM EXTENT

- EXTENT MANAGEMENT LOCAL UNIFORM SIZE

For other object types, INITIAL and NEXT are affected.
 

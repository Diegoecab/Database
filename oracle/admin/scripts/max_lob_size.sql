select nvl((max(dbms_lob.getlength("BLOB_COLUMN"))),0) as bytes from Table_NAME;


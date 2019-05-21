DECLARE
  fileHandler UTL_FILE.FILE_TYPE;
BEGIN
for r in 1 .. 1000 loop
	fileHandler := UTL_FILE.FOPEN('UTL_DBADMIN', 'test_file1'||r||'.txt', 'W');
		for z in 1 .. 1000000 loop
		  UTL_FILE.PUTF(fileHandler, 'Writing TO a file\n');
		end loop;
  UTL_FILE.FCLOSE(fileHandler);
end loop;

EXCEPTION
  WHEN utl_file.invalid_path THEN
     raise_application_error(-20000, 'ERROR: Invalid PATH FOR file.');
END;
/


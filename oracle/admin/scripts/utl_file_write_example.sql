SET SERVEROUTPUT ON
DECLARE
  fileHandler UTL_FILE.FILE_TYPE;
BEGIN

	fileHandler := UTL_FILE.FOPEN('CDP_LOG', 'test_file2.txt', 'W');
		for z in 1 .. 1000 loop
		  UTL_FILE.PUTF(fileHandler, 'Writing TO a file\n');
		end loop;
  UTL_FILE.FCLOSE(fileHandler);


EXCEPTION
  WHEN utl_file.invalid_path THEN
     raise_application_error(-20000, 'ERROR: Invalid PATH FOR file.');
END;
/


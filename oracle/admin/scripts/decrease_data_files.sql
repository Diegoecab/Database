/******************************************************************************** 
  Nombre:      dcrease_data_files
  Descripcion: Metadata para decrementar el tamaño de los datafiles de un
               tablespace dado teniendo en cuenta los bloques continuos libres 
               en el final del datafile.
  Paràmetros:  tablespace_name                
  Fecha:       12/06/2006
  Creado por:  Hernan Ariel Azpilcueta
  
  Modificaciones
  Fecha       Autor                   Descripcion
  12/05/2006  Hernan Ariel Azpilcueta 
********************************************************************************/
set pages 0 feed off veri off lines 500
set long 500
set serveroutput on

accept p_tablespace_name prompt "Enter tablespace name: "

declare

  blockidant dba_free_space.block_id%type;  
  sumbytes   dba_free_space.bytes%type;   
  
  cursor cur_files is  
  select df.tablespace_name, df.file_id, df.file_name, df.bytes
  from dba_data_files df
  where df.tablespace_name = upper('&&p_tablespace_name')
  order by df.file_id;
  
  cursor cur_blocks (pp_file_id in dba_free_space.file_id%type) is  
  select fs.block_id, fs.bytes, fs.blocks 
  from dba_free_space fs
  where fs.tablespace_name = upper('&&p_tablespace_name')
    and file_id = pp_file_id
  order by block_id desc;
  
begin    
  for x in cur_files loop
    -- limpio las variables de cada nuevo datafile
    blockidant := 0;
    sumbytes := 0;
    for y in cur_blocks(x.file_id) loop
      if blockidant = 0 then
        -- primera vez
        sumbytes := y.bytes;
        blockidant := y.block_id;
      else
        -- sumo si corresponde, sino salgo del loop
        if (y.block_id + y.blocks) = blockidant then
          -- continuos
          sumbytes := sumbytes + y.bytes;
          blockidant:= y.block_id;
        else
          -- no continuo
          exit;
        end if;
      end if;    
    end loop;
    dbms_output.put_line('-- Datafile: '''||x.file_name||''' Total: '||round(x.bytes/1024/1024,0)||' M  libre: '||trunc(sumbytes/1024/1024)||' M');
    if trunc(sumbytes/1024/1024) > 1 then 
      dbms_output.put_line('ALTER DATABASE DATAFILE '''||x.file_name||''' RESIZE '||((round(x.bytes/1024/1024,0) - trunc(sumbytes/1024/1024)) + 1)||' M;');
    end if;
  end loop;    
end;
/
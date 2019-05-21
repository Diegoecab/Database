Para mover un objeto LOB a otro Tablespace

/*Ejemplo*/

ALTER TABLE INTRANET.PRUEBA_MD5_CLOB
    MOVE LOB(texto) STORE AS (
        TABLESPACE INTRANET
    )
/


De esta forma muevo un segmento LOB a otro tablespace y también el LOBINDEX que se genera aotumaticamente con el LOBSEGMENT.






Agregar Columna LOB

ALTER TABLE test_lobtable ADD (image2 BLOB) LOB (image2) 
STORE AS image2_lob_seg ( TABLESPACE lob_data CHUNK 4096 PCTVERSION 5 ENABLE STORAGE 
IN ROW INDEX image2_lob_idx ( TABLESPACE lob_index ) ) / 


Multiples Columnas LOB

CREATE TABLE test_lobtable (
      id  NUMBER
    , xml_file CLOB
    , image    BLOB
    , log_file BFILE
)
LOB (xml_file, image)
    STORE AS  (
        TABLESPACE lob_data
        CHUNK 4096
        CACHE
        STORAGE (MINEXTENTS 2)
        INDEX (
            TABLESPACE lob_index
            STORAGE (MAXEXTENTS UNLIMITED)
        )
    )
/



CREATE TABLE test_lobtable (
      id  NUMBER
    , xml_file CLOB
    , image    BLOB
    , log_file BFILE
)
LOB (xml_file)
    STORE AS xml_file_lob_seg (
        TABLESPACE lob_data
        CHUNK 4096
        CACHE
        STORAGE (MINEXTENTS 2)
        INDEX xml_file_lob_idx (
            TABLESPACE lob_index
            STORAGE (MAXEXTENTS UNLIMITED)
        )
    )
LOB (image)
    STORE AS image_lob_seg (
        TABLESPACE lob_data
        ENABLE STORAGE IN ROW
        CHUNK 4096
        CACHE
        STORAGE (MINEXTENTS 2)
        INDEX image_lob_idx (
            TABLESPACE lob_index
        )
    )
/




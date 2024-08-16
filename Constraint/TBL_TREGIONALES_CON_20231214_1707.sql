--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       14/12/2023 Cramirezs    000001       * Se crean llaves foraneas.
--                       Kilonova     MVP_2
-- ========== ========== ============ ============ ============================================================================================================
--
Prompt
Prompt Creando llave foranea para la tabla tbl_tregionales con tbl_tempresas
Prompt
ALTER TABLE tbl_tregionales ADD CONSTRAINT fk_tbl_tregionales_tbl_tempresas
    FOREIGN KEY ( regi_empr ) 
        REFERENCES tbl_tempresas ( empr_empr ) ;
--
Prompt
Prompt Creando llave foranea para la tabla tbl_tregionales con tbl_tbancos
Prompt
ALTER TABLE tbl_tregionales ADD CONSTRAINT fk_tbl_tregionales_tbl_tbancos
    FOREIGN KEY ( regi_banc ) 
        REFERENCES tbl_tbancos ( banc_banc ) ;
--
Prompt
Prompt Creando llave foranea para la tabla tbl_tregionales con gen_tlistas
Prompt
ALTER TABLE tbl_tregionales ADD CONSTRAINT fk_tbl_tregionales_gen_tlistas
    FOREIGN KEY ( regi_fuente ) 
        REFERENCES gen_tlistas ( list_list ) ;
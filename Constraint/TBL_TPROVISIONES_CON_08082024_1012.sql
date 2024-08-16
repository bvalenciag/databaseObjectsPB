--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       08/08/2024 Jmartinezm    000001       * Se crean llaves foraneas.
--                       Kilonova
-- ========== ========== ============ ============ ============================================================================================================
--
Prompt
Prompt Creando llave foranea para la tabla TBL_TPROVISIONES con tbl_tlog_cargue
Prompt
ALTER TABLE tbl_tprovisiones ADD CONSTRAINT fk_tbl_tprovisiones_tbl_tlog_cargue
    FOREIGN KEY ( prov_log ) 
        REFERENCES tbl_tlog_cargue ( log_log ) ;
--
Prompt
Prompt Creando llave foranea para la tabla tbl_tprovisiones con tbl_tempresas
Prompt
ALTER TABLE tbl_tprovisiones ADD CONSTRAINT fk_tbl_tprovisiones_tbl_tempresas
    FOREIGN KEY ( prov_empr ) 
        REFERENCES tbl_tempresas ( empr_empr ) ;        

--
Prompt
Prompt Creando llave foranea para la tabla tbl_tprovisiones con tbl_tbancos
Prompt
ALTER TABLE tbl_tprovisiones ADD CONSTRAINT fk_tbl_tprovisiones_tbl_tbancos
    FOREIGN KEY ( prov_banc ) 
        REFERENCES tbl_tbancos ( banc_banc ) ;        
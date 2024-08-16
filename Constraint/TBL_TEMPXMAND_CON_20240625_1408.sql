--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       25/06/2024 Jmartinezm    000001       * Se crean llaves foraneas.
--                       Kilonova
-- ========== ========== ============ ============ ============================================================================================================
--
Prompt
Prompt Creando llave foranea para la tabla TBL_TEMPXMAND con tbl_tempresas
Prompt
ALTER TABLE tbl_tempxmand ADD CONSTRAINT fk_tbl_tempxmand_tbl_tempresas
    FOREIGN KEY ( empx_empr ) 
        REFERENCES tbl_tempresas ( empr_empr ) ;
--
Prompt
Prompt Creando llave foranea para la tabla tbl_tempxmand con tbl_tempresas
Prompt
ALTER TABLE tbl_tempxmand ADD CONSTRAINT fk_tbl_tempxmand_tbl_tempresas_mand
    FOREIGN KEY ( empx_mandato ) 
        REFERENCES tbl_tempresas ( empr_empr ) ;

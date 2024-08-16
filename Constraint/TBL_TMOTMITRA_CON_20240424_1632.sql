--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       24/04/2024 Jmartinezm    000001       * Se crean llaves foraneas.
--                       Kilonova
-- ========== ========== ============ ============ ============================================================================================================
--
Prompt
Prompt Creando llave foranea para la tabla TBL_TMOTMITRA con tbl_tempresas
Prompt
ALTER TABLE tbl_tmotmitra ADD CONSTRAINT fk_tbl_tmotmitra_tbl_tempresas_mandato
    FOREIGN KEY ( motm_mandato ) 
        REFERENCES tbl_tempresas ( empr_empr ) ;
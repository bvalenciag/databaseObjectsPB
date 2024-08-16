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
Prompt Creando llave foranea para la tabla TBL_TMOTPORFIN con tbl_tempresas
Prompt
ALTER TABLE tbl_tmotporfin ADD CONSTRAINT fk_tbl_tmotporfin_tbl_tempresas_mandato
    FOREIGN KEY ( motp_mandato ) 
        REFERENCES tbl_tempresas ( empr_empr ) ;
--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       09/04/2024 Jmartinezm    000001       * Se crean llaves foraneas.
--                       Kilonova      MVP_2
-- ========== ========== ============ ============ ============================================================================================================
--
Prompt
Prompt Creando llave foranea para la tabla TBL_TRANGOSTASA con tbl_tempresas
Prompt
ALTER TABLE tbl_trangostasa ADD CONSTRAINT fk_tbl_trangostasa_tbl_tempresas
    FOREIGN KEY ( rang_empr ) 
        REFERENCES tbl_tempresas ( empr_empr ) ;
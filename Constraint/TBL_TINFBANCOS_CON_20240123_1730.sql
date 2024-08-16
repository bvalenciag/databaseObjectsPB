--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       23/01/2024 Jmartinezm    00001       * Se crean llaves foraneas.
--                       Kilonova      MVP2
-- ========== ========== ============ ============ ============================================================================================================
--
Prompt
Prompt Creando llave foranea para la tabla TBL_TINFBANCOS con tbl_tbancos
Prompt
ALTER TABLE tbl_tinfbancos ADD CONSTRAINT fk_tbl_tinfbancos_tbl_tbancos
    FOREIGN KEY ( infb_banc ) 
        REFERENCES tbl_tbancos ( banc_banc ) ;
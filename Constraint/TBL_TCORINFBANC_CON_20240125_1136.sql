--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       25/01/2024 Jmartinezm    000001       * Se crean llaves foraneas.
--                       Kilonova      MVP2
-- ========== ========== ============ ============ ============================================================================================================
--
Prompt
Prompt Creando llave foranea para la tabla tbl_tcorinfbanc con tbl_tinfbancos
Prompt
ALTER TABLE tbl_tcorinfbanc ADD CONSTRAINT fk_tbl_tcorinfbanc_tbl_tinfbancos
    FOREIGN KEY ( cori_infb ) 
        REFERENCES tbl_tinfbancos ( infb_infb ) ;
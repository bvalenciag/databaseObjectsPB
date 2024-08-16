--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       18/01/2024 mzabala      000001       * Se crean llaves foraneas.
--                       Kilonova
-- ========== ========== ============ ============ ============================================================================================================
--
Prompt
Prompt Creando llave foranea para la tabla TBL_TCONDGENPFMT con TBL_TBANCOS
Prompt
ALTER TABLE tbl_tcondgenpfmt ADD CONSTRAINT fk_tbl_tcondgenpfmt_tbl_tbancos
    FOREIGN KEY ( cod_banc_banc ) 
        REFERENCES tbl_tbancos ( banc_banc ) ;
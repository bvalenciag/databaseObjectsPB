--
-- #VERSION: 1000
--
-- History
--
-- Versi�n    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       18/01/2024 mzabala      000001       * Se crea llave primaria.
--                       Kilonova
-- ========== ========== ============ ============ ============================================================================================================
--
/**********************************************************************************/
Prompt
Prompt Creando llave primaria de la tabla TBL_TCDISTPFMT
Prompt
/**********************************************************************************/
ALTER TABLE tbl_tcdistpfmt
    ADD CONSTRAINT pk_tbl_tcdistpfmt PRIMARY KEY ( id_cdist );
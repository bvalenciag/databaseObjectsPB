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
Prompt Creando llave primaria de la tabla TBL_TCONDGENPFMT
Prompt
/**********************************************************************************/
ALTER TABLE tbl_tcondgenpfmt
    ADD CONSTRAINT pk_tbl_tcondgenpfmt PRIMARY KEY ( id_cond );
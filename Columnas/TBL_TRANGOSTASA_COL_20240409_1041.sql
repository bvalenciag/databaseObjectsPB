--
-- #VERSION: 1000
--
-- History
--
-- Versi�n    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       09/04/2024 Jmartinezm    000001       * Se crea columna.
--                       Kilonova      MVP_2
-- ========== ========== ============ ============ ============================================================================================================
--
/**********************************************************************************/
Prompt
Prompt Creando campos de la tabla TBL_TRANGOSTASA
Prompt
/**********************************************************************************/
ALTER TABLE tbl_trangostasa
    ADD rang_empr NUMBER(9) DEFAULT NULL;
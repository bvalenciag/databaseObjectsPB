--
-- #VERSION: 1000
--
-- History
--
-- Versi�n    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       24/07/2024 Jmartinezm    000001       * Se crea columna.
--                       Kilonova
-- ========== ========== ============ ============ ============================================================================================================
--
/**********************************************************************************/
Prompt
Prompt Creando campos de la tabla TBL_TCONDGEN
Prompt
/**********************************************************************************/
ALTER TABLE tbl_tcondgen
    ADD cond_repre VARCHAR2(200) DEFAULT NULL;
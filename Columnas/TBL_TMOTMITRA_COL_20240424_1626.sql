--
-- #VERSION: 1000
--
-- History
--
-- Versi�n    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       24/04/2024 Jmartinezm    000001       * Se crea columna.
--                       Kilonova
-- ========== ========== ============ ============ ============================================================================================================
--
/**********************************************************************************/
Prompt
Prompt Creando campos de la tabla TBL_TMOTMITRA
Prompt
/**********************************************************************************/
ALTER TABLE tbl_tmotmitra
    ADD motm_mandato NUMBER(9) DEFAULT NULL;
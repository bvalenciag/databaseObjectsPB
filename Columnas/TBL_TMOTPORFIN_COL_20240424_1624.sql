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
Prompt Creando campos de la tabla TBL_TMOTPORFIN
Prompt
/**********************************************************************************/
ALTER TABLE tbl_tmotporfin
    ADD motp_mandato NUMBER(9) DEFAULT NULL;
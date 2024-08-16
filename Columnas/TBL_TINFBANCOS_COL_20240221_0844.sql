--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       21/02/2024 Jmartinezm    000001       * Se crea columna.
--                       Kilonova      MVP_2
-- ========== ========== ============ ============ ============================================================================================================
--
/**********************************************************************************/
Prompt
Prompt Creando campos de la tabla TBL_TINFBANCOS
Prompt
/**********************************************************************************/
ALTER TABLE tbl_tinfbancos
    ADD infb_oficina VARCHAR2(200) DEFAULT NULL;
ALTER TABLE tbl_tinfbancos
    ADD infb_refegr VARCHAR2(200) DEFAULT NULL;
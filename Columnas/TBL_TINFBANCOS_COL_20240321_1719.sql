--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       21/03/2024 Jmartinezm    000001       * Se crea columna.
--                       Kilonova
-- ========== ========== ============ ============ ============================================================================================================
--
/**********************************************************************************/
Prompt
Prompt Creando campos de la tabla TBL_TINFBANCOS
Prompt
/**********************************************************************************/
ALTER TABLE tbl_tinfbancos
    ADD infb_comision NUMBER(20) DEFAULT NULL;
--
ALTER TABLE tbl_tinfbancos
    ADD infb_comision_m NUMBER(20) DEFAULT NULL;
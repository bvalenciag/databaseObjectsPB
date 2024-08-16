--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       12/04/2024 Jmartinezm    000001       * Se crea columna.
--                       Kilonova      MVP_2
-- ========== ========== ============ ============ ============================================================================================================
--
/**********************************************************************************/
Prompt
Prompt Creando campos de la tabla TBL_TINFBANCOS
Prompt
/**********************************************************************************/
ALTER TABLE tbl_tinfbancos
    ADD infb_cuen_cud_cod   NUMBER(8) DEFAULT NULL;
ALTER TABLE tbl_tinfbancos
    ADD infb_cuen_cud_desc  VARCHAR2(100) DEFAULT NULL;
ALTER TABLE tbl_tinfbancos
    ADD infb_portafolio     VARCHAR2(100) DEFAULT NULL;        
--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       10/01/2024 Cramirezs    000001       * Se crea columna.
--                       Kilonova     MVP_2
-- ========== ========== ============ ============ ============================================================================================================
--
/**********************************************************************************/
Prompt
Prompt Creando campos de la tabla TBL_TCUENTASBAN
Prompt
/**********************************************************************************/
ALTER TABLE tbl_tcuentasban
    ADD cuen_sldmincor NUMBER(20,2) DEFAULT NULL;
--
ALTER TABLE tbl_tcuentasban
    ADD cuen_tipo_oper NUMBER(9) DEFAULT NULL;
--
ALTER TABLE tbl_tcuentasban
    ADD cuen_cta_cud NUMBER(9) DEFAULT NULL;
--
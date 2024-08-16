--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       04/01/2023 Cramirezs    000001       * Se modifica llave primaria.
--                       Kilonova     MVP_2
-- ========== ========== ============ ============ ============================================================================================================
--
/**********************************************************************************/
Prompt
Prompt Eliminando llave primaria de la tabla TBL_THOMOLOGA
Prompt
/**********************************************************************************/
ALTER TABLE tbl_thomologa DROP CONSTRAINT pk_tbl_thomologa;
/**********************************************************************************/
Prompt
Prompt Creando llave primaria de la tabla TBL_THOMOLOGA
Prompt
/**********************************************************************************/
ALTER TABLE tbl_thomologa
    ADD CONSTRAINT pk_tbl_thomologa PRIMARY KEY ( homo_sist, homo_vari, homo_dato, homo_sis_ext, homo_val_sisext );
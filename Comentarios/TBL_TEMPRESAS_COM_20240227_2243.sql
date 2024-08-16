--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       27/02/2024 Cramirezs    000001       * Se crean comentarios.
--                       Kilonova
-- ========== ========== ============ ============ ============================================================================================================
--
/**********************************************************************************/
Prompt
Prompt Generando Comentarios de la tabla TBL_TEMPRESAS
Prompt
/**********************************************************************************/
COMMENT ON COLUMN tbl_tempresas.empr_nit                         IS 'Nit de la empresa.';
COMMENT ON COLUMN tbl_tempresas.empr_digito                      IS 'Digito de verificación de la empresa.';
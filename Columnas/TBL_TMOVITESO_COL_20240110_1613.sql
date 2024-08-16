--
-- #VERSION: 1001
--
-- History
--
-- Versi�n    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       10/01/2024 Cramirezs    000001       * Se crea columna.
--                       Kilonova
-- ========== ========== ============ ============ ============================================================================================================
-- 1001       06/02/2024 Jmartinez    000002       * Se crea columna movi_encargo.
--                       Kilonova
-- ========== ========== ============ ============ ============================================================================================================
--
/**********************************************************************************/
Prompt
Prompt Modificando campos de la tabla TBL_TMOVITESO
Prompt
/**********************************************************************************/
ALTER TABLE tbl_tmoviteso 
    MODIFY movi_descripcion VARCHAR2(1000);
--
ALTER TABLE tbl_tmoviteso
    ADD movi_encargo VARCHAR2(20) DEFAULT NULL;    
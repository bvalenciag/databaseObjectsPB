--
-- #VERSION: 1000
--
-- History
--
-- Versi�n    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       14/12/2023 Cramirezs    000001       * Se crea secuencia.
--                       Kilonova     MVP_2
-- ========== ========== ============ ============ ============================================================================================================
--
/**********************************************************************************/
Prompt
Prompt Creando secuencia TBL_SCANCELACIO para la tabla TBL_TCANCELACIO
Prompt
/**********************************************************************************/
CREATE SEQUENCE tbl_scancelacio
MINVALUE 1
MAXVALUE 999999999999999999999999999
start with 1
increment by 1
nocache;
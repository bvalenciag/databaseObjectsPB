--
-- #VERSION: 1000
--
-- History
--
-- Versi�n    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       24/11/2023 Cramirezs    000001       * Se crea secuencia.
--                       Kilonova     MVP_2
-- ========== ========== ============ ============ ============================================================================================================
--
/**********************************************************************************/
Prompt
Prompt Creando secuencia TBL_SMOTBBIZA para la tabla TBL_TMOTBBIZA
Prompt
/**********************************************************************************/
CREATE SEQUENCE tbl_smotbbiza
MINVALUE 1
MAXVALUE 999999999999999999999999999
start with 1
increment by 1
nocache;
--
-- #VERSION: 1000
--
-- History
--
-- Versi�n    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       26/12/2023 Jmartinezm    00001       * Se crea secuencia.
--                       Kilonova      MVP2
-- ========== ========== ============ ============ ============================================================================================================
--
/**********************************************************************************/
Prompt
Prompt Creando secuencia TBL_SMESAOPER para la tabla tbl_smesaoper
Prompt
/**********************************************************************************/
CREATE SEQUENCE tbl_smesaoper
MINVALUE 1
MAXVALUE 999999999999999999999999999
start with 1
increment by 1
nocache;
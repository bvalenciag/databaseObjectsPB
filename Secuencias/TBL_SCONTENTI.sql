--
-- #VERSION: 1000
--
-- History
--
-- Versi�n    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       23/01/2024 Jmartinezm    00001       * Se crea secuencia.
--                       Kilonova      MVP2
-- ========== ========== ============ ============ ============================================================================================================
--
/**********************************************************************************/
Prompt
Prompt Creando secuencia tbl_scontenti para la tabla TBL_TCONTENTI
Prompt
/**********************************************************************************/
CREATE SEQUENCE tbl_scontenti
MINVALUE 1
MAXVALUE 999999999999999999999999999
start with 1
increment by 1
nocache;
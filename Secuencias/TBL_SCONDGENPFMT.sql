--
-- #VERSION: 1000
--
-- History
--
-- Versi�n    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       18/01/2024 mzabala      000001       * Se crea secuencia.
--                       Kilonova
-- ========== ========== ============ ============ ============================================================================================================
--
/**********************************************************************************/
Prompt
Prompt Creando secuencia TBL_SCONDGENPFMT para la tabla TBL_TCONDGENPFMT
Prompt
/**********************************************************************************/
CREATE SEQUENCE TBL_SCONDGENPFMT
MINVALUE 1
MAXVALUE 999999999999999999999999999
start with 1
increment by 1
nocache;
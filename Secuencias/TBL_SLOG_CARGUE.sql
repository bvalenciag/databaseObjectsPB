--
-- #VERSION: 1000
--
-- History
--
-- Versi�n    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       08/08/2024 Jmartinezm    000001       * Se crea secuencia.
--                       Kilonova
-- ========== ========== ============ ============ ============================================================================================================
--
/**********************************************************************************/
Prompt
Prompt Creando secuencia TBL_SLOG_CARGUE para la tabla tbl_tlog_cargue
Prompt
/**********************************************************************************/
CREATE SEQUENCE tbl_slog_cargue
MINVALUE 1
MAXVALUE 999999999999999999999999999
start with 1
increment by 1
nocache;
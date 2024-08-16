--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       18/01/2024 Cramirezs    000001       * Se crean permisos para control de concurrencia.
--                       Kilonova
-- ========== ========== ============ ============ ============================================================================================================
--
prompt
prompt Permisos de consulta para control de concurrencia
prompt
GRANT SELECT ON V_$SESSION TO edge;
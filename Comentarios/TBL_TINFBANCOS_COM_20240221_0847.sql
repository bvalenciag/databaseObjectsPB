--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       21/02/2024 Jmartinezm    000001       * Se crean comentarios.
--                       Kilonova      MVP_2
-- ========== ========== ============ ============ ============================================================================================================
--
/**********************************************************************************/
Prompt
Prompt Generando Comentarios de la tabla tbl_tinfbancos
Prompt
/**********************************************************************************/
COMMENT ON COLUMN tbl_tinfbancos.infb_oficina                        IS 'Oficina.';
COMMENT ON COLUMN tbl_tinfbancos.infb_refegr                        IS 'Referencia egreso.';
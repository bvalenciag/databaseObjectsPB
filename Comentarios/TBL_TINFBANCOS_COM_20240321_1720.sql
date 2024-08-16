--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       21/03/2024 Jmartinezm    000001       * Se crean comentarios.
--                       Kilonova
-- ========== ========== ============ ============ ============================================================================================================
--
/**********************************************************************************/
Prompt
Prompt Generando Comentarios de la tabla TBL_TINFBANCOS
Prompt
/**********************************************************************************/
COMMENT ON COLUMN tbl_tinfbancos.infb_comision                     IS 'Comisión Fija.';
COMMENT ON COLUMN tbl_tinfbancos.infb_comision_m                   IS 'Comisión por Millon.';
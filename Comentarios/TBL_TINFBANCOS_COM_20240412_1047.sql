--
-- #VERSION: 1000
--
-- History
--
-- Versi�n    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       10/04/2024 Jmartinezm    000001       * Se crean comentarios.
--                       Kilonova
-- ========== ========== ============ ============ ============================================================================================================
--
/**********************************************************************************/
Prompt
Prompt Generando Comentarios de la tabla TBL_TINFBANCOS
Prompt
/**********************************************************************************/
COMMENT ON COLUMN tbl_tinfbancos.infb_cuen_cud_cod                 IS 'C�digo de la cuenta CUD.';
COMMENT ON COLUMN tbl_tinfbancos.infb_cuen_cud_desc                IS 'Descripci�n de la cuenta CUD.';
COMMENT ON COLUMN tbl_tinfbancos.infb_portafolio                   IS 'Portafolio.';
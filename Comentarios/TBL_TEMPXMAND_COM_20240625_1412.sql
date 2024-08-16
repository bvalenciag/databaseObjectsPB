--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       25/06/2024 Jmartinezm    000001       * Se crean comentarios.
--                       Kilonova      MVP_2
-- ========== ========== ============ ============ ============================================================================================================
--
/**********************************************************************************/
Prompt
Prompt Generando Comentarios de la tabla TBL_TEMPXMAND
Prompt
/**********************************************************************************/
COMMENT ON TABLE  tbl_tempxmand                                  IS 'Tabla donde se almacenan los encargos relacionados a los mandatos y empresas';
COMMENT ON COLUMN tbl_tempxmand.empx_empx                        IS 'Identificador principal';
COMMENT ON COLUMN tbl_tempxmand.empx_empr                        IS 'Identificador principal de empresa que no tiene fondo';
COMMENT ON COLUMN tbl_tempxmand.empx_encargo                     IS 'Número de encargo';
COMMENT ON COLUMN tbl_tempxmand.empx_mandato                     IS 'Empresa Mandato';
COMMENT ON COLUMN tbl_tempxmand.empx_fecins                      IS 'Fecha de inserción del registro.';
COMMENT ON COLUMN tbl_tempxmand.empx_usuains                     IS 'Usuario de inserción el registro.';
COMMENT ON COLUMN tbl_tempxmand.empx_fecupd                      IS 'Ultima fecha que actualizo el registro.';
COMMENT ON COLUMN tbl_tempxmand.empx_usuaupd                     IS 'Ultimo usuario que actualizo el registro.';
--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       11/12/2023 Cramirezs    000001       * Se crean comentarios.
--                       Kilonova     MVP_2
-- ========== ========== ============ ============ ============================================================================================================
--
/**********************************************************************************/
Prompt
Prompt Generando Comentarios de la tabla TBL_TMOTMITRA
Prompt
/**********************************************************************************/
COMMENT ON TABLE  tbl_tmotmitra                                 IS 'Almacena movimientos de la sincronización con mitra.';
COMMENT ON COLUMN tbl_tmotmitra.motm_motm                       IS 'Secuencial y llave primaria d ela tabla.';
COMMENT ON COLUMN tbl_tmotmitra.motm_folio                      IS 'Folio.';
COMMENT ON COLUMN tbl_tmotmitra.motm_operacion                  IS 'Operación.';
COMMENT ON COLUMN tbl_tmotmitra.motm_cod_contra                 IS 'Código contraparte.';
COMMENT ON COLUMN tbl_tmotmitra.motm_desc_contra                IS 'Descripción contraparte.';
COMMENT ON COLUMN tbl_tmotmitra.motm_monto                      IS 'Monto.';
COMMENT ON COLUMN tbl_tmotmitra.motm_act                        IS 'Monto actualizado.';
COMMENT ON COLUMN tbl_tmotmitra.motm_fech_cump                  IS 'Fecha cumplimiento.';
COMMENT ON COLUMN tbl_tmotmitra.motm_cod_trader                 IS 'Código Trader.';
COMMENT ON COLUMN tbl_tmotmitra.motm_desc_trader                IS 'Descripción Trader.';
COMMENT ON COLUMN tbl_tmotmitra.motm_destino                    IS 'Destino Back';
COMMENT ON COLUMN tbl_tmotmitra.motm_estado                     IS 'Estado Back';
COMMENT ON COLUMN tbl_tmotmitra.motm_fuente                     IS 'Código fuente información.';
COMMENT ON COLUMN tbl_tmotmitra.motm_empr                       IS 'Código empresa EDGE.';
COMMENT ON COLUMN tbl_tmotmitra.motm_fecins                     IS 'Fecha en la que se realiza la inserción del registro.';
COMMENT ON COLUMN tbl_tmotmitra.motm_usuains                    IS 'Usuario que realizo la inserción del registro.';
COMMENT ON COLUMN tbl_tmotmitra.motm_fecupd                     IS 'Ultima fecha de actualización del registro.';
COMMENT ON COLUMN tbl_tmotmitra.motm_usuaupd                    IS 'Ultimo usuario que actualizo el registro.';
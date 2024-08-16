--
-- #VERSION: 1000
--
-- History
--
-- Versi�n    Date       User         Request      Description
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
COMMENT ON TABLE  tbl_tmotmitra                                 IS 'Almacena movimientos de la sincronizaci�n con mitra.';
COMMENT ON COLUMN tbl_tmotmitra.motm_motm                       IS 'Secuencial y llave primaria d ela tabla.';
COMMENT ON COLUMN tbl_tmotmitra.motm_folio                      IS 'Folio.';
COMMENT ON COLUMN tbl_tmotmitra.motm_operacion                  IS 'Operaci�n.';
COMMENT ON COLUMN tbl_tmotmitra.motm_cod_contra                 IS 'C�digo contraparte.';
COMMENT ON COLUMN tbl_tmotmitra.motm_desc_contra                IS 'Descripci�n contraparte.';
COMMENT ON COLUMN tbl_tmotmitra.motm_monto                      IS 'Monto.';
COMMENT ON COLUMN tbl_tmotmitra.motm_act                        IS 'Monto actualizado.';
COMMENT ON COLUMN tbl_tmotmitra.motm_fech_cump                  IS 'Fecha cumplimiento.';
COMMENT ON COLUMN tbl_tmotmitra.motm_cod_trader                 IS 'C�digo Trader.';
COMMENT ON COLUMN tbl_tmotmitra.motm_desc_trader                IS 'Descripci�n Trader.';
COMMENT ON COLUMN tbl_tmotmitra.motm_destino                    IS 'Destino Back';
COMMENT ON COLUMN tbl_tmotmitra.motm_estado                     IS 'Estado Back';
COMMENT ON COLUMN tbl_tmotmitra.motm_fuente                     IS 'C�digo fuente informaci�n.';
COMMENT ON COLUMN tbl_tmotmitra.motm_empr                       IS 'C�digo empresa EDGE.';
COMMENT ON COLUMN tbl_tmotmitra.motm_fecins                     IS 'Fecha en la que se realiza la inserci�n del registro.';
COMMENT ON COLUMN tbl_tmotmitra.motm_usuains                    IS 'Usuario que realizo la inserci�n del registro.';
COMMENT ON COLUMN tbl_tmotmitra.motm_fecupd                     IS 'Ultima fecha de actualizaci�n del registro.';
COMMENT ON COLUMN tbl_tmotmitra.motm_usuaupd                    IS 'Ultimo usuario que actualizo el registro.';
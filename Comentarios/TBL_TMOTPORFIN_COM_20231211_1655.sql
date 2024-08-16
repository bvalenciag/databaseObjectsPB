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
Prompt Generando Comentarios de la tabla TBL_TMOTPORFIN
Prompt
/**********************************************************************************/
COMMENT ON TABLE  tbl_tmotporfin                                    IS 'Almacena los movimeintos de la sincornizaci�n con porfin.';
COMMENT ON COLUMN tbl_tmotporfin.motp_motp                          IS 'Secuencial y llave primaria de la tabla.';
COMMENT ON COLUMN tbl_tmotporfin.motp_ope_fecha                     IS 'Fecha de operaci�n.';
COMMENT ON COLUMN tbl_tmotporfin.motp_det                           IS 'Det recuperado de PORFIN.';
COMMENT ON COLUMN tbl_tmotporfin.motp_transac                       IS 'Transacci�n.';
COMMENT ON COLUMN tbl_tmotporfin.motp_especie                       IS 'Especie.';
COMMENT ON COLUMN tbl_tmotporfin.motp_consec                        IS 'Concecutivo.';
COMMENT ON COLUMN tbl_tmotporfin.motp_valor_nom                     IS 'Valor nominal.';
COMMENT ON COLUMN tbl_tmotporfin.motp_emision                       IS 'Fecha emisi�n.';
COMMENT ON COLUMN tbl_tmotporfin.motp_vcto                          IS 'Fecha vencimiento.';
COMMENT ON COLUMN tbl_tmotporfin.motp_vr_reci                       IS 'Valor recibido.';
COMMENT ON COLUMN tbl_tmotporfin.motp_vr_act                        IS 'Valor actualizado.';
COMMENT ON COLUMN tbl_tmotporfin.motp_nit                           IS 'Nit.';
COMMENT ON COLUMN tbl_tmotporfin.motp_contraparte                   IS 'Contraparte.';
COMMENT ON COLUMN tbl_tmotporfin.motp_por                           IS 'Portafolio.';
COMMENT ON COLUMN tbl_tmotporfin.motp_empr                          IS 'C�digo empresa EDGE.';
COMMENT ON COLUMN tbl_tmotporfin.motp_fuente                        IS 'Fuente de informaci�n.';
COMMENT ON COLUMN tbl_tmotporfin.motp_fecins                        IS 'Fecha en la que se realiza la inserci�n del registro.';
COMMENT ON COLUMN tbl_tmotporfin.motp_usuains                       IS 'Usuario que realizo la inserci�n del registro.';
COMMENT ON COLUMN tbl_tmotporfin.motp_fecupd                        IS 'Ultima fecha de actualizaci�n del registro.';
COMMENT ON COLUMN tbl_tmotporfin.motp_usuaupd                       IS 'Ultimo usuario que actualizo el registro.';
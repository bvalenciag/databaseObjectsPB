--
-- #VERSION: 1000
--
-- History
--
-- Versi�n    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       14/12/2023 Cramirezs    000001       * Se crean comentarios.
--                       Kilonova     MVP_2
-- ========== ========== ============ ============ ============================================================================================================
--
/**********************************************************************************/
Prompt
Prompt Generando Comentarios de la tabla TBL_TCANCELACIO
Prompt
/**********************************************************************************/
COMMENT ON TABLE  tbl_tcancelacio                                   IS 'Almacena los registros de cancelaci�n recuperados de SIFI.';
COMMENT ON COLUMN tbl_tcancelacio.canc_canc                         IS 'Secuencial y llave primaria de la tabla.';
COMMENT ON COLUMN tbl_tcancelacio.canc_canc_ex                      IS 'C�digo cancelaci�n externo.';
COMMENT ON COLUMN tbl_tcancelacio.canc_fond_ex                      IS 'C�digo fondo externo.';
COMMENT ON COLUMN tbl_tcancelacio.canc_empr_ex                      IS 'C�digo empresa externo.';
COMMENT ON COLUMN tbl_tcancelacio.canc_empr                         IS 'C�digo empresa interno.';
COMMENT ON COLUMN tbl_tcancelacio.canc_banc_ex                      IS 'C�digo banco externo.';
COMMENT ON COLUMN tbl_tcancelacio.canc_banc                         IS 'C�digo banco interno.';
COMMENT ON COLUMN tbl_tcancelacio.canc_fecha                        IS 'Fecha.';
COMMENT ON COLUMN tbl_tcancelacio.canc_plan                         IS 'C�digo encargo/plan.';
COMMENT ON COLUMN tbl_tcancelacio.canc_desc_plan                    IS 'Descripci�n encargo/plan.';
COMMENT ON COLUMN tbl_tcancelacio.canc_vlr_canc                     IS 'Valor cancelaci�n.';
COMMENT ON COLUMN tbl_tcancelacio.canc_vlr_ajus                     IS 'Valor ajustado.';
COMMENT ON COLUMN tbl_tcancelacio.canc_vlr_gmf                      IS 'Valor Gmf.';
COMMENT ON COLUMN tbl_tcancelacio.canc_vlr_giro                     IS 'Valor giro.';
COMMENT ON COLUMN tbl_tcancelacio.canc_val_act                      IS 'Valor Actualizado de la cancelaci�n.';
COMMENT ON COLUMN tbl_tcancelacio.canc_fuente                       IS 'Fuente informaci�n.';
COMMENT ON COLUMN tbl_tcancelacio.canc_fecins                       IS 'Fecha en la que se realiza la inserci�n del registro.';
COMMENT ON COLUMN tbl_tcancelacio.canc_usuains                      IS 'Usuario que realizo la inserci�n del registro.';
COMMENT ON COLUMN tbl_tcancelacio.canc_fecupd                       IS 'Ultima fecha de actualizaci�n del registro.';
COMMENT ON COLUMN tbl_tcancelacio.canc_usuaupd                      IS 'Ultimo usuario que actualizo el registro.';
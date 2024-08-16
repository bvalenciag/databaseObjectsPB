--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
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
COMMENT ON TABLE  tbl_tcancelacio                                   IS 'Almacena los registros de cancelación recuperados de SIFI.';
COMMENT ON COLUMN tbl_tcancelacio.canc_canc                         IS 'Secuencial y llave primaria de la tabla.';
COMMENT ON COLUMN tbl_tcancelacio.canc_canc_ex                      IS 'Código cancelación externo.';
COMMENT ON COLUMN tbl_tcancelacio.canc_fond_ex                      IS 'Código fondo externo.';
COMMENT ON COLUMN tbl_tcancelacio.canc_empr_ex                      IS 'Código empresa externo.';
COMMENT ON COLUMN tbl_tcancelacio.canc_empr                         IS 'Código empresa interno.';
COMMENT ON COLUMN tbl_tcancelacio.canc_banc_ex                      IS 'Código banco externo.';
COMMENT ON COLUMN tbl_tcancelacio.canc_banc                         IS 'Código banco interno.';
COMMENT ON COLUMN tbl_tcancelacio.canc_fecha                        IS 'Fecha.';
COMMENT ON COLUMN tbl_tcancelacio.canc_plan                         IS 'Código encargo/plan.';
COMMENT ON COLUMN tbl_tcancelacio.canc_desc_plan                    IS 'Descripción encargo/plan.';
COMMENT ON COLUMN tbl_tcancelacio.canc_vlr_canc                     IS 'Valor cancelación.';
COMMENT ON COLUMN tbl_tcancelacio.canc_vlr_ajus                     IS 'Valor ajustado.';
COMMENT ON COLUMN tbl_tcancelacio.canc_vlr_gmf                      IS 'Valor Gmf.';
COMMENT ON COLUMN tbl_tcancelacio.canc_vlr_giro                     IS 'Valor giro.';
COMMENT ON COLUMN tbl_tcancelacio.canc_val_act                      IS 'Valor Actualizado de la cancelación.';
COMMENT ON COLUMN tbl_tcancelacio.canc_fuente                       IS 'Fuente información.';
COMMENT ON COLUMN tbl_tcancelacio.canc_fecins                       IS 'Fecha en la que se realiza la inserción del registro.';
COMMENT ON COLUMN tbl_tcancelacio.canc_usuains                      IS 'Usuario que realizo la inserción del registro.';
COMMENT ON COLUMN tbl_tcancelacio.canc_fecupd                       IS 'Ultima fecha de actualización del registro.';
COMMENT ON COLUMN tbl_tcancelacio.canc_usuaupd                      IS 'Ultimo usuario que actualizo el registro.';
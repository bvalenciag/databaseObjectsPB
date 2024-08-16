--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       18/12/2023 Jmartinezm    00001       * Se crean comentarios.
--                       Kilonova      MVP2
-- ========== ========== ============ ============ ============================================================================================================
--
/**********************************************************************************/
Prompt
Prompt Generando Comentarios de la tabla TBL_TCONDGEN
Prompt
/**********************************************************************************/
COMMENT ON TABLE  tbl_tcondgen                                  IS 'Tabla que permite parametrizar las condiciones generales';
COMMENT ON COLUMN tbl_tcondgen.cond_cond                        IS 'Secuencial y llave primaria';
COMMENT ON COLUMN tbl_tcondgen.cond_banc_inter                  IS 'Código del banco para la Tasa de Intervención';
COMMENT ON COLUMN tbl_tcondgen.cond_banc_cance                  IS 'Código del banco para Cancelación';
COMMENT ON COLUMN tbl_tcondgen.cond_dv1                         IS 'Puntos basicos';
COMMENT ON COLUMN tbl_tcondgen.cond_fecins                      IS 'Fecha en la que se realiza la inserción del registro.';
COMMENT ON COLUMN tbl_tcondgen.cond_usuains                     IS 'Usuario que realizo la inserción del registro.';
COMMENT ON COLUMN tbl_tcondgen.cond_fecupd                      IS 'Ultima fecha de actualización del registro.';
COMMENT ON COLUMN tbl_tcondgen.cond_usuaupd                     IS 'Ultimo usuario que actualizo el registro.';
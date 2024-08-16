--
-- #VERSION: 1000
--
-- History
--
-- Versi�n    Date       User         Request      Description
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
COMMENT ON COLUMN tbl_tcondgen.cond_banc_inter                  IS 'C�digo del banco para la Tasa de Intervenci�n';
COMMENT ON COLUMN tbl_tcondgen.cond_banc_cance                  IS 'C�digo del banco para Cancelaci�n';
COMMENT ON COLUMN tbl_tcondgen.cond_dv1                         IS 'Puntos basicos';
COMMENT ON COLUMN tbl_tcondgen.cond_fecins                      IS 'Fecha en la que se realiza la inserci�n del registro.';
COMMENT ON COLUMN tbl_tcondgen.cond_usuains                     IS 'Usuario que realizo la inserci�n del registro.';
COMMENT ON COLUMN tbl_tcondgen.cond_fecupd                      IS 'Ultima fecha de actualizaci�n del registro.';
COMMENT ON COLUMN tbl_tcondgen.cond_usuaupd                     IS 'Ultimo usuario que actualizo el registro.';
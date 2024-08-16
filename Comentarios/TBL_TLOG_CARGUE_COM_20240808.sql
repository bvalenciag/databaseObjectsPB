--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       08/08/2024 Jmartinezm    000001       * Se crean comentarios.
--                       Kilonova
-- ========== ========== ============ ============ ============================================================================================================
--
/**********************************************************************************/
Prompt
Prompt Generando Comentarios de la tabla TBL_TLOG_CARGUE
Prompt
/**********************************************************************************/
COMMENT ON TABLE  tbl_tlog_cargue                                 IS 'Tabla que guarda los logs de carga de la tabla tbl_tprovisiones';
COMMENT ON COLUMN tbl_tlog_cargue.log_log                         IS 'Identificador principal, secuencial';
COMMENT ON COLUMN tbl_tlog_cargue.log_tipo_cargue                 IS 'Tipo de cargue';
COMMENT ON COLUMN tbl_tlog_cargue.log_archivo                     IS 'Archivo BLOB.';
COMMENT ON COLUMN tbl_tlog_cargue.log_tipo_archivo                IS 'Tipo de archivo.';
COMMENT ON COLUMN tbl_tlog_cargue.log_nombre_archivo              IS 'Nombre del archivo.';
COMMENT ON COLUMN tbl_tlog_cargue.log_fecins                      IS 'Fecha en la que se realiza la inserción del registro.';
COMMENT ON COLUMN tbl_tlog_cargue.log_usuains                     IS 'Usuario que realizo la inserción del registro.';
COMMENT ON COLUMN tbl_tlog_cargue.log_fecupd                      IS 'Ultima fecha de actualización del registro.';
COMMENT ON COLUMN tbl_tlog_cargue.log_usuaupd                     IS 'Ultimo usuario que actualizo el registro.';
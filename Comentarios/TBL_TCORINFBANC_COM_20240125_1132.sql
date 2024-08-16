--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       24/01/2024 Jmartinezm    000001       * Se crean comentarios.
--                       Kilonova      MVP2
-- ========== ========== ============ ============ ============================================================================================================
--
/**********************************************************************************/
Prompt
Prompt Generando Comentarios de la tabla TBL_TCORINFBANC
Prompt
/**********************************************************************************/
COMMENT ON TABLE  tbl_tcorinfbanc                                  IS 'Tabla que almacena los correos electrónicos de la tabla tbl_tinfbancos';
COMMENT ON COLUMN tbl_tcorinfbanc.cori_cori                        IS 'Secuencial y llave primaria.';
COMMENT ON COLUMN tbl_tcorinfbanc.cori_infb                        IS 'Código de infbancos';
COMMENT ON COLUMN tbl_tcorinfbanc.cori_email                       IS 'Correo electrónico';
COMMENT ON COLUMN tbl_tcorinfbanc.cori_fecins                      IS 'Fecha en la que se realiza la inserción del registro.';
COMMENT ON COLUMN tbl_tcorinfbanc.cori_usuains                     IS 'Usuario que realizo la inserción del registro.';
COMMENT ON COLUMN tbl_tcorinfbanc.cori_fecupd                      IS 'Ultima fecha de actualización del registro.';
COMMENT ON COLUMN tbl_tcorinfbanc.cori_usuaupd                     IS 'Ultimo usuario que actualizo el registro.';
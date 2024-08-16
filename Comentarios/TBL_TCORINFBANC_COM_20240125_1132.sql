--
-- #VERSION: 1000
--
-- History
--
-- Versi�n    Date       User         Request      Description
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
COMMENT ON TABLE  tbl_tcorinfbanc                                  IS 'Tabla que almacena los correos electr�nicos de la tabla tbl_tinfbancos';
COMMENT ON COLUMN tbl_tcorinfbanc.cori_cori                        IS 'Secuencial y llave primaria.';
COMMENT ON COLUMN tbl_tcorinfbanc.cori_infb                        IS 'C�digo de infbancos';
COMMENT ON COLUMN tbl_tcorinfbanc.cori_email                       IS 'Correo electr�nico';
COMMENT ON COLUMN tbl_tcorinfbanc.cori_fecins                      IS 'Fecha en la que se realiza la inserci�n del registro.';
COMMENT ON COLUMN tbl_tcorinfbanc.cori_usuains                     IS 'Usuario que realizo la inserci�n del registro.';
COMMENT ON COLUMN tbl_tcorinfbanc.cori_fecupd                      IS 'Ultima fecha de actualizaci�n del registro.';
COMMENT ON COLUMN tbl_tcorinfbanc.cori_usuaupd                     IS 'Ultimo usuario que actualizo el registro.';
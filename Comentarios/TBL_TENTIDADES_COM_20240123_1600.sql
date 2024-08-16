--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       23/01/2024 Jmartinezm    00001       * Se crean comentarios.
--                       Kilonova      MVP2
-- ========== ========== ============ ============ ============================================================================================================
--
/**********************************************************************************/
Prompt
Prompt Generando Comentarios de la tabla tbl_tentidades
Prompt
/**********************************************************************************/
COMMENT ON TABLE  tbl_tentidades                                  IS 'Tabla que guarda las variables de cartas de traslado ';
COMMENT ON COLUMN tbl_tentidades.enti_enti                        IS 'Secuencial y llave primaria de la tabla.';
COMMENT ON COLUMN tbl_tentidades.enti_vari                        IS 'Secuencial diligenciado por cliente';
COMMENT ON COLUMN tbl_tentidades.enti_descripcion                 IS 'Descripción.';
COMMENT ON COLUMN tbl_tentidades.enti_fecins                      IS 'Fecha en la que se realiza la inserción del registro.';
COMMENT ON COLUMN tbl_tentidades.enti_usuains                     IS 'Usuario que realizo la inserción del registro.';
COMMENT ON COLUMN tbl_tentidades.enti_fecupd                      IS 'Ultima fecha de actualización del registro.';
COMMENT ON COLUMN tbl_tentidades.enti_usuaupd                     IS 'Ultimo usuario que actualizo el registro.';
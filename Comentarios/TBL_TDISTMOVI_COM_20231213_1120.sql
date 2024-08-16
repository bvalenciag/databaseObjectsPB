--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       13/12/2023 Jmartinezm    00001       * Se crean comentarios.
--                       Kilonova      MVP2
-- ========== ========== ============ ============ ============================================================================================================
--
/**********************************************************************************/
Prompt
Prompt Generando Comentarios de la tabla tbl_tdistmovi
Prompt
/**********************************************************************************/
COMMENT ON TABLE  tbl_tdistmovi                                  IS 'Tabla que almacena la distribución de porfin y mitra';
COMMENT ON COLUMN tbl_tdistmovi.dist_dist                        IS 'Secuencial y llave primaria de la tabla.';
COMMENT ON COLUMN tbl_tdistmovi.dist_motp                        IS 'Código de porfin sistema EDGE';
COMMENT ON COLUMN tbl_tdistmovi.dist_motm                        IS 'Código del mitra sistema EDGE';
COMMENT ON COLUMN tbl_tdistmovi.dist_banc                        IS 'Código del banco sistema EDGE';
COMMENT ON COLUMN tbl_tdistmovi.dist_val                         IS 'Valor';
COMMENT ON COLUMN tbl_tdistmovi.dist_motmd                       IS 'Almacena distribución de Mesa de Dinero';
COMMENT ON COLUMN tbl_tdistmovi.dist_fecins                      IS 'Fecha en la que se realiza la inserción del registro.';
COMMENT ON COLUMN tbl_tdistmovi.dist_usuains                     IS 'Usuario que realizo la inserción del registro.';
COMMENT ON COLUMN tbl_tdistmovi.dist_fecupd                      IS 'Ultima fecha de actualización del registro.';
COMMENT ON COLUMN tbl_tdistmovi.dist_usuaupd                     IS 'Ultimo usuario que actualizo el registro.';
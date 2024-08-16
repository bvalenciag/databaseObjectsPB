--
-- #VERSION: 1000
--
-- History
--
-- Versi�n    Date       User         Request      Description
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
COMMENT ON TABLE  tbl_tdistmovi                                  IS 'Tabla que almacena la distribuci�n de porfin y mitra';
COMMENT ON COLUMN tbl_tdistmovi.dist_dist                        IS 'Secuencial y llave primaria de la tabla.';
COMMENT ON COLUMN tbl_tdistmovi.dist_motp                        IS 'C�digo de porfin sistema EDGE';
COMMENT ON COLUMN tbl_tdistmovi.dist_motm                        IS 'C�digo del mitra sistema EDGE';
COMMENT ON COLUMN tbl_tdistmovi.dist_banc                        IS 'C�digo del banco sistema EDGE';
COMMENT ON COLUMN tbl_tdistmovi.dist_val                         IS 'Valor';
COMMENT ON COLUMN tbl_tdistmovi.dist_motmd                       IS 'Almacena distribuci�n de Mesa de Dinero';
COMMENT ON COLUMN tbl_tdistmovi.dist_fecins                      IS 'Fecha en la que se realiza la inserci�n del registro.';
COMMENT ON COLUMN tbl_tdistmovi.dist_usuains                     IS 'Usuario que realizo la inserci�n del registro.';
COMMENT ON COLUMN tbl_tdistmovi.dist_fecupd                      IS 'Ultima fecha de actualizaci�n del registro.';
COMMENT ON COLUMN tbl_tdistmovi.dist_usuaupd                     IS 'Ultimo usuario que actualizo el registro.';
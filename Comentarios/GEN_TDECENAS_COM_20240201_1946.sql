--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       01/02/2024 Cramirezs    000001       * Se crean comentarios.
--                       Kilonova
-- ========== ========== ============ ============ ============================================================================================================
--
/**********************************************************************************/
Prompt
Prompt Generando Comentarios de la tabla GEN_TDECENAS
Prompt
/**********************************************************************************/
COMMENT ON TABLE  gen_tdecenas                                  IS 'Cantidad de decenas convertidas a letras.';
COMMENT ON COLUMN gen_tdecenas.dece_dece                        IS 'Número de decenas.';
COMMENT ON COLUMN gen_tdecenas.dece_letras                      IS 'Decenas en letras.';
COMMENT ON COLUMN gen_tdecenas.dece_fecins                      IS 'Fecha en la que se realiza la inserción del registro.';
COMMENT ON COLUMN gen_tdecenas.dece_usuains                     IS 'Usuario que realizo la inserción del registro.';
COMMENT ON COLUMN gen_tdecenas.dece_fecupd                      IS 'Ultima fecha de actualización del registro.';
COMMENT ON COLUMN gen_tdecenas.dece_usuaupd                     IS 'Ultimo usuario que actualizo el registro.';
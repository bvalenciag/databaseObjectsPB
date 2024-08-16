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
Prompt Generando Comentarios de la tabla GEN_TCENTENAS
Prompt
/**********************************************************************************/
COMMENT ON TABLE  gen_tcentenas                                  IS 'Cantidad de centenas convertidas a letras.';
COMMENT ON COLUMN gen_tcentenas.cent_cent                        IS 'Número de centenas.';
COMMENT ON COLUMN gen_tcentenas.cent_letras                      IS 'Centenas en lestras.';
COMMENT ON COLUMN gen_tcentenas.cent_fecins                      IS 'Fecha en la que se realiza la inserción del registro.';
COMMENT ON COLUMN gen_tcentenas.cent_usuains                     IS 'Usuario que realizo la inserción del registro.';
COMMENT ON COLUMN gen_tcentenas.cent_fecupd                      IS 'Ultima fecha de actualización del registro.';
COMMENT ON COLUMN gen_tcentenas.cent_usuaupd                     IS 'Ultimo usuario que actualizo el registro.';
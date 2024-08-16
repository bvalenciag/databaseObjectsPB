--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       10/01/2024 Cramirezs    000001       * Se crean comentarios.
--                       Kilonova     MVP_2
-- ========== ========== ============ ============ ============================================================================================================
--
/**********************************************************************************/
Prompt
Prompt Generando Comentarios de la tabla TBL_TTRASEBRA
Prompt
/**********************************************************************************/
COMMENT ON TABLE  tbl_ttrasebra                                 IS 'Almacena registro de traslados SEBRA.';
COMMENT ON COLUMN tbl_ttrasebra.tras_tras                       IS 'Secuencial y llave primaria de la tabla.';
COMMENT ON COLUMN tbl_ttrasebra.tras_empr                       IS 'Código empresa.';
COMMENT ON COLUMN tbl_ttrasebra.tras_banc                       IS 'Código banco.';
COMMENT ON COLUMN tbl_ttrasebra.tras_cuen                       IS 'Codigo cuenta.';
COMMENT ON COLUMN tbl_ttrasebra.tras_cuen_cud                   IS 'Código cuenta CUD.';
COMMENT ON COLUMN tbl_ttrasebra.tras_tipo_oper                  IS 'Tipo de operación, relación con listas Modulo = TBL, lista = TIPO_OPER.';
COMMENT ON COLUMN tbl_ttrasebra.tras_esta                       IS 'Estado traslado, relación con estados Modulo = TBL, lista = ESTA_TRAS.';
COMMENT ON COLUMN tbl_ttrasebra.tras_valor                      IS 'Valor trasladado.';
COMMENT ON COLUMN tbl_ttrasebra.tras_impreso                    IS 'Estado impresión, relación con estados Modulo = TBL, lista = ESTA_IMPR.';
COMMENT ON COLUMN tbl_ttrasebra.tras_fecins                     IS 'Fecha en la que se realiza la inserción del registro.';
COMMENT ON COLUMN tbl_ttrasebra.tras_usuains                    IS 'Usuario que realizo la inserción del registro.';
COMMENT ON COLUMN tbl_ttrasebra.tras_fecupd                     IS 'Ultima fecha de actualización del registro.';
COMMENT ON COLUMN tbl_ttrasebra.tras_usuaupd                    IS 'Ultimo usuario que actualizo el registro.';
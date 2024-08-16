--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       26/12/2023 Jmartinezm    00001       * Se crean comentarios.
--                       Kilonova      MVP2
-- ========== ========== ============ ============ ============================================================================================================
--
/**********************************************************************************/
Prompt
Prompt Generando Comentarios de la tabla TBL_TMESAOPER
Prompt
/**********************************************************************************/
COMMENT ON TABLE  tbl_tmesaoper                                  IS 'Tabla donde se almacena los tickets de la mesa de operaciones';
COMMENT ON COLUMN tbl_tmesaoper.mesa_mesa                        IS 'Secuencial y llave primaria';
COMMENT ON COLUMN tbl_tmesaoper.mesa_fecha                       IS 'Fecha';
COMMENT ON COLUMN tbl_tmesaoper.mesa_empr                        IS 'Código empresa EDGE';
COMMENT ON COLUMN tbl_tmesaoper.mesa_banc                        IS 'Código banco EDGE';
COMMENT ON COLUMN tbl_tmesaoper.mesa_oper                        IS 'Tipo de operación, relación con listas Modulo = TBL, lista = TIPO_OPER.';
COMMENT ON COLUMN tbl_tmesaoper.mesa_descripcion                 IS 'Descripción de la operación';
COMMENT ON COLUMN tbl_tmesaoper.mesa_ticket                      IS 'Numero de ticket';
COMMENT ON COLUMN tbl_tmesaoper.mesa_valor                       IS 'Valor';
COMMENT ON COLUMN tbl_tmesaoper.mesa_fecins                      IS 'Fecha en la que se realiza la inserción del registro.';
COMMENT ON COLUMN tbl_tmesaoper.mesa_usuains                     IS 'Usuario que realizo la inserción del registro.';
COMMENT ON COLUMN tbl_tmesaoper.mesa_fecupd                      IS 'Ultima fecha de actualización del registro.';
COMMENT ON COLUMN tbl_tmesaoper.mesa_usuaupd                     IS 'Ultimo usuario que actualizo el registro.';
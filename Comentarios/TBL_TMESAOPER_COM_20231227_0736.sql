--
-- #VERSION: 1000
--
-- History
--
-- Versi�n    Date       User         Request      Description
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
COMMENT ON COLUMN tbl_tmesaoper.mesa_empr                        IS 'C�digo empresa EDGE';
COMMENT ON COLUMN tbl_tmesaoper.mesa_banc                        IS 'C�digo banco EDGE';
COMMENT ON COLUMN tbl_tmesaoper.mesa_oper                        IS 'Tipo de operaci�n, relaci�n con listas Modulo = TBL, lista = TIPO_OPER.';
COMMENT ON COLUMN tbl_tmesaoper.mesa_descripcion                 IS 'Descripci�n de la operaci�n';
COMMENT ON COLUMN tbl_tmesaoper.mesa_ticket                      IS 'Numero de ticket';
COMMENT ON COLUMN tbl_tmesaoper.mesa_valor                       IS 'Valor';
COMMENT ON COLUMN tbl_tmesaoper.mesa_fecins                      IS 'Fecha en la que se realiza la inserci�n del registro.';
COMMENT ON COLUMN tbl_tmesaoper.mesa_usuains                     IS 'Usuario que realizo la inserci�n del registro.';
COMMENT ON COLUMN tbl_tmesaoper.mesa_fecupd                      IS 'Ultima fecha de actualizaci�n del registro.';
COMMENT ON COLUMN tbl_tmesaoper.mesa_usuaupd                     IS 'Ultimo usuario que actualizo el registro.';
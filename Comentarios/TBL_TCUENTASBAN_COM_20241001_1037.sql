--
-- #VERSION: 1000
--
-- History
--
-- Versi�n    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       10/01/2024 Cramirezs    000001       * Se crean comentarios.
--                       Kilonova     MVP_2
-- ========== ========== ============ ============ ============================================================================================================
--
/**********************************************************************************/
Prompt
Prompt Generando Comentarios de la tabla TBL_TCUENTASBAN
Prompt
/**********************************************************************************/
COMMENT ON COLUMN tbl_tcuentasban.cuen_tipo_oper                    IS 'Tipo de operaci�n relaci�n con listas Modulo = TBL, lista = TIPO_OPER';
COMMENT ON COLUMN tbl_tcuentasban.cuen_cta_cud                      IS 'Cuenta CUD relaci�n con las cuentas de tablero.';
COMMENT ON COLUMN tbl_tcuentasban.cuen_sldmincor                    IS 'Saldo minimo de cuenta corriente.';
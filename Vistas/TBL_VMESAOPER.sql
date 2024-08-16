prompt
prompt VIEW: TBL_VMESAOPER
prompt
CREATE OR REPLACE FORCE VIEW tbl_vmesaoper
    (
      mesa_mesa
    , mesa_fecha
    , mesa_empr
    , mesa_banc
    , mesa_oper
    , mesa_descripcion
    , mesa_ticket
    , mesa_valor
    , mesa_esta
    , mesa_descri
    , mesa_mandato
    , mesa_mandato_descripcion
    , mesa_fecins
    , mesa_usuains
    , mesa_fecupd
    , mesa_usuaupd
    , empr_descripcion
    , empr_externo
--    , banc_descripcion
    )
AS
SELECT
--
-- #VERSION: 1003
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       27/12/2023 Jmartinezm    00001       * Se crea vista.
--                       Kilonova      MVP2
-- ========== ========== ============ ============ ============================================================================================================
-- 1001       22/02/2024 Jmartinezm    00002       * Se agrega columna.
--                       Kilonova      MVP2
-- ========== ========== ============ ============ ============================================================================================================
-- 1002       24/04/2024 Jmartinezm    00003       * Ajuste de vista.
--                       Kilonova      MVP2
-- ========== ========== ============ ============ ============================================================================================================
-- 1003       21/05/2024 Jmartinezm    00004       * Ajuste de vista.
--                       Kilonova      MVP2
-- ========== ========== ============ ============ ============================================================================================================
--
/* antes 1002       24/04/2024 Jmartinezm 
      mesa_mesa
    , mesa_fecha
    , mesa_empr
    , mesa_banc
    , mesa_oper
    , mesa_descripcion
    , mesa_ticket
    , mesa_valor
    , mesa_esta -- 1001       22/02/2024 Jmartinezm 
    , esta_descri-- 1001       22/02/2024 Jmartinezm 
    , mesa_fecins
    , mesa_usuains
    , mesa_fecupd
    , mesa_usuaupd
    , empr_descripcion
    , empr_externo
 --   , banc_descripcion
 FROM tbl_tmesaoper 
    , tbl_tempresas
--    , tbl_tbancos
    , gen_testados -- 1001       22/02/2024 Jmartinezm 
WHERE mesa_empr = empr_empr
AND mesa_esta = esta_esta -- 1001       22/02/2024 Jmartinezm 
--AND   mesa_banc = banc_banc
*/ -- ini 1002       24/04/2024 Jmartinezm 
    mo.mesa_mesa
    , mo.mesa_fecha
    , mo.mesa_empr
    , mo.mesa_banc
    , mo.mesa_oper
    , mo.mesa_descripcion
    , mo.mesa_ticket
    , mo.mesa_valor
    , mo.mesa_esta
    , es.esta_descri
    , mo.mesa_mandato       
    , mm.empr_descripcion 
    , mo.mesa_fecins
    , mo.mesa_usuains
    , mo.mesa_fecupd
    , mo.mesa_usuaupd
    , em.empr_descripcion
    , em.empr_externo
FROM 
    tbl_tmesaoper mo
    , tbl_tempresas em
    /* antes 1003       21/05/2024 Jmartinezm 
    , (SELECT te.empr_empr, te.empr_descripcion
       FROM tbl_tempresas te, tbl_tmesaoper
       WHERE mesa_mandato = empr_empr) mm
    */
    , tbl_tempresas mm   --1003       21/05/2024 Jmartinezm 
    , gen_testados es
WHERE 
    mo.mesa_empr = em.empr_empr
    AND mo.mesa_esta = es.esta_esta
    AND mm.empr_empr(+) = mo.mesa_mandato
/
--
COMMENT ON TABLE  tbl_vmesaoper                             IS 'Vista que Visualiza los registros de las operaciones registradas en mesa ';
COMMENT ON COLUMN tbl_vmesaoper.mesa_mesa                   IS 'Secuencial y llave primaria';
COMMENT ON COLUMN tbl_vmesaoper.mesa_fecha                  IS 'Fecha';
COMMENT ON COLUMN tbl_vmesaoper.mesa_empr                   IS 'Código empresa EDGE';
COMMENT ON COLUMN tbl_vmesaoper.mesa_banc                   IS 'Código banco EDGE';
COMMENT ON COLUMN tbl_vmesaoper.mesa_oper                   IS 'Operación';
COMMENT ON COLUMN tbl_vmesaoper.mesa_descripcion            IS 'Descripción de la operación';
COMMENT ON COLUMN tbl_vmesaoper.mesa_ticket                 IS 'Numero de ticket';
COMMENT ON COLUMN tbl_vmesaoper.mesa_valor                  IS 'Valor';
COMMENT ON COLUMN tbl_vmesaoper.mesa_esta                   IS 'Código del estado';
COMMENT ON COLUMN tbl_vmesaoper.mesa_mandato                IS 'Código del mandato';
COMMENT ON COLUMN tbl_vmesaoper.mesa_mandato_descripcion    IS 'Descripción del mandato';
COMMENT ON COLUMN tbl_vmesaoper.mesa_descri                 IS 'Descripción del estado';
COMMENT ON COLUMN tbl_vmesaoper.mesa_fecins                 IS 'Fecha en la que se realiza la inserción del registro.';
COMMENT ON COLUMN tbl_vmesaoper.mesa_usuains                IS 'Usuario que realizo la inserción del registro.';
COMMENT ON COLUMN tbl_vmesaoper.mesa_fecupd                 IS 'Ultima fecha de actualización del registro.';
COMMENT ON COLUMN tbl_vmesaoper.mesa_usuaupd                IS 'Ultimo usuario que actualizo el registro.';
COMMENT ON COLUMN tbl_vmesaoper.empr_descripcion            IS 'Descripción de la empresa';
--COMMENT ON COLUMN tbl_vmesaoper.banc_descripcion        IS 'Descripción del banco';
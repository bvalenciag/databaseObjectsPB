prompt
prompt VIEW: TBL_VINFBANCOS
prompt
CREATE OR REPLACE FORCE VIEW tbl_vinfbancos
    (
      infb_infb
    , infb_banc
    , infb_nit
    , infb_desti
    , infb_cargo
    , infb_dv
    , infb_dir
    , infb_ciudad
    , infb_fax
    , infb_telefono
    , infb_ref
    , infb_concep
    , infb_oficina
    , infb_refegr
    , banc_descripcion
    , infb_comision
    , infb_comision_m
    , infb_cuen_cud_cod
    , infb_cuen_cud_desc
    , infb_portafolio
    )
AS
SELECT
--
-- #VERSION: 1002
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       24/01/2024 Jmartinezm    00001       * Se crea vista.
--                       Kilonova      MVP2
-- ========== ========== ============ ============ ============================================================================================================
-- 1001       21/02/2024 Jmartinezm    00002       * Se agrega columna a la vista.
--                       Kilonova      MVP2
-- ========== ========== ============ ============ ============================================================================================================
-- 1002       21/03/2024 Jmartinezm    00003       * Se agrega columna a la vista.
--                       Kilonova      MVP2
-- ========== ========== ============ ============ ============================================================================================================
--
    infb_infb
    , infb_banc
    , infb_nit
    , infb_desti
    , infb_cargo
    , infb_dv
    , infb_dir
    , infb_ciudad
    , infb_fax
    , infb_telefono
    , infb_ref
    , infb_concep
    , infb_oficina -- 1001       21/02/2024 Jmartinezm 
    , infb_refegr  -- 1001       21/02/2024 Jmartinezm
    , banc_descripcion 
    , infb_comision -- 1002       21/03/2024 Jmartinezm 
    , infb_comision_m -- 1002       21/03/2024 Jmartinezm
    , infb_cuen_cud_cod  --1002    21/03/2024  Jmartinezm
    , infb_cuen_cud_desc  --1002    21/03/2024  Jmartinezm
    , infb_portafolio  --1002    21/03/2024  Jmartinezm 
 from tbl_tinfbancos
        ,tbl_tbancos
where infb_banc = banc_banc
/
--
COMMENT ON TABLE  tbl_vinfbancos                        IS 'Vista que ayuda a visualizar los parametros de los traslados bancarios';
COMMENT ON COLUMN tbl_vinfbancos.infb_infb              IS 'Secuencial y llave principal';
COMMENT ON COLUMN tbl_vinfbancos.infb_banc              IS 'Código de banco';
COMMENT ON COLUMN tbl_vinfbancos.infb_nit               IS 'NIT';
COMMENT ON COLUMN tbl_vinfbancos.infb_desti             IS 'Destinatario';
COMMENT ON COLUMN tbl_vinfbancos.infb_cargo             IS 'Cargo';
COMMENT ON COLUMN tbl_vinfbancos.infb_dv                IS 'Digito de verificacion';
COMMENT ON COLUMN tbl_vinfbancos.infb_dir               IS 'Dirección';
COMMENT ON COLUMN tbl_vinfbancos.infb_ciudad            IS 'Cuidad';
COMMENT ON COLUMN tbl_vinfbancos.infb_fax               IS 'Fax';
COMMENT ON COLUMN tbl_vinfbancos.infb_telefono          IS 'Teléfono';
COMMENT ON COLUMN tbl_vinfbancos.infb_ref               IS 'Referencia';
COMMENT ON COLUMN tbl_vinfbancos.infb_concep            IS 'Concepto';
COMMENT ON COLUMN tbl_vinfbancos.infb_oficina           IS 'Oficina';
COMMENT ON COLUMN tbl_vinfbancos.infb_refegr            IS 'Referencia egreso';
COMMENT ON COLUMN tbl_vinfbancos.banc_descripcion       IS 'Descripción Banco';
COMMENT ON COLUMN tbl_vinfbancos.infb_comision          IS 'Comisión Fija';
COMMENT ON COLUMN tbl_vinfbancos.infb_comision_m        IS 'Comisión por millon';
COMMENT ON COLUMN tbl_vinfbancos.infb_cuen_cud_cod      IS 'Código cuenta CUD';
COMMENT ON COLUMN tbl_vinfbancos.infb_cuen_cud_desc     IS 'Descripción cuenta CUD';
COMMENT ON COLUMN tbl_vinfbancos.infb_portafolio        IS 'Portafolio';

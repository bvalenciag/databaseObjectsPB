prompt
prompt VIEW: TBL_VREGIONALES
prompt
CREATE OR REPLACE FORCE VIEW tbl_vregionales
    (
      REGI_EMPR
    , REGI_EMPR_EX
    , EMPR_DESCRIPCION
    , REGI_BANC
    , REGI_BANC_EX
    , BANC_DESCRIPCION
    , REGI_FECHA
    , REGI_ADIC_REALES
    , REGI_RETI_REALES
    , REGI_VAL_TOTAL
    , MOTB_ING_PRE
    , MOTB_EGR_PRE
    , OTROS_INGRESOS
    , OTROS_EGRESOS  
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
-- 1000       15/12/2023 Jmartinezm    00001       * Se crea vista.
--                       Kilonova      MVP2
-- ========== ========== ============ ============ ============================================================================================================
-- 1001       23/02/2024 Jmartinezm    00002       * Se ajusta vista.
--                       Kilonova      MVP2
-- ========== ========== ============ ============ ============================================================================================================
-- 1002       11/04/2024 Jmartinezm    00003       * Se ajusta vista.
--                       Kilonova      MVP2
-- ========== ========== ============ ============ ============================================================================================================
-- 1003       09/08/2024 Jmartinezm    00004       * Se agrega consulta de tbl_tprovisiones
--                       Kilonova      MVP3
-- ========== ========== ============ ============ ============================================================================================================
-- ini 1001       23/02/2024 Jmartinezm
    REGI_EMPR
    , REGI_EMPR_EX
    , EMPR_DESCRIPCION
    , REGI_BANC
    , REGI_BANC_EX
    , BANC_DESCRIPCION
    , REGI_FECHA
    , SUM(REGI_ADIC_REALES)
    , SUM(REGI_RETI_REALES)
    , SUM(REGI_VAL_TOTAL)
    , SUM(MOTB_ING_PRE)
    , SUM(MOTB_EGR_PRE)
    , SUM(OTROS_INGRESOS)
    , SUM(OTROS_EGRESOS )
FROM
(
    select -- fin 1001       23/02/2024 Jmartinezm 
      REGI_EMPR
    , REGI_EMPR_EX
    , EMPR_DESCRIPCION
    , REGI_BANC
    , REGI_BANC_EX
    , BANC_DESCRIPCION
    , REGI_FECHA
    , SUM(REGI_ADIC_REALES) REGI_ADIC_REALES
    , SUM(REGI_RETI_REALES) REGI_RETI_REALES
    , SUM((REGI_ADIC_REALES -
       REGI_RETI_REALES)) REGI_VAL_TOTAL
    , 0   MOTB_ING_PRE
    , 0   MOTB_EGR_PRE
    , 0   otros_ingresos
    , 0   otros_egresos
FROM
    tbl_tregionales,
    tbl_tempresas,
    tbl_tbancos
WHERE
    regi_empr = empr_empr
    AND regi_banc = banc_banc
    group by REGI_EMPR, REGI_EMPR_EX,EMPR_DESCRIPCION ,REGI_BANC, REGI_BANC_EX,
    BANC_DESCRIPCION, REGI_FECHA
union all
select 
     MOTB_EMPR REGI_EMPR
    , MOTB_EMPRESA
    , EMPR_DESCRIPCION
    , MOTB_BANC
    , MOTB_BANCO
    , BANC_DESCRIPCION
    , MOTB_FECHA
    , 0 REGI_ADIC_REALES
    , 0 REGI_RETI_REALES
    , SUM(MOTB_VALOR) REGI_VAL_TOTAL
    , SUM(DECODE(MOTB_TIPO_OPER, 'INGRESO',MOTB_VALOR,0))   MOTB_ING_PRE
    , SUM(DECODE(MOTB_TIPO_OPER, 'EGRESO',MOTB_VALOR,0))    MOTB_EGR_PRE
    , 0   otros_ingresos
    , 0   otros_egresos
FROM
    tbl_tempresas,
    tbl_tbancos,
    tbl_tmotbbiza
WHERE
    MOTB_BANC = BANC_BANC
    AND MOTB_EMPR = EMPR_EMPR
    AND motb_esta  = 'REG'
    --AND motb_tipo_oper IN ('EGRESO', 'APORTE') antes 1002       11/04/2024 Jmartinezm
    AND motb_tipo_oper IN ('EGRESO', 'INGRESO') -- 1002       11/04/2024 Jmartinezm
    group by MOTB_EMPR, MOTB_EMPRESA,EMPR_DESCRIPCION ,MOTB_BANC, MOTB_BANCO,
    BANC_DESCRIPCION,MOTB_FECHA
union all
-- 1003  ini    09/08/2024 
select 
      prov_empr
    , prov_empr_externo
    , empr_descripcion
    , prov_banc
    , prov_banc_externo
    , banc_descripcion
    , trunc(prov_fecins)
    , 0
    , 0
    , SUM(prov_valor)
    , 0
    , 0
    , SUM(CASE WHEN prov_valor > 0 THEN prov_valor ELSE 0 END) AS otros_ingresos
    , SUM(CASE WHEN prov_valor < 0 THEN prov_valor ELSE 0 END) AS otros_egresos
from tbl_tprovisiones
     ,tbl_tempresas
    ,tbl_tbancos
    where prov_empr = empr_empr
    and prov_banc = banc_banc
    group by prov_empr
    , prov_empr_externo
    , empr_descripcion
    , prov_banc
    , prov_banc_externo
    , banc_descripcion
    , trunc(prov_fecins)
    -- 1003  fin 09/08/2024
) --ini 1001       23/02/2024 Jmartinezm 
  group by REGI_EMPR
, REGI_EMPR_EX
, EMPR_DESCRIPCION
, REGI_BANC
, REGI_BANC_EX
, BANC_DESCRIPCION
, REGI_FECHA --fin 1001       23/02/2024 Jmartinezm 
/
--
COMMENT ON TABLE  tbl_vregionales                     IS 'Vista que permite consultar los Saldos Regionales';
COMMENT ON COLUMN tbl_vregionales.REGI_EMPR           IS 'Código empresa EDGE';
COMMENT ON COLUMN tbl_vregionales.REGI_EMPR_EX        IS 'Código empresa externo';
COMMENT ON COLUMN tbl_vregionales.EMPR_DESCRIPCION    IS 'descripción de la empresa';
COMMENT ON COLUMN tbl_vregionales.REGI_BANC           IS 'Código banco EDGE';
COMMENT ON COLUMN tbl_vregionales.REGI_BANC_EX        IS 'Código banco externo';
COMMENT ON COLUMN tbl_vregionales.BANC_DESCRIPCION    IS 'descripción del banco';
COMMENT ON COLUMN tbl_vregionales.REGI_FECHA          IS 'fecha';
COMMENT ON COLUMN tbl_vregionales.REGI_ADIC_REALES    IS 'adiciones reales';
COMMENT ON COLUMN tbl_vregionales.REGI_RETI_REALES    IS 'retiros reales';
COMMENT ON COLUMN tbl_vregionales.REGI_VAL_TOTAL      IS 'valor total';
COMMENT ON COLUMN tbl_vregionales.MOTB_ING_PRE        IS 'ingreso presupuestado';
COMMENT ON COLUMN tbl_vregionales.MOTB_EGR_PRE        IS 'egreso presupuestado';
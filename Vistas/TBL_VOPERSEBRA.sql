prompt
prompt VIEW: TBL_VOPERSEBRA
prompt
CREATE OR REPLACE FORCE VIEW tbl_vopersebra
    (
      oper_empr_empr
    , oper_empr_externo
    , oper_empr_descripcion
    , oper_sald_fecha
    , oper_motp_mesa
    , oper_tras_valor
    , oper_cuen_banc
    , oper_mandato
    , oper_total
    , oper_dif
    , oper_fideicomiso
    , oper_inversionista
    )
AS
SELECT
--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       21/03/2024 Jmartinezm    000001       * Se crea vista.
--                       Kilonova      
-- ========== ========== ============ ============ ============================================================================================================
-- 1001       26/04/2024 Jmartinezm    000002       * Se modifica lógica de vista.
--                       Kilonova      
-- ========== ========== ============ ============ ============================================================================================================
-- 1002       26/06/2024 Jmartinezm    000003       * Se agraga columnas a la vista.
--                       Kilonova      
-- ========== ========== ============ ============ ============================================================================================================
-- 
  /*
    empr_empr
    , empr_externo
    , empr_descripcion
    , sald_fecha
    , tras_fecha
    , tbl_qgeneral.fn_val_mesa(empr_empr,cuen_banc,null,sald_fecha)    motp_mesa
    , sum(tras_valor) valor
    , ABS(sum(CASE WHEN LIST_SIGLA = 'I' then motp_mesa else 0 end)- SUM(tras_valor) ) diferencia
    , cuen_banc
    from tbl_vsaldos_genliquidez
    , tbl_ttrasebra
    , gen_tlistas
    where tras_banc = cuen_banc
    and tras_empr = empr_empr
    and tras_tipo_oper =  list_list
    and cuen_banc = tbl_qgeneral.fn_codi_condpfmt('COD')
    group by empr_empr
    ,empr_externo
    ,empr_descripcion
    ,sald_fecha
    ,tras_fecha 
    ,cuen_banc
    */ --antes 1001
    -- ini 1001  26/04/2024 Jmartinezm 
    empr_empr                                       oper_empr_empr
  , empr_externo                                    oper_empr_externo
  , empr_descripcion                                oper_empr_descripcion
  , sald_fecha                                      oper_sald_fecha
  , motp_mesa                                       oper_motp_mesa
  , tras_valor                                      oper_tras_valor
  , cuen_banc                                       oper_cuen_banc
  , MANDATO                                         oper_mandato
  , tras_sebra_fideicomiso                          oper_fideicomiso
  , tras_sebra_inversionista                        oper_inversionista
  , (tras_sebra_fideicomiso+ tras_sebra_inversionista+ motp_mesa)                            oper_total
  , ((tras_sebra_fideicomiso+ tras_sebra_inversionista+ motp_mesa)  - tras_valor)            oper_dif
FROM
  (select em.empr_empr
        , em.empr_externo
        , em.empr_descripcion
        , sc.sald_fecha
        , tbl_qgeneral.fn_val_mesa(em.empr_empr,cb.cuen_banc,null,sc.sald_fecha)    motp_mesa           -- 1002       26/06/2024 Jmartinezm 
        --, tbl_qgeneral.fn_val_mesa_sebra(em.empr_empr,cb.cuen_banc,sc.sald_fecha)    motp_mesa        antes -- 1002       26/06/2024 Jmartinezm 
        , tbl_qgeneral.fn_recupera_traslado(em.empr_empr,cb.cuen_banc,sc.sald_fecha) tras_valor
        , tbl_qgeneral.fn_val_sebra_fideicomiso(em.empr_empr,sc.sald_fecha) tras_sebra_fideicomiso      -- 1002       26/06/2024 Jmartinezm 
        , tbl_qgeneral.fn_val_sebra_inversionistas(em.empr_empr,sc.sald_fecha) tras_sebra_inversionista -- 1002       26/06/2024 Jmartinezm 
        , cb.cuen_banc
        , tbl_qgeneral.fn_recupera_mandato(em.empr_empr, cb.cuen_banc, sc.sald_fecha) MANDATO
     FROM tbl_tempresas em
        , tbl_tbancos  bn
        , tbl_tcuentasban cb
        , tbl_tsaldos_cta sc
    WHERE em.empr_empr = cb.cuen_empr
      AND cb.cuen_banc = bn.banc_banc
      AND sc.sald_cuen = cb.cuen_cuen
      AND cb.cuen_banc = tbl_qgeneral.fn_codi_condpfmt('COD')
      AND em.empr_fond IS NOT NULL
    GROUP BY em.empr_empr
        , em.empr_externo
        , em.empr_descripcion
        , sc.sald_fecha
        , cb.cuen_banc
      )
-- Fin 1001  26/04/2024 Jmartinezm 
/
--
COMMENT ON TABLE    tbl_vopersebra                           IS 'Vista que muestra la información de mesa de dinero, mandatos y traslados';
COMMENT ON COLUMN   tbl_vopersebra.oper_empr_empr            IS 'Código interno Empresa';
COMMENT ON COLUMN   tbl_vopersebra.oper_empr_externo         IS 'Código externo Empresa';
COMMENT ON COLUMN   tbl_vopersebra.oper_empr_descripcion     IS 'Descripción de la Empresa';
COMMENT ON COLUMN   tbl_vopersebra.oper_sald_fecha           IS 'Fecha del saldo';
COMMENT ON COLUMN   tbl_vopersebra.oper_motp_mesa            IS 'Calculo de la mesa de dinero';
COMMENT ON COLUMN   tbl_vopersebra.oper_tras_valor           IS 'Valor del traslado';
COMMENT ON COLUMN   tbl_vopersebra.oper_cuen_banc            IS 'Código interno de Banco';
COMMENT ON COLUMN   tbl_vopersebra.oper_mandato              IS 'Mandato';
COMMENT ON COLUMN   tbl_vopersebra.oper_total                IS 'Total';
COMMENT ON COLUMN   tbl_vopersebra.oper_dif                  IS 'Diferencia';
COMMENT ON COLUMN   tbl_vopersebra.oper_fideicomiso          IS 'Valor de Fideicomisos';
COMMENT ON COLUMN   tbl_vopersebra.oper_inversionista        IS 'Valor de Inversionistas';
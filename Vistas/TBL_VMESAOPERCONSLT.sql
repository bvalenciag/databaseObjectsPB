prompt
prompt VIEW: TBL_VMESAOPERCONSLT
prompt
CREATE OR REPLACE FORCE VIEW tbl_vmesaoperconslt
    (
      empr
    , origen
    , tipo_oper
    , especie
    , fecha
    , num_oper       
    , num_ticket
    , nit
    , contraparte
    , id_trader
    , trader   
    , val_nom
    , emision
    , vcto
    , banc_prin
    , estado
    , val
    , val_ajt
    , empr_descripcion
    , banc_descripcion
    , naturaleza
    , mandato
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
-- 1000       05/01/2024 Jmartinezm    00001       * Se crea vista.
--                       Kilonova      MPV2
-- ========== ========== ============ ============ ============================================================================================================
-- 1001       22/01/2024 Jmartinezm    00002       * Ajuste de vista
--                       Kilonova      MPV2
-- ========== ========== ============ ============ ============================================================================================================
-- 1002       11/04/2024 Jmartinezm    00003       * Ajuste de vista
--                       Kilonova      MPV2
-- ========== ========== ============ ============ ============================================================================================================
-- 1003       15/08/2024 Jmartinezm    00004       * Ajuste de vista
--                       Kilonova      MPV3
-- ========== ========== ============ ============ ============================================================================================================
--
-- Consulta 1
--No distribuidas
       motp_empr empr
     , gen_qgeneral.id_lista_desc(motp_fuente) origen
     , motp_transac tipo_oper        
     , motp_especie especie 
     , motp_ope_fecha fecha 
     , TO_CHAR(motp_consec) num_oper
     , null num_ticket
     , motp_nit nit
     , motp_contraparte contraparte
     , null id_trader
     , null trader  
     , sum(
         case
            when MOTP_DET = 'Ent' then NVL(motp_valor_nom,0)
            when MOTP_DET = 'Sal' then -NVL(motp_valor_nom,0)
            else 0
         end) val_nom
     , motp_emision emision
     , motp_vcto vcto
     , tbl_qgeneral.fn_codi_condpfmt('COD')  banc_prin
     , null estado
     --, sum(motp_vr_reci) val
     , sum(
         case
            when MOTP_DET = 'Ent' then NVL(motp_vr_reci,0)
            when MOTP_DET = 'Sal' then -NVL(motp_vr_reci,0)
            else 0
         end
     ) val --1002       11/04/2024 Jmartinezm
     --, sum(motp_vr_act) val_ajt
     , sum(
         case
            when MOTP_DET = 'Ent' then NVL(motp_vr_act,0)
            when MOTP_DET = 'Sal' then -NVL(motp_vr_act,0)
            else 0
         end
     ) val_ajt --1002       11/04/2024 Jmartinezm
     , empr_descripcion
     , banc_descripcion
     , decode(UPPER(MOTP_DET), 'ENT', 'INGRESO', 'EGRESO')
     , motp_mandato mesa_mandato
  FROM tbl_tmotporfin
    ,  tbl_tempresas
    ,  tbl_tbancos
 WHERE motp_empr = empr_empr
 AND   banc_banc = tbl_qgeneral.fn_codi_condpfmt('COD') 
 AND NOT EXISTS (SELECT dist_motp
                     FROM tbl_tdistmovi
                    WHERE dist_motp = motp_motp
                    )
-- ini 1003       15/08/2024 Jmartinezm                    
 AND EXISTS     ( select 1 
                     FROM TBL_TCDISTPFMT cd  
                     WHERE (motp_especie = cd.NAME_DIST OR motp_transac = cd.NAME_DIST)
                    AND cd.IS_CHECK = 'S'
                    AND cd.TYPE_DIST IN ('E', 'O'))   
-- fin 1003       15/08/2024 Jmartinezm                                      
 group by motp_empr,gen_qgeneral.id_lista_desc(motp_fuente),motp_transac 
,motp_especie,motp_ope_fecha,motp_consec,motp_nit,motp_contraparte,
motp_emision,motp_vcto,tbl_qgeneral.fn_codi_condpfmt('COD'),empr_descripcion
, banc_descripcion,motp_det  , motp_mandato
UNION ALL
--Distribuidas
SELECT motp_empr empr
     , gen_qgeneral.id_lista_desc(motp_fuente) origen
     , motp_transac tipo_oper         
     , motp_especie especie
     , motp_ope_fecha fecha
     , TO_CHAR(motp_consec) num_oper
     , null num_ticket
     , motp_nit nit
     , motp_contraparte contraparte
     , null id_trader
     , null trader 
     --, sum(motp_valor_nom) val_nom antes 1002       11/04/2024 Jmartinezm
     , min(
         case
            when MOTP_DET = 'Ent' then NVL(motp_valor_nom,0)
            when MOTP_DET = 'Sal' then -NVL(motp_valor_nom,0)
            else 0
         end) val_nom --1002       11/04/2024 Jmartinezm
     , motp_emision emision
     , motp_vcto vcto
     --, tbl_qgeneral.fn_codi_condpfmt('COD')  banc_prin antes 1002       11/04/2024 Jmartinezm
     , dist_banc banc_prin    -- 1002       11/04/2024 Jmartinezm
     , null estado
     --, sum(motp_vr_reci) val antes 1002       11/04/2024 Jmartinezm
     , (case
            when MOTP_DET = 'Ent' then min(motp_vr_reci)
            when MOTP_DET = 'Sal' then -min(motp_vr_reci)
            else 0
         end ) val --1002       11/04/2024 Jmartinezm
     --, sum(motp_vr_act) val_ajt antes 1001       22/01/2024 Jmartinezm
     , sum (case
            when MOTP_DET = 'Ent' then NVL(dist_val,0)
            when MOTP_DET = 'Sal' then -NVL(dist_val,0)
            else 0
         end) val_ajt --1002       11/04/2024 Jmartinezm
     , empr_descripcion
     , banc_descripcion
     , decode(UPPER(MOTP_DET), 'ENT', 'INGRESO', 'EGRESO')
     , motp_mandato mesa_mandato
  FROM tbl_tdistmovi
     , tbl_tmotporfin
     , tbl_tempresas
     , tbl_tbancos
 WHERE dist_motp = motp_motp
 AND   motp_empr = empr_empr
 --AND   banc_banc = tbl_qgeneral.fn_codi_condpfmt('COD') antes 1002       11/04/2024 Jmartinezm
 AND   banc_banc = dist_banc -- 1002       11/04/2024 Jmartinezm
-- ini 1003       15/08/2024 Jmartinezm                    
 AND EXISTS     ( select 1 
                     FROM TBL_TCDISTPFMT cd  
                     WHERE (motp_especie = cd.NAME_DIST OR motp_transac = cd.NAME_DIST)
                    AND cd.IS_CHECK = 'S'
                    AND cd.TYPE_DIST IN ('E', 'O'))   
-- fin 1003       15/08/2024 Jmartinezm  
 group by motp_empr,gen_qgeneral.id_lista_desc(motp_fuente),motp_transac 
,motp_especie,motp_ope_fecha,motp_consec,motp_nit,motp_contraparte,
motp_emision,motp_vcto,dist_banc,empr_descripcion 
, banc_descripcion,motp_det , motp_mandato
UNION ALL
--Consulta 2
--No Distribuidas
SELECT motm_empr empr 
     , gen_qgeneral.id_lista_desc(motm_fuente) origen
     , motm_operacion tipo_oper        
     , null especie
     , motm_fech_cump fecha 
     , motm_folio num_oper 
     , null num_ticket
     , motm_cod_contra nit
     , motm_desc_contra contraparte
     , motm_cod_trader id_trader
     , motm_desc_trader trader 
     , 0 val_nom
     , null emision
     , null vcto
     , tbl_qgeneral.fn_codi_condpfmt('COD')  banc_prin
     , motm_estado estado
     --, sum(motm_monto) val
     , sum(
         case
            when MOTM_OPERACION = 'VENTA' then NVL(motm_monto,0)
            when MOTM_OPERACION = 'COMPRA' then -NVL(motm_monto,0)
            else 0
         end
     ) val --1002       11/04/2024 Jmartinezm
     --, sum(motm_act) val_ajt
     , SUM(
         case
            when MOTM_OPERACION = 'VENTA' then NVL(motm_act,0)
            when MOTM_OPERACION = 'COMPRA' then -NVL(motm_act,0)
            else 0
         end
     )  val_ajt --1002       11/04/2024 Jmartinezm
     , empr_descripcion
     , banc_descripcion
     ,decode(UPPER(MOTM_OPERACION), 'COMPRA', 'EGRESO', 'INGRESO')
     ,motm_mandato mesa_mandato
  FROM tbl_tmotmitra
    ,  tbl_tempresas
    ,  tbl_tbancos
 WHERE motm_estado = 'OPE'
   AND motm_empr = empr_empr
   AND banc_banc = tbl_qgeneral.fn_codi_condpfmt('COD') 
   AND NOT EXISTS (SELECT dist_motm
                     FROM tbl_tdistmovi
                    WHERE dist_motm = motm_motm
                       )
-- ini 1003       15/08/2024 Jmartinezm                    
 AND EXISTS     ( select 1 
                     FROM TBL_TCDISTPFMT cd  
                     WHERE ( motm_operacion = cd.NAME_DIST)
                    AND cd.IS_CHECK = 'S'
                    AND cd.TYPE_DIST IN ('E', 'O'))   
-- fin 1003       15/08/2024 Jmartinezm                        
 group by motm_empr, gen_qgeneral.id_lista_desc(motm_fuente),motm_operacion,
motm_fech_cump,motm_folio, motm_cod_contra,motm_desc_contra,motm_cod_trader,
motm_desc_trader,tbl_qgeneral.fn_codi_condpfmt('COD'),motm_estado,empr_descripcion
, banc_descripcion,motm_operacion , motm_mandato
UNION ALL
--Distribuidas
SELECT motm_empr empr
     , gen_qgeneral.id_lista_desc(motm_fuente) origen
     , motm_operacion tipo_oper
     , null especie
     , motm_fech_cump fecha
     , motm_folio num_oper       
     , null num_ticket
     , motm_cod_contra nit
     , motm_desc_contra contraparte
     , motm_cod_trader id_trader
     , motm_desc_trader trader   
     , 0 val_nom
     , null emision
     , null vcto
     , dist_banc  banc_prin
     , motm_estado estado
     --, sum(motm_monto) val
     , sum(
         case
            when MOTM_OPERACION = 'VENTA' then NVL(motm_monto,0)
            when MOTM_OPERACION = 'COMPRA' then -NVL(motm_monto,0)
            else 0
         end
     ) val --1002       11/04/2024 Jmartinezm
     --, sum(dist_val) val_ajt
     , sum(
         case
            when MOTM_OPERACION = 'VENTA' then NVL(dist_val,0)
            when MOTM_OPERACION = 'COMPRA' then -NVL(dist_val,0)
            else 0
         end
     ) val_ajt --1002       11/04/2024 Jmartinezm
     , empr_descripcion
     , banc_descripcion
     ,decode(UPPER(MOTM_OPERACION), 'COMPRA', 'EGRESO', 'INGRESO')
     , motm_mandato mesa_mandato
  FROM tbl_tdistmovi
     , tbl_tmotmitra
    ,  tbl_tempresas
    ,  tbl_tbancos
 WHERE dist_motm   = motm_motm
   AND motm_empr = empr_empr
   AND banc_banc = dist_banc 
   AND motm_estado = 'OPE'
-- ini 1003       15/08/2024 Jmartinezm                    
 AND EXISTS     ( select 1 
                     FROM TBL_TCDISTPFMT cd  
                     WHERE ( motm_operacion = cd.NAME_DIST)
                    AND cd.IS_CHECK = 'S'
                    AND cd.TYPE_DIST IN ('E', 'O'))   
-- fin 1003       15/08/2024 Jmartinezm  
 group by motm_empr, gen_qgeneral.id_lista_desc(motm_fuente),motm_operacion,
motm_fech_cump,motm_folio, motm_cod_contra,motm_desc_contra,motm_cod_trader,
motm_desc_trader,dist_banc,motm_estado,empr_descripcion
, banc_descripcion,motm_operacion , motm_mandato
UNION ALL
SELECT empr_empr empr
      ,'INDIVIDUAL' origen
      ,list_descri tipo_oper
      ,null especie
      ,mesa_fecha fecha
      ,null num_oper
      ,mesa_ticket num_ticket
      ,null nit
      ,null contraparte
      ,null id_trader
      ,null trader
      ,0 val_nom
      ,null emision
      ,null vcto
      ,tbl_qgeneral.fn_codi_condpfmt('COD')  banc_prin
      ,'ACT' estado
      --,sum(mesa_valor) val
      , sum(
          case
            when MESA_OPER = (select list_list from gen_tlistas where list_modulo = 'TBL' and list_lista = 'TIPO_OPER' and list_sigla = 'I')
                 then NVL(mesa_valor,0)
            when MESA_OPER = (select list_list from gen_tlistas where list_modulo = 'TBL' and list_lista = 'TIPO_OPER' and list_sigla = 'E') 
                 then -NVL(mesa_valor,0)
            else 0
         end
      ) val --1002       11/04/2024 Jmartinezm
      --,sum(mesa_valor) val_ajt
      , sum(
          case
            when MESA_OPER = (select list_list from gen_tlistas where list_modulo = 'TBL' and list_lista = 'TIPO_OPER' and list_sigla = 'I')
                 then NVL(mesa_valor,0)
            when MESA_OPER = (select list_list from gen_tlistas where list_modulo = 'TBL' and list_lista = 'TIPO_OPER' and list_sigla = 'E') 
                 then -NVL(mesa_valor,0)
            else 0
         end
      ) val_ajt --1002       11/04/2024 Jmartinezm
      ,empr_descripcion
      ,banc_descripcion
      ,list_descri
      ,mesa_mandato mesa_mandato
 FROM tbl_tmesaoper
    ,  tbl_tempresas
    ,  tbl_tbancos
    ,  gen_tlistas
WHERE mesa_empr  = empr_empr
  AND NVL(mesa_banc, tbl_qgeneral.fn_codi_condpfmt('COD')) = banc_banc
  and list_list = mesa_oper
  AND NOT EXISTS (SELECT dist_motmd
                     FROM tbl_tdistmovi
                    WHERE dist_motmd = mesa_mesa
                       )
 group by empr_empr,mesa_descripcion,mesa_fecha,list_descri,mesa_ticket 
    ,tbl_qgeneral.fn_codi_condpfmt('COD'),empr_descripcion, banc_descripcion,
    list_descri ,mesa_mandato
UNION ALL
select empr_empr empr
      ,'INDIVIDUAL' origen
      ,list_descri tipo_oper
      ,null especie
      ,mesa_fecha fecha
      ,null num_oper
      ,mesa_ticket num_ticket
      ,null nit
      ,null contraparte
      ,null id_trader
      ,null trader
      ,0 val_nom
      ,null emision
      ,null vcto
      ,dist_banc  banc_prin
      ,'ACT' estado
      --,sum(mesa_valor) val
      , sum(
          case
            when MESA_OPER = (select list_list from gen_tlistas where list_modulo = 'TBL' and list_lista = 'TIPO_OPER' and list_sigla = 'I')
                 then NVL(mesa_valor,0)
            when MESA_OPER = (select list_list from gen_tlistas where list_modulo = 'TBL' and list_lista = 'TIPO_OPER' and list_sigla = 'E') 
                 then -NVL(mesa_valor,0)
            else 0
         end
      ) val --1002       11/04/2024 Jmartinezm
      --,sum(dist_val) val_ajt
      , sum(
          case
            when MESA_OPER = (select list_list from gen_tlistas where list_modulo = 'TBL' and list_lista = 'TIPO_OPER' and list_sigla = 'I')
                 then NVL(dist_val,0)
            when MESA_OPER = (select list_list from gen_tlistas where list_modulo = 'TBL' and list_lista = 'TIPO_OPER' and list_sigla = 'E') 
                 then -NVL(dist_val,0)
            else 0
         end
      ) val_ajt --1002       11/04/2024 Jmartinezm
      ,empr_descripcion
      ,banc_descripcion
      ,list_descri
      ,mesa_mandato mesa_mandato
 from tbl_tdistmovi
    , tbl_tmesaoper
    , tbl_tempresas
    , tbl_tbancos
    , gen_tlistas
WHERE mesa_empr  = empr_empr
  AND dist_banc = banc_banc
  and list_list = mesa_oper
  and dist_motmd = mesa_mesa
 group by empr_empr,mesa_descripcion,mesa_fecha,list_descri,mesa_ticket 
    ,dist_banc,empr_descripcion, banc_descripcion,
    list_descri ,mesa_mandato
/
--
COMMENT ON TABLE  tbl_vmesaoperconslt                   IS 'Vista que muestra la consulta de mesa';
COMMENT ON COLUMN tbl_vmesaoperconslt.empr              IS 'Código de la empresa EDGE';
COMMENT ON COLUMN tbl_vmesaoperconslt.origen            IS 'Origen';
COMMENT ON COLUMN tbl_vmesaoperconslt.tipo_oper         IS 'Tipo de la operación';
COMMENT ON COLUMN tbl_vmesaoperconslt.especie           IS 'Especie';
COMMENT ON COLUMN tbl_vmesaoperconslt.fecha             IS 'Fecha';
COMMENT ON COLUMN tbl_vmesaoperconslt.num_oper          IS 'Numero de operación';
COMMENT ON COLUMN tbl_vmesaoperconslt.num_ticket        IS 'Numero de ticket';
COMMENT ON COLUMN tbl_vmesaoperconslt.nit               IS 'NIT';
COMMENT ON COLUMN tbl_vmesaoperconslt.contraparte       IS 'Contraparte';
COMMENT ON COLUMN tbl_vmesaoperconslt.id_trader         IS 'Código de trader';
COMMENT ON COLUMN tbl_vmesaoperconslt.trader            IS 'Trader';
COMMENT ON COLUMN tbl_vmesaoperconslt.val_nom           IS 'Valor nominal';
COMMENT ON COLUMN tbl_vmesaoperconslt.emision           IS 'Fecha Emisión';
COMMENT ON COLUMN tbl_vmesaoperconslt.vcto              IS 'Fecha Vencimiento';
COMMENT ON COLUMN tbl_vmesaoperconslt.banc_prin         IS 'Código del banco';
COMMENT ON COLUMN tbl_vmesaoperconslt.estado            IS 'Estado';
COMMENT ON COLUMN tbl_vmesaoperconslt.val               IS 'Valor';
COMMENT ON COLUMN tbl_vmesaoperconslt.val_ajt           IS 'Valor Ajustado';
COMMENT ON COLUMN tbl_vmesaoperconslt.empr_descripcion  IS 'Descripción de la empresa';
COMMENT ON COLUMN tbl_vmesaoperconslt.naturaleza        IS 'Naturaleza';
COMMENT ON COLUMN tbl_vmesaoperconslt.mandato           IS 'Mandato';
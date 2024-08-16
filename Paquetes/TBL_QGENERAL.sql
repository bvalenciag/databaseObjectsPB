prompt
prompt PACKAGE: TBL_QGENERAL
prompt
create or replace PACKAGE tbl_qgeneral IS
--
-- Reúne funciones y procedimientos directamente relacionados con el procedimiento de generales de tablero de liquidez
--
-- #VERSION: 1002
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       25/10/2023 Cramirezs    000001       * Se crea paquete.
--                       Kilonova
-- ========== ========== ============ ============ ============================================================================================================
-- 1001       14/12/2023 cramirezs    000001       * Se crean funciones fn_recupera_motp, fn_sald_ini, fn_val_regi, fn_val_mesa, fn_sald_ccr, fn_sald_fin, 
--                       Kilonova     MVP_2          fn_sald_fin_rent, fn_codi_cond, fn_recupera_regi, fn_recupera_canc, fn_codi_condpfmt
-- ========== ========== ============ ============ ============================================================================================================
-- 1002       01/04/2024 Jmartinezm   000002       * Ajuste a fn_banc_rentabilidad, fn_val_rendi, fn_val_canc, fn_val_mesa
--                       Kilonova     MVP_2         
-- ========== ========== ============ ============ ============================================================================================================
-- 1004       26/06/2024 Jmartinezm   000003       * Nuevas funciones - cambios a fn_val_regi
--                       Kilonova     MVP_2         
-- ========== ========== ============ ============ ============================================================================================================
-- 1005       09/08/2024 Jmartinezm   000004       * Cambio a Funcion fn_val_regi
--                       Kilonova     MVP_3         
-- ========== ========== ============ ============ ============================================================================================================
--
vg_fech         DATE;
-------------------------------------------------------------------------------------------------
--Types
-------------------------------------------------------------------------------------------------
--
-------------------------------------------------------------------------------------------------
--Procedure - Function
-------------------------------------------------------------------------------------------------
--
FUNCTION recupera_empr(p_exte   tbl_tempresas.empr_externo%TYPE
                     , p_fuen   tbl_tempresas.empr_fuente%TYPE
                      )RETURN tbl_tempresas.empr_empr%TYPE;
--
-------------------------------------------------------------------------------------------------
--
FUNCTION recupera_banc(p_exte   tbl_tbancos.banc_externo%TYPE
                     , p_fuen   tbl_tbancos.banc_fuente%TYPE
                      )RETURN tbl_tbancos.banc_banc%TYPE;
--
-------------------------------------------------------------------------------------------------
--
FUNCTION recupera_cuen(p_empr      tbl_tcuentasban.cuen_empr%TYPE
                     , p_banc      tbl_tcuentasban.cuen_banc%TYPE
                     , p_nrocta    tbl_tcuentasban.cuen_nrocta%TYPE
                      )RETURN tbl_tcuentasban.cuen_cuen%TYPE;
--
-------------------------------------------------------------------------------------------------
--
FUNCTION recupera_movi(p_nrocom         tbl_tmoviteso.movi_nrocom%TYPE
                     , p_fecmov         tbl_tmoviteso.movi_fecmov%TYPE
                     , p_tpco           tbl_tmoviteso.movi_tpco%TYPE
                     , p_cias           tbl_tmoviteso.movi_cias%TYPE
                     , p_rengln         tbl_tmoviteso.movi_rengln%TYPE
                      )RETURN tbl_tmoviteso.movi_movi%TYPE;
--
-------------------------------------------------------------------------------------------------
--
FUNCTION recupera_sald(p_fecha          tbl_tsaldos_cta.sald_fecha%TYPE
                     , p_auxi           tbl_tsaldos_cta.sald_auxi%TYPE
                     , p_cias           tbl_tsaldos_cta.sald_cias%TYPE
                     , p_mayo           tbl_tsaldos_cta.sald_mayo%TYPE
                      )RETURN tbl_tsaldos_cta.sald_sald%TYPE;
--
--Ini 1001 14/12/2023 cramirezs
-------------------------------------------------------------------------------------------------
--
FUNCTION fn_recupera_motp(p_por         tbl_tmotporfin.motp_por   %TYPE
                        , p_consec      tbl_tmotporfin.motp_consec%TYPE
                        , p_fuen        tbl_tempresas.empr_fuente %TYPE
                       )RETURN tbl_tmotporfin.motp_motp%TYPE;
--
-------------------------------------------------------------------------------------------------
--
FUNCTION fn_recupera_motm(p_foli        tbl_tmotmitra.motm_folio   %TYPE
                        , p_fech        DATE
                        , p_fuen        tbl_tempresas.empr_fuente    %TYPE
                       )RETURN tbl_tmotmitra.motm_motm%TYPE;
--
-------------------------------------------------------------------------------------------------
--
FUNCTION fn_recupera_canc(p_canc     tbl_tcancelacio.canc_canc_ex%TYPE
                        , p_fond     tbl_tcancelacio.canc_fond_ex%TYPE
                        , p_fuen     tbl_tempresas.empr_fuente %TYPE
                       )RETURN tbl_tcancelacio.canc_canc%TYPE;
--
-------------------------------------------------------------------------------------------------
--
FUNCTION fn_recupera_regi(p_empr        tbl_tempresas.empr_empr%TYPE
                        , p_banc        tbl_tbancos.banc_banc%TYPE
                        , p_fech        DATE
                        , p_fuen        tbl_tempresas.empr_fuente%TYPE
                       )RETURN tbl_tmotporfin.motp_motp%TYPE;
--
-------------------------------------------------------------------------------------------------
--Fin 1001 14/12/2023 cramirezs
-------------------------------------------------------------------------------------------------
--
FUNCTION fn_sald_fech_banc(p_fecha          DATE
                         , p_empr           tbl_tcuentasban.cuen_empr%TYPE
                          )RETURN NUMBER;
--
-------------------------------------------------------------------------------------------------
--
FUNCTION fn_sald_fech(p_fecha          DATE
                    , p_cuen           tbl_tcuentasban.cuen_cuen%TYPE
                      )RETURN NUMBER;
--
-------------------------------------------------------------------------------------------------
--
PROCEDURE sp_set_fech(p_fech  DATE);
--
-------------------------------------------------------------------------------------------------
--
FUNCTION fn_get_fech RETURN DATE;
--
-------------------------------------------------------------------------------------------------
--
FUNCTION fn_banc_rentabilidad(p_empr    tbl_tempresas.empr_empr%TYPE
                            , p_banc    tbl_tbancos.banc_banc%TYPE
                            , p_fech    DATE DEFAULT NULL
                            , p_cuen    tbl_tcuentasban.cuen_cuen%TYPE DEFAULT NULL
                            )RETURN tbl_tcuentasban.cuen_tasa_ea%TYPE;
--
-------------------------------------------------------------------------------------------------
--
FUNCTION fn_tas_cuenban(p_empr    tbl_tempresas.empr_empr%TYPE
                      , p_banc    tbl_tbancos.banc_banc%TYPE
                        )RETURN tbl_tcuentasban.cuen_tasa_ea%TYPE;
--
-------------------------------------------------------------------------------------------------
--
FUNCTION fn_tas_rango(p_valor   NUMBER
                    , p_banc    tbl_tbancos.banc_banc%TYPE
                    , p_empr    tbl_tempresas.empr_empr%TYPE -- 1002       01/04/2024 Jmartinezm 
                        )RETURN tbl_trangostasa.rang_tasa_ea%TYPE;
--
-------------------------------------------------------------------------------------------------
--
FUNCTION fn_movi_dia(p_banc     tbl_tbancos.banc_banc%TYPE
                   , p_empr     tbl_tempresas.empr_empr%TYPE
                   , p_cuen     tbl_tcuentasban.cuen_cuen%TYPE
                   , p_fecha    DATE
                    )RETURN NUMBER;
--
--Ini 1001 14/12/2023 cramirezs
--
-------------------------------------------------------------------------------------------------
--
FUNCTION fn_sald_ini(p_empr tbl_tcuentasban.cuen_empr%TYPE
                   , p_banc tbl_tcuentasban.cuen_banc%TYPE
                   , p_cuen tbl_tcuentasban.cuen_cuen%TYPE
                   , p_fech DATE
                      )RETURN NUMBER;
--
-------------------------------------------------------------------------------------------------
--
FUNCTION fn_val_regi(p_empr tbl_tcuentasban.cuen_empr%TYPE
                   , p_banc tbl_tcuentasban.cuen_banc%TYPE
                   , p_cuen tbl_tcuentasban.cuen_cuen%TYPE
                   , p_fech DATE
                      )RETURN NUMBER;
--
-------------------------------------------------------------------------------------------------
FUNCTION fn_val_canc(p_empr tbl_tcuentasban.cuen_empr%TYPE
                   , p_banc tbl_tcuentasban.cuen_banc%TYPE
                   , p_cuen tbl_tcuentasban.cuen_cuen%TYPE
                   , p_fech DATE
                      )RETURN NUMBER;
--
-------------------------------------------------------------------------------------------------
--
FUNCTION fn_val_mesa(p_empr tbl_tcuentasban.cuen_empr%TYPE
                   , p_banc tbl_tcuentasban.cuen_banc%TYPE
                   , p_cuen tbl_tcuentasban.cuen_cuen%TYPE
                   , p_fech DATE
                      )RETURN NUMBER;
--
-------------------------------------------------------------------------------------------------
--
FUNCTION fn_sald_ccr(p_empr tbl_tcuentasban.cuen_empr%TYPE
                   , p_banc tbl_tcuentasban.cuen_banc%TYPE
                   , p_cuen tbl_tcuentasban.cuen_cuen%TYPE
                   , p_fech DATE
                      )RETURN NUMBER;
--
-------------------------------------------------------------------------------------------------
--
FUNCTION fn_sald_fin(p_empr tbl_tcuentasban.cuen_empr%TYPE
                   , p_banc tbl_tcuentasban.cuen_banc%TYPE
                   , p_fech DATE
                      )RETURN NUMBER;
--
-------------------------------------------------------------------------------------------------
--
FUNCTION fn_sald_fin_rent(p_empr tbl_tcuentasban.cuen_empr%TYPE
                        , p_banc tbl_tcuentasban.cuen_banc%TYPE
                        , p_fech DATE
                        )RETURN NUMBER;
--
-------------------------------------------------------------------------------------------------
--
FUNCTION fn_tasa_365(p_tasa_EA  NUMBER
                    )RETURN     NUMBER;
--
-------------------------------------------------------------------------------------------------
--
FUNCTION fn_val_rendi(p_sald    NUMBER
                    , p_tasa_EA NUMBER
                    )RETURN NUMBER;
--
-------------------------------------------------------------------------------------------------
--
FUNCTION fn_codi_cond(p_codi VARCHAR2
                      )RETURN NUMBER;
--
-------------------------------------------------------------------------------------------------
--
FUNCTION fn_codi_condpfmt(p_codi VARCHAR2
                      )RETURN NUMBER;
--
-------------------------------------------------------------------------------------------------
--Fin 1001 14/12/2023 cramirezs
-------------------------------------------------------------------------------------------------
-- ini 1003
FUNCTION fn_recupera_mandato(p_empr   tbl_tempresas.empr_empr%TYPE
                           , p_banc   tbl_tbancos.banc_banc%TYPE
                           , p_fech   DATE
                            )RETURN NUMBER;
--                            
-------------------------------------------------------------------------------------------------
--
FUNCTION fn_recupera_traslado(p_empr   tbl_tempresas.empr_empr%TYPE
                           , p_banc   tbl_tbancos.banc_banc%TYPE
                           , p_fech   DATE
                            )RETURN NUMBER;
--                            
-------------------------------------------------------------------------------------------------
--
FUNCTION fn_val_mesa_sebra( p_empr   tbl_tempresas.empr_empr%TYPE
                           , p_banc   tbl_tbancos.banc_banc%TYPE
                           , p_fech   DATE
                            )RETURN NUMBER;                      
--Fin 1003 
-------------------------------------------------------------------------------------------------
-- ini 1004
FUNCTION fn_val_sebra_fideicomiso( p_empr   tbl_tempresas.empr_empr%TYPE
                           , p_fech   DATE
                            )RETURN NUMBER;
--
-------------------------------------------------------------------------------------------------
--
FUNCTION fn_val_sebra_inversionistas( p_empr   tbl_tempresas.empr_empr%TYPE
                           , p_fech   DATE
                            )RETURN NUMBER;
--fin 1004                            
-------------------------------------------------------------------------------------------------                                                        
END tbl_qgeneral;
/
prompt
prompt PACKAGE BODY: tbl_qgeneral
prompt
--
create or replace PACKAGE BODY tbl_qgeneral IS
--
-- #VERSION: 1002
--
---------------------------------------------------------------------------------------------------
FUNCTION recupera_empr(p_exte   tbl_tempresas.empr_externo%TYPE
                     , p_fuen   tbl_tempresas.empr_fuente%TYPE
                      )RETURN tbl_tempresas.empr_empr%TYPE IS
    --
    v_valor     tbl_tempresas.empr_empr%TYPE;
    --
    CURSOR c_empr IS
        SELECT empr_empr
          FROM tbl_tempresas
         WHERE empr_externo = p_exte
           AND empr_fuente  = p_fuen
        ;
    --
BEGIN
    --
    v_valor := NULL;
    --
    OPEN  c_empr;
    FETCH c_empr INTO v_valor;
    IF c_empr%NOTFOUND THEN
        --
        v_valor := NULL;
        --
    END IF;
    CLOSE c_empr;
    --
    RETURN v_valor;
    --
EXCEPTION
    WHEN OTHERS THEN
        v_valor := NULL;
        RETURN v_valor;
END recupera_empr;
---------------------------------------------------------------------------------------------------
FUNCTION recupera_banc(p_exte   tbl_tbancos.banc_externo%TYPE
                     , p_fuen   tbl_tbancos.banc_fuente%TYPE
                      )RETURN tbl_tbancos.banc_banc%TYPE IS
    --
    v_valor     tbl_tbancos.banc_banc%TYPE;
    --
    CURSOR c_banc IS
        SELECT banc_banc
          FROM tbl_tbancos
         WHERE banc_externo = p_exte
           AND banc_fuente  = p_fuen
        ;
    --
BEGIN
    --
    v_valor := NULL;
    --
    OPEN  c_banc;
    FETCH c_banc INTO v_valor;
    IF c_banc%NOTFOUND THEN
        --
        v_valor := NULL;
        --
    END IF;
    CLOSE c_banc;
    --
    RETURN v_valor;
    --
EXCEPTION
    WHEN OTHERS THEN
        v_valor := NULL;
        RETURN v_valor;
END recupera_banc;
---------------------------------------------------------------------------------------------------
FUNCTION recupera_cuen(p_empr      tbl_tcuentasban.cuen_empr%TYPE
                     , p_banc      tbl_tcuentasban.cuen_banc%TYPE
                     , p_nrocta    tbl_tcuentasban.cuen_nrocta%TYPE
                      )RETURN tbl_tcuentasban.cuen_cuen%TYPE IS
    --
    v_valor     tbl_tcuentasban.cuen_cuen%TYPE;
    --
    CURSOR c_cuen IS
        SELECT cuen_cuen
          FROM tbl_tcuentasban
         WHERE cuen_nrocta = p_nrocta
           AND cuen_empr   = p_empr
           AND cuen_banc   = p_banc
        ;
    --
BEGIN
    --
    v_valor := NULL;
    --
    OPEN  c_cuen;
    FETCH c_cuen INTO v_valor;
    IF c_cuen%NOTFOUND THEN
        --
        v_valor := NULL;
        --
    END IF;
    CLOSE c_cuen;
    --
    RETURN v_valor;
    --
EXCEPTION
    WHEN OTHERS THEN
        v_valor := NULL;
        RETURN v_valor;
END recupera_cuen;
---------------------------------------------------------------------------------------------------
FUNCTION recupera_movi(p_nrocom     tbl_tmoviteso.movi_nrocom%TYPE
                     , p_fecmov     tbl_tmoviteso.movi_fecmov%TYPE
                     , p_tpco       tbl_tmoviteso.movi_tpco%TYPE
                     , p_cias       tbl_tmoviteso.movi_cias%TYPE
                     , p_rengln     tbl_tmoviteso.movi_rengln%TYPE
                      )RETURN tbl_tmoviteso.movi_movi%TYPE IS
    --
    v_valor     tbl_tmoviteso.movi_movi%TYPE;
    --
    CURSOR c_movi IS
        SELECT movi_movi
          FROM tbl_tmoviteso
         WHERE movi_nrocom  = p_nrocom
           AND movi_fecmov  = p_fecmov
           AND movi_tpco    = p_tpco
           AND movi_cias    = p_cias
           AND movi_rengln  = p_rengln
        ;
    --
BEGIN
    --
    v_valor := NULL;
    --
    OPEN  c_movi;
    FETCH c_movi INTO v_valor;
    IF c_movi%NOTFOUND THEN
        --
        v_valor := NULL;
        --
    END IF;
    CLOSE c_movi;
    --
    RETURN v_valor;
    --
EXCEPTION
    WHEN OTHERS THEN
        v_valor := NULL;
        RETURN v_valor;
END recupera_movi;
---------------------------------------------------------------------------------------------------
FUNCTION recupera_sald(p_fecha          tbl_tsaldos_cta.sald_fecha%TYPE
                     , p_auxi           tbl_tsaldos_cta.sald_auxi%TYPE
                     , p_cias           tbl_tsaldos_cta.sald_cias%TYPE
                     , p_mayo           tbl_tsaldos_cta.sald_mayo%TYPE
                      )RETURN tbl_tsaldos_cta.sald_sald%TYPE IS
    --
    v_valor     tbl_tsaldos_cta.sald_sald%TYPE;
    --
    CURSOR c_sald IS
        SELECT sald_sald
          FROM tbl_tsaldos_cta
         WHERE sald_fecha  = p_fecha
           AND sald_auxi   = p_auxi
           AND sald_cias   = p_cias
           AND sald_mayo   = p_mayo
        ;
    --
BEGIN
    --
    v_valor := NULL;
    --
    OPEN  c_sald;
    FETCH c_sald INTO v_valor;
    IF c_sald%NOTFOUND THEN
        --
        v_valor := NULL;
        --
    END IF;
    CLOSE c_sald;
    --
    RETURN v_valor;
    --
EXCEPTION
    WHEN OTHERS THEN
        v_valor := NULL;
        RETURN v_valor;
END recupera_sald;
--Ini 1001 14/12/2023 cramirezs
---------------------------------------------------------------------------------------------------
FUNCTION fn_recupera_motp(p_por         tbl_tmotporfin.motp_por   %TYPE
                        , p_consec      tbl_tmotporfin.motp_consec%TYPE
                        , p_fuen        tbl_tempresas.empr_fuente %TYPE
                       )RETURN tbl_tmotporfin.motp_motp%TYPE IS
    --
    v_valor     tbl_tmotporfin.motp_motp%TYPE;
    --
    CURSOR c_motp IS
        SELECT motp_motp
          FROM tbl_tmotporfin
         WHERE motp_por    = p_por
           AND motp_consec = p_consec
           AND motp_fuente = p_fuen
        ;
    --
BEGIN
    --
    v_valor := NULL;
    --
    OPEN  c_motp;
    FETCH c_motp INTO v_valor;
    IF c_motp%NOTFOUND THEN
        --
        v_valor := NULL;
        --
    END IF;
    CLOSE c_motp;
    --
    RETURN v_valor;
    --
EXCEPTION
    WHEN OTHERS THEN
        v_valor := NULL;
        RETURN v_valor;
END fn_recupera_motp;
--
FUNCTION fn_recupera_motm(p_foli        tbl_tmotmitra.motm_folio   %TYPE
                        , p_fech        DATE
                        , p_fuen        tbl_tempresas.empr_fuente    %TYPE
                       )RETURN tbl_tmotmitra.motm_motm%TYPE IS
    --
    v_valor     tbl_tmotmitra.motm_motm%TYPE;
    --
    CURSOR c_motm IS
        SELECT motm_motm
          FROM tbl_tmotmitra
         WHERE motm_folio      = p_foli
           AND motm_fech_cump  = p_fech
           AND motm_fuente     = p_fuen
        ;
    --
BEGIN
    --
    v_valor := NULL;
    --
    OPEN  c_motm;
    FETCH c_motm INTO v_valor;
    IF c_motm%NOTFOUND THEN
        --
        v_valor := NULL;
        --
    END IF;
    CLOSE c_motm;
    --
    RETURN v_valor;
    --
EXCEPTION
    WHEN OTHERS THEN
        v_valor := NULL;
        RETURN v_valor;
END fn_recupera_motm;
--
FUNCTION fn_recupera_canc(p_canc     tbl_tcancelacio.canc_canc_ex%TYPE
                        , p_fond     tbl_tcancelacio.canc_fond_ex%TYPE
                        , p_fuen     tbl_tempresas.empr_fuente %TYPE
                       )RETURN tbl_tcancelacio.canc_canc%TYPE IS
    --
    v_valor     tbl_tcancelacio.canc_canc%TYPE;
    --
    CURSOR c_canc IS
        SELECT canc_canc
          FROM tbl_tcancelacio
         WHERE canc_canc_ex = p_canc
           AND canc_fond_ex = p_fond
           AND canc_fuente  = p_fuen
        ;
    --
BEGIN
    --
    v_valor := NULL;
    --
    OPEN  c_canc;
    FETCH c_canc INTO v_valor;
    IF c_canc%NOTFOUND THEN
        --
        v_valor := NULL;
        --
    END IF;
    CLOSE c_canc;
    --
    RETURN v_valor;
    --
EXCEPTION
    WHEN OTHERS THEN
        v_valor := NULL;
        RETURN v_valor;
END fn_recupera_canc;
--
FUNCTION fn_recupera_regi(p_empr        tbl_tempresas.empr_empr%TYPE
                        , p_banc        tbl_tbancos.banc_banc%TYPE
                        , p_fech        DATE
                        , p_fuen        tbl_tempresas.empr_fuente%TYPE
                       )RETURN tbl_tmotporfin.motp_motp%TYPE IS
    --
    v_valor     tbl_tregionales.regi_regi%TYPE;
    --
    CURSOR c_regi IS
        SELECT regi_regi
          FROM tbl_tregionales
         WHERE regi_empr    = p_empr
           AND regi_fecha   = p_fech
           AND regi_fuente  = p_fuen
           AND regi_banc    = p_banc
        ;
    --
BEGIN
    --
    v_valor := NULL;
    --
    OPEN  c_regi;
    FETCH c_regi INTO v_valor;
    IF c_regi%NOTFOUND THEN
        --
        v_valor := NULL;
        --
    END IF;
    CLOSE c_regi;
    --
    RETURN v_valor;
    --
EXCEPTION
    WHEN OTHERS THEN
        v_valor := NULL;
        RETURN v_valor;
END fn_recupera_regi;
--Fin 1001 14/12/2023 cramirezs
---------------------------------------------------------------------------------------------------
FUNCTION fn_sald_fech(p_fecha          DATE
                    , p_cuen           tbl_tcuentasban.cuen_cuen%TYPE
                      )RETURN NUMBER IS
    --
    v_valor     NUMBER;
    --
    CURSOR c_movi IS
        SELECT SUM(movi_valor)
          FROM tbl_tmoviteso
         WHERE movi_cuen = p_cuen
           AND movi_fecha <= p_fecha
        ;
    --
BEGIN
    --
    v_valor := NULL;
    --
    OPEN  c_movi;
    FETCH c_movi INTO v_valor;
    IF c_movi%NOTFOUND THEN
        --
        v_valor := 0;
        --
    END IF;
    CLOSE c_movi;
    --
    RETURN v_valor;
    --
EXCEPTION
    WHEN OTHERS THEN
        v_valor := NULL;
        RETURN v_valor;
END fn_sald_fech;
---------------------------------------------------------------------------------------------------
FUNCTION fn_sald_fech_banc(p_fecha          DATE
                         , p_empr           tbl_tcuentasban.cuen_empr%TYPE
                          )RETURN NUMBER IS
    --
    v_valor     NUMBER;
    --
    CURSOR c_movi IS
        SELECT SUM(movi_valor)
          FROM tbl_tmoviteso
             , tbl_tcuentasban
         WHERE movi_cuen = cuen_cuen
           AND cuen_empr = p_empr
           AND movi_fecha <= p_fecha
        ;
    --
BEGIN
    --
    v_valor := NULL;
    --
    OPEN  c_movi;
    FETCH c_movi INTO v_valor;
    IF c_movi%NOTFOUND THEN
        --
        v_valor := 0;
        --
    END IF;
    CLOSE c_movi;
    --
    RETURN v_valor;
    --
EXCEPTION
    WHEN OTHERS THEN
        v_valor := NULL;
        RETURN v_valor;
END fn_sald_fech_banc;
---------------------------------------------------------------------------------------------------
PROCEDURE sp_set_fech(p_fech  DATE) IS
    --
BEGIN
    --
    gen_pseguimiento('set_fech: '||p_fech);
    vg_fech    := p_fech;
    --
END sp_set_fech;
---------------------------------------------------------------------------------------------------
FUNCTION fn_get_fech RETURN DATE IS
    --
BEGIN
    --
    gen_pseguimiento('get_fech: '||vg_fech);
    RETURN vg_fech;
    --
END fn_get_fech;
---------------------------------------------------------------------------------------------------
FUNCTION fn_banc_rentabilidad(p_empr    tbl_tempresas.empr_empr%TYPE
                            , p_banc    tbl_tbancos.banc_banc%TYPE
                            , p_fech    DATE DEFAULT NULL
                            , p_cuen    tbl_tcuentasban.cuen_cuen%TYPE DEFAULT NULL
                            )RETURN tbl_tcuentasban.cuen_tasa_ea%TYPE IS
    --
    v_valor     tbl_tcuentasban.cuen_tasa_ea%TYPE;
    --
    CURSOR c_banc IS
        SELECT banc_tipo_tasa
             , banc_rangos
             , banc_tasa_agru -- 1002       01/04/2024 Jmartinezm 
          FROM tbl_tbancos
         WHERE banc_banc = p_banc
        ;
    --
    r_banc      c_banc%ROWTYPE;
    v_ty_msg    gen_qgeneral.ty_msg;
    v_tipo      gen_tmensajes.mens_tipo%TYPE;
    v_campo1    VARCHAR2(200);
    v_campo2    VARCHAR2(200);
    e_error     EXCEPTION;
    --
    CURSOR c_cuen IS
        --SELECT (SUM(NVL(sald_valor_act, sald_valor))) + NVL(tbl_qgeneral.fn_movi_dia(cuen_banc, cuen_empr, cuen_cuen, sald_fecha), 0) sald antes 1002 01/04/2024 Jmartinezm
        select nvl(tbl_qgeneral.fn_sald_fin(p_empr,p_banc,p_fech),0) sald --1002 01/04/2024 Jmartinezm
          FROM tbl_tcuentasban
             , tbl_tsaldos_cta
         WHERE cuen_cuen = sald_cuen
           AND cuen_banc = p_banc
           AND cuen_empr = p_empr --1002 01/04/2024 Jmartinezm
           AND cuen_sincroniza = 'S'
           AND sald_fecha = NVL(p_fech, tbl_qgeneral.fn_get_fech)
           AND NVL(cuen_cuen, -1) = NVL(p_cuen, NVL(cuen_cuen, -1)) -- 1002       01/04/2024 Jmartinezm 
           --AND sald_fecha = NVL(p_fech, to_date('16/11/2023', 'dd/mm/yyyy'))
        GROUP BY cuen_banc
               --, cuen_cuen antes 1002 01/04/2024 Jmartinezm
               , sald_fecha
               , cuen_empr
        ;
    --
    r_cuen      c_cuen%ROWTYPE;
    --
    CURSOR c_cuen_ind IS
        --SELECT (SUM(NVL(sald_valor_act, sald_valor))) + NVL(tbl_qgeneral.fn_movi_dia(cuen_banc, cuen_empr, cuen_cuen, sald_fecha), 0) sald antes 1002 01/04/2024 Jmartinezm
        SELECT  nvl(tbl_qgeneral.fn_sald_fin(p_empr,p_banc,p_fech),0) sald --1002 01/04/2024 Jmartinezm
          FROM tbl_tcuentasban
             , tbl_tsaldos_cta
         WHERE cuen_cuen = sald_cuen
           AND cuen_banc = p_banc
           AND cuen_empr = p_empr
           AND cuen_sincroniza = 'S'
           AND NVL(cuen_cuen, -1) = NVL(p_cuen, NVL(cuen_cuen, -1)) -- 1002       01/04/2024 Jmartinezm 
           AND sald_fecha = NVL(p_fech, tbl_qgeneral.fn_get_fech)
           --AND sald_fecha = NVL(p_fech, to_date('16/11/2023', 'dd/mm/yyyy'))
        GROUP BY cuen_banc
               --, cuen_cuen antes 1002 01/04/2024 Jmartinezm
               , sald_fecha
               , cuen_empr
        ;
    --
    r_cuen_ind      c_cuen_ind%ROWTYPE;
    v_sald          NUMBER;
    --
BEGIN
    --
    v_valor := NULL;
    --
    OPEN  c_banc;
    FETCH c_banc INTO r_banc;
    IF c_banc%NOTFOUND THEN
        CLOSE c_banc;
        v_campo1 := p_banc;
        v_ty_msg.cod_msg := 'ER_CD_NOEX';--Error código de banco {campo1} no existe.
        raise e_error;
    END IF;
    CLOSE c_banc;
    --
    --Tipo Tasa I-individual y NO maneja Rangos
    IF r_banc.banc_tipo_tasa = 'I' AND r_banc.banc_rangos = 'N' THEN
        --
        v_valor := tbl_qgeneral.fn_tas_cuenban(p_empr, p_banc);
        --
    --Tipo Tasa I-Individual y maneja Rangos
    ELSIF r_banc.banc_tipo_tasa = 'I' AND r_banc.banc_rangos = 'S' THEN
        --
        v_sald := 0;
        FOR i IN c_cuen_ind LOOP
            --
            v_sald := v_sald + i.sald;
            --
        END LOOP c_cuen_ind;
        --
        --v_valor := tbl_qgeneral.fn_tas_rango(v_sald, p_banc); antes 1002       01/04/2024 Jmartinezm  
        v_valor := tbl_qgeneral.fn_tas_rango(v_sald, p_banc, p_empr); -- 1002       01/04/2024 Jmartinezm 
        --
    --Tipo Tasa A-Agrupada y maneja Rangos
    ELSIF r_banc.banc_tipo_tasa = 'A' AND r_banc.banc_rangos = 'S' THEN
        --
        v_sald := 0;
        FOR i IN c_cuen LOOP
            --
            v_sald := v_sald + i.sald;
            --
        END LOOP c_cuen;
        --
        --v_valor := tbl_qgeneral.fn_tas_rango(v_sald, p_banc); antes -- 1002       01/04/2024 Jmartinezm 
        v_valor := tbl_qgeneral.fn_tas_rango(v_sald, p_banc, NULL); -- 1002       01/04/2024 Jmartinezm 
        --
    ELSE
        --
        v_valor := NVL(r_banc.banc_tasa_agru,0); -- 1002       01/04/2024 Jmartinezm 
        --
    END IF;
    --
    RETURN v_valor;
    --
EXCEPTION
    WHEN e_error THEN
        --
        v_ty_msg.msg_msg := gen_fmensajes(v_ty_msg.cod_msg, v_tipo);
        IF v_campo1 IS NOT NULL THEN
            --
            v_ty_msg.msg_msg := REPLACE(v_ty_msg.msg_msg, '{campo1}', v_campo1);
            --
        END IF;
        --
        Raise_application_error(-20512, v_ty_msg.msg_msg);
        --
    WHEN OTHERS THEN
        --
        v_ty_msg.cod_msg := 'ER_NO_CTRL';--Error no controlado, {campo1}:  {campo2}.
        v_ty_msg.msg_msg := gen_fmensajes(v_ty_msg.cod_msg, v_tipo);
            --
        v_campo1 := 'fn_banc_rentabilidad';
        v_campo2 := SUBSTR(SQLERRM, 1, 170);
        v_ty_msg.msg_msg := REPLACE(v_ty_msg.msg_msg, '{campo1}', v_campo1);
        v_ty_msg.msg_msg := REPLACE(v_ty_msg.msg_msg, '{campo2}', v_campo2);
        --
        Raise_application_error(-20512, v_ty_msg.msg_msg);
END fn_banc_rentabilidad;
---------------------------------------------------------------------------------------------------
FUNCTION fn_tas_cuenban(p_empr    tbl_tempresas.empr_empr%TYPE
                      , p_banc    tbl_tbancos.banc_banc%TYPE
                        )RETURN tbl_tcuentasban.cuen_tasa_ea%TYPE IS
    --
    v_valor     tbl_tcuentasban.cuen_tasa_ea%TYPE;
    --
    CURSOR c_cuen IS
        SELECT cuen_tasa_ea
          FROM tbl_tcuentasban
         WHERE cuen_banc = p_banc
           AND cuen_empr = p_empr
           --AND cuen_sincroniza = 'S'--Antes 1001 14/12/2023 cramirezs
           AND cuen_tasa_ea IS NOT NULL
        ;
    --
    r_cuen      c_cuen%ROWTYPE;
    --
BEGIN
    --
    v_valor := NULL;
    --
    OPEN  c_cuen;
    FETCH c_cuen INTO v_valor;
    CLOSE c_cuen;
    --
    RETURN v_valor;
    --
END fn_tas_cuenban;
---------------------------------------------------------------------------------------------------
FUNCTION fn_tas_rango(p_valor   NUMBER
                    , p_banc    tbl_tbancos.banc_banc%TYPE
                    , p_empr    tbl_tempresas.empr_empr%TYPE -- 1002       01/04/2024 Jmartinezm 
                        )RETURN tbl_trangostasa.rang_tasa_ea%TYPE IS
    --
    v_valor     tbl_trangostasa.rang_tasa_ea%TYPE;
    --
    CURSOR c_rang IS
        SELECT rang_tasa_ea
          FROM tbl_trangostasa
         WHERE rang_banc = p_banc
           AND NVL(rang_empr, -1) = NVL(p_empr, NVL(rang_empr, -1)) -- 1002       01/04/2024 Jmartinezm 
           AND p_valor BETWEEN rang_val_ini AND rang_val_fin
        ;
    --
    r_rang      c_rang%ROWTYPE;
    --
BEGIN
    --
    v_valor := NULL;
    --
    OPEN  c_rang;
    FETCH c_rang INTO v_valor;
    IF c_rang%NOTFOUND THEN
        --
        v_valor := 0;
        --
    END IF;
    CLOSE c_rang;
    --
    RETURN v_valor;
    --
END fn_tas_rango;
---------------------------------------------------------------------------------------------------
FUNCTION fn_movi_dia(p_banc     tbl_tbancos.banc_banc%TYPE
                   , p_empr     tbl_tempresas.empr_empr%TYPE
                   , p_cuen     tbl_tcuentasban.cuen_cuen%TYPE
                   , p_fecha    DATE
                    )RETURN NUMBER IS
    --
    v_valor     tbl_trangostasa.rang_tasa_ea%TYPE;
    --
    CURSOR c_movi IS
        SELECT SUM(movi_valor)
          FROM tbl_tmoviteso
             , tbl_tcuentasban
         WHERE movi_cuen  = cuen_cuen
           AND cuen_banc  = p_banc
           AND movi_cuen  = NVL(p_cuen, movi_cuen)
           AND movi_fecha = p_fecha
           AND cuen_sincroniza = 'S'
           AND cuen_empr = p_empr
        ;
    --
    r_movi      c_movi%ROWTYPE;
    --
BEGIN
    --
    v_valor := NULL;
    --
    OPEN  c_movi;
    FETCH c_movi INTO v_valor;
    IF c_movi%NOTFOUND THEN
        --
        v_valor := 0;
        --
    END IF;
    CLOSE c_movi;
    --
    RETURN v_valor;
    --
END fn_movi_dia;
---------------------------------------------------------------------------------------------------
--Ini 1001 14/12/2023 cramirezs
FUNCTION fn_sald_ini(p_empr tbl_tcuentasban.cuen_empr%TYPE
                   , p_banc tbl_tcuentasban.cuen_banc%TYPE
                   , p_cuen tbl_tcuentasban.cuen_cuen%TYPE
                   , p_fech DATE
                      )RETURN NUMBER IS
    --
    v_valor      NUMBER;
    --
    CURSOR c_sald IS
        SELECT SUM(NVL(sald_valor_act, sald_valor)) sald_valor
          FROM tbl_tsaldos_cta
             , tbl_tcuentasban
         WHERE sald_cuen  = cuen_cuen
           AND cuen_empr  = p_empr
           AND cuen_banc  = p_banc
           AND sald_cuen  = NVL(p_cuen, sald_cuen)
           AND sald_fecha = p_fech
        ;
    --
BEGIN
    --
    v_valor := NULL;
    --
    OPEN  c_sald;
    FETCH c_sald INTO v_valor;
    IF c_sald%NOTFOUND THEN
        --
        v_valor := 0;
        --
    END IF;
    CLOSE c_sald;
    --
    RETURN v_valor;
    --
END fn_sald_ini;
---------------------------------------------------------------------------------------------------
FUNCTION fn_val_regi(p_empr tbl_tcuentasban.cuen_empr%TYPE
                   , p_banc tbl_tcuentasban.cuen_banc%TYPE
                   , p_cuen tbl_tcuentasban.cuen_cuen%TYPE
                   , p_fech DATE
                      )RETURN NUMBER IS
    --
    v_valor      NUMBER;
    --
    CURSOR c_regi IS
        SELECT   NVL(SUM(NVL(regi_adic_reales, 0)), 0)
               - NVL(SUM(NVL(regi_reti_reales, 0)), 0) 
          FROM tbl_tregionales
         WHERE regi_empr  = p_empr
           AND regi_banc  = p_banc
           AND regi_fecha = p_fech
        ;
    --
    v_regi  NUMBER;
    --
    CURSOR c_biza IS
        SELECT NVL(DECODE(motb_tipo_oper, 'EGRESO', (SUM(NVL(motb_valor, 0))),0 ), 0)
             - NVL(DECODE(motb_tipo_oper, 'APORTE', (SUM(NVL(motb_valor, 0))),0 ), 0)
          FROM tbl_tmotbbiza
         WHERE motb_empr  = p_empr
           AND motb_banc  = p_banc
           AND motb_fecha = p_fech
           AND motb_esta  = 'REG'
           AND motb_tipo_oper IN ('EGRESO', 'APORTE')
        GROUP BY motb_tipo_oper
        ;
    --
    v_biza  NUMBER;
    --1004 26/06/2024 Jmartinezm
    /*
    CURSOR c_sebra IS
        SELECT  SUM(NVL(mt.movi_valor,0))
          FROM tbl_tempxmand em
            LEFT join tbl_tmoviteso mt on mt.movi_encargo = em.empx_encargo
            LEFT join tbl_tcuentasban cb on mt.movi_cuen = cb.cuen_cuen
         WHERE cb.cuen_sebra is not null
          AND em.empx_empr = p_empr
          AND mt.movi_fecha = p_fech
          AND p_banc = tbl_qgeneral.fn_codi_condpfmt('COD')
        ;
    --
    v_sebra  NUMBER;*/
    --
    --1005 09/08/2024     Jmartinezm
    CURSOR c_provision IS
        SELECT   NVL(SUM(NVL(prov_valor, 0)), 0) 
          FROM tbl_tprovisiones
         WHERE prov_empr   = p_empr
           AND prov_banc   = p_banc
           AND prov_fecins = p_fech
        ;
    --
    v_provision  NUMBER;
BEGIN
    --
    v_valor := NULL;
    --
    --Ingresos reales + egresos reales
    OPEN  c_regi;
    FETCH c_regi INTO v_regi;
    IF c_regi%NOTFOUND THEN
        --
        v_regi := 0;
        --
    END IF;
    CLOSE c_regi;
    --
    --Aportes bizagi + egresos bizagi
    OPEN  c_biza;
    FETCH c_biza INTO v_biza;
    IF c_biza%NOTFOUND THEN
        --
        v_biza := 0;
        --
    END IF;
    CLOSE c_biza;
    --
    --Aportes Sebra
    --1004 26/06/2024 Jmartinezm
    /*
    OPEN  c_sebra;
    FETCH c_sebra INTO v_sebra;
    IF c_sebra%NOTFOUND THEN
        --
        v_sebra := 0;
        --
    END IF;
    CLOSE c_sebra; */
    --Otras fuentes, provisiones
    --1005 09/08/2024 Jmartinezm
    OPEN  c_provision;
    FETCH c_provision INTO v_provision;
    IF c_provision%NOTFOUND THEN
        --
        v_provision := 0;
        --
    END IF;
    CLOSE c_provision;    
    --
    v_valor := NVL(v_regi, 0) + NVL(v_biza, 0)  + NVL(v_provision, 0); --NVL((-1*v_sebra),0)
    --
    RETURN v_valor;
    --
END fn_val_regi;
---------------------------------------------------------------------------------------------------
FUNCTION fn_val_canc(p_empr tbl_tcuentasban.cuen_empr%TYPE
                   , p_banc tbl_tcuentasban.cuen_banc%TYPE
                   , p_cuen tbl_tcuentasban.cuen_cuen%TYPE
                   , p_fech DATE
                      )RETURN NUMBER IS
    --
    v_valor      NUMBER;
    --
    CURSOR c_canc IS
        --SELECT sum(canc_vlr_canc - canc_vlr_gmf)  antes 1002 01/04/2024 Jmartinezm
        SELECT sum(nvl(canc_vlr_canc,0) - nvl(canc_vlr_gmf,0)) --1002 01/04/2024 Jmartinezm
          FROM tbl_tcancelacio 
         WHERE canc_empr    = p_empr
           AND canc_fecha   = p_fech
           and tbl_qgeneral.fn_codi_cond('CANCE') = p_banc
        ;
    --
    v_canc  NUMBER;
    --
BEGIN
    --
    v_valor := NULL;
    --
    --Cancelaciones
    OPEN  c_canc;
    FETCH c_canc INTO v_canc;
    IF c_canc%NOTFOUND THEN
        --
        v_canc := 0;
        --
    END IF;
    CLOSE c_canc;
    --
    v_valor := NVL(v_canc, 0);
    --
    RETURN v_valor;
    --
END fn_val_canc;
---------------------------------------------------------------------------------------------------
FUNCTION fn_val_mesa(p_empr tbl_tcuentasban.cuen_empr%TYPE
                   , p_banc tbl_tcuentasban.cuen_banc%TYPE
                   , p_cuen tbl_tcuentasban.cuen_cuen%TYPE
                   , p_fech DATE
                      )RETURN NUMBER IS
    --
    v_valor      NUMBER;
    --
    CURSOR c_motp IS
        SELECT NVL(SUM(NVL(motp_vr, 0)), 0)  tot_porfin
          FROM (--No distribuidas
                SELECT motp_empr                            
                     , motp_ope_fecha                       
                     , tbl_qgeneral.fn_codi_condpfmt('COD')   motp_banc--Se recupera el banco de intervención
                     --, SUM(NVL(motp_vr_act, motp_vr_reci)) motp_vr antes 1002 01/04/2024 Jmartinezm
                     , SUM(
                         CASE 
                            WHEN motp_det = 'Ent' THEN NVL(motp_vr_act, motp_vr_reci)
                            WHEN motp_det = 'Sal'  THEN -NVL(motp_vr_act, motp_vr_reci)
                            ELSE 0
                         END
                     ) motp_vr --1002 01/04/2024 Jmartinezm
                  FROM tbl_tmotporfin
                 WHERE NOT EXISTS (SELECT dist_motp
                                     FROM tbl_tdistmovi
                                    WHERE dist_motp = motp_motp
                                       )
                GROUP BY motp_empr
                       , motp_ope_fecha
                UNION ALL 
                --Distribuidas
                SELECT motp_empr
                     , motp_ope_fecha
                     , dist_banc
                     --, SUM(NVL(dist_val, 0))  antes 1002 01/04/2024 Jmartinezm
                     , SUM(
                         CASE 
                            WHEN motp_det = 'Ent' THEN NVL(dist_val, 0)
                            WHEN motp_det = 'Sal'  THEN -NVL(dist_val, 0)
                            ELSE 0
                         END
                     )  -- 1002 01/04/2024 Jmartinezm
                  FROM tbl_tdistmovi
                     , tbl_tmotporfin
                 WHERE dist_motp = motp_motp
                GROUP BY motp_empr
                       , motp_ope_fecha
                       , dist_banc
                ) motp 
         WHERE motp_empr      = p_empr
           AND motp_banc      = p_banc
           AND motp_ope_fecha = p_fech
        ;
    --
    v_motp      NUMBER;
    --
    CURSOR c_motm IS
        SELECT NVL(SUM(NVL(motm_vr, 0)), 0)  tot_mitra
          FROM (--No distribuidas
                SELECT motm_empr                            
                     , motm_fech_cump                       
                     , tbl_qgeneral.fn_codi_condpfmt('COD')   motm_banc--Se recupera el banco de intervención
                     --, SUM(NVL(motm_act, motm_monto)) motm_vr antes 1002 01/04/2024 Jmartinezm
                     , SUM(
                         CASE
                            WHEN motm_operacion = 'COMPRA' THEN NVL(motm_act, motm_monto)
                            WHEN motm_operacion = 'VENTA'  THEN -NVL(motm_act, motm_monto)
                            ELSE 0
                         END
                     ) motm_vr -- 1002 01/04/2024 Jmartinezm
                  FROM tbl_tmotmitra
                 WHERE motm_estado = 'OPE'
                   AND NOT EXISTS (SELECT dist_motm
                                     FROM tbl_tdistmovi
                                    WHERE dist_motm = motm_motm
                                       )
                GROUP BY motm_empr
                       , motm_fech_cump
                UNION ALL 
                --Distribuidas
                SELECT motm_empr
                     , motm_fech_cump
                     , dist_banc
                     --, SUM(NVL(dist_val, 0)) antes 1002 01/04/2024 Jmartinezm
                     , SUM(
                         CASE
                            WHEN motm_operacion = 'COMPRA' THEN NVL(dist_val, 0)
                            WHEN motm_operacion = 'VENTA'  THEN -NVL(dist_val, 0)
                            ELSE 0
                         END
                     ) -- 1002 01/04/2024 Jmartinezm
                  FROM tbl_tdistmovi
                     , tbl_tmotmitra
                 WHERE dist_motm   = motm_motm
                   AND motm_estado = 'OPE'
                GROUP BY motm_empr
                       , motm_fech_cump
                       , dist_banc
                ) motm 
         WHERE motm_empr      = p_empr
           AND motm_banc      = p_banc
           AND motm_fech_cump = p_fech
        ;
    --
    v_motm      NUMBER;
    --
    CURSOR c_mesa IS 
    /*
        SELECT SUM(NVL(mesa_valor, 0))
          FROM tbl_tmesaoper
         WHERE mesa_empr  = p_empr
           AND NVL(mesa_banc, tbl_qgeneral.fn_codi_condpfmt('COD')) = p_banc
           AND mesa_fecha = p_fech
     antes 1002 01/04/2024 Jmartinezm */
        -- ini  1002 01/04/2024 Jmartinezm
        SELECT NVL(SUM(NVL(mesa_vr, 0)), 0) mesa_vr
          FROM (--No distribuidas
                SELECT mesa_empr
                     , mesa_fecha
                     , tbl_qgeneral.fn_codi_condpfmt('COD') mesa_banc
                     --,SUM(NVL(mesa_valor, 0)) mesa_vr
                     ,SUM(
                         CASE
                            WHEN mesa_oper = (select list_list from gen_tlistas where list_modulo = 'TBL' and list_lista = 'TIPO_OPER' and list_sigla = 'I') 
                                THEN NVL(mesa_valor, 0)
                            WHEN mesa_oper = (select list_list from gen_tlistas where list_modulo = 'TBL' and list_lista = 'TIPO_OPER' and list_sigla = 'E') 
                                THEN -NVL(mesa_valor, 0)
                            ELSE 0
                         END
                     ) mesa_vr
                  FROM tbl_tmesaoper
                 WHERE mesa_empr  = p_empr
                   AND NVL(mesa_banc, tbl_qgeneral.fn_codi_condpfmt('COD')) = p_banc
                   AND mesa_fecha = p_fech
                   AND NOT EXISTS (SELECT dist_motmd
                                     FROM tbl_tdistmovi
                                    WHERE DIST_MOTMD = mesa_mesa
                                       )
                GROUP BY mesa_empr
                       , mesa_fecha
                UNION ALL 
                --Distribuidas
                SELECT mesa_empr
                     , mesa_fecha
                     , dist_banc mesa_banc
                     --, SUM(NVL(dist_val, 0)) mesa_vr
                     , SUM(
                         CASE
                            WHEN mesa_oper = (select list_list from gen_tlistas where list_modulo = 'TBL' and list_lista = 'TIPO_OPER' and list_sigla = 'I') 
                                THEN NVL(dist_val, 0)
                            WHEN mesa_oper = (select list_list from gen_tlistas where list_modulo = 'TBL' and list_lista = 'TIPO_OPER' and list_sigla = 'E') 
                                THEN -NVL(dist_val, 0)
                            ELSE 0
                         END
                     ) mesa_vr
                  FROM tbl_tdistmovi
                     , tbl_tmesaoper
                 WHERE DIST_MOTMD = mesa_mesa
                 GROUP BY mesa_empr
                       , mesa_fecha
                       , dist_banc
                ) mesa 
         WHERE mesa_empr      = p_empr
           AND mesa_banc      = p_banc
           AND mesa_fecha     = p_fech 
           -- fin  1002 01/04/2024 Jmartinezm    
        ;
    --
    v_mesa      NUMBER;
    --
BEGIN
    --
    v_valor := NULL;
    --
    OPEN  c_motp;
    FETCH c_motp INTO v_motp;
    IF c_motp%NOTFOUND THEN
        --
        v_motp := 0;
        --
    END IF;
    CLOSE c_motp;
    --
    OPEN  c_motm;
    FETCH c_motm INTO v_motm;
    IF c_motm%NOTFOUND THEN
        --
        v_motm := 0;
        --
    END IF;
    CLOSE c_motm;
    --
    OPEN  c_mesa;
    FETCH c_mesa INTO v_mesa;
    IF c_mesa%NOTFOUND THEN
        --
        v_mesa := 0;
        --
    END IF;
    CLOSE c_mesa;
    --
    GEN_PSEGUIMIENTO('fn_val_mesa p_empr: '||p_empr
                    ||' p_banc: '||p_banc
                    ||' p_cuen: '||p_cuen
                    ||' p_fech: '||p_fech
                    ||' v_motp: '||v_motp
                    ||' v_motm: '||v_motm
                    ||' v_mesa: '||v_mesa
                    );
    v_valor := NVL(v_motp, 0) + NVL(v_motm, 0) + NVL(v_mesa, 0);
    --
    RETURN v_valor;
    --
END fn_val_mesa;
---------------------------------------------------------------------------------------------------
FUNCTION fn_sald_ccr(p_empr tbl_tcuentasban.cuen_empr%TYPE
                   , p_banc tbl_tcuentasban.cuen_banc%TYPE
                   , p_cuen tbl_tcuentasban.cuen_cuen%TYPE
                   , p_fech DATE
                      )RETURN NUMBER IS
    --
    v_valor      NUMBER;
    --
    CURSOR c_sald IS
        SELECT SUM(NVL(cuen_sldmincor, 0)) sald_valor
          FROM tbl_tcuentasban
         WHERE cuen_empr  = p_empr
           AND cuen_banc  = p_banc
           AND cuen_cuen  = NVL(p_cuen, cuen_cuen)
           --AND sald_fecha = p_fech
        ;
    --
BEGIN
    --
    v_valor := NULL;
    --
    OPEN  c_sald;
    FETCH c_sald INTO v_valor;
    IF c_sald%NOTFOUND THEN
        --
        v_valor := 0;
        --
    END IF;
    CLOSE c_sald;
    --
    RETURN v_valor;
    --
END fn_sald_ccr;
---------------------------------------------------------------------------------------------------
FUNCTION fn_sald_fin(p_empr tbl_tcuentasban.cuen_empr%TYPE
                   , p_banc tbl_tcuentasban.cuen_banc%TYPE
                   , p_fech DATE
                      )RETURN NUMBER IS
    --
    v_valor      NUMBER;
    --
BEGIN
    --
    v_valor := NULL;
    --
    v_valor := tbl_qgeneral.fn_sald_ini(p_empr => p_empr
                                      , p_banc => p_banc
                                      , p_cuen => NULL
                                      , p_fech => p_fech
                                       )
             + tbl_qgeneral.fn_val_regi(p_empr => p_empr
                                      , p_banc => p_banc
                                      , p_cuen => NULL
                                      , p_fech => p_fech
                            )
             + tbl_qgeneral.fn_val_mesa(p_empr => p_empr
                                      , p_banc => p_banc
                                      , p_cuen => NULL
                                      , p_fech => p_fech
                                        )
                ;
    --
    RETURN v_valor;
    --
END fn_sald_fin;
---------------------------------------------------------------------------------------------------
FUNCTION fn_sald_fin_rent(p_empr tbl_tcuentasban.cuen_empr%TYPE
                        , p_banc tbl_tcuentasban.cuen_banc%TYPE
                        , p_fech DATE
                        )RETURN NUMBER IS
    --
    v_valor      NUMBER;
    --
BEGIN
    --
    v_valor := NULL;
    --
    v_valor := (
               tbl_qgeneral.fn_sald_ini(p_empr => p_empr
                                      , p_banc => p_banc
                                      , p_cuen => NULL
                                      , p_fech => p_fech
                                       )
             + tbl_qgeneral.fn_val_regi(p_empr => p_empr
                                      , p_banc => p_banc
                                      , p_cuen => NULL
                                      , p_fech => p_fech
                            )
             + tbl_qgeneral.fn_val_mesa(p_empr => p_empr
                                      , p_banc => p_banc
                                      , p_cuen => NULL
                                      , p_fech => p_fech
                                        )
                ) -
                tbl_qgeneral.fn_sald_ccr(p_empr => p_empr
                                       , p_banc => p_banc
                                       , p_cuen => NULL
                                       , p_fech => p_fech
                                        )
                ;
    --
    RETURN v_valor;
    --
END fn_sald_fin_rent;
---------------------------------------------------------------------------------------------------
FUNCTION fn_tasa_365(p_tasa_EA NUMBER
                    )RETURN NUMBER IS
    --
    v_valor      NUMBER;
    --
BEGIN
    --
    v_valor := NULL;
    --
    v_valor := ((POWER((1 + (p_tasa_EA/100)), (1/365))- 1) * 365)*100;
    --
    RETURN v_valor;
    --
END fn_tasa_365;
---------------------------------------------------------------------------------------------------
FUNCTION fn_val_rendi(p_sald    NUMBER
                    , p_tasa_EA NUMBER
                    )RETURN NUMBER IS
    --
    v_valor      NUMBER;
    --
BEGIN
    --
    v_valor := NULL;
    --
    --v_valor := p_sald * tbl_qgeneral.fn_tasa_365(p_tasa_EA); antes -- 1002       01/04/2024 Jmartinezm   
    v_valor := p_sald * (tbl_qgeneral.fn_tasa_365(p_tasa_EA) / 365 ); -- 1002  01/04/2024 Jmartinezm   
    --
    RETURN v_valor;
    --
END fn_val_rendi;
---------------------------------------------------------------------------------------------------
FUNCTION fn_codi_cond(p_codi VARCHAR2
                      )RETURN NUMBER IS
    --
    v_valor      NUMBER;
    --
    CURSOR c_cond IS
        SELECT cond_banc_inter
             , cond_banc_cance
             , cond_dv1
          FROM tbl_tcondgen
        ;
    --
    r_cond      c_cond%ROWTYPE;
    --
BEGIN
    --
    v_valor := NULL;
    --
    OPEN  c_cond;
    FETCH c_cond INTO r_cond;
    CLOSE c_cond;
    --
    IF p_codi = 'INTER' THEN
        --
        v_valor := r_cond.cond_banc_inter;
        --
    ELSIF p_codi = 'CANCE' THEN
        --
        v_valor := r_cond.cond_banc_cance;
        --
    ELSIF p_codi = 'DV1' THEN
        --
        v_valor := r_cond.cond_dv1;
        --
    END IF;
    --
    RETURN v_valor;
    --
END fn_codi_cond;
---------------------------------------------------------------------------------------------------
FUNCTION fn_codi_condpfmt(p_codi VARCHAR2
                      )RETURN NUMBER IS
    --
    v_valor      NUMBER;
    --
    CURSOR c_cond IS
        SELECT cod_banc_banc
          FROM tbl_tcondgenpfmt
        ;
    --
    r_cond      c_cond%ROWTYPE;
    --
BEGIN
    --
    v_valor := NULL;
    --
    OPEN  c_cond;
    FETCH c_cond INTO r_cond;
    CLOSE c_cond;
    --
    IF p_codi = 'COD' THEN
        --
        v_valor := r_cond.cod_banc_banc;
        --
    END IF;
    --
    RETURN v_valor;
    --
END fn_codi_condpfmt;
---------------------------------------------------------------------------------------------------
--Fin 1001 14/12/2023 cramirezs
-- ini 1003
FUNCTION fn_recupera_mandato(p_empr   tbl_tempresas.empr_empr%TYPE
                           , p_banc   tbl_tbancos.banc_banc%TYPE
                           , p_fech   DATE
                            )RETURN NUMBER IS
    --
    v_valor     NUMBER;
    v_empr_tempresas tbl_tempresas.empr_empr%TYPE;
    v_valor_cursor_1 NUMBER;
    v_valor_cursor_2 NUMBER;
    v_aux            NUMBER;
    --
    CURSOR c_mandato IS
        SELECT SUM(DECODE(NVL(VAL_AJT,0), 0, VAL, VAL_AJT))
          FROM tbl_vmesaoperconslt
         WHERE mandato   = p_empr
           AND banc_prin = p_banc
           AND empr     <> MANDATO
           AnD fecha     = p_fech
        ;
    --
    CURSOR c_mandato_modificado(p_empr2 tbl_tempresas.empr_empr%TYPE) IS 
        SELECT SUM(DECODE(NVL(VAL_AJT,0), 0, VAL, VAL_AJT))
          FROM tbl_vmesaoperconslt
         WHERE mandato   IS NULL
           AND banc_prin = p_banc
           AND empr      = p_empr2
           AND fecha     = p_fech
        ;
    --    
BEGIN
    --
    v_valor_cursor_2 := 0;
    --
    FOR I IN ( 
        SELECT empr_empr
            FROM tbl_tempresas
            WHERE empr_mandato = p_empr
    ) loop
    --
    OPEN  c_mandato_modificado(i.empr_empr);
    FETCH c_mandato_modificado INTO v_aux;
    IF c_mandato_modificado%FOUND THEN
        --
        v_valor_cursor_2 := v_valor_cursor_2+ v_aux ;
        --
    END IF;
    CLOSE c_mandato_modificado;
    --
    end loop;
    --
    v_valor := 0;
    --
    OPEN  c_mandato;
    FETCH c_mandato INTO v_valor_cursor_1;
    IF c_mandato%NOTFOUND THEN
        --
        v_valor_cursor_1 := 0;
        --
    END IF;
    CLOSE c_mandato;

    v_valor := NVL(v_valor_cursor_1, 0) + NVL(v_valor_cursor_2, 0);
    --
    RETURN NVL(v_valor, 0);
    --
END fn_recupera_mandato;
---------------------------------------------------------------------------------------------------
FUNCTION fn_recupera_traslado(p_empr   tbl_tempresas.empr_empr%TYPE
                           , p_banc   tbl_tbancos.banc_banc%TYPE
                           , p_fech   DATE
                            )RETURN NUMBER IS
    --
    v_valor     NUMBER;
    --
    CURSOR c_traslado IS
        SELECT  SUM(
            CASE
                WHEN tras_tipo_oper = (select list_list from gen_tlistas where list_modulo = 'TBL' and list_lista = 'TIPO_OPER' and list_sigla = 'I')
                    AND tras_esta = (select esta_esta from gen_testados where esta_modulo = 'TBL' and esta_lista = 'ESTA_TRAS' and esta_sigla = 'A')
                        THEN NVL(tras_valor,0)
                WHEN tras_tipo_oper = (select list_list from gen_tlistas where list_modulo = 'TBL' and list_lista = 'TIPO_OPER' and list_sigla = 'E')
                    AND tras_esta = (select esta_esta from gen_testados where esta_modulo = 'TBL' and esta_lista = 'ESTA_TRAS' and esta_sigla = 'A')
                        THEN -NVL(tras_valor,0)
                ELSE 
                    0
                END
            ) tras_valor
          FROM tbl_ttrasebra
         WHERE tras_empr    = p_empr
           AND tras_banc    = p_banc
           AnD tras_fecha   = p_fech
        ;
    --
BEGIN
    --
    v_valor := NULL;
    --
    OPEN  c_traslado;
    FETCH c_traslado INTO v_valor;
    IF c_traslado%NOTFOUND THEN
        --
        v_valor := 0;
        --
    END IF;
    CLOSE c_traslado;
    --
    RETURN NVL(v_valor, 0);
    --
END fn_recupera_traslado;
---------------------------------------------------------------------------------------------------
FUNCTION fn_val_mesa_sebra( p_empr   tbl_tempresas.empr_empr%TYPE
                           , p_banc   tbl_tbancos.banc_banc%TYPE
                           , p_fech   DATE
                            )RETURN NUMBER IS
    --
    v_valor         NUMBER;
    v_valor_mesa    NUMBER;
    v_total         NUMBER;
    --
    CURSOR c_sebra IS
        SELECT  SUM(NVL(movi_valor,0)) 
          FROM tbl_vmoviteso
         WHERE empr_empr    = p_empr
           --AND banc_banc    = p_banc
           AND movi_fecha   = p_fech
           AND cuen_sebra is not null
        ;
    --
BEGIN
    --
    v_valor := NULL;
    v_valor_mesa := tbl_qgeneral.fn_val_mesa(p_empr,p_banc,null,p_fech);
    --
    OPEN  c_sebra;
    FETCH c_sebra INTO v_valor;
    IF c_sebra%NOTFOUND THEN
        --
        v_valor := 0;
        --
    END IF;
    CLOSE c_sebra;
    --
    v_total := NVL(v_valor,0) + NVL(v_valor_mesa,0);
    RETURN NVL(v_total, 0);
    --
END fn_val_mesa_sebra;
--Fin 1003
---------------------------------------------------------------------------------------------------
--ini 1004 26/06/2024 Jmartinezm
FUNCTION fn_val_sebra_fideicomiso( p_empr   tbl_tempresas.empr_empr%TYPE
                           , p_fech   DATE
                            )RETURN NUMBER IS
    --
    v_valor         NUMBER;
    --
    CURSOR c_sebra IS
        SELECT SUM(NVL(movi_valor, 0))  
        FROM tbl_tmoviteso mt
         INNER JOIN tbl_tcuentasban cb ON cb.cuen_cuen = mt.movi_cuen
         where mt.movi_fecha = p_fech
         and cb.cuen_empr = p_empr
         and mt.movi_encargo IS NOT NULL
         and cb.cuen_sebra = gen_qgeneral.id_estado('GEN', 'BASICOS', 'S')
         and EXISTS (
            SELECT 1
            FROM tbl_tempxmand em
            WHERE em.empx_mandato = cb.cuen_empr
            and em.empx_encargo = NVL(mt.movi_encargo,9999999)
        )
        ;
    --
BEGIN
    --
    v_valor := NULL;
    --
    OPEN  c_sebra;
    FETCH c_sebra INTO v_valor;
    IF c_sebra%NOTFOUND THEN
        --
        v_valor := 0;
        --
    END IF;
    CLOSE c_sebra;
    --
    RETURN NVL(v_valor, 0);
    --
END fn_val_sebra_fideicomiso;
---------------------------------------------------------------------------------------------------
FUNCTION fn_val_sebra_inversionistas( p_empr   tbl_tempresas.empr_empr%TYPE
                           , p_fech   DATE
                            )RETURN NUMBER IS
    --
    v_valor         NUMBER;
    --
    CURSOR c_sebra IS
        SELECT SUM(NVL(movi_valor, 0))  
        FROM tbl_tmoviteso mt
         INNER JOIN tbl_tcuentasban cb ON cb.cuen_cuen = mt.movi_cuen
         WHERE mt.movi_fecha = p_fech
         AND cb.cuen_empr = p_empr
         AND mt.movi_encargo IS NOT NULL
         AND cb.cuen_sebra = gen_qgeneral.id_estado('GEN', 'BASICOS', 'S')
         AND NOT EXISTS (
            SELECT 1
            FROM tbl_tempxmand em
            WHERE em.empx_mandato = cb.cuen_empr
            and em.empx_encargo = NVL(mt.movi_encargo,9999999)
        )
        ;
    --
BEGIN
    --
    v_valor := NULL;
    --
    OPEN  c_sebra;
    FETCH c_sebra INTO v_valor;
    IF c_sebra%NOTFOUND THEN
        --
        v_valor := 0;
        --
    END IF;
    CLOSE c_sebra;
    --
    RETURN NVL(v_valor, 0);
    --
END fn_val_sebra_inversionistas;
--fin 1004 26/06/2024 Jmartinezm
---------------------------------------------------------------------------------------------------
END tbl_qgeneral;
/
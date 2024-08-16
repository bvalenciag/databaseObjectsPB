prompt
prompt PACKAGE: TBL_QVPL_COLP
prompt
create or replace PACKAGE tbl_qvpl_colp IS
--
-- Reúne funciones y procedimientos directamente relacionados con el procedimiento de las cartas vpl bancolombia
--
-- #VERSION: 1001
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       02/01/2024 Cramirezs    000001       * Se crea paquete.
--                       Kilonova
-- ========== ========== ============ ============ ============================================================================================================
-- 1001       16/04/2024 Jmartinezm    000001       * Ajuste al paquete.
--                       Kilonova
-- ========== ========== ============ ============ ============================================================================================================
--
-------------------------------------------------------------------------------------------------
--Types
-------------------------------------------------------------------------------------------------
/**
 * Tipo para el manejo de Retornos en los reportes
*/
TYPE ty_data_sebra IS RECORD(
      ing_egr                         VARCHAR2(50)                --0  I-Ingreso - E-Egreso 
    , ciudad                          VARCHAR2(200)               --1  Ciudad Asociada al banco
    , fecha                           VARCHAR2(50)                --2  Fecha en que se registra el traslado
    , nomb_banco                      VARCHAR2(200)               --3  Nombre del banco
    , dest_carta                      VARCHAR2(200)               --4  Destinatario de la carta
    , dire_desti                      VARCHAR2(200)               --5  Dirección del destinatario de la carta
    , val_fj6                         VARCHAR2(1000)              --6  Valor fijo campo 6
    , vari_9                          VARCHAR2(1000)              --7  Variale 9
    , val_fj8                         VARCHAR2(1000)              --8  Valor fijo campo 8
    , val_fj9                         VARCHAR2(1000)              --9  Valor fijo campo 9 egresos
    , concep_cud                      VARCHAR2(200)               --10 Concepto CUD
    , ref_carta                       VARCHAR2(1000)              --11 Referencia de la carta egresos
    , val_fj12                        VARCHAR2(1000)              --12 Valor fijo campo 12 egresos 
    , num_cuen                        VARCHAR2(40)                --13 Número de cuenta a la cual se registra el debito y el credito
    , razon                           VARCHAR2(200)               --14 Nombre de la empresa que hace el traslado debito y el credito
    , cod_cuen_CUD                    VARCHAR2(40)                --15 Código de la cuenta CUD debito y el credito
    , val_fj16_12                     VARCHAR2(1000)              --16 Valor fijo campo 16 egresos 12 ingresos
    , val_fj17                        VARCHAR2(1000)              --17 Valor fijo campo 17 egresos 
    , valor_numero                    VARCHAR2(200)               --18 Valor del traslado en números  
    , val_fj19                        VARCHAR2(1000)              --19 Valor fijo campo 19 egresos 
    , vari_10                         VARCHAR2(1000)              --20 Variale 10
    , confir_carta_nomb               VARCHAR2(200)               --21 Nombre confirmación
    , confir_carta_tele               VARCHAR2(200)               --21 Telefono confirmación
    , confir_carta_exte               VARCHAR2(200)               --21 Extención confirmación
    , confir_sebra_nomb               VARCHAR2(200)               --23 Nombre contacto sebra
    , confir_sebra_tele               VARCHAR2(200)               --23 Telefono contacto sebra
    , confir_sebra_exte               VARCHAR2(200)               --23 extensión contacto sebra
    , contac_sebra                    VARCHAR2(4000)
    , fecha_conf                      VARCHAR2(10)                --22 Fecha en que se registra el traslado formato confirmación
);
--
TYPE ty_data_sebra_c IS TABLE OF ty_data_sebra INDEX BY BINARY_INTEGER;
vg_data_sebra ty_data_sebra_c;
TYPE ty_data_sebra_c_return IS TABLE OF ty_data_sebra;
--
-------------------------------------------------------------------------------------------------
--Procedure - Function
-------------------------------------------------------------------------------------------------
/** 
 * llenar el tipo con toda la información correspondiente al reporte
 * @param p_traslado Número de traslado
 */
FUNCTION ws_fn_acx_fill_sebra (p_traslado tbl_ttrasebra.tras_tras%TYPE 
                               ) RETURN BOOLEAN;
/** 
 * Exponer todas las control Accounts y su respectiva sociedad con la estructura WBS por ID de Proyecto entregado
 * @param p_traslado Número de traslado
 */
FUNCTION ws_fn_acx_get_sebra (p_traslado tbl_ttrasebra.tras_tras%TYPE
                              ) RETURN ty_data_sebra_c_return PIPELINED;
-------------------------------------------------------------------------------------------------
--
END tbl_qvpl_colp;
/
prompt
prompt PACKAGE BODY: tbl_qvpl_colp
prompt
--
CREATE OR REPLACE PACKAGE BODY tbl_qvpl_colp IS
--
-- #VERSION: 1001
--
FUNCTION ws_fn_acx_fill_sebra (p_traslado tbl_ttrasebra.tras_tras%TYPE
                               ) RETURN BOOLEAN IS
    --
    CURSOR c_tras IS       
        SELECT list_sigla                                                                                                                                   ing_egr
             , infb_ciudad                                                                                                                                  ciudad 
             , to_char(tras_fecha, 'dd')||' de '||RTRIM(to_char(tras_fecha, 'Month', 'NLS_DATE_LANGUAGE=SPANISH'))||' de '||to_char(tras_fecha, 'yyyy')     fecha
             , banc_descripcion                                                                                                                             nomb_banco
             , infb_desti                                                                                                                                   dest_carta
             , infb_dir                                                                                                                                     dire_desti
             --, 'TRASLADO DE FONDOS VIA SEBRA'                                                                                                             val_fj6 antes 1001 16/04/2024 Jmartinezm 
             , 'FIDUCIARIA CORFICOLOMBIANA S.A.'                                                                                                            val_fj6 -- 1001 16/04/2024 Jmartinezm 
             , tbl_qreporsebra.fn_valor_variable (9)                                                                                                        vari_9
             , DECODE(list_sigla, 'E', 'DEBITO', 'CREDITO')                                                                                                 val_fj8
             , DECODE(list_sigla, 'E', 'NO', NULL)                                                                                                          val_fj9
             , DECODE(list_sigla, 'E', infb_concep, NULL)                                                                                                   concep_cud
             , DECODE(list_sigla, 'E', infb_refegr, NULL)                                                                                                   ref_carta
             , DECODE(list_sigla, 'E', 'Exento', NULL)                                                                                                      val_fj12
             , cue.cuen_nrocta                                                                                                                              num_cuen 
             , empr_descripcion||' '||empr_nit||CASE WHEN empr_digito IS NOT NULL THEN '-'||empr_digito ELSE '' END                                         razon
             --, cud.cuen_nrocta                                                                                                                            cod_cuen_CUD antes 1001 16/04/2024 Jmartinezm 
             , infb_cuen_cud_cod                                                                                                                            cod_cuen_CUD -- 1001 16/04/2024 Jmartinezm 
             , 'FIDUCIARIA CORFICOLOMBIANA S.A.'                                                                                                            val_fj16_12    
             --, DECODE(list_sigla, 'E', '0', NULL)                                                                                                         val_fj17 antes 1001 16/04/2024 Jmartinezm     
             , DECODE(list_sigla, 'E', infb_portafolio, NULL)                                                                                               val_fj17 -- 1001 16/04/2024 Jmartinezm     
             , RTRIM(LTRIM(TO_CHAR(tras_valor,'L99G999G999G999G999G999G999D99MI','NLS_NUMERIC_CHARACTERS = '',.''NLS_CURRENCY = ''$ ''')))                  valor_numero
             , DECODE(list_sigla, 'E', 'Autorizamos de igual manera debitar de la cuenta en Referencia el valor de la comisión e Iva que esta operación genere.', NULL) val_fj19
             , DECODE(list_sigla, 'E', tbl_qreporsebra.fn_valor_variable (10), NULL)                                                                        vari_10
             , cc.cont_nombre                                                                                                                               confir_carta_nomb
             , cc.cont_telefono                                                                                                                             confir_carta_tele
             , cc.cont_extension                                                                                                                            confir_carta_exte
             , cs.cont_nombre                                                                                                                               confir_sebra_nomb
             , cs.cont_telefono                                                                                                                             confir_sebra_tele
             , cs.cont_extension                                                                                                                            confir_sebra_exte
             , TO_CHAR(tras_fecha, 'DD/MM/YYYY')                                                                                                            fecha_conf
          FROM tbl_ttrasebra
             , tbl_tinfbancos
             , tbl_tempresas
             , gen_tlistas
             --, tbl_tcuentasban cud antes 1001 16/04/2024 Jmartinezm 
             , tbl_tcuentasban cue
             , tbl_tbancos
             , (SELECT DISTINCT p_traslado tras
                     , cont_nombre
                     , cont_telefono
                     , cont_extension
                  FROM tbl_tcontenti 
                     , gen_tlistas
                 WHERE cont_sebra(+) = list_list
                   AND list_sigla = 'N'
                   AND LIST_MODULO = 'TBL'
                   AND LIST_LISTA = 'CONT_ENTI'
                 ) cc
             , (SELECT DISTINCT p_traslado tras
                     , cont_nombre
                     , cont_telefono
                     , cont_extension
                  FROM tbl_tcontenti 
                     , gen_tlistas
                 WHERE cont_sebra(+) = list_list
                   AND list_sigla = 'S'
                   AND LIST_MODULO = 'TBL'
                   AND LIST_LISTA = 'CONT_ENTI'
                 ) cs
         WHERE tras_banc      = infb_banc
           AND tras_empr      = empr_empr
           AND tras_tipo_oper = list_list
           --AND tras_cuen_cud  = cud.cuen_cuen antes 1001 16/04/2024 Jmartinezm 
           AND tras_cuen      = cue.cuen_cuen
           AND banc_banc      = tras_banc 
           AND tras_tras      = p_traslado
        ;
    --
    r_tras  c_tras%ROWTYPE;
    v_count NUMBER;
    --
BEGIN
    --
    v_count := 0;
    --
    vg_data_sebra.DELETE;
    --
    vg_data_sebra(0).ing_egr           := NULL;
    vg_data_sebra(0).ciudad            := NULL;
    vg_data_sebra(0).fecha             := NULL;
    vg_data_sebra(0).nomb_banco        := NULL;
    vg_data_sebra(0).dest_carta        := NULL;
    vg_data_sebra(0).dire_desti        := NULL;
    vg_data_sebra(0).val_fj6           := NULL;
    vg_data_sebra(0).vari_9            := NULL;
    vg_data_sebra(0).val_fj8           := NULL;
    vg_data_sebra(0).val_fj9           := NULL;
    vg_data_sebra(0).concep_cud        := NULL;
    vg_data_sebra(0).ref_carta         := NULL;
    vg_data_sebra(0).val_fj12          := NULL;
    vg_data_sebra(0).num_cuen          := NULL;
    vg_data_sebra(0).razon             := NULL;
    vg_data_sebra(0).cod_cuen_CUD      := NULL;
    vg_data_sebra(0).val_fj16_12       := NULL;
    vg_data_sebra(0).val_fj17          := NULL;
    vg_data_sebra(0).valor_numero      := NULL;
    vg_data_sebra(0).val_fj19          := NULL;
    vg_data_sebra(0).vari_10           := NULL;
    vg_data_sebra(0).confir_carta_nomb := NULL;
    vg_data_sebra(0).confir_carta_tele := NULL;
    vg_data_sebra(0).confir_carta_exte := NULL;
    vg_data_sebra(0).confir_sebra_nomb := NULL;
    vg_data_sebra(0).confir_sebra_tele := NULL;
    vg_data_sebra(0).confir_sebra_exte := NULL;
    vg_data_sebra(0).fecha_conf        := NULL;
    --
    FOR i IN c_tras LOOP
        --
        --gen_pseguimiento('colp 1');
        vg_data_sebra(v_count).ing_egr           := i.ing_egr     ;--0  I-Ingreso - E-Egreso 
    	vg_data_sebra(v_count).ciudad            := i.ciudad      ;--1  Ciudad Asociada al banco
    	vg_data_sebra(v_count).fecha             := i.fecha       ;--2  Fecha en que se registra el traslado
    	vg_data_sebra(v_count).nomb_banco        := i.nomb_banco  ;--3  Nombre del banco
    	vg_data_sebra(v_count).dest_carta        := i.dest_carta  ;--4  Destinatario de la carta
    	vg_data_sebra(v_count).dire_desti        := i.dire_desti  ;--5  Dirección del destinatario de la carta
    	vg_data_sebra(v_count).val_fj6           := i.val_fj6     ;--6  Valor fijo campo 6
    	vg_data_sebra(v_count).vari_9            := i.vari_9      ;--7  Variale 9
    	vg_data_sebra(v_count).val_fj8           := i.val_fj8     ;--8  Valor fijo campo 8
    	vg_data_sebra(v_count).val_fj9           := i.val_fj9     ;--9  Valor fijo campo 9 egresos
    	vg_data_sebra(v_count).concep_cud        := i.concep_cud  ;--10 Concepto CUD
    	vg_data_sebra(v_count).ref_carta         := i.ref_carta   ;--11 Referencia de la carta egresos
    	vg_data_sebra(v_count).val_fj12          := i.val_fj12    ;--12 Valor fijo campo 12 egresos 
    	vg_data_sebra(v_count).num_cuen          := i.num_cuen    ;--13 Número de cuenta a la cual se registra el debito y el credito
    	vg_data_sebra(v_count).razon             := i.razon       ;--14 Nombre de la empresa que hace el traslado debito y el credito
    	vg_data_sebra(v_count).cod_cuen_CUD      := i.cod_cuen_CUD;--15 Código de la cuenta CUD debito y el credito
    	vg_data_sebra(v_count).val_fj16_12       := i.val_fj16_12 ;--16 Valor fijo campo 16 egresos 12 ingresos
    	vg_data_sebra(v_count).val_fj17          := i.val_fj17    ;--17 Valor fijo campo 17 egresos 
    	vg_data_sebra(v_count).valor_numero      := i.valor_numero;--18 Valor del traslado en números  
    	vg_data_sebra(v_count).val_fj19          := i.val_fj19    ;--19 Valor fijo campo 19 egresos 
    	vg_data_sebra(v_count).vari_10           := i.vari_10     ;--20 Variale 10
        vg_data_sebra(v_count).confir_carta_nomb := i.confir_carta_nomb;
        vg_data_sebra(v_count).confir_carta_tele := i.confir_carta_tele;
        vg_data_sebra(v_count).confir_carta_exte := i.confir_carta_exte;
        vg_data_sebra(v_count).confir_sebra_nomb := i.confir_sebra_nomb;
        vg_data_sebra(v_count).confir_sebra_tele := i.confir_sebra_tele;
        vg_data_sebra(v_count).confir_sebra_exte := i.confir_sebra_exte;
    	vg_data_sebra(v_count).fecha_conf        := i.fecha_conf  ;--22 Fecha en que se registra el traslado formato confirmación
        --gen_pseguimiento('colp 2');
        --
        v_count := v_count + 1;
        --
    END LOOP c_tras;
    --
    RETURN TRUE;
    --
END ws_fn_acx_fill_sebra;
-------------------------------------------------------------------------------------------------
FUNCTION ws_fn_acx_get_sebra (p_traslado tbl_ttrasebra.tras_tras%TYPE
                              ) RETURN ty_data_sebra_c_return PIPELINED IS
    --
    v_fill_data BOOLEAN;
    l_index     PLS_INTEGER;
    --
BEGIN
    --
    v_fill_data := ws_fn_acx_fill_sebra(p_traslado);
    --
    IF v_fill_data THEN
        --
        l_index := vg_data_sebra.FIRST;
        --
        IF vg_data_sebra.count > 0 THEN
            --
            --gen_pseguimiento('colp 11');
            WHILE (l_index IS NOT NULL) LOOP
                --
                --gen_pseguimiento('colp 12');
                pipe row(vg_data_sebra(l_index));
                --gen_pseguimiento('colp 13');
                l_index := vg_data_sebra.NEXT(l_index);
                --
            END LOOP;
            --
        END IF;
        --
    END IF;
    --
    RETURN;
    --
END ws_fn_acx_get_sebra;
--
END tbl_qvpl_colp;
/
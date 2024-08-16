prompt
prompt PACKAGE: TBL_QVPL_WWB
prompt
CREATE OR REPLACE PACKAGE tbl_qvpl_wwb IS
--
-- Reúne funciones y procedimientos directamente relacionados con el procedimiento de las cartas vpl WWB
--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       22/05/2024 Jmartinezm    000001       * Se crea paquete.
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
      ing_egr               VARCHAR2(500)              --0  I-Ingreso - E-Egreso
    , ciudad_fecha          VARCHAR2(2000)             --1  Cuidad (Bogotá) y fecha
    , ciudad                VARCHAR2(200)              --22  Cuidad 
    , nomb_banco            VARCHAR2(2000)             --2  Nombre del banco
    , dest_carta            VARCHAR2(2000)             --3  Destinatario de la carta
    , carg_dest_carta       VARCHAR2(2000)             --4  Cargo destinatario de la carta
    , refe_carta            VARCHAR2(2000)             --5  Referencia de la carta 
    , val_fj1               VARCHAR2(2000)             --6  Valor fijo 1 campo 7
    , val_fj2               VARCHAR2(4000)             --7  Valor fijo 2 campo 8 
    , val_fj3               VARCHAR2(4000)             --8  Valor fijo 3 campo 9
    , val_fj4               VARCHAR2(2000)             --9  Valor fijo 4 campo 10 
    , cod_cuen_cud          VARCHAR2(4000)             --10 Cuenta CUD                  
    , portaflio             VARCHAR2(2000)             --11 Portafolio                  
    , concep_cud            VARCHAR2(2000)             --12 Concepto CUD                    
    , valor_tras_num        VARCHAR2(2000)             --13 Valor traslado en número                        
    , valor_tras_let        VARCHAR2(4000)             --14 Valor traslado en letra                         
    , tipo_cuen             VARCHAR2(2000)             --15 Tipo de cuenta bancaria asociada al traslado    
    , cod_cuent_banc_empr   VARCHAR2(2000)             --16 Cuenta bancaria asociada a la empresa y banco, diferente a la relacionada al traslado
    , nomb_empr             VARCHAR2(2000)             --17 Nombre de la empresa
    , nit_empr              VARCHAR2(200)              --23 Nit de la empresa
    , vari_14               VARCHAR2(2000)             --18 Variable 14
    , confir_carta_nomb     VARCHAR2(2000)             --19 Nombre confirmacion    
    , confir_carta_tele     VARCHAR2(2000)             --20 Telefono confirmacion    
    , confir_carta_exte     VARCHAR2(2000)             --21 Extension confirmación    
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
END tbl_qvpl_wwb;
/
prompt
prompt PACKAGE BODY: tbl_qvpl_wwb
prompt
--
CREATE OR REPLACE PACKAGE BODY tbl_qvpl_wwb IS
--
-- #VERSION: 1000
--
---------------------------------------------------------------------------------------------------
FUNCTION ws_fn_acx_fill_sebra (p_traslado tbl_ttrasebra.tras_tras%TYPE
                               ) RETURN BOOLEAN IS
    --
    CURSOR c_tras IS       
       SELECT list_sigla                                                                                                                            ing_egr
             , 'Bogotá'||'  '|| to_char(tras_fecha, 'dd')||' de '
               ||RTRIM(to_char(tras_fecha, 'Month', 'NLS_DATE_LANGUAGE=SPANISH'))
               ||' de '||to_char(tras_fecha, 'yyyy')                                                                                                ciudad_fecha
             , infb_ciudad                                                                                                                          ciudad                                                                        
             , banc_descripcion                                                                                                                     nomb_banco                                                                                                       
             , infb_desti                                                                                                                           dest_carta                                                                                                       
             , infb_cargo                                                                                                                           carg_dest_carta
             , DECODE(list_sigla, 'E', infb_refegr, infb_ref)                                                                                       refe_carta
             , '62250899'                                                                                                                           val_fj1
             , 'portafolio cero (0)'                                                                                                                val_fj2
             , '(Fiduciaria Corficolombiana S.A.)'                                                                                                  val_fj3
             , '(800.162.271-6)'                                                                                                                    val_fj4
             , infb_cuen_cud_cod                                                                                                                    cod_cuen_cud
             , infb_portafolio                                                                                                                      portaflio
             , infb_concep                                                                                                                          concep_cud
             , RTRIM(LTRIM(TO_CHAR(NVL(tras_valor,0),'L99G999G999G999G999G999G999D99MI','NLS_NUMERIC_CHARACTERS = '',.''NLS_CURRENCY = ''$ ''')))   valor_tras_num
             , tbl_qreporsebra.fn_numero_a_texto(NVL(tras_valor,0))                                                                                 valor_tras_let
             , DECODE(cue.cuen_tipo, 'CC', 'Cuenta Corriente', 'Cuenta de Ahorros')                                                                 tipo_cuen
             , tbl_qreporsebra.fn_cuen_traslado_ingreso(empr_empr,banc_banc, DECODE(list_sigla, 'E', 'I', 'I', 'E'))                                cod_cuent_banc_empr
             , empr_descripcion                                                                                                                     nomb_empr
             , empr_nit                                                                                                                             nit_empr
             , tbl_qreporsebra.fn_valor_variable (14)                                                                                               vari_14
             , cc.cont_nombre                                                                                                                       confir_carta_nomb             
             , cc.cont_telefono                                                                                                                     confir_carta_tele
             , cc.cont_extension                                                                                                                    confir_carta_exte
          FROM tbl_ttrasebra
             , tbl_tinfbancos
             , tbl_tempresas
             , gen_tlistas
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
         WHERE tras_banc      = infb_banc
           AND tras_empr      = empr_empr
           AND tras_tipo_oper = list_list
           AND tras_cuen      = cue.cuen_cuen
           AND tras_banc      = banc_banc
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
    vg_data_sebra(0).ing_egr                := NULL;
    vg_data_sebra(0).ciudad_fecha           := NULL;
    vg_data_sebra(0).ciudad                 := NULL;
    vg_data_sebra(0).nomb_banco             := NULL;
    vg_data_sebra(0).dest_carta             := NULL;
    vg_data_sebra(0).carg_dest_carta        := NULL;
    vg_data_sebra(0).refe_carta             := NULL;
    vg_data_sebra(0).val_fj1                := NULL;
    vg_data_sebra(0).val_fj2                := NULL;
    vg_data_sebra(0).val_fj3                := NULL;
    vg_data_sebra(0).val_fj4                := NULL;
    vg_data_sebra(0).cod_cuen_cud           := NULL;
    vg_data_sebra(0).portaflio              := NULL;
    vg_data_sebra(0).concep_cud             := NULL;
    vg_data_sebra(0).valor_tras_num         := NULL;
    vg_data_sebra(0).valor_tras_let         := NULL;
    vg_data_sebra(0).tipo_cuen              := NULL;
    vg_data_sebra(0).cod_cuent_banc_empr    := NULL;
    vg_data_sebra(0).nomb_empr              := NULL;
    vg_data_sebra(0).nit_empr               := NULL;
    vg_data_sebra(0).vari_14                := NULL;
    vg_data_sebra(0).confir_carta_nomb      := NULL;
    vg_data_sebra(0).confir_carta_tele      := NULL;
    vg_data_sebra(0).confir_carta_exte      := NULL;
    --
    FOR i IN c_tras LOOP
        --
        --gen_pseguimiento('colp 1');
        vg_data_sebra(v_count).ing_egr                      := i.ing_egr                    ;--0  I-Ingreso - E-Egreso
    	vg_data_sebra(v_count).ciudad_fecha                 := i.ciudad_fecha               ;--1  Cuidad y fecha
        vg_data_sebra(v_count).ciudad                       := i.ciudad                     ;--22 Cuidad
    	vg_data_sebra(v_count).nomb_banco                   := i.nomb_banco                 ;--2  Nombre del banco
    	vg_data_sebra(v_count).dest_carta                   := i.dest_carta                 ;--3  Destinatario de la carta
    	vg_data_sebra(v_count).carg_dest_carta              := i.carg_dest_carta            ;--4  Cargo destinatario de la carta
    	vg_data_sebra(v_count).refe_carta                   := i.refe_carta                 ;--5  Referencia de la carta 
    	vg_data_sebra(v_count).val_fj1                      := i.val_fj1                    ;--6  Valor fijo 1 campo 7
    	vg_data_sebra(v_count).val_fj2                      := i.val_fj2                    ;--7  Valor fijo 2 campo 8 
    	vg_data_sebra(v_count).val_fj3                      := i.val_fj3                    ;--8  Valor fijo 3 campo 9
    	vg_data_sebra(v_count).val_fj4                      := i.val_fj4                    ;--9  Valor fijo 4 campo 10 
    	vg_data_sebra(v_count).cod_cuen_cud                 := i.cod_cuen_cud               ;--10 Cuenta CUD                  
    	vg_data_sebra(v_count).portaflio                    := i.portaflio                  ;--11 Portafolio                  
    	vg_data_sebra(v_count).concep_cud                   := i.concep_cud                 ;--12 Concepto CUD                    
    	vg_data_sebra(v_count).valor_tras_num               := i.valor_tras_num             ;--13 Valor traslado en número                        
    	vg_data_sebra(v_count).valor_tras_let               := i.valor_tras_let             ;--14 Valor traslado en letra                         
    	vg_data_sebra(v_count).tipo_cuen                    := i.tipo_cuen                  ;--15 Tipo de cuenta bancaria asociada al traslado    
    	vg_data_sebra(v_count).cod_cuent_banc_empr          := i.cod_cuent_banc_empr        ;--16 Cuenta bancaria asociada a la empresa y banco, diferente a la relacionada al traslado
    	vg_data_sebra(v_count).nomb_empr                    := i.nomb_empr                  ;--17 Nombre de la empresa
        vg_data_sebra(v_count).nit_empr                     := i.nit_empr                   ;--23 Nit de la empresa
    	vg_data_sebra(v_count).vari_14                      := i.vari_14                    ;--18 Variable 14
        vg_data_sebra(v_count).confir_carta_nomb            := i.confir_carta_nomb          ;--19 Nombre confirmacion    
        vg_data_sebra(v_count).confir_carta_tele            := i.confir_carta_tele          ;--20 Telefono confirmacion    
        vg_data_sebra(v_count).confir_carta_exte            := i.confir_carta_exte          ;--21 Extension confirmación    
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
---------------------------------------------------------------------------------------------------
--
END tbl_qvpl_wwb;
/
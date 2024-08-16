prompt
prompt PACKAGE: TBL_QVPL_COOP
prompt
CREATE OR REPLACE PACKAGE tbl_qvpl_coop IS
--
-- Reúne funciones y procedimientos directamente relacionados con el procedimiento de las cartas vpl coopcentral
--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       23/05/2024 Jmartinezm    000001       * Se crea paquete.
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
      ing_egr                         VARCHAR2(50)              --0  I-Ingreso - E-Egreso
    , val_fj1                         VARCHAR2(1000)            --1  Valor Fijo campo 2
    , ciudad_fecha                    VARCHAR2(200)             --2  Ciudad y fecha Asociada al banco
    , nomb_banco                      VARCHAR2(200)             --3  Nombre del banco
    , tipo_cuen                       VARCHAR2(40)              --4  Tipo de cuenta a la cual se registra el debito y el credito
    , val_fj2                         VARCHAR2(1000)            --5  Valor fijo campo 7
    , val_fj3                         VARCHAR2(1000)            --6  Valor fijo campo 8
    , cod_cuenta_cod_cud              VARCHAR2(40)              --7  Si es egreso cuenta bancaria del aporte, si es ingreso cuenta CUD
    , tipo_cuenta_cod_cud             VARCHAR2(40)              --8  Tipo de cuenta bancaria del cod_cuenta_cod_cud
    , portafolio                      VARCHAR2(40)              --9  Si es Ingreso Portafolio si es egreso 0
    , cod_cud_cod_cuenta              VARCHAR2(40)              --10 Si es egreso cuenta CUD, si es ingreso cuenta bancaria del aporte
    , tipo_cod_cud_cuenta             VARCHAR2(40)              --11 Tipo de cuenta bancaria del cod_cud_cod_cuenta
    , portafolio_e                    VARCHAR2(40)              --12 Si es Egreso portafolio, si es ingreso 0
    , valor_tras_num                  VARCHAR2(200)             --13 Valor del traslado en números 
    , valor_tras_let                  VARCHAR2(200)             --14 Valor del traslado en letras
    , val_fj4                         VARCHAR2(1000)            --15 Valor fijo campo 17 
    , val_fj5                         VARCHAR2(1000)            --16 Valor fijo campo 18
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
END tbl_qvpl_coop;
/
prompt
prompt PACKAGE BODY: tbl_qvpl_coop
prompt
--
CREATE OR REPLACE PACKAGE BODY tbl_qvpl_coop IS
--
-- #VERSION: 1000
--
---------------------------------------------------------------------------------------------------
FUNCTION ws_fn_acx_fill_sebra (p_traslado tbl_ttrasebra.tras_tras%TYPE
                               ) RETURN BOOLEAN IS
    --
    CURSOR c_tras IS       
       SELECT list_sigla                                                                                                                     ing_egr
             , 'AUTORIZACIÓN OPERACIONES SEBRA' || chr(13) ||
                'OPE-F-15'  || chr(13) ||
                'VER.5'                                                                                                                      val_fj1
             , infb_ciudad||'  '|| to_char(tras_fecha, 'dd')||' de '
               ||RTRIM(to_char(tras_fecha, 'Month', 'NLS_DATE_LANGUAGE=SPANISH'))
               ||' de '||to_char(tras_fecha, 'yyyy')                                                                                         ciudad_fecha                                                                              
             , banc_descripcion                                                                                                              nomb_banco 
             , DECODE(cue.cuen_tipo, 'CC', 'Cuenta Corriente', 'Cuenta de Ahorros')                                                          tipo_cuen
             , 'S'                                                                                                                           val_fj2
             , NULL                                                                                                                          val_fj3
             , DECODE(list_sigla, 'E', cue.cuen_nrocta, infb_cuen_cud_cod)                                                                   cod_cuenta_cod_cud
             , DECODE(list_sigla, 'E', DECODE(cue.cuen_tipo, 'CC', 'Cuenta Corriente', 'Cuenta de Ahorros'), 'Cuenta Corriente')             tipo_cuenta_cod_cud
             , DECODE(list_sigla, 'I',infb_portafolio, 0)                                                                                    portafolio
             , DECODE(list_sigla, 'E', infb_cuen_cud_cod, cue.cuen_nrocta)                                                                   cod_cud_cod_cuenta
             , DECODE(list_sigla, 'I', DECODE(cue.cuen_tipo, 'CC', 'Cuenta Corriente', 'Cuenta de Ahorros'), 'Cuenta Corriente')             tipo_cod_cud_cuenta
             , DECODE(list_sigla, 'E',infb_portafolio, 0)                                                                                    portafolio_e
             , RTRIM(LTRIM(TO_CHAR(tras_valor,'L99G999G999G999G999G999G999D99MI','NLS_NUMERIC_CHARACTERS = '',.''NLS_CURRENCY = ''$ ''')))   valor_tras_num
             , tbl_qreporsebra.fn_numero_a_texto(tras_valor)                                                                                 valor_tras_let
             , 'Fiduciaria Corficolombiana S.A'                                                                                              val_fj4
             , '800.162.271-6'                                                                                                               val_fj5
          FROM tbl_ttrasebra
             , tbl_tinfbancos
             , tbl_tempresas
             , gen_tlistas
             , tbl_tcuentasban cue
             , tbl_tbancos
             --, tbl_tcorinfbanc
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
           --AND cori_infb      = infb_infb
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
    vg_data_sebra(0).ing_egr              := NULL;
    vg_data_sebra(0).val_fj1              := NULL;
    vg_data_sebra(0).ciudad_fecha         := NULL;
    vg_data_sebra(0).nomb_banco           := NULL;
    vg_data_sebra(0).tipo_cuen            := NULL;
    vg_data_sebra(0).val_fj2              := NULL;
    vg_data_sebra(0).val_fj3              := NULL;
    vg_data_sebra(0).cod_cuenta_cod_cud   := NULL;
    vg_data_sebra(0).tipo_cuenta_cod_cud  := NULL;
    vg_data_sebra(0).portafolio           := NULL;
    vg_data_sebra(0).cod_cud_cod_cuenta   := NULL;
    vg_data_sebra(0).tipo_cod_cud_cuenta  := NULL;
    vg_data_sebra(0).portafolio_e         := NULL;
    vg_data_sebra(0).valor_tras_num       := NULL;
    vg_data_sebra(0).valor_tras_let       := NULL;
    vg_data_sebra(0).val_fj4              := NULL;
    vg_data_sebra(0).val_fj5              := NULL;
    --
    FOR i IN c_tras LOOP
        --
        --gen_pseguimiento('colp 1');
      vg_data_sebra(v_count).ing_egr              := i.ing_egr                ;--0  I-Ingreso - E-Egreso
    	vg_data_sebra(v_count).val_fj1              := i.val_fj1                ;--1  Valor Fijo campo 2
    	vg_data_sebra(v_count).ciudad_fecha         := i.ciudad_fecha           ;--2  Ciudad y fecha Asociada al banco
    	vg_data_sebra(v_count).nomb_banco           := i.nomb_banco             ;--3  Nombre del banco
    	vg_data_sebra(v_count).tipo_cuen            := i.tipo_cuen              ;--4  Tipo de cuenta a la cual se registra el debito y el credito
    	vg_data_sebra(v_count).val_fj2              := i.val_fj2                ;--5  Valor fijo campo 7
    	vg_data_sebra(v_count).val_fj3              := i.val_fj3                ;--6  Valor fijo campo 8
    	vg_data_sebra(v_count).cod_cuenta_cod_cud   := i.cod_cuenta_cod_cud     ;--7  Si es egreso cuenta bancaria del aporte, si es ingreso cuenta CUD
    	vg_data_sebra(v_count).tipo_cuenta_cod_cud  := i.tipo_cuenta_cod_cud    ;--8  Tipo de cuenta bancaria del cod_cuenta_cod_cud
    	vg_data_sebra(v_count).portafolio           := i.portafolio             ;--9  Si es Ingreso Portafolio si es egreso 0
    	vg_data_sebra(v_count).cod_cud_cod_cuenta   := i.cod_cud_cod_cuenta     ;--10 Si es egreso cuenta CUD, si es ingreso cuenta bancaria del aporte
    	vg_data_sebra(v_count).tipo_cod_cud_cuenta  := i.tipo_cod_cud_cuenta    ;--11 Tipo de cuenta bancaria del cod_cud_cod_cuenta
    	vg_data_sebra(v_count).portafolio_e         := i.portafolio_e           ;--12 Si es Egreso portafolio, si es ingreso 0
    	vg_data_sebra(v_count).valor_tras_num       := i.valor_tras_num         ;--13 Valor del traslado en números 
    	vg_data_sebra(v_count).valor_tras_let       := i.valor_tras_let         ;--14 Valor del traslado en letras
    	vg_data_sebra(v_count).val_fj4              := i.val_fj4                ;--15 Valor fijo campo 17 
    	vg_data_sebra(v_count).val_fj5              := i.val_fj5                ;--16 Valor fijo campo 18
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
END tbl_qvpl_coop;
/
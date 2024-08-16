prompt
prompt PACKAGE: TBL_QVPL_BOGO
prompt
create or replace PACKAGE tbl_qvpl_bogo IS
--
-- Reúne funciones y procedimientos directamente relacionados con el procedimiento de las cartas vpl bogotá
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
-- 1001       16/04/2024 Jmartinezm   000002       * Ajuste al paquete.
--                       Kilonova
-- ========== ========== ============ ============ ============================================================================================================
--
-------------------------------------------------------------------------------------------------
--Types
-------------------------------------------------------------------------------------------------
/**
 * Tipo para el manejo de Retornos en los reportes de ingreso
*/
TYPE ty_data_sebra_i IS RECORD(
      fijo_formato                    VARCHAR2(50)              --2  Valor fijo Formato movimiento    
    , fijo_codigo                     VARCHAR2(50)              --3  Valor fijo Código FID
    , ciudad_fecha                    VARCHAR2(200)             --4  Ciudad Asociada al banco
    , nomb_banco                      VARCHAR2(100)             --5  Nombre del banco
    , dest_carta                      VARCHAR2(200)             --6  Destinatario de la carta
    , carg_dest_carta                 VARCHAR2(200)             --7  Cargo destinatario de la carta
    , dire_dest_carta                 VARCHAR2(200)             --8  Dirección del destinatario de la carta
    , ciud_dest_carta                 VARCHAR2(200)             --9  Ciudad destino de la carta
    , fax_dest_carta                  VARCHAR2(200)             --10 Fax des destinatario de la carta
    , tele_dest_carta                 VARCHAR2(200)             --11 Telefeno destinatario de la carta
    , emai_dest_carta                 VARCHAR2(200)             --12 Correo Electronico del destinatario de la carta 
    , refe_carta                      VARCHAR2(200)             --13 Referencia de la carta
    , texto_informa                   VARCHAR2(200)             --14 Texto fijo Me permito informar...
    , valor_tras_num                  VARCHAR2(200)             --15 Valor del traslado en número
    , valor_tras_let                  VARCHAR2(200)             --16 Valor del traslado en letras
    , texto_para                      VARCHAR2(200)             --17 Texto fijo para que este...
    , cod_cuenta                      VARCHAR2(40)              --18 Cuenta bancaria del aporte
    , texto_sucur                     VARCHAR2(200)             --19 Texto fijo sucursal principal ...
    , texto_concep                    VARCHAR2(200)             --20 Texto fijo por concepto ...
    , vari_dos                        VARCHAR2(1000)            --21 Variable # 2
    , texto_cuenta                    VARCHAR2(200)             --22 Texto fijo Esta cuenta es...
    , texto_102                       VARCHAR2(200)             --23 texto fijo 102.
    , cod_cuenta_CUD                  VARCHAR2(200)             --24 Cuenta CUD + portafolio
    , confir_carta_nomb               VARCHAR2(200)             --25 Nombre confirmación
    , confir_carta_tele               VARCHAR2(200)             --26 Telefono confirmación
    , confir_carta_exte               VARCHAR2(200)             --27 Extención confirmación
    , confir_sebra_nomb               VARCHAR2(200)             --28 Nombre contacto sebra
    , confir_sebra_tele               VARCHAR2(200)             --29 Telefono contacto sebra
    , confir_sebra_exte               VARCHAR2(200)             --30 extensión contacto sebra
);
--
TYPE ty_data_sebra_i_c IS TABLE OF ty_data_sebra_i INDEX BY BINARY_INTEGER;
vg_data_sebra_i ty_data_sebra_i_c;
TYPE ty_data_sebra_i_c_return IS TABLE OF ty_data_sebra_i;
-------------------------------------------------------------------------------------------------
/**
 * Tipo para el manejo de Retornos en los reportes de egreso
*/
TYPE ty_data_sebra_e IS RECORD(
      fijo_formato                    VARCHAR2(50)              --2  Valor fijo Formato movimiento    
    , fijo_codigo                     VARCHAR2(50)              --3  Valor fijo Código FID
    , ciudad_fecha                    VARCHAR2(200)             --4  Ciudad Asociada al banco
    , nomb_banco                      VARCHAR2(100)             --5  Nombre del banco
    , dest_carta                      VARCHAR2(200)             --6  Destinatario de la carta
    , carg_dest_carta                 VARCHAR2(200)             --7  Cargo destinatario de la carta
    , dire_dest_carta                 VARCHAR2(200)             --8  Dirección del destinatario de la carta
    , ciud_dest_carta                 VARCHAR2(200)             --9  Ciudad destino de la carta
    , fax_dest_carta                  VARCHAR2(200)             --10 Fax des destinatario de la carta
    , tele_dest_carta                 VARCHAR2(200)             --11 Telefeno destinatario de la carta
    , emai_dest_carta                 VARCHAR2(200)             --12 Correo Electronico del destinatario de la carta 
    , refe_carta                      VARCHAR2(200)             --13 Referencia de la carta
    , texto_informa                   VARCHAR2(200)             --14 Texto fijo Solicitamos cargar...
    , cod_cuenta                      VARCHAR2(40)              --15 Cuenta bancaria del aporte
    , texto_suma                      VARCHAR2(200)             --16 Texto suma  
    , valor_tras_num                  VARCHAR2(200)             --16 Valor del traslado en número
    , valor_tras_let                  VARCHAR2(200)             --17 Valor del traslado en letras
    , texto_para                      VARCHAR2(1000)             --18 Texto fijo para que este ...
    , vari_dos                        VARCHAR2(1000)            --19 Variable # 2
    , texto_cuenta                    VARCHAR2(500)             --20 Texto fijo Esta cuenta es ...
    , texto_102                       VARCHAR2(200)             --21 texto fijo 102.
    , cod_cuenta_CUD                  VARCHAR2(200)             --22 Cuenta CUD + portafolio
    , confir_carta_nomb               VARCHAR2(200)             --23 Nombre confirmación
    , confir_carta_tele               VARCHAR2(200)             --24 Telefono confirmación
    , confir_carta_exte               VARCHAR2(200)             --25 Extención confirmación
    , confir_sebra_nomb               VARCHAR2(200)             --26 Nombre contacto sebra
    , confir_sebra_tele               VARCHAR2(200)             --27 Telefono contacto sebra
    , confir_sebra_exte               VARCHAR2(200)             --28 extensión contacto sebra
);
--
TYPE ty_data_sebra_e_c IS TABLE OF ty_data_sebra_e INDEX BY BINARY_INTEGER;
vg_data_sebra_e ty_data_sebra_e_c;
TYPE ty_data_sebra_e_c_return IS TABLE OF ty_data_sebra_e;
--
-------------------------------------------------------------------------------------------------
/**
 * Tipo para el manejo de Retornos en los reportes de egreso
*/
TYPE ty_data_sebra IS RECORD(
      ing_egr                         VARCHAR2(50)
    , fijo_formato                    VARCHAR2(50)              --2  Valor fijo Formato movimiento    
    , fijo_codigo                     VARCHAR2(50)              --3  Valor fijo Código FID
    , ciudad_fecha                    VARCHAR2(200)             --4  Ciudad Asociada al banco
    , nomb_banco                      VARCHAR2(100)             --5  Nombre del banco
    , dest_carta                      VARCHAR2(200)             --6  Destinatario de la carta
    , carg_dest_carta                 VARCHAR2(200)             --7  Cargo destinatario de la carta
    , dire_dest_carta                 VARCHAR2(200)             --8  Dirección del destinatario de la carta
    , ciud_dest_carta                 VARCHAR2(200)             --9  Ciudad destino de la carta
    , fax_dest_carta                  VARCHAR2(200)             --10 Fax des destinatario de la carta
    , tele_dest_carta                 VARCHAR2(200)             --11 Telefeno destinatario de la carta
    , emai_dest_carta                 VARCHAR2(200)             --12 Correo Electronico del destinatario de la carta 
    , refe_carta                      VARCHAR2(200)             --13 Referencia de la carta
    , texto_informa                   VARCHAR2(200)             --14 Texto fijo Solicitamos cargar...
    , cod_cuenta                      VARCHAR2(40)              --15 Cuenta bancaria del aporte
    , texto_suma                      VARCHAR2(200)             --16 Texto suma  
    , valor_tras_num                  VARCHAR2(200)             --16 Valor del traslado en número
    , valor_tras_let                  VARCHAR2(200)             --17 Valor del traslado en letras
    , texto_para                      VARCHAR2(1000)             --18 Texto fijo para que este ...
    , vari_dos                        VARCHAR2(1000)            --19 Variable # 2
    , texto_cuenta                    VARCHAR2(500)             --20 Texto fijo Esta cuenta es ...
    , texto_102                       VARCHAR2(200)             --21 texto fijo 102.
    , texto_para_in                   VARCHAR2(1000)
    , texto_sucur_in                  VARCHAR2(1000)
    , texto_concep_IN                 VARCHAR2(1000)
    , cod_cuenta_CUD                  VARCHAR2(200)             --22 Cuenta CUD + portafolio
    , confir_carta_nomb               VARCHAR2(200)             --23 Nombre confirmación
    , confir_carta_tele               VARCHAR2(200)             --24 Telefono confirmación
    , confir_carta_exte               VARCHAR2(200)             --25 Extención confirmación
    , confir_sebra_nomb               VARCHAR2(200)             --26 Nombre contacto sebra
    , confir_sebra_tele               VARCHAR2(200)             --27 Telefono contacto sebra
    , confir_sebra_exte               VARCHAR2(200)             --28 extensión contacto sebra
);
--
TYPE ty_data_sebra_c IS TABLE OF ty_data_sebra INDEX BY BINARY_INTEGER;
vg_data_sebra ty_data_sebra_c;
TYPE ty_data_sebra_c_return IS TABLE OF ty_data_sebra;
--
-------------------------------------------------------------------------------------------------
--Procedure - Function
-------------------------------------------------------------------------------------------------
--
/** 
 * llenar el tipo con toda la información correspondiente al reporte de ingreso
 * @param p_traslado Número de traslado
 */
FUNCTION ws_fn_acx_fill_sebra_i (p_traslado tbl_ttrasebra.tras_tras%TYPE 
                               ) RETURN BOOLEAN;
/** 
 * Exponer todas las control Accounts y su respectiva sociedad con la estructura WBS por ID de Proyecto entregado
 * @param p_traslado Número de traslado
 */
FUNCTION ws_fn_acx_get_sebra_i (p_traslado tbl_ttrasebra.tras_tras%TYPE
                              ) RETURN ty_data_sebra_i_c_return PIPELINED;
--
-------------------------------------------------------------------------------------------------
/** 
 * llenar el tipo con toda la información correspondiente al reporte de egreso
 * @param p_traslado Número de traslado
 */
FUNCTION ws_fn_acx_fill_sebra_e (p_traslado tbl_ttrasebra.tras_tras%TYPE 
                               ) RETURN BOOLEAN;
/** 
 * Exponer todas las control Accounts y su respectiva sociedad con la estructura WBS por ID de Proyecto entregado
 * @param p_traslado Número de traslado
 */
FUNCTION ws_fn_acx_get_sebra_e (p_traslado tbl_ttrasebra.tras_tras%TYPE
                              ) RETURN ty_data_sebra_e_c_return PIPELINED;
--
-------------------------------------------------------------------------------------------------
/** 
 * llenar el tipo con toda la información correspondiente al reporte de egreso
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
--
-------------------------------------------------------------------------------------------------
--
END tbl_qvpl_bogo;
/
prompt
prompt PACKAGE BODY: tbl_qvpl_bogo
prompt
--
CREATE OR REPLACE PACKAGE BODY tbl_qvpl_bogo IS
--
-- #VERSION: 1001
--
FUNCTION ws_fn_acx_fill_sebra_i (p_traslado tbl_ttrasebra.tras_tras%TYPE
                               ) RETURN BOOLEAN IS
    --
    CURSOR c_tras IS
        SELECT 'Formato Movimiento Recursos por SEBRA'                                                                                      fijo_formato
             , 'Código FID-REG-GI-48 Versión 1.0'                                                                                           fijo_codigo
             , infb_ciudad||', '|| to_char(tras_fecha, 'dd')||' de '
               ||RTRIM(to_char(tras_fecha, 'Month', 'NLS_DATE_LANGUAGE=SPANISH'))
               ||' de '||to_char(tras_fecha, 'yyyy')                                                                                        ciudad_fecha
             , banc_descripcion                                                                                                             nomb_banco
             , infb_desti                                                                                                                   dest_carta
             , infb_cargo                                                                                                                   carg_dest_carta
             , infb_dir                                                                                                                     dire_dest_carta
             , infb_ciudad                                                                                                                  ciud_dest_carta
             , infb_fax                                                                                                                     fax_dest_carta 
             , infb_telefono                                                                                                                tele_dest_carta
             , cori_email                                                                                                                   emai_dest_carta
             , infb_ref                                                                                                                     refe_carta
             , 'Me permito informar que a traves del Sistema S.E.B.R.A les abonaremos (credito) la suma de '                                texto_informa
             , RTRIM(LTRIM(TO_CHAR(tras_valor,'L99G999G999G999G999G999G999D99MI','NLS_NUMERIC_CHARACTERS = '',.''NLS_CURRENCY = ''$ ''')))  valor_tras_num
             , tbl_qreporsebra.fn_numero_a_texto(tras_valor)                                                                                valor_tras_let
             , 'para que dicho valor sea abonado a la cuenta de ahorros del banco de Bogotá No. '                                           texto_para
             , cue.cuen_nrocta                                                                                                              cod_cuenta
             , 'Sucursal principal bta,'                                                                                                    texto_sucur
             , 'por concepto de traslado de fondos por compensación de liquidación de titulos valores en DCV.'                              texto_concep
             , tbl_qreporsebra.fn_valor_variable (2)                                                                                        vari_dos
             , 'Esta cuenta es exenta para la compensación y liquidación de titulos valores y el código de transacción a utilizar es el '   texto_cuenta
             , '102.'                                                                                                                       texto_102
             , 'CUENTA SEBRA '||cud.cuen_nrocta||' PORTAFOLIO 0'                                                                            cod_cuenta_CUD
             , cc.cont_nombre                                                                                                               confir_carta_nomb
             , cc.cont_telefono                                                                                                             confir_carta_tele
             , cc.cont_extension                                                                                                            confir_carta_exte
             , cs.cont_nombre                                                                                                               confir_sebra_nomb
             , cs.cont_telefono                                                                                                             confir_sebra_tele
             , cs.cont_extension                                                                                                            confir_sebra_exte
          FROM tbl_ttrasebra
             , tbl_tinfbancos
             , tbl_tempresas
             , gen_tlistas
             , tbl_tcuentasban cud
             , tbl_tcuentasban cue
             , tbl_tbancos
             , tbl_tcorinfbanc
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
           AND tras_cuen_cud  = cud.cuen_cuen
           AND tras_cuen      = cue.cuen_cuen
           AND tras_banc      = banc_banc
           AND cori_infb      = infb_infb
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
    vg_data_sebra_i.DELETE;
    --
    vg_data_sebra_i(0).fijo_formato      := NULL;
    vg_data_sebra_i(0).fijo_codigo       := NULL;
    vg_data_sebra_i(0).ciudad_fecha      := NULL;
    vg_data_sebra_i(0).nomb_banco        := NULL;
    vg_data_sebra_i(0).dest_carta        := NULL;
    vg_data_sebra_i(0).carg_dest_carta   := NULL;
    vg_data_sebra_i(0).dire_dest_carta   := NULL;
    vg_data_sebra_i(0).ciud_dest_carta   := NULL;
    vg_data_sebra_i(0).fax_dest_carta    := NULL;
    vg_data_sebra_i(0).tele_dest_carta   := NULL;
    vg_data_sebra_i(0).emai_dest_carta   := NULL;
    vg_data_sebra_i(0).refe_carta        := NULL;
    vg_data_sebra_i(0).texto_informa     := NULL;
    vg_data_sebra_i(0).valor_tras_num    := NULL;
    vg_data_sebra_i(0).valor_tras_let    := NULL;
    vg_data_sebra_i(0).texto_para        := NULL;
    vg_data_sebra_i(0).cod_cuenta        := NULL;
    vg_data_sebra_i(0).texto_sucur       := NULL;
    vg_data_sebra_i(0).texto_concep      := NULL;
    vg_data_sebra_i(0).vari_dos          := NULL;
    vg_data_sebra_i(0).texto_cuenta      := NULL;
    vg_data_sebra_i(0).texto_102         := NULL;
    vg_data_sebra_i(0).cod_cuenta_CUD    := NULL;
    vg_data_sebra_i(0).confir_carta_nomb := NULL;
    vg_data_sebra_i(0).confir_carta_tele := NULL;
    vg_data_sebra_i(0).confir_carta_exte := NULL;
    vg_data_sebra_i(0).confir_sebra_nomb := NULL;
    vg_data_sebra_i(0).confir_sebra_tele := NULL;
    vg_data_sebra_i(0).confir_sebra_exte := NULL;
    --
    FOR i IN c_tras LOOP
        --
        vg_data_sebra_i(v_count).fijo_formato      := i.fijo_formato     ;
        vg_data_sebra_i(v_count).fijo_codigo       := i.fijo_codigo      ;
        vg_data_sebra_i(v_count).ciudad_fecha      := i.ciudad_fecha     ;
        vg_data_sebra_i(v_count).nomb_banco        := i.nomb_banco       ;
        vg_data_sebra_i(v_count).dest_carta        := i.dest_carta       ;
        vg_data_sebra_i(v_count).carg_dest_carta   := i.carg_dest_carta  ;
        vg_data_sebra_i(v_count).dire_dest_carta   := i.dire_dest_carta  ;
        vg_data_sebra_i(v_count).ciud_dest_carta   := i.ciud_dest_carta  ;
        vg_data_sebra_i(v_count).fax_dest_carta    := i.fax_dest_carta   ;
        vg_data_sebra_i(v_count).tele_dest_carta   := i.tele_dest_carta  ;
        vg_data_sebra_i(v_count).emai_dest_carta   := i.emai_dest_carta  ;
        vg_data_sebra_i(v_count).refe_carta        := i.refe_carta       ;
        vg_data_sebra_i(v_count).texto_informa     := i.texto_informa    ;
        vg_data_sebra_i(v_count).valor_tras_num    := i.valor_tras_num   ;
        vg_data_sebra_i(v_count).valor_tras_let    := i.valor_tras_let   ;
        vg_data_sebra_i(v_count).texto_para        := i.texto_para       ;
        vg_data_sebra_i(v_count).cod_cuenta        := i.cod_cuenta       ;
        vg_data_sebra_i(v_count).texto_sucur       := i.texto_sucur      ;
        vg_data_sebra_i(v_count).texto_concep      := i.texto_concep     ;
        vg_data_sebra_i(v_count).vari_dos          := i.vari_dos         ;
        vg_data_sebra_i(v_count).texto_cuenta      := i.texto_cuenta     ;
        vg_data_sebra_i(v_count).texto_102         := i.texto_102        ;
        vg_data_sebra_i(v_count).cod_cuenta_CUD    := i.cod_cuenta_CUD   ;
        vg_data_sebra_i(v_count).confir_carta_nomb := i.confir_carta_nomb;
        vg_data_sebra_i(v_count).confir_carta_tele := i.confir_carta_tele;
        vg_data_sebra_i(v_count).confir_carta_exte := i.confir_carta_exte;
        vg_data_sebra_i(v_count).confir_sebra_nomb := i.confir_sebra_nomb;
        vg_data_sebra_i(v_count).confir_sebra_tele := i.confir_sebra_tele;
        vg_data_sebra_i(v_count).confir_sebra_exte := i.confir_sebra_exte;
        --
        v_count := v_count + 1;
        --
    END LOOP c_tras;
    --
    RETURN TRUE;
    --
END ws_fn_acx_fill_sebra_i;
-------------------------------------------------------------------------------------------------
FUNCTION ws_fn_acx_get_sebra_i (p_traslado tbl_ttrasebra.tras_tras%TYPE
                              ) RETURN ty_data_sebra_i_c_return PIPELINED IS
    --
    v_fill_data BOOLEAN;
    l_index     PLS_INTEGER;
    --
BEGIN
    --
    v_fill_data := ws_fn_acx_fill_sebra_i(p_traslado);
    --
    IF v_fill_data THEN
        --
        l_index := vg_data_sebra_i.FIRST;
        --
        IF vg_data_sebra_i.count > 0 THEN
            --
            WHILE (l_index IS NOT NULL) LOOP
                --
                pipe row(vg_data_sebra_i(l_index));
                l_index := vg_data_sebra_i.NEXT(l_index);
                --
            END LOOP;
            --
        END IF;
        --
    END IF;
    --
    RETURN;
    --
END ws_fn_acx_get_sebra_i;
---------------------------------------------------------------------------------------------------
FUNCTION ws_fn_acx_fill_sebra_e (p_traslado tbl_ttrasebra.tras_tras%TYPE
                               ) RETURN BOOLEAN IS
    --
    CURSOR c_tras IS
        SELECT 'Formato Movimiento Recursos por SEBRA'                                                                                      fijo_formato
             , 'Código FID-REG-GI-48 Versión 1.0'                                                                                           fijo_codigo
             , infb_ciudad||', '|| to_char(tras_fecha, 'dd')||' de '
               ||RTRIM(to_char(tras_fecha, 'Month', 'NLS_DATE_LANGUAGE=SPANISH'))
               ||' de '||to_char(tras_fecha, 'yyyy')                                                                                        ciudad_fecha
             , banc_descripcion                                                                                                             nomb_banco
             , infb_desti                                                                                                                   dest_carta
             , infb_cargo                                                                                                                   carg_dest_carta
             , infb_dir                                                                                                                     dire_dest_carta
             , infb_ciudad                                                                                                                  ciud_dest_carta
             , infb_fax                                                                                                                     fax_dest_carta 
             , infb_telefono                                                                                                                tele_dest_carta
             , cori_email                                                                                                                   emai_dest_carta
             , infb_ref                                                                                                                     refe_carta
             , 'Solicitamos cargar (DEBITAR) nuestra cuenta corriente No. '                                                                 texto_informa
             , cue.cuen_nrocta                                                                                                              cod_cuenta
             , 'por la suma de '                                                                                                            texto_suma
             , RTRIM(LTRIM(TO_CHAR(tras_valor,'L99G999G999G999G999G999G999D99MI','NLS_NUMERIC_CHARACTERS = '',.''NLS_CURRENCY = ''$ ''')))  valor_tras_num
             , tbl_qreporsebra.fn_numero_a_texto(tras_valor)                                                                                valor_tras_let
             , 'para que este valor sea abonado a través del sistema SEBRA a la Cuenta de Deposito No. '||cud.cuen_nrocta|| ' portafolio 0 en el Banco de la Republica a nombre de FIDUCIARIA CORFICOLOMBIANA SA, por concepto de compensación y liquidación de titulos valores en DCV.' texto_para
             , tbl_qreporsebra.fn_valor_variable (2)                                                                                        vari_dos
             , 'Esta cuenta es exenta para la compensación y liquidación de titulos valores y el código de transacción a utilizar es el '   texto_cuenta
             , '102.'                                                                                                                       texto_102
             , 'CUENTA SEBRA '||cud.cuen_nrocta||' PORTAFOLIO 0'                                                                            cod_cuenta_CUD
             , cc.cont_nombre                                                                                                               confir_carta_nomb
             , cc.cont_telefono                                                                                                             confir_carta_tele
             , cc.cont_extension                                                                                                            confir_carta_exte
             , cs.cont_nombre                                                                                                               confir_sebra_nomb
             , cs.cont_telefono                                                                                                             confir_sebra_tele
             , cs.cont_extension                                                                                                            confir_sebra_exte
          FROM tbl_ttrasebra
             , tbl_tinfbancos
             , tbl_tempresas
             , gen_tlistas
             , tbl_tcuentasban cud
             , tbl_tcuentasban cue
             , tbl_tbancos
             , tbl_tcorinfbanc
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
           AND tras_cuen_cud  = cud.cuen_cuen
           AND tras_cuen      = cue.cuen_cuen
           AND tras_banc      = banc_banc
           AND cori_infb      = infb_infb
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
    vg_data_sebra_e.DELETE;
    --
    vg_data_sebra_e(0).fijo_formato      := NULL;
    vg_data_sebra_e(0).fijo_codigo       := NULL;
    vg_data_sebra_e(0).ciudad_fecha      := NULL;
    vg_data_sebra_e(0).nomb_banco        := NULL;
    vg_data_sebra_e(0).dest_carta        := NULL;
    vg_data_sebra_e(0).carg_dest_carta   := NULL;
    vg_data_sebra_e(0).dire_dest_carta   := NULL;
    vg_data_sebra_e(0).ciud_dest_carta   := NULL;
    vg_data_sebra_e(0).fax_dest_carta    := NULL;
    vg_data_sebra_e(0).tele_dest_carta   := NULL;
    vg_data_sebra_e(0).emai_dest_carta   := NULL;
    vg_data_sebra_e(0).refe_carta        := NULL;
    vg_data_sebra_e(0).texto_informa     := NULL;
    vg_data_sebra_e(0).cod_cuenta        := NULL;
    vg_data_sebra_e(0).texto_suma        := NULL;
    vg_data_sebra_e(0).valor_tras_num    := NULL;
    vg_data_sebra_e(0).valor_tras_let    := NULL;
    vg_data_sebra_e(0).texto_para        := NULL;
    vg_data_sebra_e(0).vari_dos          := NULL;
    vg_data_sebra_e(0).texto_cuenta      := NULL;
    vg_data_sebra_e(0).texto_102         := NULL;
    vg_data_sebra_e(0).cod_cuenta_CUD    := NULL;
    vg_data_sebra_e(0).confir_carta_nomb := NULL;
    vg_data_sebra_e(0).confir_carta_tele := NULL;
    vg_data_sebra_e(0).confir_carta_exte := NULL;
    vg_data_sebra_e(0).confir_sebra_nomb := NULL;
    vg_data_sebra_e(0).confir_sebra_tele := NULL;
    vg_data_sebra_e(0).confir_sebra_exte := NULL;
    --
    FOR i IN c_tras LOOP
        --
        vg_data_sebra_e(v_count).fijo_formato      := i.fijo_formato     ;
        vg_data_sebra_e(v_count).fijo_codigo       := i.fijo_codigo      ;
        vg_data_sebra_e(v_count).ciudad_fecha      := i.ciudad_fecha     ;
        vg_data_sebra_e(v_count).nomb_banco        := i.nomb_banco       ;
        vg_data_sebra_e(v_count).dest_carta        := i.dest_carta       ;
        vg_data_sebra_e(v_count).carg_dest_carta   := i.carg_dest_carta  ;
        vg_data_sebra_e(v_count).dire_dest_carta   := i.dire_dest_carta  ;
        vg_data_sebra_e(v_count).ciud_dest_carta   := i.ciud_dest_carta  ;
        vg_data_sebra_e(v_count).fax_dest_carta    := i.fax_dest_carta   ;
        vg_data_sebra_e(v_count).tele_dest_carta   := i.tele_dest_carta  ;
        vg_data_sebra_e(v_count).emai_dest_carta   := i.emai_dest_carta  ;
        vg_data_sebra_e(v_count).refe_carta        := i.refe_carta       ;
        vg_data_sebra_e(v_count).texto_informa     := i.texto_informa    ;
        vg_data_sebra_e(v_count).cod_cuenta        := i.cod_cuenta       ;
        vg_data_sebra_e(v_count).texto_suma        := i.texto_suma       ;
        vg_data_sebra_e(v_count).valor_tras_num    := i.valor_tras_num   ;
        vg_data_sebra_e(v_count).valor_tras_let    := i.valor_tras_let   ;
        vg_data_sebra_e(v_count).texto_para        := i.texto_para       ;
        vg_data_sebra_e(v_count).vari_dos          := i.vari_dos         ;
        vg_data_sebra_e(v_count).texto_cuenta      := i.texto_cuenta     ;
        vg_data_sebra_e(v_count).texto_102         := i.texto_102        ;
        vg_data_sebra_e(v_count).cod_cuenta_CUD    := i.cod_cuenta_CUD   ;
        vg_data_sebra_e(v_count).confir_carta_nomb := i.confir_carta_nomb;
        vg_data_sebra_e(v_count).confir_carta_tele := i.confir_carta_tele;
        vg_data_sebra_e(v_count).confir_carta_exte := i.confir_carta_exte;
        vg_data_sebra_e(v_count).confir_sebra_nomb := i.confir_sebra_nomb;
        vg_data_sebra_e(v_count).confir_sebra_tele := i.confir_sebra_tele;
        vg_data_sebra_e(v_count).confir_sebra_exte := i.confir_sebra_exte;
        --
        v_count := v_count + 1;
        --
    END LOOP c_tras;
    --
    RETURN TRUE;
    --
END ws_fn_acx_fill_sebra_e;
-------------------------------------------------------------------------------------------------
FUNCTION ws_fn_acx_get_sebra_e (p_traslado tbl_ttrasebra.tras_tras%TYPE
                              ) RETURN ty_data_sebra_e_c_return PIPELINED IS
    --
    v_fill_data BOOLEAN;
    l_index     PLS_INTEGER;
    --
BEGIN
    --
    v_fill_data := ws_fn_acx_fill_sebra_e(p_traslado);
    --
    IF v_fill_data THEN
        --
        l_index := vg_data_sebra_e.FIRST;
        --
        IF vg_data_sebra_e.count > 0 THEN
            --
            WHILE (l_index IS NOT NULL) LOOP
                --
                pipe row(vg_data_sebra_e(l_index));
                l_index := vg_data_sebra_e.NEXT(l_index);
                --
            END LOOP;
            --
        END IF;
        --
    END IF;
    --
    RETURN;
    --
END ws_fn_acx_get_sebra_e;
---------------------------------------------------------------------------------------------------
FUNCTION ws_fn_acx_fill_sebra (p_traslado tbl_ttrasebra.tras_tras%TYPE
                               ) RETURN BOOLEAN IS
    --
    CURSOR c_tras IS
        SELECT list_sigla                                                                                                                   ing_egr
             , 'Formato Movimiento Recursos por SEBRA'                                                                                      fijo_formato
             , 'Código FID-REG-GI-48 Versión 1.0'                                                                                           fijo_codigo
             , infb_ciudad||', '|| to_char(tras_fecha, 'dd')||' de '
               ||RTRIM(to_char(tras_fecha, 'Month', 'NLS_DATE_LANGUAGE=SPANISH'))
               ||' de '||to_char(tras_fecha, 'yyyy')                                                                                        ciudad_fecha
             , banc_descripcion                                                                                                             nomb_banco
             , infb_desti                                                                                                                   dest_carta
             , infb_cargo                                                                                                                   carg_dest_carta
             , infb_dir                                                                                                                     dire_dest_carta
             , infb_ciudad                                                                                                                  ciud_dest_carta
             , infb_fax                                                                                                                     fax_dest_carta 
             , infb_telefono                                                                                                                tele_dest_carta
             , cori_email                                                                                                                   emai_dest_carta
             , DECODE(list_sigla, 'E', infb_refegr, infb_ref)                                                                               refe_carta
             , DECODE(list_sigla, 'E', 'Solicitamos cargar (DEBITAR) nuestra cuenta corriente No. '
                                     , 'Me permito informar que a traves del Sistema S.E.B.R.A les abonaremos (credito) la suma de ')       texto_informa
             , cue.cuen_nrocta                                                                                                              cod_cuenta
             , 'por la suma de '                                                                                                            texto_suma
             , RTRIM(LTRIM(TO_CHAR(tras_valor,'L99G999G999G999G999G999G999D99MI','NLS_NUMERIC_CHARACTERS = '',.''NLS_CURRENCY = ''$ ''')))  valor_tras_num
             , tbl_qreporsebra.fn_numero_a_texto(tras_valor)                                                                                valor_tras_let
             --, 'para que este valor sea abonado a través del sistema SEBRA a la Cuenta de Deposito No. '||cud.cuen_nrocta|| ' portafolio 0 en el Banco de la Republica a nombre de FIDUCIARIA CORFICOLOMBIANA SA, por concepto de compensación y liquidación de titulos valores en DCV.' texto_para antes 1001 16/04/2024 Jmartinezm 
             , 'para que este valor sea abonado a través del sistema SEBRA a la Cuenta de Deposito No. '||infb_cuen_cud_cod|| ' portafolio '|| infb_portafolio ||' en el Banco de la Republica a nombre de FIDUCIARIA CORFICOLOMBIANA SA, por concepto de compensación y liquidación de titulos valores en DCV.' texto_para
             , tbl_qreporsebra.fn_valor_variable (2)                                                                                        vari_dos
             , DECODE(list_sigla, 'E' ,'Esta cuenta es exenta para la compensación y liquidación de titulos valores y el código de transacción a utilizar es el ', null)  texto_cuenta
             , DECODE(list_sigla, 'E', '102.', NULL)                                                                                        texto_102
             --, 'CUENTA SEBRA '||cud.cuen_nrocta||' PORTAFOLIO 0'                                                                          cod_cuenta_CUD antes 1001 16/04/2024 Jmartinezm  
             , DECODE(list_sigla, 'E', 'CUENTA SEBRA '||infb_cuen_cud_cod||' PORTAFOLIO ' || infb_portafolio , null)                        cod_cuenta_CUD
             , 'para que dicho valor sea abonado a la cuenta de ahorros del banco de Bogotá No. '                                           texto_para_in
             , 'Sucursal principal bta,'                                                                                                    texto_sucur_in
             , 'por concepto de traslado de fondos por compensación de liquidación de titulos valores en DCV.'                              texto_concep_IN
             , cc.cont_nombre                                                                                                               confir_carta_nomb
             , cc.cont_telefono                                                                                                             confir_carta_tele
             , cc.cont_extension                                                                                                            confir_carta_exte
             , cs.cont_nombre                                                                                                               confir_sebra_nomb
             , cs.cont_telefono                                                                                                             confir_sebra_tele
             , cs.cont_extension                                                                                                            confir_sebra_exte
          FROM tbl_ttrasebra
             , tbl_tinfbancos
             , tbl_tempresas
             , gen_tlistas
             --, tbl_tcuentasban cud antes 1001 16/04/2024 Jmartinezm 
             , tbl_tcuentasban cue
             , tbl_tbancos
             , tbl_tcorinfbanc
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
           AND tras_banc      = banc_banc
           AND cori_infb      = infb_infb
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
    vg_data_sebra(0).fijo_formato      := NULL;
    vg_data_sebra(0).fijo_codigo       := NULL;
    vg_data_sebra(0).ciudad_fecha      := NULL;
    vg_data_sebra(0).nomb_banco        := NULL;
    vg_data_sebra(0).dest_carta        := NULL;
    vg_data_sebra(0).carg_dest_carta   := NULL;
    vg_data_sebra(0).dire_dest_carta   := NULL;
    vg_data_sebra(0).ciud_dest_carta   := NULL;
    vg_data_sebra(0).fax_dest_carta    := NULL;
    vg_data_sebra(0).tele_dest_carta   := NULL;
    vg_data_sebra(0).emai_dest_carta   := NULL;
    vg_data_sebra(0).refe_carta        := NULL;
    vg_data_sebra(0).texto_informa     := NULL;
    vg_data_sebra(0).cod_cuenta        := NULL;
    vg_data_sebra(0).texto_suma        := NULL;
    vg_data_sebra(0).valor_tras_num    := NULL;
    vg_data_sebra(0).valor_tras_let    := NULL;
    vg_data_sebra(0).texto_para        := NULL;
    vg_data_sebra(0).vari_dos          := NULL;
    vg_data_sebra(0).texto_cuenta      := NULL;
    vg_data_sebra(0).texto_102         := NULL;
    vg_data_sebra(0).texto_para_in     := NULL;
    vg_data_sebra(0).texto_sucur_in    := NULL;
    vg_data_sebra(0).texto_concep_IN   := NULL;
    vg_data_sebra(0).cod_cuenta_CUD    := NULL;
    vg_data_sebra(0).confir_carta_nomb := NULL;
    vg_data_sebra(0).confir_carta_tele := NULL;
    vg_data_sebra(0).confir_carta_exte := NULL;
    vg_data_sebra(0).confir_sebra_nomb := NULL;
    vg_data_sebra(0).confir_sebra_tele := NULL;
    vg_data_sebra(0).confir_sebra_exte := NULL;
    --
    FOR i IN c_tras LOOP
        --
        vg_data_sebra(v_count).ing_egr           := i.ing_egr          ;
        vg_data_sebra(v_count).fijo_formato      := i.fijo_formato     ;
        vg_data_sebra(v_count).fijo_codigo       := i.fijo_codigo      ;
        vg_data_sebra(v_count).ciudad_fecha      := i.ciudad_fecha     ;
        vg_data_sebra(v_count).nomb_banco        := i.nomb_banco       ;
        vg_data_sebra(v_count).dest_carta        := i.dest_carta       ;
        vg_data_sebra(v_count).carg_dest_carta   := i.carg_dest_carta  ;
        vg_data_sebra(v_count).dire_dest_carta   := i.dire_dest_carta  ;
        vg_data_sebra(v_count).ciud_dest_carta   := i.ciud_dest_carta  ;
        vg_data_sebra(v_count).fax_dest_carta    := i.fax_dest_carta   ;
        vg_data_sebra(v_count).tele_dest_carta   := i.tele_dest_carta  ;
        vg_data_sebra(v_count).emai_dest_carta   := i.emai_dest_carta  ;
        vg_data_sebra(v_count).refe_carta        := i.refe_carta       ;
        vg_data_sebra(v_count).texto_informa     := i.texto_informa    ;
        vg_data_sebra(v_count).cod_cuenta        := i.cod_cuenta       ;
        vg_data_sebra(v_count).texto_suma        := i.texto_suma       ;
        vg_data_sebra(v_count).valor_tras_num    := i.valor_tras_num   ;
        vg_data_sebra(v_count).valor_tras_let    := i.valor_tras_let   ;
        vg_data_sebra(v_count).texto_para        := i.texto_para       ;
        vg_data_sebra(v_count).vari_dos          := i.vari_dos         ;
        vg_data_sebra(v_count).texto_cuenta      := i.texto_cuenta     ;
        vg_data_sebra(v_count).texto_102         := i.texto_102        ;
        vg_data_sebra(v_count).texto_para_in     := i.texto_para_in    ;
        vg_data_sebra(v_count).texto_sucur_in    := i.texto_sucur_in   ;
        vg_data_sebra(v_count).texto_concep_IN   := i.texto_concep_in  ;
        vg_data_sebra(v_count).cod_cuenta_CUD    := i.cod_cuenta_CUD   ;
        vg_data_sebra(v_count).confir_carta_nomb := i.confir_carta_nomb;
        vg_data_sebra(v_count).confir_carta_tele := i.confir_carta_tele;
        vg_data_sebra(v_count).confir_carta_exte := i.confir_carta_exte;
        vg_data_sebra(v_count).confir_sebra_nomb := i.confir_sebra_nomb;
        vg_data_sebra(v_count).confir_sebra_tele := i.confir_sebra_tele;
        vg_data_sebra(v_count).confir_sebra_exte := i.confir_sebra_exte;
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
            WHILE (l_index IS NOT NULL) LOOP
                --
                pipe row(vg_data_sebra(l_index));
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
END tbl_qvpl_bogo;
/
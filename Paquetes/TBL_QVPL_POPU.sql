prompt
prompt PACKAGE: TBL_QVPL_POPU
prompt
create or replace PACKAGE tbl_qvpl_popu IS
--
-- Reúne funciones y procedimientos directamente relacionados con el procedimiento de las cartas vpl popular
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
    , fecha                           VARCHAR2(10)                --2  Fecha en que se registra el traslado
    , oficina                         VARCHAR2(200)               --3  Oficina asociada al banco
    , razon                           VARCHAR2(100)               --4  Nombre de la empresa que hace el traslado
    , nit                             VARCHAR2(200)               --5  Nit de la empresa que hace el traslado
    , val_fj6                         VARCHAR2(1000)              --6  Valor fijo campo 6
    , tip_cuen                        VARCHAR2(50)                --7  Tipo de cuenta a la cual se registra el retiro
    , num_cuen                        VARCHAR2(40)                --8  Número de cuenta a la cual se registra el retiro
    , ref_carta                       VARCHAR2(1000)              --9  Referencia de la carta
    , val_fj10                        VARCHAR2(1000)              --10 Valor fijo campo 10
    , cod_cuen_CUD                    VARCHAR2(40)                --11 Código de la cuenta CUD
    , val_fj12                        VARCHAR2(1000)              --12 Valor fijo campo 12
    , val_fj13                        VARCHAR2(1000)              --13 Valor fijo campo 13
    , valor_numero                    VARCHAR2(200)               --14 Valor del traslado en números  
    , valor_letras                    VARCHAR2(200)               --15 Valor del traslado en letras
    , concep_cud                      VARCHAR2(200)               --16 Concepto CUD
    , vari_6                          VARCHAR2(1000)              --17 Variale 6
    , vari_7                          VARCHAR2(1000)              --18 Variale 7
    , val_fj9                         VARCHAR2(1000)              --9  Valor fijo campo 9
    , vari_8                          VARCHAR2(1000)              --18 Variale 8
);
--
TYPE ty_data_sebra_c IS TABLE OF ty_data_sebra INDEX BY BINARY_INTEGER;
vg_data_sebra ty_data_sebra_c;
TYPE ty_data_sebra_c_return IS TABLE OF ty_data_sebra;
--
-------------------------------------------------------------------------------------------------
TYPE ty_data_sebrae IS RECORD(
      ciudad                          VARCHAR2(200)               --1  Ciudad Asociada al banco
    , fecha                           VARCHAR2(10)                --2  Fecha en que se registra el traslado
    , oficina                         VARCHAR2(200)               --3  Oficina asociada al banco
    , razon                           VARCHAR2(100)               --4  Nombre de la empresa que hace el traslado
    , nit                             VARCHAR2(200)               --5  Nit de la empresa que hace el traslado
    , val_fj6                         VARCHAR2(1000)              --6  Valor fijo campo 6
    , tip_cuen_reti_db                VARCHAR2(50)                --7  Tipo de cuenta a la cual se registra el retiro
    , num_cuen_reti_db                VARCHAR2(40)                --8  Número de cuenta a la cual se registra el retiro
    , ref_carta                       VARCHAR2(1000)              --9  Referencia de la carta
    , val_fj10                        VARCHAR2(1000)              --10 Valor fijo campo 10
    , cod_cuen_CUD_db                 VARCHAR2(40)                --11 Código de la cuenta CUD
    , val_fj12                        VARCHAR2(1000)              --12 Valor fijo campo 12
    , val_fj13                        VARCHAR2(1000)              --13 Valor fijo campo 13
    , valor_db_num                    VARCHAR2(200)               --14 Valor del traslado en números  
    , valor_db_let                    VARCHAR2(200)               --15 Valor del traslado en letras
    , concep_cud                      VARCHAR2(200)               --16 Concepto CUD
    , vari_6                          VARCHAR2(1000)              --17 Variale 6
    , vari_7                          VARCHAR2(1000)              --18 Variale 7
);
--
TYPE ty_data_sebrae_c IS TABLE OF ty_data_sebrae INDEX BY BINARY_INTEGER;
vg_data_sebrae ty_data_sebrae_c;
TYPE ty_data_sebrae_c_return IS TABLE OF ty_data_sebrae;
--
-------------------------------------------------------------------------------------------------
/**
 * Tipo para el manejo de Retornos en los reportes ingresos
*/
TYPE ty_data_sebrai IS RECORD(
      ciudad                          VARCHAR2(200)               --1  Ciudad Asociada al banco
    , fecha                           VARCHAR2(10)                --2  Fecha en que se registra el traslado
    , oficina                         VARCHAR2(200)               --3  Oficina asociada al banco
    , razon                           VARCHAR2(100)               --4  Nombre de la empresa que hace el traslado
    , nit                             VARCHAR2(200)               --5  Nit de la empresa que hace el traslado
    , val_fj6                         VARCHAR2(1000)              --6  Valor fijo campo 6
    , valor_db_num                    VARCHAR2(200)               --7  Valor del traslado en números  
    , valor_db_let                    VARCHAR2(200)               --8  Valor del traslado en letras
    , val_fj9                         VARCHAR2(1000)              --9  Valor fijo campo 9
    , cod_cuen_CUD_db                 VARCHAR2(40)                --10 Código de la cuenta CUD
    , tip_cuen_reti_db                VARCHAR2(50)                --11 Tipo de cuenta a la cual se registra el ingreso
    , num_cuen_reti_db                VARCHAR2(40)                --12 Número de cuenta a la cual se registra el ingreso
    , vari_8                          VARCHAR2(1000)              --18 Variale 8
);
--
TYPE ty_data_sebrai_c IS TABLE OF ty_data_sebrai INDEX BY BINARY_INTEGER;
vg_data_sebrai ty_data_sebrai_c;
TYPE ty_data_sebrai_c_return IS TABLE OF ty_data_sebrai;
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
/** 
 * llenar el tipo con toda la información correspondiente al reporte
 * @param p_traslado Número de traslado
 */
FUNCTION ws_fn_acx_fill_sebra_e (p_traslado tbl_ttrasebra.tras_tras%TYPE 
                               ) RETURN BOOLEAN;
/** 
 * Exponer todas las control Accounts y su respectiva sociedad con la estructura WBS por ID de Proyecto entregado
 * @param p_traslado Número de traslado
 */
FUNCTION ws_fn_acx_get_sebra_e (p_traslado tbl_ttrasebra.tras_tras%TYPE
                              ) RETURN ty_data_sebrae_c_return PIPELINED;
--
-------------------------------------------------------------------------------------------------
/** 
 * llenar el tipo con toda la información correspondiente al reporte
 * @param p_traslado Número de traslado
 */
FUNCTION ws_fn_acx_fill_sebra_i (p_traslado tbl_ttrasebra.tras_tras%TYPE 
                               ) RETURN BOOLEAN;
/** 
 * Exponer todas las control Accounts y su respectiva sociedad con la estructura WBS por ID de Proyecto entregado
 * @param p_traslado Número de traslado
 */
FUNCTION ws_fn_acx_get_sebra_i (p_traslado tbl_ttrasebra.tras_tras%TYPE
                              ) RETURN ty_data_sebrai_c_return PIPELINED;
--
-------------------------------------------------------------------------------------------------
--
END tbl_qvpl_popu;
/
prompt
prompt PACKAGE BODY: tbl_qvpl_popu
prompt
--
CREATE OR REPLACE PACKAGE BODY tbl_qvpl_popu IS
--
-- #VERSION: 1001
--
FUNCTION ws_fn_acx_fill_sebra (p_traslado tbl_ttrasebra.tras_tras%TYPE
                               ) RETURN BOOLEAN IS
    --
    CURSOR c_tras IS       
        SELECT list_sigla                                                                                                                                   ing_egr
             , infb_ciudad                                                                                                                                  ciudad          
             , to_char(tras_fecha, 'dd/mm/yyyy')                                                                                                            fecha    
             , infb_oficina                                                                                                                                 oficina
             , empr_descripcion                                                                                                                             razon                      
             , empr_nit||CASE WHEN empr_digito IS NOT NULL THEN '-'||empr_digito ELSE '' END                                                                nit
             , DECODE(list_sigla, 'E', 'Autorizamos transferencia de fondos a través del sistema SEBRA bajo las siguientes condiciones:'
                                     , 'Nos permitimos informarles que en la fecha estamos recibiendo una transferencia a través del sistema SEBRA así:')   val_fj6
             , DECODE(cue.cuen_tipo, 'CC', 'Cuenta Corriente', 'Cuenta de Ahorros')                                                                         tip_cuen
             , cue.cuen_nrocta                                                                                                                              num_cuen 
             , DECODE(list_sigla, 'E', infb_concep, NULL)                                                                                                   ref_carta
             , DECODE(list_sigla, 'E', 'EXENTA', NULL)                                                                                                      val_fj10
             --, cud.cuen_nrocta                                                                                                                            cod_cuen_CUD antes 1001 16/04/2024 Jmartinezm 
             , infb_cuen_cud_cod                                                                                                                            cod_cuen_CUD -- 1001 16/04/2024 Jmartinezm 
             , DECODE(list_sigla, 'E', 'FIDUCIARIA CORFICOLOMBIANA S.A', cue.cuen_nrocta)                                                                   val_fj12 -- 1001 16/04/2024 Jmartinezm         
             --, DECODE(list_sigla, 'E', '0', NULL)                                                                                                         val_fj13  antes 1001 16/04/2024 Jmartinezm  
             , DECODE(list_sigla, 'E', infb_portafolio, NULL)                                                                                               val_fj13  -- 1001 16/04/2024 Jmartinezm 
             , RTRIM(LTRIM(TO_CHAR(tras_valor,'L99G999G999G999G999G999G999D99MI','NLS_NUMERIC_CHARACTERS = '',.''NLS_CURRENCY = ''$ ''')))                  valor_numero
             , tbl_qreporsebra.fn_numero_a_texto(tras_valor)                                                                                                valor_letras
             , DECODE(list_sigla, 'E', infb_concep, NULL)                                                                                                   concep_cud
             , DECODE(list_sigla, 'E', tbl_qreporsebra.fn_valor_variable (6), NULL)                                                                         vari_6
             , DECODE(list_sigla, 'E', tbl_qreporsebra.fn_valor_variable (7), NULL)                                                                         vari_7
             , DECODE(list_sigla, 'I', 'FIDUCIARIA CORFICOLOMBIANA S.A. FCORFICOLOMBIANA', NULL)                                                            val_fj9
             , DECODE(list_sigla, 'I', tbl_qreporsebra.fn_valor_variable (8), NULL)                                                                         vari_8
          FROM tbl_ttrasebra
             , tbl_tinfbancos
             , tbl_tempresas
             , gen_tlistas
             --, tbl_tcuentasban cud antes 1001 16/04/2024 Jmartinezm 
             , tbl_tcuentasban cue
         WHERE tras_banc      = infb_banc
           AND tras_empr      = empr_empr
           AND tras_tipo_oper = list_list
           --AND tras_cuen_cud  = cud.cuen_cuen antes 1001 16/04/2024 Jmartinezm 
           AND tras_cuen      = cue.cuen_cuen
           AND tras_tras      = p_traslado
        ;
    --
    r_tras  c_tras%ROWTYPE;
    --
BEGIN
    --
    OPEN  c_tras;
    FETCH c_tras INTO r_tras;
    CLOSE c_tras;
    --
    vg_data_sebra(1).ing_egr      := r_tras.ing_egr     ; --0  I-Ingreso - E-Egreso
    vg_data_sebra(1).ciudad       := r_tras.ciudad      ; --1  Ciudad Asociada al banco
    vg_data_sebra(1).fecha        := r_tras.fecha       ; --2  Fecha en que se registra el traslado
    vg_data_sebra(1).oficina      := r_tras.oficina     ; --3  Oficina asociada al banco
    vg_data_sebra(1).razon        := r_tras.razon       ; --4  Nombre de la empresa que hace el traslado
    vg_data_sebra(1).nit          := r_tras.nit         ; --5  Nit de la empresa que hace el traslado
    vg_data_sebra(1).val_fj6      := r_tras.val_fj6     ; --6  Valor fijo campo 6
    vg_data_sebra(1).tip_cuen     := r_tras.tip_cuen    ; --7  Tipo de cuenta a la cual se registra el retiro
    vg_data_sebra(1).num_cuen     := r_tras.num_cuen    ; --8  Número de cuenta a la cual se registra el retiro
    vg_data_sebra(1).ref_carta    := r_tras.ref_carta   ; --9  Referencia de la carta
    vg_data_sebra(1).val_fj10     := r_tras.val_fj10    ; --10 Valor fijo campo 10
    vg_data_sebra(1).cod_cuen_CUD := r_tras.cod_cuen_CUD; --11 Código de la cuenta CUD
    vg_data_sebra(1).val_fj12     := r_tras.val_fj12    ; --12 Valor fijo campo 12
    vg_data_sebra(1).val_fj13     := r_tras.val_fj13    ; --13 Valor fijo campo 13
    vg_data_sebra(1).valor_numero := r_tras.valor_numero; --14 Valor del traslado en números  
    vg_data_sebra(1).valor_letras := r_tras.valor_letras; --15 Valor del traslado en letras
    vg_data_sebra(1).concep_cud   := r_tras.concep_cud  ; --16 Concepto CUD
    vg_data_sebra(1).vari_6       := r_tras.vari_6      ; --17 Variale 6
    vg_data_sebra(1).vari_7       := r_tras.vari_7      ; --18 Variale 7
    vg_data_sebra(1).val_fj9      := r_tras.val_fj9     ; --9  Valor fijo campo 9
    vg_data_sebra(1).vari_8       := r_tras.vari_8      ; --18 Variale 8
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
--
FUNCTION ws_fn_acx_fill_sebra_e (p_traslado tbl_ttrasebra.tras_tras%TYPE
                               ) RETURN BOOLEAN IS
    --
    CURSOR c_tras IS
        SELECT infb_ciudad                                                                                                                  ciudad          
             , to_char(tras_fecha, 'dd/mm/yyyy')                                                                                            fecha    
             , infb_oficina                                                                                                                 oficina
             , empr_descripcion                                                                                                             razon           
             , empr_nit||CASE WHEN empr_digito IS NOT NULL THEN '-'||empr_digito ELSE '' END                                              nit
             , 'Autorizamos transferencia de fondos a través del sistema SEBRA bajo las siguientes condiciones:'                            val_fj6
             , DECODE(cue.cuen_tipo, 'CC', 'Cuenta Corriente', 'Cuenta de Ahorros')                                                         tip_cuen_reti_db
             , cue.cuen_nrocta                                                                                                              num_cuen_reti_db 
             , infb_ref                                                                                                                     ref_carta
             , 'EXENTA'                                                                                                                     val_fj10
             , cud.cuen_nrocta                                                                                                              cod_cuen_CUD_db
             , 'FIDUCIARIA CORFICOLOMBIANA S.A'                                                                                             val_fj12        
             , '0'                                                                                                                          val_fj13
             , RTRIM(LTRIM(TO_CHAR(tras_valor,'L99G999G999G999G999G999G999D99MI','NLS_NUMERIC_CHARACTERS = '',.''NLS_CURRENCY = ''$ ''')))  valor_db_num
             , tbl_qreporsebra.fn_numero_a_texto(tras_valor)                                                                                valor_db_let
             , infb_concep                                                                                                                  concep_cud
             , tbl_qreporsebra.fn_valor_variable (6)                                                                                        vari_6
             , tbl_qreporsebra.fn_valor_variable (7)                                                                                        vari_7
          FROM tbl_ttrasebra
             , tbl_tinfbancos
             , tbl_tempresas
             , tbl_tcuentasban cud
             , tbl_tcuentasban cue
         WHERE tras_banc      = infb_banc
           AND tras_empr      = empr_empr
           AND tras_cuen_cud  = cud.cuen_cuen
           AND tras_cuen      = cue.cuen_cuen
           AND tras_tras      = p_traslado
        ;
    --
    r_tras  c_tras%ROWTYPE;
    --
BEGIN
    --
    OPEN  c_tras;
    FETCH c_tras INTO r_tras;
    CLOSE c_tras;
    --
    vg_data_sebrae(1).ciudad           := r_tras.ciudad          ;  --1  Ciudad Asociada al banco
    vg_data_sebrae(1).fecha            := r_tras.fecha           ;  --2  Fecha en que se registra el traslado
    vg_data_sebrae(1).oficina          := r_tras.oficina         ;  --3  Oficina asociada al banco
    vg_data_sebrae(1).razon            := r_tras.razon           ;  --4  Nombre de la empresa que hace el traslado
    vg_data_sebrae(1).nit              := r_tras.nit             ;  --5  Nit de la empresa que hace el traslado
    vg_data_sebrae(1).val_fj6          := r_tras.val_fj6         ;  --6  Valor fijo campo 6
    vg_data_sebrae(1).tip_cuen_reti_db := r_tras.tip_cuen_reti_db;  --7  Tipo de cuenta a la cual se registra el retiro
    vg_data_sebrae(1).num_cuen_reti_db := r_tras.num_cuen_reti_db;  --8  Número de cuenta a la cual se registra el retiro
    vg_data_sebrae(1).ref_carta        := r_tras.ref_carta       ;  --9  Referencia de la carta
    vg_data_sebrae(1).val_fj10         := r_tras.val_fj10        ;  --10 Valor fijo campo 10
    vg_data_sebrae(1).cod_cuen_CUD_db  := r_tras.cod_cuen_CUD_db ;  --11 Código de la cuenta CUD
    vg_data_sebrae(1).val_fj12         := r_tras.val_fj12        ;  --12 Valor fijo campo 12
    vg_data_sebrae(1).val_fj13         := r_tras.val_fj13        ;  --13 Valor fijo campo 13
    vg_data_sebrae(1).valor_db_num     := r_tras.valor_db_num    ;  --14 Valor del traslado en números  
    vg_data_sebrae(1).valor_db_let     := r_tras.valor_db_let    ;  --15 Valor del traslado en letras
    vg_data_sebrae(1).concep_cud       := r_tras.concep_cud      ;  --16 Concepto CUD
    vg_data_sebrae(1).vari_6           := r_tras.vari_6          ;  --17 Variale 6
    vg_data_sebrae(1).vari_7           := r_tras.vari_7          ;  --18 Variale 7
    --
    RETURN TRUE;
    --
END ws_fn_acx_fill_sebra_e;
-------------------------------------------------------------------------------------------------
FUNCTION ws_fn_acx_get_sebra_e (p_traslado tbl_ttrasebra.tras_tras%TYPE
                              ) RETURN ty_data_sebrae_c_return PIPELINED IS
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
        l_index := vg_data_sebrae.FIRST;
        --
        IF vg_data_sebrae.count > 0 THEN
            --
            WHILE (l_index IS NOT NULL) LOOP
                --
                pipe row(vg_data_sebrae(l_index));
                l_index := vg_data_sebrae.NEXT(l_index);
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
FUNCTION ws_fn_acx_fill_sebra_i (p_traslado tbl_ttrasebra.tras_tras%TYPE
                               ) RETURN BOOLEAN IS
    --
    CURSOR c_tras IS
        SELECT infb_ciudad                                                                                                                      ciudad          
             , to_char(tras_fecha, 'dd/mm/yyyy')                                                                                                fecha    
             , infb_oficina                                                                                                                     oficina
             , empr_descripcion                                                                                                                 razon           
             , empr_nit||CASE WHEN empr_digito IS NOT NULL THEN '-'||empr_digito ELSE '' END                                                  nit
             , 'Nos permitimos informarles que en la fecha estamos recibiendo una transferencia a través del sistema SEBRA así:'                val_fj6
             , RTRIM(LTRIM(TO_CHAR(tras_valor,'L99G999G999G999G999G999G999D99MI','NLS_NUMERIC_CHARACTERS = '',.''NLS_CURRENCY = ''$ ''')))      valor_db_num
             , tbl_qreporsebra.fn_numero_a_texto(tras_valor)                                                                                    valor_db_let
             , 'FIDUCIARIA CORFICOLOMBIANA S.A. FCORFICOLOMBIANA'                                                                               val_fj9        
             , cud.cuen_nrocta                                                                                                                  cod_cuen_CUD_db
             , DECODE(cue.cuen_tipo, 'CC', 'Cuenta Corriente', 'Cuenta de Ahorros')                                                             tip_cuen_reti_db
             , cue.cuen_nrocta                                                                                                                  num_cuen_reti_db 
             , tbl_qreporsebra.fn_valor_variable (8)                                                                                            vari_8
          FROM tbl_ttrasebra
             , tbl_tinfbancos
             , tbl_tempresas
             , tbl_tcuentasban cud
             , tbl_tcuentasban cue
         WHERE tras_banc      = infb_banc
           AND tras_empr      = empr_empr
           AND tras_cuen_cud  = cud.cuen_cuen
           AND tras_cuen      = cue.cuen_cuen
           AND tras_tras      = p_traslado
        ;
    --
    r_tras  c_tras%ROWTYPE;
    --
BEGIN
    --
    OPEN  c_tras;
    FETCH c_tras INTO r_tras;
    CLOSE c_tras;
    --
    vg_data_sebrai(1).ciudad           := r_tras.ciudad          ; --1  Ciudad Asociada al banco
    vg_data_sebrai(1).fecha            := r_tras.fecha           ; --2  Fecha en que se registra el traslado
    vg_data_sebrai(1).oficina          := r_tras.oficina         ; --3  Oficina asociada al banco
    vg_data_sebrai(1).razon            := r_tras.razon           ; --4  Nombre de la empresa que hace el traslado
    vg_data_sebrai(1).nit              := r_tras.nit             ; --5  Nit de la empresa que hace el traslado
    vg_data_sebrai(1).val_fj6          := r_tras.val_fj6         ; --6  Valor fijo campo 6
    vg_data_sebrai(1).valor_db_num     := r_tras.valor_db_num    ; --7  Valor del traslado en números  
    vg_data_sebrai(1).valor_db_let     := r_tras.valor_db_let    ; --8  Valor del traslado en letras
    vg_data_sebrai(1).val_fj9          := r_tras.val_fj9         ; --9  Valor fijo campo 9
    vg_data_sebrai(1).cod_cuen_CUD_db  := r_tras.cod_cuen_CUD_db ; --10 Código de la cuenta CUD
    vg_data_sebrai(1).tip_cuen_reti_db := r_tras.tip_cuen_reti_db; --11 Tipo de cuenta a la cual se registra el ingreso
    vg_data_sebrai(1).num_cuen_reti_db := r_tras.num_cuen_reti_db; --12 Número de cuenta a la cual se registra el ingreso
    vg_data_sebrai(1).vari_8           := r_tras.vari_8          ; --18 Variale 8
    --
    RETURN TRUE;
    --
END ws_fn_acx_fill_sebra_i;
-------------------------------------------------------------------------------------------------
FUNCTION ws_fn_acx_get_sebra_i (p_traslado tbl_ttrasebra.tras_tras%TYPE
                              ) RETURN ty_data_sebrai_c_return PIPELINED IS
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
        l_index := vg_data_sebrai.FIRST;
        --
        IF vg_data_sebrai.count > 0 THEN
            --
            WHILE (l_index IS NOT NULL) LOOP
                --
                pipe row(vg_data_sebrai(l_index));
                l_index := vg_data_sebrai.NEXT(l_index);
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
--
END tbl_qvpl_popu;
/
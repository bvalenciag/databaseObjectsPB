prompt
prompt PACKAGE: TBL_QVPL_AGRA
prompt
CREATE OR REPLACE PACKAGE tbl_qvpl_agra IS
--
-- Reúne funciones y procedimientos directamente relacionados con el procedimiento de las cartas vpl Agraria
--
-- #VERSION: 1001
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       13/03/2024 Jmartinezm    000001       * Se crea paquete.
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
    , val_fj1                         VARCHAR2(1000)              --1  Valor fijo campo 1 
    , nomb_banco                      VARCHAR2(200)               --2  Nombre del banco
    , ciudad                          VARCHAR2(200)               --3  Ciudad Asociada al banco
    , dia                             VARCHAR2(50)                --4  dia en que se registra el traslado
    , mes                             VARCHAR2(50)                --5  mes en que se registra el traslado
    , anio                            VARCHAR2(50)                --6  año en que se registra el traslado
    , oficina                         VARCHAR2(200)               --7  Oficina asociada al Banco
    , val_fj6                         VARCHAR2(1000)              --8  Valor fijo campo 6
    , nomb_empr                       VARCHAR2(200)               --9  Nombre de la empresa
    , valor_tras_num                  VARCHAR2(200)               --10 Valor del traslado en números
    , valor_tras_let                  VARCHAR2(200)               --11 Valor del traslado en letras
    , val_fj10                        VARCHAR2(1000)              --12 Valor fijo campo 10
    , val_fj11                        VARCHAR2(1000)              --13 Valor fijo campo 11
    , num_cuen                        VARCHAR2(40)                --14 Número de cuenta a la cual se registra el debito y el credito
    , tipo_cuen                       VARCHAR2(40)                --15 Tipo de cuenta a la cual se registra el debito y el credito
    , cod_empr                        VARCHAR2(200)               --16 Número de identificación de la empresa que hace el traslado
    , vari_11                         VARCHAR2(1000)              --17 Variable 11
    , cod_cuen_CUD                    VARCHAR2(40)                --18 Código de la cuenta CUD Egreso
    , val_fj13                        VARCHAR2(1000)              --19 Valor fijo campo 13 Egreso
    , concep_cud                      VARCHAR2(200)               --20 Concepto CUD Egreso
    , cod_oficina                     VARCHAR2(1000)              --21 Código de Oficina
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
END tbl_qvpl_agra;
/
prompt
prompt PACKAGE BODY: tbl_qvpl_agra
prompt
--
CREATE OR REPLACE PACKAGE BODY tbl_qvpl_agra IS
--
-- #VERSION: 1001
--
FUNCTION ws_fn_acx_fill_sebra (p_traslado tbl_ttrasebra.tras_tras%TYPE
                               ) RETURN BOOLEAN IS
    --
    CURSOR c_tras IS       
       SELECT list_sigla                                                                                                                                    ing_egr
             , DECODE(list_sigla, 'I', 'SOLICITUD DE ABONO A CUENTAS. CLIENTES VIGILADOS POR LA SUPERINTENDENCIA FINANCIERA', NULL)                         val_fj1
             , banc_descripcion                                                                                                                             nomb_banco
             , infb_ciudad                                                                                                                                  ciudad
             , to_char(tras_fecha, 'dd')                                                                                                                    dia
             , to_char(tras_fecha, 'mm')                                                                                                                    mes
             , to_char(tras_fecha, 'yyyy')                                                                                                                  anio
             , infb_oficina                                                                                                                                 oficina
             , DECODE(list_sigla, 'I', 'FIDUCIARIA CORFICOLOMBINA SA', NULL)                                                                                val_fj6
             , empr_descripcion                                                                                                                             nomb_empr
             , RTRIM(LTRIM(TO_CHAR(tras_valor,'L99G999G999G999G999G999G999D99MI','NLS_NUMERIC_CHARACTERS = '',.''NLS_CURRENCY = ''$ ''')))                  valor_tras_num
             , tbl_qreporsebra.fn_numero_a_texto(tras_valor)                                                                                                valor_tras_let
             , 'S'                                                                                                                                          val_fj10
             , DECODE(list_sigla,'I','S', NULL)                                                                                                             val_fj11
             , cue.cuen_nrocta                                                                                                                              num_cuen
             , DECODE(cue.cuen_tipo, 'CC', 'Cuenta Corriente', 'Cuenta de Ahorros')                                                                         tipo_cuen
             , DECODE(list_sigla, 'I',empr_nit|| '-' || empr_digito, NULL)                                                                                                       cod_empr
             , DECODE(list_sigla,'I',tbl_qreporsebra.fn_valor_variable (11), NULL)                                                                          vari_11
             --, DECODE(list_sigla, 'E', LPAD(cud.cuen_nrocta, 11, ' '), NULL)                                                                              cod_cuen_CUD antes 1001 16/04/2024 Jmartinezm
             , DECODE(list_sigla, 'E', LPAD(infb_cuen_cud_cod, 11, ' '), NULL)                                                                              cod_cuen_CUD -- 1001       16/04/2024 Jmartinezm
             , DECODE(list_sigla,'E','0',NULL)                                                                                                              val_fj13
             , DECODE(list_sigla, 'E', LPAD(infb_concep,6,' '), NULL)                                                                                       concep_cud
             , DECODE(list_sigla, 'I', infb_desti, NULL)                                                                                                    cod_oficina
          FROM tbl_ttrasebra
             , tbl_tinfbancos
             , tbl_tempresas
             , gen_tlistas
             --, tbl_tcuentasban cud antes 1001  16/04/2024 Jmartinezm 
             , tbl_tcuentasban cue
             , tbl_tbancos
         WHERE tras_banc      = infb_banc
           AND tras_empr      = empr_empr
           AND tras_tipo_oper = list_list
           --AND tras_cuen_cud  = cud.cuen_cuen antes 1001       16/04/2024 Jmartinezm
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
    vg_data_sebra(0).ing_egr        := NULL;
    vg_data_sebra(0).val_fj1        := NULL;
    vg_data_sebra(0).nomb_banco     := NULL;
    vg_data_sebra(0).ciudad         := NULL;
    vg_data_sebra(0).dia            := NULL;
    vg_data_sebra(0).mes            := NULL;
    vg_data_sebra(0).anio           := NULL;
    vg_data_sebra(0).oficina        := NULL;
    vg_data_sebra(0).val_fj6        := NULL;
    vg_data_sebra(0).nomb_empr      := NULL;
    vg_data_sebra(0).valor_tras_num := NULL;
    vg_data_sebra(0).valor_tras_let := NULL;
    vg_data_sebra(0).val_fj10       := NULL;
    vg_data_sebra(0).val_fj11       := NULL;
    vg_data_sebra(0).num_cuen       := NULL;
    vg_data_sebra(0).tipo_cuen      := NULL;
    vg_data_sebra(0).cod_empr       := NULL;
    vg_data_sebra(0).vari_11        := NULL;
    vg_data_sebra(0).cod_cuen_CUD   := NULL;
    vg_data_sebra(0).val_fj13       := NULL;
    vg_data_sebra(0).concep_cud     := NULL;
    vg_data_sebra(0).cod_oficina    := NULL;
    --
    FOR i IN c_tras LOOP
        --
        --gen_pseguimiento('colp 1');
        vg_data_sebra(v_count).ing_egr          := i.ing_egr        ;--0  I-Ingreso - E-Egreso 
    	vg_data_sebra(v_count).val_fj1          := i.val_fj1        ;--1  Valor fijo campo 1 
    	vg_data_sebra(v_count).nomb_banco       := i.nomb_banco     ;--2  Nombre del banco
    	vg_data_sebra(v_count).ciudad           := i.ciudad         ;--3  Ciudad Asociada al banco
    	vg_data_sebra(v_count).dia              := i.dia            ;--4  dia en que se registra el traslado
    	vg_data_sebra(v_count).mes              := i.mes            ;--5  mes en que se registra el traslado
    	vg_data_sebra(v_count).anio             := i.anio           ;--6  año en que se registra el traslado
    	vg_data_sebra(v_count).oficina          := i.oficina        ;--7  Oficina asociada al Banco
    	vg_data_sebra(v_count).val_fj6          := i.val_fj6        ;--8  Valor fijo campo 6
    	vg_data_sebra(v_count).nomb_empr        := i.nomb_empr      ;--9  Nombre de la empresa
    	vg_data_sebra(v_count).valor_tras_num   := i.valor_tras_num ;--10  Valor del traslado en números
    	vg_data_sebra(v_count).valor_tras_let   := i.valor_tras_let ;--11  Valor del traslado en letras
    	vg_data_sebra(v_count).val_fj10         := i.val_fj10       ;--12 Valor fijo campo 10
    	vg_data_sebra(v_count).val_fj11         := i.val_fj11       ;--13 Valor fijo campo 11
    	vg_data_sebra(v_count).num_cuen         := i.num_cuen       ;--14 Número de cuenta a la cual se registra el debito y el credito
    	vg_data_sebra(v_count).tipo_cuen        := i.tipo_cuen      ;--15 Tipo de cuenta a la cual se registra el debito y el credito
    	vg_data_sebra(v_count).cod_empr         := i.cod_empr       ;--16 Número de identificación de la empresa que hace el traslado
    	vg_data_sebra(v_count).vari_11          := i.vari_11        ;--17 Variable 10
    	vg_data_sebra(v_count).cod_cuen_CUD     := i.cod_cuen_CUD   ;--18 Código de la cuenta CUD Egreso
    	vg_data_sebra(v_count).val_fj13         := i.val_fj13       ;--19 Valor fijo campo 13 Egreso
    	vg_data_sebra(v_count).concep_cud       := i.concep_cud     ;--20 Concepto CUD Egreso
        vg_data_sebra(v_count).cod_oficina      := i.cod_oficina    ;--21 Código de Oficina
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
END tbl_qvpl_agra;
/
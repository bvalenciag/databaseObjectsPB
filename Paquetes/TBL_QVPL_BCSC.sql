prompt
prompt PACKAGE: TBL_QVPL_BCSC
prompt
CREATE OR REPLACE PACKAGE tbl_qvpl_bcsc IS
--
-- Reúne funciones y procedimientos directamente relacionados con el procedimiento de las cartas vpl BCSC
--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       09/07/2024 Jmartinezm    000001       * Se crea paquete.
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
      ing_egr                   VARCHAR2(50)                --1  I-Ingreso - E-Egreso
    , val_fj1                   VARCHAR2(100)               --2  Valor Fijo, Campo 1
    , ciudad_fecha              VARCHAR2(50)                --3  Ciudad y fecha, Campo 2 y 3
    , nomb_banco                VARCHAR2(50)                --4  Nombre banco, Campo 4
    , ref_ingreso               VARCHAR2(500)               --5  Referencia de Ingreso, Campo 5
    , tip_cuen                  VARCHAR2(50)                --6  Tipo de Cuenta, Para ingreso campo 6 egreso campo 16
    , num_cuen                  VARCHAR2(20)                --7  Numero de cuenta, Para ingreso campo 7 egreso campo 17
    , nomb_empr                 VARCHAR2(50)                --8  Nombre de la empresa, Para ingreso campo 8 egreso campo 18
    , empr_nit                  VARCHAR2(50)                --9  Nit de la empresa, Para Ingreso Campo 9, Egreso campo 19
    , valor_tras_let            VARCHAR2(500)               --10 Valor traslado en letras, Para Ingreso Campo 10, Egreso campo 20
    , valor_tras_num            VARCHAR2(500)               --11 Valor traslado en numero, Para Ingreso Campo 11, Egreso campo 21
    , cod_cuen_cud              VARCHAR2(50)                --12 Código cuenta cud, Para Ingreso Campo 12, Egreso campo 22
    , portafolio                VARCHAR2(50)                --13 Portafolio, Para Ingreso Campo 13, Egreso campo 23
    , val_fj2                   VARCHAR2(50)                --14 Valor fijo 'Fiduciaria Corficolombiana', Para Ingreso Campo 14, Egreso campo 24
    , ref_egreso                VARCHAR2(500)               --15 Referencia de Egreso, Campo 15
    , val_fj3                   VARCHAR2(500)               --16 Valor fijo 102, Para Egreso Campo 29
    , val_fj4                   VARCHAR2(500)               --17 Valor fijo Nulo, Para Egreso Campo 25
    , val_fj5                   VARCHAR2(500)               --18 Valor fijo Nulo, Para Egreso Campo 26
    , val_fj6                   VARCHAR2(500)               --19 Valor fijo Nulo, Para Egreso Campo 27
    , val_fj7                   VARCHAR2(500)               --20 Valor fijo Nulo, Para Egreso Campo 28
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
--
-------------------------------------------------------------------------------------------------
--
END tbl_qvpl_bcsc;
/
prompt
prompt PACKAGE BODY: tbl_qvpl_bcsc
prompt
--
CREATE OR REPLACE PACKAGE BODY tbl_qvpl_bcsc IS
--
-- #VERSION: 1000
--
---------------------------------------------------------------------------------------------------
FUNCTION ws_fn_acx_fill_sebra (p_traslado tbl_ttrasebra.tras_tras%TYPE
                               ) RETURN BOOLEAN IS
    --
    --
    CURSOR c_tras IS       
       SELECT list_sigla                                                                                                                           ing_egr
             , 'SOLICITUD DE TRANSFERENCIA DE FONDOS WSEBRA'                                                                                        val_fj1
             , infb_ciudad||'  '|| to_char(tras_fecha, 'dd')||' de '
               ||RTRIM(to_char(tras_fecha, 'Month', 'NLS_DATE_LANGUAGE=SPANISH'))
               ||' de '||to_char(tras_fecha, 'yyyy')                                                                                               ciudad_fecha
             , banc_descripcion                                                                                                                    nomb_banco
             , infb_ref                                                                                                                            ref_ingreso
             , cue.cuen_tipo                                                                                                                       tip_cuen
             , cue.cuen_nrocta                                                                                                                     num_cuen
             , empr_descripcion                                                                                                                    nomb_empr
             , empr_nit                                                                                                                            empr_nit
             , tbl_qreporsebra.fn_numero_a_texto(NVL(tras_valor,0))                                                                                valor_tras_let
             , RTRIM(LTRIM(TO_CHAR(NVL(tras_valor,0),'L99G999G999G999G999G999G999D99MI','NLS_NUMERIC_CHARACTERS = '',.''NLS_CURRENCY = ''$ ''')))  valor_tras_num
             , infb_cuen_cud_cod                                                                                                                   cod_cuen_cud
             , infb_portafolio                                                                                                                     portafolio
             , 'Fiduciaria Corficolombiana'                                                                                                        val_fj2
             , infb_refegr                                                                                                                         ref_egreso
             , '102'                                                                                                                               val_fj3
             , ''                                                                                                                                  val_fj4
             , ''                                                                                                                                  val_fj5
             , ''                                                                                                                                  val_fj6
             , ''                                                                                                                                  val_fj7
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
    vg_data_sebra(0).ing_egr            := NULL;
    vg_data_sebra(0).val_fj1            := NULL;
    vg_data_sebra(0).ciudad_fecha       := NULL;
    vg_data_sebra(0).nomb_banco         := NULL;
    vg_data_sebra(0).ref_ingreso        := NULL;
    vg_data_sebra(0).tip_cuen           := NULL;
    vg_data_sebra(0).num_cuen           := NULL;    
    vg_data_sebra(0).nomb_empr          := NULL;
    vg_data_sebra(0).empr_nit           := NULL;
    vg_data_sebra(0).valor_tras_let     := NULL;
    vg_data_sebra(0).valor_tras_num     := NULL;
    vg_data_sebra(0).cod_cuen_cud       := NULL;
    vg_data_sebra(0).portafolio         := NULL;
    vg_data_sebra(0).val_fj2            := NULL;
    vg_data_sebra(0).ref_egreso         := NULL;
    vg_data_sebra(0).val_fj3            := NULL;
    vg_data_sebra(0).val_fj4            := NULL;
    vg_data_sebra(0).val_fj5            := NULL;
    vg_data_sebra(0).val_fj6            := NULL;
    vg_data_sebra(0).val_fj7            := NULL;
    --
    FOR i IN c_tras LOOP
        --
        --gen_pseguimiento('colp 1');
        vg_data_sebra(v_count).ing_egr          := i.ing_egr            ;--1  I-Ingreso - E-Egreso
    	vg_data_sebra(v_count).val_fj1          := i.val_fj1            ;--2  Valor Fijo, Campo 1
    	vg_data_sebra(v_count).ciudad_fecha     := i.ciudad_fecha       ;--3  Ciudad y fecha, Campo 2 y 3
    	vg_data_sebra(v_count).nomb_banco       := i.nomb_banco         ;--4  Nombre banco, Campo 4
    	vg_data_sebra(v_count).ref_ingreso      := i.ref_ingreso        ;--5  Referencia de Ingreso, Campo 5
    	vg_data_sebra(v_count).tip_cuen         := i.tip_cuen           ;--6  Tipo de Cuenta, Para ingreso campo 6 egreso campo 16
        vg_data_sebra(v_count).num_cuen         := i.num_cuen           ;--7  Numero de cuenta, Para ingreso campo 7 egreso campo 17
    	vg_data_sebra(v_count).nomb_empr        := i.nomb_empr          ;--8  Nombre de la empresa, Para ingreso campo 8 egreso campo 18
    	vg_data_sebra(v_count).empr_nit         := i.empr_nit           ;--9  Nit de la empresa, Para Ingreso Campo 9, Egreso campo 19
    	vg_data_sebra(v_count).valor_tras_let   := i.valor_tras_let     ;--10 Valor traslado en letras, Para Ingreso Campo 10, Egreso campo 20
    	vg_data_sebra(v_count).valor_tras_num   := i.valor_tras_num     ;--11 Valor traslado en numero, Para Ingreso Campo 11, Egreso campo 21
    	vg_data_sebra(v_count).cod_cuen_cud     := i.cod_cuen_cud       ;--12 Código cuenta cud, Para Ingreso Campo 12, Egreso campo 22
    	vg_data_sebra(v_count).portafolio       := i.portafolio         ;--13 Portafolio, Para Ingreso Campo 13, Egreso campo 23
    	vg_data_sebra(v_count).val_fj2          := i.val_fj2            ;--14 Valor fijo 'Fiduciaria Corficolombiana', Para Ingreso Campo 14, Egreso campo 24
    	vg_data_sebra(v_count).ref_egreso       := i.ref_egreso         ;--15 Referencia de Egreso, Campo 15
    	vg_data_sebra(v_count).val_fj3          := i.val_fj3            ;--16 Valor fijo 102, Para Egreso Campo 29
    	vg_data_sebra(v_count).val_fj4          := i.val_fj4            ;--17 Valor fijo Nulo, Para Egreso Campo 25
    	vg_data_sebra(v_count).val_fj5          := i.val_fj5            ;--18 Valor fijo Nulo, Para Egreso Campo 26
        vg_data_sebra(v_count).val_fj6          := i.val_fj6            ;--19 Valor fijo Nulo, Para Egreso Campo 27
        vg_data_sebra(v_count).val_fj7          := i.val_fj7            ;--20 Valor fijo Nulo, Para Egreso Campo 28
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
END tbl_qvpl_bcsc;
/
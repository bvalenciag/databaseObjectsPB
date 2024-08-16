prompt
prompt PACKAGE: TBL_QVPL_COOM
prompt
CREATE OR REPLACE PACKAGE tbl_qvpl_coom IS
--
-- Reúne funciones y procedimientos directamente relacionados con el procedimiento de las cartas vpl coomeva
--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       08/07/2024 Jmartinezm    000001       * Se crea paquete.
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
    , ciudad                    VARCHAR2(100)               --2  Ciudad Asociada al banco
    , ano                       VARCHAR2(20)                --3  Año en que se regrstra el traslado
    , mes                       VARCHAR2(20)                --4  Mes en que se registra el traslado
    , dia                       VARCHAR2(20)                --5  Día en que se registra el traslado
    , nomb_empr                 VARCHAR2(100)               --6  Nombre de la empresa que hace el traslado
    , val_fj1                   VARCHAR2(20)                --7  Valor Fijo NIT
    , nit_banc                  VARCHAR2(20)                --8  Nit del banco
    , val_fj2                   VARCHAR2(100)               --9  Valor fijo FIDUCIARIA CORFICOLOMBIANA Para Ingreso Campo 9, Egreso campo 18
    , cod_cuen_cud              VARCHAR2(100)               --10 Código cuenta CUD Para Ingreso Campo 10, Egreso campo 19
    , portafolio                VARCHAR2(40)                --11 Portafolio Para Ingreso Campo 11, Egreso campo 20
    , valor_numero              VARCHAR2(500)               --12 Valor de traslado  Para Ingreso Campo 12, Egreso campo 21
    , fecha_tras                VARCHAR2(10)                --13 Fecha del traslado (dd/mm/aaaa)  Para Ingreso Campo 13
    , tip_cuen                  VARCHAR2(20)                --14 Tipo de cuenta (CC-Cuenta Corriente, CH-Cuenta de Ahorros) Para Ingreso Campo 14, Egreso campo 16
    , num_cuen                  VARCHAR2(20)                --15 Código de cuenta bancaria  Para Ingreso Campo 15, Egreso campo 17, 23
    , ref_egreso                VARCHAR2(1000)              --16 Referencia Egreso Campo 22
    , val_fj3                   VARCHAR2(1000)              --17 Valor fijo TRASLADO SEBRA  Campo 24
    , vari_13                   VARCHAR2(1000)              --18 Variable #13 Campo 25
    
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
END tbl_qvpl_coom;
/
prompt
prompt PACKAGE BODY: tbl_qvpl_coom
prompt
--
CREATE OR REPLACE PACKAGE BODY tbl_qvpl_coom IS
--
-- #VERSION: 1000
--
---------------------------------------------------------------------------------------------------
FUNCTION ws_fn_acx_fill_sebra (p_traslado tbl_ttrasebra.tras_tras%TYPE
                               ) RETURN BOOLEAN IS
    --
    --
    CURSOR c_tras IS       
       SELECT list_sigla                                                                                                                     ing_egr
             , infb_ciudad                                                                                                                   ciudad
             , to_char(tras_fecha, 'yyyy')                                                                                                   ano             
             , RTRIM(to_char(tras_fecha, 'Month', 'NLS_DATE_LANGUAGE=SPANISH'))                                                              mes             
             , to_char(tras_fecha, 'dd')                                                                                                     dia     
             , empr_descripcion                                                                                                              nomb_empr
             , 'NIT'                                                                                                                         val_fj1
             , infb_nit                                                                                                                      nit_banc
             , 'FIDUCIARIA CORFICOLOMBIANA'                                                                                                  val_fj2
             , infb_cuen_cud_cod                                                                                                             cod_cuen_cud
             , infb_portafolio                                                                                                               portafolio
             , RTRIM(LTRIM(TO_CHAR(tras_valor,'L99G999G999G999G999G999G999D99MI','NLS_NUMERIC_CHARACTERS = '',.''NLS_CURRENCY = ''$ ''')))   valor_numero
             , DECODE(list_sigla, 'I',to_char(tras_fecha, 'dd/mm/yyyy'),NULL)                                                                fecha_tras
             , cue.cuen_tipo                                                                                                                 tip_cuen
             , cue.cuen_nrocta                                                                                                               num_cuen
             , DECODE(list_sigla, 'E',infb_refegr,NULL)                                                                                      ref_egreso
             , 'TRASLADO SEBRA'                                                                                                              val_fj3
             , tbl_qreporsebra.fn_valor_variable (13)                                                                                        vari_13
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
    vg_data_sebra(0).ing_egr        := NULL;
    vg_data_sebra(0).ciudad         := NULL;
    vg_data_sebra(0).ano            := NULL;
    vg_data_sebra(0).mes            := NULL;
    vg_data_sebra(0).dia            := NULL;
    vg_data_sebra(0).nomb_empr      := NULL;
    vg_data_sebra(0).val_fj1        := NULL;    
    vg_data_sebra(0).nit_banc       := NULL;
    vg_data_sebra(0).val_fj2        := NULL;
    vg_data_sebra(0).cod_cuen_cud   := NULL;
    vg_data_sebra(0).portafolio     := NULL;
    vg_data_sebra(0).valor_numero   := NULL;
    vg_data_sebra(0).fecha_tras     := NULL;
    vg_data_sebra(0).tip_cuen       := NULL;
    vg_data_sebra(0).num_cuen       := NULL;
    vg_data_sebra(0).ref_egreso     := NULL;
    vg_data_sebra(0).val_fj3        := NULL;
    vg_data_sebra(0).vari_13        := NULL;
    --
    FOR i IN c_tras LOOP
        --
        --gen_pseguimiento('colp 1');
        vg_data_sebra(v_count).ing_egr          := i.ing_egr        ;--1  I-Ingreso - E-Egreso
    	vg_data_sebra(v_count).ciudad           := i.ciudad         ;--2  Ciudad Asociada al banco
    	vg_data_sebra(v_count).ano              := i.ano            ;--3  Año en que se regrstra el traslado
    	vg_data_sebra(v_count).mes              := i.mes            ;--4  Mes en que se registra el traslado
    	vg_data_sebra(v_count).dia              := i.dia            ;--5  Día en que se registra el traslado
    	vg_data_sebra(v_count).nomb_empr        := i.nomb_empr      ;--6  Nombre de la empresa que hace el traslado
        vg_data_sebra(v_count).val_fj1          := i.val_fj1        ;--8  Valor fijo FIDUCIARIA CORFICOLOMBIANA
    	vg_data_sebra(v_count).nit_banc         := i.nit_banc       ;--7  Nit del banco
    	vg_data_sebra(v_count).val_fj2          := i.val_fj2        ;--8  Valor fijo FIDUCIARIA CORFICOLOMBIANA
    	vg_data_sebra(v_count).cod_cuen_cud     := i.cod_cuen_cud   ;--9  Código cuenta CUD
    	vg_data_sebra(v_count).portafolio       := i.portafolio     ;--10 Portafolio
    	vg_data_sebra(v_count).valor_numero     := i.valor_numero   ;--11 Valor de traslado 
    	vg_data_sebra(v_count).fecha_tras       := i.fecha_tras     ;--12 Fecha del traslado (dd/mm/aaaa)
    	vg_data_sebra(v_count).tip_cuen         := i.tip_cuen       ;--13 Tipo de cuenta
    	vg_data_sebra(v_count).num_cuen         := i.num_cuen       ;--14 Código de cuenta bancaria
    	vg_data_sebra(v_count).ref_egreso       := i.ref_egreso     ;--15 Referencia Egreso
    	vg_data_sebra(v_count).val_fj3          := i.val_fj3        ;--16 Valor fijo TRASLADO SEBRA
    	vg_data_sebra(v_count).vari_13          := i.vari_13        ;--17 Variable #13
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
END tbl_qvpl_coom;
/
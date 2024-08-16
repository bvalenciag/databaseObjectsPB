prompt
prompt PACKAGE: TBL_QVPL_DAVI
prompt
CREATE OR REPLACE PACKAGE tbl_qvpl_davi IS
--
-- Reúne funciones y procedimientos directamente relacionados con el procedimiento de las cartas vpl Davivienda
--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       12/07/2024 Jmartinezm    000001       * Se crea paquete.
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
      ing_egr                         VARCHAR2(50)              --0  I-Ingreso - E-Egreso --campo 13
    , val_fj1                         VARCHAR2(1000)            --1  Valor fijo campo 1 Formato     
    , val_fj2                         VARCHAR2(1000)            --2  Valor fijo campo 1 Código  
    , ciudad_fecha                    VARCHAR2(200)             --3  Ciudad (Bogotá) y fecha Asociada al banco
    , ciudad                          VARCHAR2(200)             --33 Ciudad
    , nomb_banco                      VARCHAR2(200)             --4  Nombre del banco
    , dest_carta                      VARCHAR2(200)             --5  Destinatario de la carta
    , dest_cargo                      VARCHAR2(200)             --6  Cargo del destinatario
    , val_fj3                         VARCHAR2(1000)             --7  Valor fijo campo 8
    , fax_dest_carta                  VARCHAR2(200)             --8  Fax del destinatario de la carta
    , tele_dest_carta                 VARCHAR2(200)             --9  Telefeno destinatario de la carta
    , emai_dest_carta                 VARCHAR2(1000)             --10 Correo Electronico del destinatario de la carta 
    , val_fj4                         VARCHAR2(1000)            --11 Valor fijo campo 12
    , ref_carta                       VARCHAR2(400)             --12 Referencia de la carta
    , repre_carta                     VARCHAR2(400)             --13 Representante legal
    , nomb_empr                       VARCHAR2(200)             --14 Nombre de la empresa
    , nit_empr                        VARCHAR2(200)             --15 NIT de la empresa  
    , proc_carta                      VARCHAR2(200)             --16 Campo 17, si es Egreso Debitar, ingreso Acreditar
    , valor_tras_num                  VARCHAR2(1000)             --17 Valor de traslado en numeros 
    , valor_tras_let                  VARCHAR2(1000)             --18 Valor de traslado en letras
    , tipo_cuen                       VARCHAR2(40)              --19 Tipo de cuenta bancaria,Cuenta Corriente, Cuenta de Ahorros
    , cod_cuenta                      VARCHAR2(1000)            --20 Número de la cuenta de la cual se hace el traslado
    , cod_cuen_cud                    VARCHAR2(1000)            --21 Cuenta CUD
    , portafolio                      VARCHAR2(1000)            --22 Portafolio 
    , concep_cud                      VARCHAR2(200)             --23 Concepto CUD
    , vari_1                          VARCHAR2(2000)            --24 Variable 1
    , vari_3                          VARCHAR2(2000)            --25 Variable 3
    , vari_4                          VARCHAR2(2000)            --26 Variable 4
    , confir_carta_nomb               VARCHAR2(2000)             --27 Nombre confirmación
    , confir_carta_tele               VARCHAR2(2000)             --28 Telefono confirmación
    , confir_carta_exte               VARCHAR2(2000)             --29 Extención confirmación
    , confir_sebra_nomb               VARCHAR2(2000)             --30 Nombre contacto sebra
    , confir_sebra_tele               VARCHAR2(2000)             --31 Telefono contacto sebra
    , confir_sebra_exte               VARCHAR2(2000)             --32 extensión contacto sebra
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
END tbl_qvpl_davi;
/
prompt
prompt PACKAGE BODY: tbl_qvpl_davi
prompt
--
CREATE OR REPLACE PACKAGE BODY tbl_qvpl_davi IS
--
-- #VERSION: 1000
--
FUNCTION ws_fn_acx_fill_sebra (p_traslado tbl_ttrasebra.tras_tras%TYPE
                               ) RETURN BOOLEAN IS
    --
    CURSOR c_tras IS       
        SELECT list_sigla                                                                                                                           ing_egr
                    , 'Formato Movimiento Recursos por SEBRA'                                                                                      val_fj1
                    , 'Código FID-REG-GI-48 Versión 1.0'                                                                                           val_fj2
                    , 'Bogotá '||', '|| to_char(tras_fecha, 'dd')||' de '
                    ||RTRIM(to_char(tras_fecha, 'Month', 'NLS_DATE_LANGUAGE=SPANISH'))
                    ||' de '||to_char(tras_fecha, 'yyyy')                                                                                          ciudad_fecha
                    , infb_ciudad                                                                                                                  ciudad
                    , banc_descripcion                                                                                                             nomb_banco
                    , infb_desti                                                                                                                   dest_carta
                    , infb_cargo                                                                                                                   dest_cargo
                    , '885 49 53'                                                                                                                  val_fj3
                    , infb_fax                                                                                                                     fax_dest_carta 
                    , infb_telefono                                                                                                                tele_dest_carta
                    , cori_email                                                                                                                   emai_dest_carta
                    , '052 8987400 Ext. 2238'                                                                                                      val_fj4
                    , infb_ref                                                                                                                     ref_carta
                    , cond_repre                                                                                                                   repre_carta
                    , empr_descripcion                                                                                                             nomb_empr
                    , empr_nit || '-' || empr_digito                                                                                               nit_empr--
                    , DECODE(list_sigla, 'E', 'DEBITAR', 'ACREDITAR')                                                                              proc_carta
                    , RTRIM(LTRIM(TO_CHAR(tras_valor,'L99G999G999G999G999G999G999D99MI','NLS_NUMERIC_CHARACTERS = '',.''NLS_CURRENCY = ''$ ''')))  valor_tras_num
                    , tbl_qreporsebra.fn_numero_a_texto(round(tras_valor,2))                                                                       valor_tras_let
                    , DECODE(cue.cuen_tipo, 'CC', 'Cuenta Corriente', 'Cuenta de Ahorros')                                                         tipo_cuen
                    , 'DAVIVIENDA'||' '||cue.cuen_nrocta                                                                                           cod_cuenta
                    , infb_cuen_cud_cod                                                                                                            cod_cuen_cud
                    , infb_portafolio                                                                                                              portafolio
                    , infb_concep                                                                                                                  concep_cud    
                    , tbl_qreporsebra.fn_valor_variable (1)                                                                                        vari_1
                    , tbl_qreporsebra.fn_valor_variable (3)                                                                                        vari_3
                    , tbl_qreporsebra.fn_valor_variable (4)                                                                                        vari_4
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
                    , tbl_tcuentasban cue
                    , tbl_tbancos
                    , tbl_tcorinfbanc
                    , tbl_tcondgen
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
    vg_data_sebra(0).ing_egr                := NULL;
    vg_data_sebra(0).val_fj1                := NULL;
    vg_data_sebra(0).val_fj2                := NULL;
    vg_data_sebra(0).ciudad_fecha           := NULL;
    vg_data_sebra(0).ciudad                 := NULL;
    vg_data_sebra(0).nomb_banco             := NULL;
    vg_data_sebra(0).dest_carta             := NULL;
    vg_data_sebra(0).dest_cargo             := NULL;
    vg_data_sebra(0).val_fj3                := NULL;
    vg_data_sebra(0).fax_dest_carta         := NULL;
    vg_data_sebra(0).tele_dest_carta        := NULL;
    vg_data_sebra(0).emai_dest_carta        := NULL;
    vg_data_sebra(0).val_fj4                := NULL;
    vg_data_sebra(0).ref_carta              := NULL;
    vg_data_sebra(0).repre_carta            := NULL;
    vg_data_sebra(0).nomb_empr              := NULL;
    vg_data_sebra(0).nit_empr               := NULL;
    vg_data_sebra(0).proc_carta             := NULL;
    vg_data_sebra(0).valor_tras_num         := NULL;
    vg_data_sebra(0).valor_tras_let         := NULL;
    vg_data_sebra(0).tipo_cuen              := NULL;
    vg_data_sebra(0).cod_cuenta             := NULL;
    vg_data_sebra(0).cod_cuen_cud           := NULL;
    vg_data_sebra(0).portafolio             := NULL;
    vg_data_sebra(0).concep_cud             := NULL;
    vg_data_sebra(0).vari_1                 := NULL;
    vg_data_sebra(0).vari_3                 := NULL;
    vg_data_sebra(0).vari_4                 := NULL;
    vg_data_sebra(0).confir_carta_nomb      := NULL;
    vg_data_sebra(0).confir_carta_tele      := NULL;
    vg_data_sebra(0).confir_carta_exte      := NULL;
    vg_data_sebra(0).confir_sebra_nomb      := NULL;
    vg_data_sebra(0).confir_sebra_tele      := NULL;
    vg_data_sebra(0).confir_sebra_exte      := NULL;
    --
    FOR i IN c_tras LOOP
        --
        --gen_pseguimiento('colp 1');
        vg_data_sebra(v_count).ing_egr              := i.ing_egr                ;--0  I-Ingreso - E-Egreso --campo 13
    	vg_data_sebra(v_count).val_fj1              := i.val_fj1                ;--1  Valor fijo campo 1 Formato     
    	vg_data_sebra(v_count).val_fj2              := i.val_fj2                ;--2  Valor fijo campo 1 Código  
    	vg_data_sebra(v_count).ciudad_fecha         := i.ciudad_fecha           ;--3  Ciudad y fecha Asociada al banco
        vg_data_sebra(v_count).ciudad               := i.ciudad                 ;--33  Ciudad
    	vg_data_sebra(v_count).nomb_banco           := i.nomb_banco             ;--4  Nombre del banco
    	vg_data_sebra(v_count).dest_carta           := i.dest_carta             ;--5  Destinatario de la carta
    	vg_data_sebra(v_count).dest_cargo           := i.dest_cargo             ;--6  Cargo del destinatario
    	vg_data_sebra(v_count).val_fj3              := i.val_fj3                ;--7  Valor fijo campo 8
    	vg_data_sebra(v_count).fax_dest_carta       := i.fax_dest_carta         ;--8  Fax del destinatario de la carta
    	vg_data_sebra(v_count).tele_dest_carta      := i.tele_dest_carta        ;--9  Telefeno destinatario de la carta
    	vg_data_sebra(v_count).emai_dest_carta      := i.emai_dest_carta        ;--10 Correo Electronico del destinatario de la carta 
    	vg_data_sebra(v_count).val_fj4              := i.val_fj4                ;--11 Valor fijo campo 12
    	vg_data_sebra(v_count).ref_carta            := i.ref_carta              ;--12 Referencia de la carta
    	vg_data_sebra(v_count).repre_carta          := i.repre_carta            ;--13 Representante legal
    	vg_data_sebra(v_count).nomb_empr            := i.nomb_empr              ;--14 Nombre de la empresa
    	vg_data_sebra(v_count).nit_empr             := i.nit_empr               ;--15 NIT de la empresa  
    	vg_data_sebra(v_count).proc_carta           := i.proc_carta             ;--16 Campo 17, si es Egreso Debitar, ingreso Acreditar
    	vg_data_sebra(v_count).valor_tras_num       := i.valor_tras_num         ;--17 Valor de traslado en numeros 
    	vg_data_sebra(v_count).valor_tras_let       := i.valor_tras_let         ;--18 Valor de traslado en letras
    	vg_data_sebra(v_count).tipo_cuen            := i.tipo_cuen              ;--19 Tipo de cuenta bancaria,Cuenta Corriente, Cuenta de Ahorros
    	vg_data_sebra(v_count).cod_cuenta           := i.cod_cuenta             ;--20 Número de la cuenta de la cual se hace el traslado
        vg_data_sebra(v_count).cod_cuen_cud         := i.cod_cuen_cud           ;--21 Cuenta CUD
        vg_data_sebra(v_count).portafolio           := i.portafolio             ;--22 Portafolio 
        vg_data_sebra(v_count).concep_cud           := i.concep_cud             ;--23 Concepto CUD
        vg_data_sebra(v_count).vari_1               := i.vari_1                 ;--24 Variable 1
        vg_data_sebra(v_count).vari_3               := i.vari_3                 ;--25 Variable 3
        vg_data_sebra(v_count).vari_4               := i.vari_4                 ;--26 Variable 4
        vg_data_sebra(v_count).confir_carta_nomb    := i.confir_carta_nomb      ;--27 Nombre confirmación
        vg_data_sebra(v_count).confir_carta_tele    := i.confir_carta_tele      ;--28 Telefono confirmación
        vg_data_sebra(v_count).confir_carta_exte    := i.confir_carta_exte      ;--29 Extención confirmación
        vg_data_sebra(v_count).confir_sebra_nomb    := i.confir_sebra_nomb      ;--30 Nombre contacto sebra
        vg_data_sebra(v_count).confir_sebra_tele    := i.confir_sebra_tele      ;--31 Telefono contacto sebra
        vg_data_sebra(v_count).confir_sebra_exte    := i.confir_sebra_exte      ;--32 extensión contacto sebra
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
END tbl_qvpl_davi;
/
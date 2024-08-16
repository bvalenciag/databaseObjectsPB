prompt
prompt PACKAGE: TBL_QVPL_HELM
prompt
CREATE OR REPLACE PACKAGE tbl_qvpl_helm IS
--
-- Reúne funciones y procedimientos directamente relacionados con el procedimiento de las cartas vpl Helm
--
-- #VERSION: 1001
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       14/02/2024 Jmartinezm    000001       * Se crea paquete.
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
      ing_egr                         VARCHAR2(50)              --0  I-Ingreso - E-Egreso
    , val_fj1                         VARCHAR2(1000)            --1  Valor fijo campo 1 Formato     
    , val_fj2                         VARCHAR2(1000)            --2  Valor fijo campo 1 Código
    , ciudad_fecha                    VARCHAR2(200)             --3  Ciudad y fecha Asociada al banco
    , nomb_banco                      VARCHAR2(200)             --4  Nombre del banco
    , dest_carta                      VARCHAR2(200)             --5  Destinatario de la carta
    , carg_dest_carta                 VARCHAR2(200)             --6  Cargo destinatario de la carta
    , ciud_dest_carta                 VARCHAR2(200)             --7  Ciudad destino de la carta
    , fax_dest_carta                  VARCHAR2(200)             --8  Fax des destinatario de la carta
    , tele_dest_carta                 VARCHAR2(200)             --9  Telefeno destinatario de la carta
    , emai_dest_carta                 VARCHAR2(200)             --10 Correo Electronico del destinatario de la carta 
    , refe_carta                      VARCHAR2(200)             --11 Referencia de la carta    
    , tipo_cuen                       VARCHAR2(40)              --12 Tipo de cuenta a la cual se registra el debito y el credito
    , cod_cuenta                      VARCHAR2(40)              --13 Cuenta bancaria del aporte
    , nomb_empr                       VARCHAR2(200)             --14 Nombre de la empresa
    , valor_tras_num                  VARCHAR2(200)             --15 Valor del traslado en números
    , val_fj17                        VARCHAR2(1000)            --16 Valor fijo campo 17 
    , concep_cud                      VARCHAR2(200)             --17 Concepto CUD 
    , cod_cuen_cud                    VARCHAR2(40)              --18 Código de la cuenta CUD 
    , portafolio                      VARCHAR2(40)              --19 Portafolio
    , vari_12                         VARCHAR2(1000)            --20 Variable 12
    , confir_carta_nomb               VARCHAR2(200)             --21 Nombre confirmación
    , confir_carta_tele               VARCHAR2(200)             --22 Telefono confirmación
    , confir_carta_exte               VARCHAR2(200)             --23 Extención confirmación
    , confir_sebra_nomb               VARCHAR2(200)             --24 Nombre contacto sebra
    , confir_sebra_tele               VARCHAR2(200)             --25 Telefono contacto sebra
    , confir_sebra_exte               VARCHAR2(200)             --26 extensión contacto sebra
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
END tbl_qvpl_helm;
/
prompt
prompt PACKAGE BODY: tbl_qvpl_helm
prompt
--
CREATE OR REPLACE PACKAGE BODY tbl_qvpl_helm IS
--
-- #VERSION: 1001
--
FUNCTION ws_fn_acx_fill_sebra (p_traslado tbl_ttrasebra.tras_tras%TYPE
                               ) RETURN BOOLEAN IS
    --
    CURSOR c_tras IS       
       SELECT list_sigla                                                                                                                     ing_egr
             , 'Formato Movimiento Recursos por SEBRA'                                                                                       val_fj1
             , 'Código FID-REG-GI-48 Versión 1.0'                                                                                            val_fj2
             , infb_ciudad||'  '|| to_char(tras_fecha, 'dd')||' de '
               ||RTRIM(to_char(tras_fecha, 'Month', 'NLS_DATE_LANGUAGE=SPANISH'))
               ||' de '||to_char(tras_fecha, 'yyyy')                                                                                         ciudad_fecha                                                                              
             , banc_descripcion                                                                                                              nomb_banco                                                                                                       
             , infb_desti                                                                                                                    dest_carta                                                                                                       
             , infb_cargo                                                                                                                    carg_dest_carta                                                                                                       
             , infb_ciudad                                                                                                                   ciud_dest_carta                                                                                                          
             , infb_fax                                                                                                                      fax_dest_carta                                                                                                    
             , infb_telefono                                                                                                                 tele_dest_carta                                                                                                                   
             , cori_email                                                                                                                    emai_dest_carta                                                                                                    
             , DECODE(list_sigla, 'E', infb_refegr, infb_ref)                                                                                refe_carta                                   
             , DECODE(cue.cuen_tipo, 'CC', 'Cuenta Corriente', 'Cuenta de Ahorros')                                                          tipo_cuen
             , cue.cuen_nrocta                                                                                                               cod_cuenta                                                                                                        
             , empr_descripcion                                                                                                              nomb_empr
             , RTRIM(LTRIM(TO_CHAR(tras_valor,'L99G999G999G999G999G999G999D99MI','NLS_NUMERIC_CHARACTERS = '',.''NLS_CURRENCY = ''$ ''')))   valor_tras_num
             , DECODE(list_sigla, 'E', 'Abonar los recursos a nuestra cuenta SEBRA a cual relacionamos a continuación: ',
               'Los recursos serán abonados a través de nuestra cuenta SEBRA la cual relacionamos a continuación: ')                         val_fj17
             , infb_concep                                                                                                                   concep_cud    
             --, cud.cuen_nrocta                                                                                                             cod_cuen_cud  antes 1001 16/04/2024 Jmartinezm 
             , infb_cuen_cud_cod                                                                                                             cod_cuen_cud  
             , infb_portafolio                                                                                                               portafolio    
             , DECODE(list_sigla,'E',tbl_qreporsebra.fn_valor_variable (12), NULL)                                                           vari_12
             , cc.cont_nombre                                                                                                                confir_carta_nomb                                                         
             , cc.cont_telefono                                                                                                              confir_carta_tele                                                         
             , cc.cont_extension                                                                                                             confir_carta_exte                                                         
             , cs.cont_nombre                                                                                                                confir_sebra_nomb                                                         
             , cs.cont_telefono                                                                                                              confir_sebra_tele                                                         
             , cs.cont_extension                                                                                                             confir_sebra_exte                                                         
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
    vg_data_sebra(0).ing_egr            := NULL;
    vg_data_sebra(0).val_fj1            := NULL;
    vg_data_sebra(0).val_fj2            := NULL;
    vg_data_sebra(0).ciudad_fecha       := NULL;
    vg_data_sebra(0).nomb_banco         := NULL;
    vg_data_sebra(0).dest_carta         := NULL;
    vg_data_sebra(0).carg_dest_carta    := NULL;
    vg_data_sebra(0).ciud_dest_carta    := NULL;
    vg_data_sebra(0).fax_dest_carta     := NULL;
    vg_data_sebra(0).tele_dest_carta    := NULL;
    vg_data_sebra(0).emai_dest_carta    := NULL;
    vg_data_sebra(0).refe_carta         := NULL;
    vg_data_sebra(0).tipo_cuen          := NULL;
    vg_data_sebra(0).cod_cuenta         := NULL;
    vg_data_sebra(0).nomb_empr          := NULL;
    vg_data_sebra(0).valor_tras_num     := NULL;
    vg_data_sebra(0).val_fj17           := NULL;
    vg_data_sebra(0).concep_cud         := NULL;
    vg_data_sebra(0).cod_cuen_cud       := NULL;
    vg_data_sebra(0).portafolio         := NULL;
    vg_data_sebra(0).vari_12            := NULL;
    vg_data_sebra(0).confir_carta_nomb  := NULL;
    vg_data_sebra(0).confir_carta_tele  := NULL;
    vg_data_sebra(0).confir_carta_exte  := NULL;
    vg_data_sebra(0).confir_sebra_nomb  := NULL;
    vg_data_sebra(0).confir_sebra_tele  := NULL;
    vg_data_sebra(0).confir_sebra_exte  := NULL;
    --
    FOR i IN c_tras LOOP
        --
        --gen_pseguimiento('colp 1');
        vg_data_sebra(v_count).ing_egr              := i.ing_egr            ;--0  I-Ingreso - E-Egreso
    	vg_data_sebra(v_count).val_fj1              := i.val_fj1            ;--1  Valor fijo campo 1 Formato     
    	vg_data_sebra(v_count).val_fj2              := i.val_fj2            ;--2  Valor fijo campo 1 Código
    	vg_data_sebra(v_count).ciudad_fecha         := i.ciudad_fecha       ;--3  Ciudad y fecha Asociada al banco
    	vg_data_sebra(v_count).nomb_banco           := i.nomb_banco         ;--4  Nombre del banco
    	vg_data_sebra(v_count).dest_carta           := i.dest_carta         ;--5  Destinatario de la carta
    	vg_data_sebra(v_count).carg_dest_carta      := i.carg_dest_carta    ;--6  Cargo destinatario de la carta
    	vg_data_sebra(v_count).ciud_dest_carta      := i.ciud_dest_carta    ;--7  Ciudad destino de la carta
    	vg_data_sebra(v_count).fax_dest_carta       := i.fax_dest_carta     ;--8  Fax des destinatario de la carta
    	vg_data_sebra(v_count).tele_dest_carta      := i.tele_dest_carta    ;--9  Telefeno destinatario de la carta
    	vg_data_sebra(v_count).emai_dest_carta      := i.emai_dest_carta    ;--10 Correo Electronico del destinatario de la carta 
    	vg_data_sebra(v_count).refe_carta           := i.refe_carta         ;--11 Referencia de la carta    
    	vg_data_sebra(v_count).tipo_cuen            := i.tipo_cuen          ;--12 Tipo de cuenta a la cual se registra el debito y el credito
    	vg_data_sebra(v_count).cod_cuenta           := i.cod_cuenta         ;--13 Cuenta bancaria del aporte
    	vg_data_sebra(v_count).nomb_empr            := i.nomb_empr          ;--14 Nombre de la empresa
    	vg_data_sebra(v_count).valor_tras_num       := i.valor_tras_num     ;--15 Valor del traslado en números
    	vg_data_sebra(v_count).val_fj17             := i.val_fj17           ;--16 Valor fijo campo 17 
    	vg_data_sebra(v_count).concep_cud           := i.concep_cud         ;--17 Concepto CUD 
    	vg_data_sebra(v_count).cod_cuen_cud         := i.cod_cuen_cud       ;--18 Código de la cuenta CUD 
    	vg_data_sebra(v_count).portafolio           := i.portafolio         ;--19 Portafolio 20
    	vg_data_sebra(v_count).vari_12              := i.vari_12            ;--20 Variable 12
        vg_data_sebra(v_count).confir_carta_nomb    := i.confir_carta_nomb  ;--21 Nombre confirmación
        vg_data_sebra(v_count).confir_carta_tele    := i.confir_carta_tele  ;--22 Telefono confirmación
        vg_data_sebra(v_count).confir_carta_exte    := i.confir_carta_exte  ;--23 Extención confirmación
        vg_data_sebra(v_count).confir_sebra_nomb    := i.confir_sebra_nomb  ;--24 Nombre contacto sebra
        vg_data_sebra(v_count).confir_sebra_tele    := i.confir_sebra_tele  ;--25 Telefono contacto sebra
        vg_data_sebra(v_count).confir_sebra_exte    := i.confir_sebra_exte  ;--26 extensión contacto sebra
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
END tbl_qvpl_helm;
/
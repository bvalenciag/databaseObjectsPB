prompt
prompt PACKAGE: TBL_QVPL_BANC
prompt
create or replace PACKAGE tbl_qvpl_banc IS
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
-- 1001       16/04/2024 Jmartinezm   000002       * Ajuste al paquete.
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
      ciudad                          VARCHAR2(200)               --2  Ciudad Asociada al banco
    , ano                             VARCHAR2(4)                 --3  Año en que se registra el traslado
    , mes                             VARCHAR2(2)                 --4  Mes en que se regrstra el traslado
    , dia                             VARCHAR2(2)                 --5  Día en que se registra el traslado
    , razon                           VARCHAR2(100)               --6  Nombre de la empresa que hace el traslado
    , tipodocu                        VARCHAR2(3)                 --7  Valor fijo NIT
    , identif                         VARCHAR2(200)               --8  Nit del banco
    , dv                              VARCHAR2(9)                 --9  Digito de verificación
    , Nomb_empr_cr                    VARCHAR2(100)               --10 Para INGRESOS: Nombre empresa que hace el traslado
    , cod_cuen_CUD_cr                 VARCHAR2(40)                --11 Para INGRESOS: Código de la cuenta CUD
    , port_cr                         VARCHAR2(2)                 --12 Para INGRESOS: Valor fijo 0, PORTAFOLIO 
    , valor_cr                        NUMBER                      --13 Para INGRESOS: Valor del traslado
    , fech_tras_cr                    VARCHAR2(10)                --14 Para INGRESOS: Fecha del traslado (dd/mm/aaaa)
    , tip_cuen_apor_cr                VARCHAR2(20)                --15 Para INGRESOS: Tipo de cuenta a la cual se registra el aporte
    , num_cuen_apor_cr                VARCHAR2(40)                --16 Para INGRESOS: Número de cuenta a la cual se registra el aporte
    , tip_cuen_reti_db                VARCHAR2(20)                --17 Para EGRESOS: Tipo de cuenta a la cual se registra el retiro
    , num_cuen_reti_db                VARCHAR2(40)                --18 Para EGRESOS: Número de cuenta a la cual se registra el retiro
    , Nomb_empr_db                    VARCHAR2(100)               --19 Para EGRESOS: Nombre empresa que hace el traslado
    , valor_db                        NUMBER                      --20 Para EGRESOS: Valor del traslado
    , cod_cuen_CUD_db                 VARCHAR2(40)                --21 Para EGRESOS: Código de la cuenta CUD
    , port_db                         VARCHAR2(2)                 --22 Para EGRESOS: Valor fijo 0, PORTAFOLIO
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
END tbl_qvpl_banc;
/
prompt
prompt PACKAGE BODY: TBL_QVPL_BANC
prompt
--
CREATE OR REPLACE PACKAGE BODY tbl_qvpl_banc IS
--
-- #VERSION: 1001
--
FUNCTION ws_fn_acx_fill_sebra (p_traslado tbl_ttrasebra.tras_tras%TYPE
                               ) RETURN BOOLEAN IS
    --
    CURSOR c_tras IS
        SELECT infb_ciudad                                                              ciudad          
             , to_char(tras_fecha, 'yyyy')                                              ano             
             , to_char(tras_fecha, 'mm')                                                mes             
             , to_char(tras_fecha, 'dd')                                                dia             
             , empr_descripcion                                                         razon           
             , 'NIT'                                                                    tipodocu 
             --, infb_nit                                                               identif antes 1001  16/04/2024 Jmartinezm               
             , empr_nit                                                                 identif --1001      16/04/2024 Jmartinezm       
             --, infb_dv                                                                dv antes 1001  16/04/2024 Jmartinezm                     
             , empr_digito                                                              dv --1001      16/04/2024 Jmartinezm                     
             , DECODE(list_sigla, 'I', empr_descripcion, NULL)                          Nomb_empr_cr    
             --, DECODE(list_sigla, 'I', SUBSTR(cud.cuen_nrocta,1,8), NULL)             cod_cuen_CUD_cr antes 1001  16/04/2024 Jmartinezm
             , DECODE(list_sigla, 'I', LPAD(SUBSTR(infb_cuen_cud_cod,1,8),8,' '), NULL) cod_cuen_CUD_cr --1001  16/04/2024 Jmartinezm
             , DECODE(list_sigla, 'I', LPAD(SUBSTR(infb_portafolio,1,2), 2, ' '), NULL) port_cr         --1001  16/04/2024 Jmartinezm 
             , DECODE(list_sigla, 'I', tras_valor, NULL)                                valor_cr        
             , DECODE(list_sigla, 'I', TO_CHAR(tras_fecha,'DD/MM/YYYY'), NULL)          fech_tras_cr    
             , DECODE(list_sigla, 'I', cue.cuen_tipo, NULL)                             tip_cuen_apor_cr
             , DECODE(list_sigla, 'I', LPAD(cue.cuen_nrocta, 11, ' '), NULL)            num_cuen_apor_cr
             , DECODE(list_sigla, 'E', cue.cuen_tipo, NULL)                             tip_cuen_reti_db
             , DECODE(list_sigla, 'E', LPAD(cue.cuen_nrocta, 11, ' '), NULL)            num_cuen_reti_db
             , DECODE(list_sigla, 'E', empr_descripcion, NULL)                          Nomb_empr_db    
             , DECODE(list_sigla, 'E', tras_valor, NULL)                                valor_db        
             --, DECODE(list_sigla, 'E', SUBSTR(cud.cuen_nrocta,1,8), NULL)             cod_cuen_CUD_db antes 1001  16/04/2024 Jmartinezm
             , DECODE(list_sigla, 'E', LPAD(SUBSTR(infb_cuen_cud_cod, 1, 8), 8, ' '), NULL) cod_cuen_CUD_db --1001  16/04/2024 Jmartinezm
             , DECODE(list_sigla, 'E', LPAD(SUBSTR(infb_portafolio, 1, 2), 2, ' '), NULL)   port_db         --1001  16/04/2024 Jmartinezm
          FROM tbl_ttrasebra
             , tbl_tinfbancos
             , tbl_tempresas
             , gen_tlistas
             --, tbl_tcuentasban cud antes 1001  16/04/2024 Jmartinezm
             , tbl_tcuentasban cue
         WHERE tras_banc      = infb_banc
           AND tras_empr      = empr_empr
           AND tras_tipo_oper = list_list
           --AND tras_cuen_cud  = cud.cuen_cuen antes 1001  16/04/2024 Jmartinezm
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
    vg_data_sebra(1).ciudad             := r_tras.ciudad          ;--2  Ciudad Asociada al banco
    vg_data_sebra(1).ano                := r_tras.ano             ;--3  Año en que se registra el traslado
    vg_data_sebra(1).mes                := r_tras.mes             ;--4  Mes en que se regrstra el traslado
    vg_data_sebra(1).dia                := r_tras.dia             ;--5  Día en que se registra el traslado
    vg_data_sebra(1).razon              := r_tras.razon           ;--6  Nombre de la empresa que hace el traslado
    vg_data_sebra(1).tipodocu           := r_tras.tipodocu        ;--7  Valor fijo NIT
    vg_data_sebra(1).identif            := r_tras.identif         ;--8  Nit del banco
    vg_data_sebra(1).dv                 := r_tras.dv              ;--9  Digito de verificación
    vg_data_sebra(1).Nomb_empr_cr       := r_tras.Nomb_empr_cr    ;--10 Para INGRESOS: Nombre empresa que hace el traslado
    vg_data_sebra(1).cod_cuen_CUD_cr    := r_tras.cod_cuen_CUD_cr ;--11 Para INGRESOS: Código de la cuenta CUD
    vg_data_sebra(1).port_cr            := r_tras.port_cr         ;--12 Para INGRESOS: Valor fijo 0, PORTAFOLIO 
    vg_data_sebra(1).valor_cr           := r_tras.valor_cr        ;--13 Para INGRESOS: Valor del traslado
    vg_data_sebra(1).fech_tras_cr       := r_tras.fech_tras_cr    ;--14 Para INGRESOS: Fecha del traslado (dd/mm/aaaa)
    vg_data_sebra(1).tip_cuen_apor_cr   := r_tras.tip_cuen_apor_cr;--15 Para INGRESOS: Tipo de cuenta a la cual se registra el aporte
    vg_data_sebra(1).num_cuen_apor_cr   := r_tras.num_cuen_apor_cr;--16 Para INGRESOS: Número de cuenta a la cual se registra el aporte
    vg_data_sebra(1).tip_cuen_reti_db   := r_tras.tip_cuen_reti_db;--17 Para EGRESOS: Tipo de cuenta a la cual se registra el retiro
    vg_data_sebra(1).num_cuen_reti_db   := r_tras.num_cuen_reti_db;--18 Para EGRESOS: Número de cuenta a la cual se registra el retiro
    vg_data_sebra(1).Nomb_empr_db       := r_tras.Nomb_empr_db    ;--19 Para EGRESOS: Nombre empresa que hace el traslado
    vg_data_sebra(1).valor_db           := r_tras.valor_db        ;--20 Para EGRESOS: Valor del traslado
    vg_data_sebra(1).cod_cuen_CUD_db    := r_tras.cod_cuen_CUD_db ;--21 Para EGRESOS: Código de la cuenta CUD
    vg_data_sebra(1).port_db            := r_tras.port_db         ;--22 Para EGRESOS: Valor fijo 0, PORTAFOLIO
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
END tbl_qvpl_banc;
/
prompt
prompt PACKAGE: GEN_QAPI_REST
prompt
create or replace PACKAGE gen_qapi_rest IS
--
-- Reúne funciones y procedimientos directamente relacionados con el procedimiento de recibir información de apis rest
--
-- #VERSION: 1002
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       25/10/2023 Cramirezs    000001       * Se crea paquete.
--                       Kilonova
-- ========== ========== ============ ============ ============================================================================================================
-- 1001       14/12/2023 cramirezs    000001       * Se crean procedimientos sp_get_mopf_api_rest, sp_validar_dat_tran, sp_validar_dat_movi, sp_valida_fmto
--                       Kilonova     MVP_2          sp_get_regi_api_rest, sp_get_canc_api_rest, sp_get_mopm_api_rest, api_rest_regi, api_rest_canc, 
--                                                   api_rest_mopf, api_rest_mopm
--                                                 * Se crea función fn_movi_bizagi.
--                                                 * Se crean types ty_tran y ty_mvbi.
--                                                 * Se agrega parámetro p_empr en función fn_get_api.
-- ========== ========== ============ ============ ============================================================================================================
-- 1002       14/08/2024 cramrezs     000001       * Se ajusta función fn_get_api para que si el proceso es de sincronización de cancelaciones solicite  
--                       Kilonova                    la fecha anterior.
--                                                 * Se ajusta api_rest_canc y api_rest_mopf para que se ejecute todos los días.
--                                                 * Se agrega condición en sp_get_canc_api_rest para validar si el día de la cancelación es un día no habíl 
--                                                   lleva la cancelación al siguiente día habíl.
-- ========== ========== ============ ============ ============================================================================================================
--
-------------------------------------------------------------------------------------------------
--Types
-------------------------------------------------------------------------------------------------
--
--Ini 1001 14/12/2023 cramirezs
TYPE ty_tran IS RECORD(
      transaccion   VARCHAR2(4000)
    , aplicacion    VARCHAR2(4000)
    , fecha         VARCHAR2(4000)
    , hora          VARCHAR2(4000)
    , terminal      VARCHAR2(4000)
    , usuario       VARCHAR2(4000)
    , canal         VARCHAR2(4000)
);
--
TYPE ty_mvbi IS RECORD(
      motb_caso         VARCHAR2(4000) 
    , motb_empresa      VARCHAR2(4000)
    , motb_banco        VARCHAR2(4000)
    , motb_nrocta       VARCHAR2(4000)
    , motb_fecha        VARCHAR2(4000)
    , motb_descripcion  VARCHAR2(4000)
    , motb_valor        VARCHAR2(4000)
    , motb_estado       VARCHAR2(4000)
    , motb_tipo_oper    VARCHAR2(4000)
    , motb_gmf          VARCHAR2(4000)
);
--Fin 1001 14/12/2023 cramirezs
--
-------------------------------------------------------------------------------------------------
--Procedure - Function
-------------------------------------------------------------------------------------------------
--
FUNCTION fn_get_api (p_api gen_tapis.apis_apis%TYPE
                   , p_empr tbl_tempresas.empr_empr%TYPE DEFAULT NULL--1001 14/12/2023 cramirezs
                    ) RETURN CLOB;
--
-------------------------------------------------------------------------------------------------
--
PROCEDURE sp_get_banc_api_rest;
--
-------------------------------------------------------------------------------------------------
--
PROCEDURE sp_get_empr_api_rest;
--
-------------------------------------------------------------------------------------------------
--
PROCEDURE sp_get_cuen_api_rest;
--
-------------------------------------------------------------------------------------------------
--
PROCEDURE api_rest_basi;
--
-------------------------------------------------------------------------------------------------
--
PROCEDURE api_rest_movi;
--
-------------------------------------------------------------------------------------------------
--
PROCEDURE api_rest_sald;
--Ini 1001 14/12/2023 cramirezs
---------------------------------------------------------------------------------------------------
--
PROCEDURE api_rest_regi;
--
---------------------------------------------------------------------------------------------------
--
PROCEDURE api_rest_canc;
--
---------------------------------------------------------------------------------------------------
--
PROCEDURE api_rest_mopf;
--
---------------------------------------------------------------------------------------------------
--
PROCEDURE api_rest_mopm;
--
---------------------------------------------------------------------------------------------------
--Fin 1001 14/12/2023 cramirezs
--
-------------------------------------------------------------------------------------------------
--
PROCEDURE sp_get_movi_api_rest;
--
-------------------------------------------------------------------------------------------------
--
PROCEDURE sp_get_sald_api_rest;
--
-------------------------------------------------------------------------------------------------
--Ini 1001 14/12/2023 cramirezs
-------------------------------------------------------------------------------------------------
--
PROCEDURE sp_get_regi_api_rest;
--
-------------------------------------------------------------------------------------------------
--
PROCEDURE sp_get_canc_api_rest;
--
-------------------------------------------------------------------------------------------------
--
PROCEDURE sp_get_fest_api_rest;
--
-------------------------------------------------------------------------------------------------
--
PROCEDURE sp_get_mopf_api_rest;
--
-------------------------------------------------------------------------------------------------
--
PROCEDURE sp_get_mopm_api_rest;
--
-------------------------------------------------------------------------------------------------
--
FUNCTION fn_movi_bizagi(p_body CLOB DEFAULT NULL
                        ) RETURN CLOB;
--
-------------------------------------------------------------------------------------------------
--
PROCEDURE sp_validar_dat_tran( p_ty_tran       gen_qapi_rest.ty_tran
                             , p_campo1    OUT VARCHAR2
                             , p_campo2    OUT VARCHAR2
                             , p_campo3    OUT VARCHAR2
                             , p_ty_msg    OUT gen_qgeneral.ty_msg
                          );
--
-------------------------------------------------------------------------------------------------
--
PROCEDURE sp_validar_dat_movi( p_ty_mvbi       gen_qapi_rest.ty_mvbi
                             , p_campo1    OUT VARCHAR2
                             , p_campo2    OUT VARCHAR2
                             , p_campo3    OUT VARCHAR2
                             , p_ty_msg    OUT gen_qgeneral.ty_msg
                          );
--
-------------------------------------------------------------------------------------------------
--
PROCEDURE sp_valida_fmto( p_long           NUMBER
                        , p_perm           NUMBER
                        , p_colu           VARCHAR2
                        , p_dato           VARCHAR2
                        , p_tipo_dat       VARCHAR2
                        , p_campo1     OUT VARCHAR2  
                        , p_campo2     OUT VARCHAR2
                        , p_campo3     OUT VARCHAR2
                        , p_ty_msg    OUT gen_qgeneral.ty_msg
                          );
--
--Fin 1001 14/12/2023 cramirezs
-------------------------------------------------------------------------------------------------
--
END gen_qapi_rest;
/
prompt
prompt PACKAGE BODY: gen_qapi_rest
prompt
--
CREATE OR REPLACE PACKAGE BODY gen_qapi_rest IS
--
-- #VERSION: 1002
--
---------------------------------------------------------------------------------------------------
FUNCTION fn_get_api (p_api  gen_tapis.apis_apis%TYPE
                   , p_empr tbl_tempresas.empr_empr%TYPE DEFAULT NULL--1001 14/12/2023 cramirezs
                    ) RETURN CLOB AS
    --
    v_resp_buffer       CLOB;
    --
    CURSOR c_apis IS
        SELECT apis_token_url
             , apis_client_id
             , apis_client_secret
             , apis_utl_url
             , apis_method
             , apis_wall_path
             , apis_wall_pwd
             , apis_encodig
         FROM gen_tapis
        WHERE apis_apis = p_api
        ;
    --
    r_apis  c_apis%ROWTYPE;
    --
    v_ty_msg    gen_qgeneral.ty_msg;
    --
    e_error     EXCEPTION;
    --
    v_para      gen_tparametros.para_valor%TYPE;
    v_fecha     DATE;
    v_api       VARCHAR2(4000);
    --
BEGIN
    --
    --Recupera par metros por api
    OPEN  c_apis;
    FETCH c_apis INTO r_apis;
    CLOSE c_apis;
    --
    --IF p_api IN ('movi', 'sald') THEN--Antes 1001 14/12/2023 cramirezs
    IF p_api IN ('movi', 'sald', 'regi', 'canc', 'fest', 'mopf', 'mopm') THEN--1001 14/12/2023 cramirezs
        --
        v_para := gen_qgeneral.recupera_parametro(gen_qgeneral.id_lista('GEN', 'MODU_EDGE', 'TBL'), 'FECH_CONS_MOVI');
        --
        IF v_para IS NOT NULL THEN
            --
            BEGIN
                --
                v_fecha := TO_DATE(v_para, 'DD/MM/YYYY');
                --
            EXCEPTION
                WHEN OTHERS THEN
                    v_fecha := SYSDATE;
            END;
            --
        ELSE
            --
            v_fecha := SYSDATE;
            --
        END IF;
        --
        --Ini 1002 cramirezs 14/08/2024
        IF p_api = 'canc' THEN
            --
            v_fecha := v_fecha - 1;
            --
        END IF;
        --Fin 1002 cramirezs 14/08/2024
        --
        v_api := p_api||'/'||TO_CHAR(v_fecha,'DDMMYYYY');
        --
        --Ini 1001 14/12/2023 cramirezs
        IF p_api = 'regi' AND p_empr IS NOT NULL THEN
            --
            v_api := v_api||'/'||p_empr;
            --
        END IF;
        --
        IF p_api = 'fest' THEN
            --
            v_api := p_api||'/'||TO_CHAR(v_fecha,'YYYY');
            --
        END IF;
        --
        IF p_api IN ('mopf', 'mopm') THEN
            --
            v_api := 'movi'||'/'||TO_CHAR(v_fecha,'DDMMYYYY');
            --
        END IF;
        --Fin 1001 14/12/2023 cramirezs
        --
    ELSE
        --
        v_api := p_api;
        --
    END IF;
    --
    --gen_pseguimiento(' v_api: '||v_api||' r_apis.apis_utl_url: '||r_apis.apis_utl_url);
    -- TODO: Implementation required for FUNCTION EDGE_PCK_API_REST.FN_GET_TOKEN
    apex_web_service.oauth_authenticate(p_token_url     => r_apis.apis_token_url            --'http://172.31.0.52:7001/occistru/api/oauth/token'
                                      , p_client_id     => r_apis.apis_client_id            --'je__XqXLTfQR7trTd4ICBg..'
                                      , p_client_secret => r_apis.apis_client_secret        --'82hRNnld565gy5qGBLmH2g..'
                                        );
    --
    APEX_WEB_SERVICE.g_request_headers.delete();
    APEX_WEB_SERVICE.g_request_headers(1).NAME  := 'Authorization';
    APEX_WEB_SERVICE.g_request_headers(1).VALUE := 'Bearer '||apex_web_service.oauth_get_last_token;
    --
    --P_URL => UTL_URL.ESCAPE('http://172.31.0.52:7001/occistru/api/edge/'||li_api, FALSE, 'UTF-8'),
    v_resp_buffer := APEX_WEB_SERVICE.make_rest_request(p_url         => UTL_URL.ESCAPE(r_apis.apis_utl_url||v_api, FALSE, r_apis.apis_encodig)
                                                      , p_http_method => r_apis.apis_method     --'GET'
                                                      , p_wallet_path => r_apis.apis_wall_path
                                                      , p_wallet_pwd  => r_apis.apis_wall_pwd
                                                        );
    RETURN v_resp_buffer;
    --
END fn_get_api;
---------------------------------------------------------------------------------------------------
PROCEDURE sp_get_banc_api_rest IS
    --
    v_items_object          JSON_OBJECT_T;
    vt_items                JSON_ARRAY_T;
    vr_item_rec             JSON_OBJECT_T;
    v_json_clob             CLOB;
    v_count                 PLS_INTEGER := 0;
    --
    v_ty_banc               tbl_qbancos_crud.ty_banc;
    v_banc_banc             tbl_tbancos.banc_banc%TYPE;
    --
    v_ty_msg                gen_qgeneral.ty_msg;
    e_error                 EXCEPTION;
    --
BEGIN -- Get the CLOB.
    --
    v_json_clob := gen_qapi_rest.fn_get_api('banc');
    --SELECT json_clob INTO v_json_clob FROM test_json_parsing WHERE json_id = 5;
    -- Parse the JSON CLOB.
    v_items_object := JSON_OBJECT_T.PARSE(v_json_clob);
    -- Get the ITEMS Array.
    vt_items := v_items_object.get_Array('banc_data');
    -- Get the Record Count.
    v_count := vt_items.get_size;
    -- Loop through the items and get the item_id for each.
    FOR i IN 0..v_count -1 LOOP
        --
        vr_item_rec                 := JSON_OBJECT_T(vt_items.get(i));
        v_ty_banc                   := NULL;
        v_ty_banc.banc_externo      := vr_item_rec.get_String('BANC_BANC');
        v_ty_banc.banc_descripcion  := vr_item_rec.get_String('BANC_DESCRI');
        v_ty_banc.banc_fuente       := gen_qgeneral.id_lista('TBL', 'FUEN_INFO', 'SF');
        v_ty_banc.banc_fecins       := SYSDATE;
        v_ty_banc.banc_usuains      := USER;
        v_ty_banc.banc_banc         := tbl_qgeneral.recupera_banc(v_ty_banc.banc_externo, v_ty_banc.banc_fuente);
        --
        IF v_ty_banc.banc_banc IS NULL THEN
            --
            tbl_qbancos_crud.insertar_tbl_tbancos(
                                                  v_ty_banc
                                                , v_banc_banc
                                                , v_ty_msg
                                                );
            --
            IF v_ty_msg.cod_msg <> 'OK' THEN
                --
                raise e_error;
                --
            END IF;
            --
        ELSE
            --
            v_ty_banc.banc_fecupd         := SYSDATE;
            v_ty_banc.banc_usuaupd        := USER;
            --
            tbl_qbancos_crud.actualizar_tbl_tbancos(
                                                    v_ty_banc
                                                  , v_ty_msg
                                                    );
            --
            IF v_ty_msg.cod_msg <> 'OK' THEN
                --
                raise e_error;
                --
            END IF;
            --
        END IF;
        --
    END LOOP;
    --
    COMMIT;
    --
EXCEPTION
    WHEN e_error THEN
        GEN_PSEGUIMIENTO('Error en gen_qapi_rest.sp_get_banc_api_rest: '||v_ty_msg.msg_msg);
    WHEN OTHERS THEN
        GEN_PSEGUIMIENTO('Error NO_CTRL en gen_qapi_rest.sp_get_banc_api_rest: '||sqlerrm);
END sp_get_banc_api_rest;
---------------------------------------------------------------------------------------------------
PROCEDURE sp_get_empr_api_rest IS
    --
    v_items_object          JSON_OBJECT_T;
    vt_items                JSON_ARRAY_T;
    vr_item_rec             JSON_OBJECT_T;
    v_json_clob             CLOB;
    v_count                 PLS_INTEGER := 0;
    --
    v_ty_empr               tbl_qempresas_crud.ty_empr;
    v_empr_empr             tbl_tempresas.empr_empr%TYPE;
    --
    v_ty_msg                gen_qgeneral.ty_msg;
    e_error                 EXCEPTION;
    --
BEGIN -- Get the CLOB.
    --
    v_json_clob := gen_qapi_rest.fn_get_api('empr');
    --SELECT json_clob INTO v_json_clob FROM test_json_parsing WHERE json_id = 5;
    -- Parse the JSON CLOB.
    v_items_object := JSON_OBJECT_T.PARSE(v_json_clob);
    -- Get the ITEMS Array.
    vt_items := v_items_object.get_Array('empr_data');
    -- Get the Record Count.
    v_count := vt_items.get_size;
    -- Loop through the items and get the item_id for each.
    FOR i IN 0..v_count -1 LOOP
        --
        vr_item_rec                 := JSON_OBJECT_T(vt_items.get(i));
        v_ty_empr                   := NULL;
        v_ty_empr.empr_externo      := vr_item_rec.get_String('empr_externo');
        v_ty_empr.empr_descripcion  := vr_item_rec.get_String('empr_descripcion');
        v_ty_empr.empr_fond         := vr_item_rec.get_String('empr_fond');
        v_ty_empr.empr_esta         := gen_qgeneral.id_estado('TBL', 'BASICOS', vr_item_rec.get_String('empr_esta'));
        v_ty_empr.empr_fuente       := gen_qgeneral.id_lista('TBL', 'FUEN_INFO', 'SF');
        v_ty_empr.empr_empr         := tbl_qgeneral.recupera_empr(v_ty_empr.empr_externo, v_ty_empr.empr_fuente);
        v_ty_empr.empr_nit          := vr_item_rec.get_String('empr_nit');   --27/02/2024
        v_ty_empr.empr_digito       := vr_item_rec.get_String('empr_digito');--27/02/2024
        --
        IF v_ty_empr.empr_empr IS NULL THEN
            --
            v_ty_empr.empr_fecins       := SYSDATE;
            v_ty_empr.empr_usuains      := USER;
            v_ty_empr.empr_sincroniza   := 'N';
            --
            GEN_PSEGUIMIENTO('Error : v_ty_empr.empr_externo: '||v_ty_empr.empr_externo
                                ||' v_ty_empr.empr_descripcion: '||v_ty_empr.empr_descripcion
                                ||' v_ty_empr.empr_fond: '||v_ty_empr.empr_fond
                                ||' v_ty_empr.empr_esta: '||v_ty_empr.empr_esta
                                ||' v_ty_empr.empr_fuente: '||v_ty_empr.empr_fuente
                                ||' v_ty_empr.empr_empr: '||v_ty_empr.empr_empr
            );
            --
            tbl_qempresas_crud.insertar_tbl_tempresas(
                                                  v_ty_empr
                                                , v_empr_empr
                                                , v_ty_msg
                                                );
            --
            IF v_ty_msg.cod_msg <> 'OK' THEN
                --
                raise e_error;
                --
            END IF;
            --
        ELSE
            --
            v_ty_empr.empr_fecupd       := SYSDATE;
            v_ty_empr.empr_usuaupd      := USER;
            --
            tbl_qempresas_crud.actualizar_tbl_tempresas(
                                                    v_ty_empr
                                                  , v_ty_msg
                                                    );
            --
            IF v_ty_msg.cod_msg <> 'OK' THEN
                --
                raise e_error;
                --
            END IF;
            --
        END IF;
        --
    END LOOP;
    --
    COMMIT;
    --
EXCEPTION
    WHEN e_error THEN
        GEN_PSEGUIMIENTO('Error en gen_qapi_rest.sp_get_empr_api_rest: '||v_ty_msg.msg_msg);
    WHEN OTHERS THEN
        GEN_PSEGUIMIENTO('Error NO_CTRL en gen_qapi_rest.sp_get_empr_api_rest: '||sqlerrm);
END sp_get_empr_api_rest;
---------------------------------------------------------------------------------------------------
PROCEDURE sp_get_cuen_api_rest IS
    --
    v_items_object          JSON_OBJECT_T;
    vt_items                JSON_ARRAY_T;
    vr_item_rec             JSON_OBJECT_T;
    v_json_clob             CLOB;
    v_count                 PLS_INTEGER := 0;
    --
    v_ty_cuen               tbl_qcuentasban_crud.ty_cuen;
    v_cuen_cuen             TBL_Tcuentasban.cuen_cuen%TYPE;
    v_ty_banx               tbl_qbanxempres_crud.ty_BANX;
    --
    v_ty_msg                gen_qgeneral.ty_msg;
    e_error                 EXCEPTION;
    v_fuente                gen_tlistas.list_list%TYPE;
    --
    CURSOR c_banx (pc_banc tbl_tbanxempres.banx_banc%TYPE
                 , pc_empr tbl_tbanxempres.banx_empr%TYPE
                    )IS
        SELECT 'S'
          FROM tbl_tbanxempres
         WHERE banx_banc = pc_banc
           AND banx_empr = pc_empr
        ;
    --
    r_banx      c_banx%ROWTYPE;
    --
BEGIN -- Get the CLOB.
    --
    v_json_clob := gen_qapi_rest.fn_get_api('cuen');
    --SELECT json_clob INTO v_json_clob FROM test_json_parsing WHERE json_id = 5;
    -- Parse the JSON CLOB.
    v_items_object := JSON_OBJECT_T.PARSE(v_json_clob);
    -- Get the ITEMS Array.
    vt_items := v_items_object.get_Array('cuen_data');
    -- Get the Record Count.
    v_count := vt_items.get_size;
    --
    v_fuente := gen_qgeneral.id_lista('TBL', 'FUEN_INFO', 'SF');
    -- Loop through the items and get the item_id for each.
    FOR i IN 0..v_count -1 LOOP
        --
        vr_item_rec                 := JSON_OBJECT_T(vt_items.get(i));
        v_ty_cuen                   := NULL;
        v_ty_cuen.cuen_empr         := tbl_qgeneral.recupera_empr(vr_item_rec.get_String('cuen_empr'), v_fuente);
        v_ty_cuen.cuen_banc         := tbl_qgeneral.recupera_banc(vr_item_rec.get_String('cuen_banc'), v_fuente);
        v_ty_cuen.cuen_nrocta       := vr_item_rec.get_String('cuen_nrocta');
        v_ty_cuen.cuen_descripcion  := vr_item_rec.get_String('cuen_descripcion');
        v_ty_cuen.cuen_tipo         := vr_item_rec.get_String('cuen_tipo');
        v_ty_cuen.cuen_esta         := gen_qgeneral.id_estado('TBL', 'BASICOS', vr_item_rec.get_String('cuen_esta'));
        v_ty_cuen.cuen_cuen         := tbl_qgeneral.recupera_cuen(v_ty_cuen.cuen_empr, v_ty_cuen.cuen_banc, v_ty_cuen.cuen_nrocta);
        --
        IF v_ty_cuen.cuen_cuen IS NULL THEN
            --
            v_ty_cuen.cuen_fecins       := SYSDATE;
            v_ty_cuen.cuen_usuains      := USER;
            v_ty_cuen.cuen_sincroniza   := 'N';
            --
            tbl_qcuentasban_crud.insertar_tbl_tcuentasban(
                                                          v_ty_cuen
                                                        , v_cuen_cuen
                                                        , v_ty_msg
                                                        );
            --
            IF v_ty_msg.cod_msg <> 'OK' THEN
                --
                raise e_error;
                --
            END IF;
            --
            OPEN c_banx (v_ty_cuen.cuen_banc
                       , v_ty_cuen.cuen_empr
                         );
            FETCH c_banx INTO r_banx;
            IF c_banx%NOTFOUND THEN
                --
                v_ty_banx              := NULL;
                v_ty_banx.banx_banc    := v_ty_cuen.cuen_banc;
                v_ty_banx.banx_empr    := v_ty_cuen.cuen_empr;
                v_ty_banx.banx_fecins  := SYSDATE;
                v_ty_banx.banx_usuains := USER;
                --
                tbl_qbanxempres_crud.insertar_tbl_tbanxempres(
                                                               v_ty_banx
                                                             , v_ty_msg
                                                                );
                --
                IF v_ty_msg.cod_msg <> 'OK' THEN
                    --
                    raise e_error;
                    --
                END IF;
                --
            END IF;
            CLOSE c_banx;
            --
        ELSE
            --
            v_ty_cuen.cuen_fecupd       := SYSDATE;
            v_ty_cuen.cuen_usuaupd      := USER;
            --
            tbl_qcuentasban_crud.actualizar_tbl_tcuentasban(
                                                            v_ty_cuen
                                                          , v_ty_msg
                                                            );
            --
            IF v_ty_msg.cod_msg <> 'OK' THEN
                --
                raise e_error;
                --
            END IF;
            --
        END IF;
        --
    END LOOP;
    --
    COMMIT;
    --
EXCEPTION
    WHEN e_error THEN
        GEN_PSEGUIMIENTO('Error en gen_qapi_rest.sp_get_cuen_api_rest: '||v_ty_msg.msg_msg);
    WHEN OTHERS THEN
        GEN_PSEGUIMIENTO('Error NO_CTRL en gen_qapi_rest.sp_get_cuen_api_rest: '||sqlerrm);
END sp_get_cuen_api_rest;
---------------------------------------------------------------------------------------------------
PROCEDURE api_rest_basi IS
    --
BEGIN
    --
    IF TO_NUMBER(to_char(SYSDATE,'D')) >= 2 AND TO_NUMBER(to_char(SYSDATE,'D')) <= 6 THEN
        --
        gen_qapi_rest.sp_get_empr_api_rest;
        gen_qapi_rest.sp_get_banc_api_rest;
        gen_qapi_rest.sp_get_cuen_api_rest;
        --
    END IF;
    --
EXCEPTION
    WHEN OTHERS THEN
        GEN_PSEGUIMIENTO('Error NO_CTRL en gen_qapi_rest.api_rest_basi: '||sqlerrm);
END api_rest_basi;
---------------------------------------------------------------------------------------------------
PROCEDURE api_rest_movi IS
    --
BEGIN
    --
    IF TO_NUMBER(to_char(SYSDATE,'D')) >= 2 AND TO_NUMBER(to_char(SYSDATE,'D')) <= 6 THEN
        --
        gen_qapi_rest.sp_get_movi_api_rest;
        --
    END IF;
    --
EXCEPTION
    WHEN OTHERS THEN
        GEN_PSEGUIMIENTO('Error NO_CTRL en gen_qapi_rest.api_rest_movi: '||sqlerrm);
END api_rest_movi;
---------------------------------------------------------------------------------------------------
PROCEDURE api_rest_sald IS
    --
BEGIN
    --
    IF TO_NUMBER(to_char(SYSDATE,'D')) >= 2 AND TO_NUMBER(to_char(SYSDATE,'D')) <= 6 THEN
        --
        gen_qapi_rest.sp_get_sald_api_rest;
        --
    END IF;
    --
EXCEPTION
    WHEN OTHERS THEN
        GEN_PSEGUIMIENTO('Error NO_CTRL en gen_qapi_rest.api_rest_sald: '||sqlerrm);
END api_rest_sald;
---------------------------------------------------------------------------------------------------
--Ini 1001 14/12/2023 cramirezs
---------------------------------------------------------------------------------------------------
PROCEDURE api_rest_regi IS
    --
BEGIN
    --
    IF TO_NUMBER(to_char(SYSDATE,'D')) >= 2 AND TO_NUMBER(to_char(SYSDATE,'D')) <= 6 THEN
        --
        gen_qapi_rest.sp_get_regi_api_rest;
        --
    END IF;
    --
EXCEPTION
    WHEN OTHERS THEN
        GEN_PSEGUIMIENTO('Error NO_CTRL en gen_qapi_rest.api_rest_regi: '||sqlerrm);
END api_rest_regi;
---------------------------------------------------------------------------------------------------
PROCEDURE api_rest_canc IS
    --
BEGIN
    --
    --IF TO_NUMBER(to_char(SYSDATE,'D')) >= 2 AND TO_NUMBER(to_char(SYSDATE,'D')) <= 6 THEN--Antes 1002 cramirezs 14/08/2024
        --
        gen_qapi_rest.sp_get_canc_api_rest;
        --
    --END IF;--Antes 1002 cramirezs 14/08/2024
    --
EXCEPTION
    WHEN OTHERS THEN
        GEN_PSEGUIMIENTO('Error NO_CTRL en gen_qapi_rest.api_rest_canc: '||sqlerrm);
END api_rest_canc;
---------------------------------------------------------------------------------------------------
PROCEDURE api_rest_mopf IS
    --
BEGIN
    --
    --IF TO_NUMBER(to_char(SYSDATE,'D')) >= 2 AND TO_NUMBER(to_char(SYSDATE,'D')) <= 6 THEN--Antes 1002 cramirezs 14/08/2024
        --
        gen_qapi_rest.sp_get_mopf_api_rest;
        --
    --END IF;--Antes 1002 cramirezs 14/08/2024
    --
EXCEPTION
    WHEN OTHERS THEN
        GEN_PSEGUIMIENTO('Error NO_CTRL en gen_qapi_rest.api_rest_mopf: '||sqlerrm);
END api_rest_mopf;
---------------------------------------------------------------------------------------------------
PROCEDURE api_rest_mopm IS
    --
BEGIN
    --
    IF TO_NUMBER(to_char(SYSDATE,'D')) >= 2 AND TO_NUMBER(to_char(SYSDATE,'D')) <= 6 THEN
        --
        gen_qapi_rest.sp_get_mopm_api_rest;
        --
    END IF;
    --
EXCEPTION
    WHEN OTHERS THEN
        GEN_PSEGUIMIENTO('Error NO_CTRL en gen_qapi_rest.api_rest_mopm: '||sqlerrm);
END api_rest_mopm;
---------------------------------------------------------------------------------------------------
--Fin 1001 14/12/2023 cramirezs
---------------------------------------------------------------------------------------------------
PROCEDURE sp_get_movi_api_rest IS
    --
    v_items_object          JSON_OBJECT_T;
    vt_items                JSON_ARRAY_T;
    vr_item_rec             JSON_OBJECT_T;
    v_json_clob             CLOB;
    v_count                 PLS_INTEGER := 0;
    --
    v_ty_movi               tbl_qmoviteso_crud.ty_movi;
    v_movi_movi             tbl_tmoviteso.movi_movi%TYPE;
    --
    v_ty_msg                gen_qgeneral.ty_msg;
    e_error                 EXCEPTION;
    v_fuente                gen_tlistas.list_list%TYPE;
    --
BEGIN -- Get the CLOB.
    --
    v_json_clob := gen_qapi_rest.fn_get_api('movi');
    --SELECT json_clob INTO v_json_clob FROM test_json_parsing WHERE json_id = 5;
    -- Parse the JSON CLOB.
    v_items_object := JSON_OBJECT_T.PARSE(v_json_clob);
    -- Get the ITEMS Array.
    vt_items := v_items_object.get_Array('movi_data');
    -- Get the Record Count.
    v_count := vt_items.get_size;
    --
    v_fuente := gen_qgeneral.id_lista('TBL', 'FUEN_INFO', 'SF');
    -- Loop through the items and get the item_id for each.
    FOR i IN 0..v_count -1 LOOP
        --
        vr_item_rec                 := JSON_OBJECT_T(vt_items.get(i));
        v_ty_movi                   := NULL;
        v_ty_movi.movi_nrocom       := vr_item_rec.get_String('movi_nrocom');
        v_ty_movi.movi_fecmov       := vr_item_rec.get_String('movi_fecmov');
        v_ty_movi.movi_tpco         := vr_item_rec.get_String('movi_tpco');
        v_ty_movi.movi_cias         := vr_item_rec.get_String('movi_cias');
        v_ty_movi.movi_rengln       := vr_item_rec.get_String('movi_rengln');
        v_ty_movi.movi_cuen         := tbl_qgeneral.recupera_cuen(tbl_qgeneral.recupera_empr(vr_item_rec.get_String('movi_cias'), v_fuente), tbl_qgeneral.recupera_banc(vr_item_rec.get_String('movi_abon_banc'), v_fuente), vr_item_rec.get_String('movi_abon_cta'));
        v_ty_movi.movi_fecha        := to_date(vr_item_rec.get_String('movi_fecha'), 'DD/MM/YYYY');
        v_ty_movi.movi_descripcion  := vr_item_rec.get_String('movi_descripcion');
        v_ty_movi.movi_encargo      := vr_item_rec.get_String('movi_encargo');
        v_ty_movi.movi_fuente       := v_fuente;
        BEGIN
            --
            v_ty_movi.movi_valor        := replace(vr_item_rec.get_String('movi_valor'),'.',',');
            --
        EXCEPTION
            WHEN OTHERS THEN
                v_ty_movi.movi_valor        := replace(vr_item_rec.get_String('movi_valor'),',','.');
        END;
        v_ty_movi.movi_esta         := gen_qgeneral.id_estado('TBL', 'ESTA_MOVI', vr_item_rec.get_String('movi_esta'));
        v_ty_movi.movi_tipo_oper    := vr_item_rec.get_String('movi_tipo_oper');
        v_ty_movi.movi_movi         := tbl_qgeneral.recupera_movi(v_ty_movi.movi_nrocom, v_ty_movi.movi_fecmov, v_ty_movi.movi_tpco, v_ty_movi.movi_cias, v_ty_movi.movi_rengln);
        --
        IF v_ty_movi.movi_movi IS NULL THEN
            --
            v_ty_movi.movi_fecins       := SYSDATE;
            v_ty_movi.movi_usuains      := USER;
            --
            tbl_qmoviteso_crud.insertar_tbl_tmoviteso(
                                                          v_ty_movi
                                                        , v_movi_movi
                                                        , v_ty_msg
                                                        );
            --
            IF v_ty_msg.cod_msg <> 'OK' THEN
                --
                raise e_error;
                --
            END IF;
            --
        ELSE
            --
            v_ty_movi.movi_fecupd       := SYSDATE;
            v_ty_movi.movi_usuaupd      := USER;
            --
            tbl_qmoviteso_crud.actualizar_tbl_tmoviteso(
                                                        v_ty_movi
                                                      , v_ty_msg
                                                        );
            --
            IF v_ty_msg.cod_msg <> 'OK' THEN
                --
                raise e_error;
                --
            END IF;
            --
        END IF;
        --
    END LOOP;
    --
    COMMIT;
    --
EXCEPTION
    WHEN e_error THEN
        GEN_PSEGUIMIENTO('Error en gen_qapi_rest.sp_get_movi_api_rest: '||v_ty_msg.msg_msg);
    WHEN OTHERS THEN
        GEN_PSEGUIMIENTO('Error NO_CTRL en gen_qapi_rest.sp_get_movi_api_rest: '||sqlerrm);
END sp_get_movi_api_rest;
---------------------------------------------------------------------------------------------------
PROCEDURE sp_get_sald_api_rest IS
    --
    v_items_object          JSON_OBJECT_T;
    vt_items                JSON_ARRAY_T;
    vr_item_rec             JSON_OBJECT_T;
    v_json_clob             CLOB;
    v_count                 PLS_INTEGER := 0;
    --
    v_ty_sald               tbl_qsaldos_cta_crud.ty_sald;
    v_sald_sald             tbl_tsaldos_cta.sald_sald%TYPE;
    --
    v_ty_msg                gen_qgeneral.ty_msg;
    e_error                 EXCEPTION;
    v_fuente                gen_tlistas.list_list%TYPE;
    --
BEGIN -- Get the CLOB.
    --
    v_json_clob := gen_qapi_rest.fn_get_api('sald');
    --SELECT json_clob INTO v_json_clob FROM test_json_parsing WHERE json_id = 5;
    -- Parse the JSON CLOB.
    v_items_object := JSON_OBJECT_T.PARSE(v_json_clob);
    -- Get the ITEMS Array.
    vt_items := v_items_object.get_Array('sald_data');
    -- Get the Record Count.
    v_count := vt_items.get_size;
    --
    v_fuente := gen_qgeneral.id_lista('TBL', 'FUEN_INFO', 'SF');
    -- Loop through the items and get the item_id for each.
    FOR i IN 0..v_count -1 LOOP
        --
        vr_item_rec                 := JSON_OBJECT_T(vt_items.get(i));
        v_ty_sald                   := NULL;
        v_ty_sald.sald_fecha        := to_date(vr_item_rec.get_String('sald_fecha'), 'DD/MM/YYYY');
        v_ty_sald.sald_auxi         := vr_item_rec.get_String('sald_auxi');
        v_ty_sald.sald_cias         := vr_item_rec.get_String('sald_cias');
        v_ty_sald.sald_mayo         := vr_item_rec.get_String('sald_mayo');
        v_ty_sald.sald_cuen         := tbl_qgeneral.recupera_cuen(tbl_qgeneral.recupera_empr(v_ty_sald.sald_cias, v_fuente), tbl_qgeneral.recupera_banc(vr_item_rec.get_String('cuen_banc'), v_fuente), vr_item_rec.get_String('cuen_nrocta'));
        BEGIN
            --
            v_ty_sald.sald_valor        := replace(vr_item_rec.get_String('sald_valor'),'.',',');
            --
        EXCEPTION
            WHEN OTHERS THEN
                v_ty_sald.sald_valor        := replace(vr_item_rec.get_String('sald_valor'),',','.');
        END;
        v_ty_sald.sald_sald         := tbl_qgeneral.recupera_sald(v_ty_sald.sald_fecha, v_ty_sald.sald_auxi, v_ty_sald.sald_cias, v_ty_sald.sald_mayo);
        --
        IF v_ty_sald.sald_sald IS NULL THEN
            --
            v_ty_sald.sald_fecins       := SYSDATE;
            v_ty_sald.sald_usuains      := USER;
            --
            tbl_qsaldos_cta_crud.insertar_tbl_tsaldos_cta(
                                                          v_ty_sald
                                                        , v_sald_sald
                                                        , v_ty_msg
                                                        );
            --
            IF v_ty_msg.cod_msg <> 'OK' THEN
                --
                raise e_error;
                --
            END IF;
            --
        ELSE
            --
            v_ty_sald.sald_fecupd       := SYSDATE;
            v_ty_sald.sald_usuaupd      := USER;
            --
            tbl_qsaldos_cta_crud.actualizar_tbl_tsaldos_cta(
                                                              v_ty_sald
                                                            , v_ty_msg
                                                            );
            --
            IF v_ty_msg.cod_msg <> 'OK' THEN
                --
                raise e_error;
                --
            END IF;
            --
        END IF;
        --
    END LOOP;
    --
    COMMIT;
    --
EXCEPTION
    WHEN e_error THEN
        GEN_PSEGUIMIENTO('Error en gen_qapi_rest.sp_get_sald_api_rest: '||v_ty_msg.msg_msg);
    WHEN OTHERS THEN
        GEN_PSEGUIMIENTO('Error NO_CTRL en gen_qapi_rest.sp_get_sald_api_rest: '||sqlerrm);
END sp_get_sald_api_rest;
---------------------------------------------------------------------------------------------------
--Ini 1001 14/12/2023 cramirezs
---------------------------------------------------------------------------------------------------
PROCEDURE sp_get_regi_api_rest IS
    --
    v_items_object          JSON_OBJECT_T;
    vt_items                JSON_ARRAY_T;
    vr_item_rec             JSON_OBJECT_T;
    v_json_clob             CLOB;
    v_count                 PLS_INTEGER := 0;
    --
    v_ty_regi               tbl_qregionales_crud.ty_regi;
    v_regi_regi             tbl_tregionales.regi_regi%TYPE;
    v_ty_logs               tbl_qlogsservic_crud.ty_logs;
    v_logs_logs             tbl_tlogsservic.logs_logs%TYPE;
    --
    v_ty_msg                gen_qgeneral.ty_msg;
    e_error                 EXCEPTION;
    e_error_e               EXCEPTION;
    v_fuente                gen_tlistas.list_list%TYPE;
    --
    CURSOR c_empr (pc_fuen  tbl_tempresas.empr_fuente%TYPE
                    )IS
        SELECT empr_externo
          FROM tbl_tempresas
         WHERE NVL(empr_sincroniza, 'N') = 'S'
           AND empr_fuente = pc_fuen
        ORDER BY empr_empr
        ;
    --
BEGIN -- Get the CLOB.
    --
    v_ty_msg.cod_msg := 'OK';
    v_ty_logs.logs_id_trans   := TO_CHAR(sysdate,'YYYYDDMMHH24MISS');
    v_ty_logs.logs_apli       := 'EDGE-SIFI';
    v_ty_logs.logs_fecha      := SYSDATE;
    v_ty_logs.logs_terminal   := Sys_Context ('USERENV', 'HOST');
    v_ty_logs.logs_canal      := 'API';
    v_ty_logs.logs_request    := NULL;
    v_ty_logs.logs_response   := NULL;
    v_ty_logs.logs_fecha_resp := SYSDATE;
    v_ty_logs.logs_proceso    := 'SIN_REGI_SIFI';
    v_ty_logs.logs_fecins     := SYSDATE;
    v_ty_logs.logs_usuains    := USER;
    --Cada 5 minutos
    gen_pcontrolpro('SIN_REGI_SIFI'
                  , 'REGIONALES'
                  , 'P'
                  , v_ty_msg
                  );
    --
    IF v_ty_msg.cod_msg <> 'OK' THEN
        --
        raise e_error;
        --
    END IF;
    --
    v_fuente := gen_qgeneral.id_lista('TBL', 'FUEN_INFO', 'SF');
    --
    FOR i IN c_empr (v_fuente
                      )LOOP
        --
        v_json_clob := gen_qapi_rest.fn_get_api('regi', i.empr_externo);
        v_items_object := JSON_OBJECT_T.PARSE(v_json_clob);
        -- Get the ITEMS Array.
        vt_items := v_items_object.get_Array('regi_data');
        -- Get the Record Count.
        v_count := vt_items.get_size;
        --
        -- Loop through the items and get the item_id for each.
        FOR i IN 0..v_count -1 LOOP
            --
            vr_item_rec                 := JSON_OBJECT_T(vt_items.get(i));
            v_ty_regi                   := NULL;
            v_ty_regi.regi_empr_ex      := vr_item_rec.get_String('regi_empr_ex');
            v_ty_regi.regi_empr         := tbl_qgeneral.recupera_empr(v_ty_regi.regi_empr_ex, v_fuente);
            v_ty_regi.regi_banc_ex      := vr_item_rec.get_String('regi_banc_ex');
            v_ty_regi.regi_banc         := tbl_qgeneral.recupera_banc(v_ty_regi.regi_banc_ex, v_fuente);
            v_ty_regi.regi_fecha        := to_date(vr_item_rec.get_String('regi_fecha'), 'DD/MM/YYYY');
            --
            BEGIN
                --
                v_ty_regi.regi_adic_reales  := replace(vr_item_rec.get_String('regi_adic_reales'),'.',',');
                --
            EXCEPTION
                WHEN OTHERS THEN
                    v_ty_regi.regi_adic_reales  := replace(vr_item_rec.get_String('regi_adic_reales'),',','.');
            END;
            --
            BEGIN
                --
                v_ty_regi.regi_reti_reales  := replace(vr_item_rec.get_String('regi_reti_reales'),'.',',');
                --
            EXCEPTION
                WHEN OTHERS THEN
                    v_ty_regi.regi_reti_reales  := replace(vr_item_rec.get_String('regi_reti_reales'),',','.');
            END;
            --
            v_ty_regi.regi_fuente       := v_fuente;
            --
            v_ty_regi.regi_regi         := tbl_qgeneral.fn_recupera_regi(v_ty_regi.regi_empr, v_ty_regi.regi_banc, v_ty_regi.regi_fecha, v_fuente);
            --
            IF v_ty_regi.regi_regi IS NULL THEN
                --
                v_ty_regi.regi_fecins       := SYSDATE;
                v_ty_regi.regi_usuains      := USER;
                --
                tbl_qregionales_crud.insertar_tbl_tregionales(
                                                              v_ty_regi
                                                            , v_regi_regi
                                                            , v_ty_msg
                                                            );
                --
                IF v_ty_msg.cod_msg <> 'OK' THEN
                    --
                    raise e_error;
                    --
                END IF;
                --
            ELSE
                --
                v_ty_regi.regi_fecupd       := SYSDATE;
                v_ty_regi.regi_usuaupd      := USER;
                --
                tbl_qregionales_crud.actualizar_tbl_tregionales(
                                                                  v_ty_regi
                                                                , v_ty_msg
                                                                );
                --
                IF v_ty_msg.cod_msg <> 'OK' THEN
                    --
                    raise e_error;
                    --
                END IF;
                --
            END IF;
            --
        END LOOP;
        --
    END LOOP c_empr;
    --
    v_ty_msg.msg_msg          := 'Proceso Exitoso.';
    --
    v_ty_logs.logs_cod_respu  := v_ty_msg.cod_msg;
    v_ty_logs.logs_msg_resp   := v_ty_msg.msg_msg;
    --
    tbl_qlogsservic_crud.insertar_tbl_tlogsservic(v_ty_logs
                                                , v_logs_logs
                                                , v_ty_msg
                                                );
    --
    IF v_ty_msg.cod_msg <> 'OK' THEN
        --
        raise e_error_e;
        --
    END IF;
    --
    gen_pcontrolpro('SIN_REGI_SIFI', 'REGIONALES', 'F', v_ty_msg);
    --
    IF v_ty_msg.cod_msg <> 'OK' THEN
        --
        raise e_error;
        --
    END IF;
    --
    COMMIT;
    --
EXCEPTION
    WHEN e_error THEN
        --
        v_ty_logs.logs_cod_respu  := v_ty_msg.cod_msg;
        v_ty_logs.logs_msg_resp   := v_ty_msg.msg_msg;
        --
        gen_pcontrolpro('SIN_REGI_SIFI', 'REGIONALES', 'F', v_ty_msg);
        --
        IF v_ty_msg.cod_msg <> 'OK' THEN
            --
            GEN_PSEGUIMIENTO('Error en gen_qapi_rest.sp_get_regi_api_rest 0.1: '||v_ty_msg.msg_msg);
            --
        END IF;
        --
        tbl_qlogsservic_crud.insertar_tbl_tlogsservic(v_ty_logs
                                                    , v_logs_logs
                                                    , v_ty_msg
                                                    );
        --
        IF v_ty_msg.cod_msg <> 'OK' THEN
            --
            GEN_PSEGUIMIENTO('Error en gen_qapi_rest.sp_get_regi_api_rest 0.2: '||v_ty_msg.msg_msg);
            --
        END IF;
        ROLLBACK;
        --
    WHEN e_error_e THEN
        GEN_PSEGUIMIENTO('Error en gen_qapi_rest.sp_get_regi_api_rest 0.3: '||v_ty_msg.msg_msg);
        gen_pcontrolpro('SIN_REGI_SIFI', 'REGIONALES', 'F', v_ty_msg);
        --
        IF v_ty_msg.cod_msg <> 'OK' THEN
            --
            GEN_PSEGUIMIENTO('Error en gen_qapi_rest.sp_get_regi_api_rest 0.4: '||v_ty_msg.msg_msg);
            --
        END IF;
        ROLLBACK;
    WHEN OTHERS THEN
        --
        v_ty_msg.cod_msg          := 'ERROR';
        v_ty_msg.msg_msg          := 'Error en gen_qapi_rest.sp_get_regi_api_rest 05: '||sqlerrm;
        v_ty_logs.logs_cod_respu  := v_ty_msg.cod_msg;
        v_ty_logs.logs_msg_resp   := v_ty_msg.msg_msg;
        --
        gen_pcontrolpro('SIN_REGI_SIFI', 'REGIONALES', 'F', v_ty_msg);
        --
        IF v_ty_msg.cod_msg <> 'OK' THEN
            --
            GEN_PSEGUIMIENTO('Error en gen_qapi_rest.sp_get_regi_api_rest 0.5: '||v_ty_msg.msg_msg);
            --
        END IF;
        --
        tbl_qlogsservic_crud.insertar_tbl_tlogsservic(v_ty_logs
                                                    , v_logs_logs
                                                    , v_ty_msg
                                                    );
        --
        IF v_ty_msg.cod_msg <> 'OK' THEN
            --
            GEN_PSEGUIMIENTO('Error en gen_qapi_rest.sp_get_regi_api_rest 0.6: '||v_ty_msg.msg_msg);
            --
        END IF;
        ROLLBACK;
        --
END sp_get_regi_api_rest;
---------------------------------------------------------------------------------------------------
PROCEDURE sp_get_canc_api_rest IS
    --
    v_items_object          JSON_OBJECT_T;
    vt_items                JSON_ARRAY_T;
    vr_item_rec             JSON_OBJECT_T;
    v_json_clob             CLOB;
    v_count                 PLS_INTEGER := 0;
    --
    v_ty_canc               tbl_qcancelacio_crud.ty_canc;
    v_canc_canc             tbl_tcancelacio.canc_canc%TYPE;
    v_ty_logs               tbl_qlogsservic_crud.ty_logs;
    v_logs_logs             tbl_tlogsservic.logs_logs%TYPE;
    --
    v_ty_msg                gen_qgeneral.ty_msg;
    e_error                 EXCEPTION;
    e_error_e               EXCEPTION;
    v_fuente                gen_tlistas.list_list%TYPE;
    --
BEGIN -- Get the CLOB.
    --
    v_ty_msg.cod_msg := 'OK';
    v_ty_logs.logs_id_trans   := TO_CHAR(sysdate,'YYYYDDMMHH24MISS');
    v_ty_logs.logs_apli       := 'EDGE-SIFI';
    v_ty_logs.logs_fecha      := SYSDATE;
    v_ty_logs.logs_terminal   := Sys_Context ('USERENV', 'HOST');
    v_ty_logs.logs_canal      := 'API';
    v_ty_logs.logs_request    := NULL;
    v_ty_logs.logs_response   := NULL;
    v_ty_logs.logs_fecha_resp := SYSDATE;
    v_ty_logs.logs_proceso    := 'SIN_CANC_SIFI';
    v_ty_logs.logs_fecins     := SYSDATE;
    v_ty_logs.logs_usuains    := USER;
    --Cada 5 minutos
    gen_pcontrolpro('SIN_CANC_SIFI', 'CANCELACIONES', 'P', v_ty_msg);
    --
    IF v_ty_msg.cod_msg <> 'OK' THEN
        --
        raise e_error;
        --
    END IF;
    --
    v_fuente := gen_qgeneral.id_lista('TBL', 'FUEN_INFO', 'SF');
    --
    v_json_clob := gen_qapi_rest.fn_get_api('canc');
    v_items_object := JSON_OBJECT_T.PARSE(v_json_clob);
    -- Get the ITEMS Array.
    vt_items := v_items_object.get_Array('canc_data');
    -- Get the Record Count.
    v_count := vt_items.get_size;
    --
    -- Loop through the items and get the item_id for each.
    FOR i IN 0..v_count -1 LOOP
        --
        vr_item_rec                 := JSON_OBJECT_T(vt_items.get(i));
        v_ty_canc                   := NULL;
        v_ty_canc.canc_canc_ex      := vr_item_rec.get_String('canc_canc_ex');
        v_ty_canc.canc_fond_ex      := vr_item_rec.get_String('canc_fond_ex');
        v_ty_canc.canc_empr_ex      := vr_item_rec.get_String('canc_empr_ex');
        v_ty_canc.canc_empr         := tbl_qgeneral.recupera_empr(v_ty_canc.canc_empr_ex, v_fuente);
        v_ty_canc.canc_banc_ex      := vr_item_rec.get_String('canc_banc_ex');
        v_ty_canc.canc_banc         := tbl_qgeneral.recupera_banc(v_ty_canc.canc_banc_ex, v_fuente);
        v_ty_canc.canc_fecha        := to_date(vr_item_rec.get_String('canc_fecha'), 'DD/MM/YYYY');
        v_ty_canc.canc_plan         := vr_item_rec.get_String('canc_plan');
        v_ty_canc.canc_desc_plan    := vr_item_rec.get_String('canc_desc_plan');
        v_ty_canc.canc_stat_ex      := vr_item_rec.get_String('canc_stat');
        --
        BEGIN
            --
            v_ty_canc.canc_vlr_canc  := replace(vr_item_rec.get_String('canc_vlr_canc'),'.',',');
            --
        EXCEPTION
            WHEN OTHERS THEN
                v_ty_canc.canc_vlr_canc  := replace(vr_item_rec.get_String('canc_vlr_canc'),',','.');
        END;
        --
        BEGIN
            --
            v_ty_canc.canc_vlr_ajus  := replace(vr_item_rec.get_String('canc_vlr_ajus'),'.',',');
            --
        EXCEPTION
            WHEN OTHERS THEN
                v_ty_canc.canc_vlr_ajus  := replace(vr_item_rec.get_String('canc_vlr_ajus'),',','.');
        END;
        --
        BEGIN
            --
            v_ty_canc.canc_vlr_gmf  := replace(vr_item_rec.get_String('canc_vlr_gmf'),'.',',');
            --
        EXCEPTION
            WHEN OTHERS THEN
                v_ty_canc.canc_vlr_gmf  := replace(vr_item_rec.get_String('canc_vlr_gmf'),',','.');
        END;
        --
        --Ini 1002 cramirezs 14/08/2024
        IF gen_qgeneral.fn_es_habil(v_ty_canc.canc_fecha) = 'N' THEN
            --
            v_ty_canc.canc_fecha := gen_qgeneral.fn_ste_habil(v_ty_canc.canc_fecha);
            --
        ELSE
            --
            v_ty_canc.canc_fecha := v_ty_canc.canc_fecha + 1;
            --
        END IF;
        --Fin 1002 cramirezs 14/08/2024
        --
        v_ty_canc.canc_vlr_giro     := NVL(v_ty_canc.canc_vlr_canc,0) - NVL(v_ty_canc.canc_vlr_gmf, 0);
        v_ty_canc.canc_val_act      := NULL;
        v_ty_canc.canc_fuente       := v_fuente;
        v_ty_canc.canc_canc         := tbl_qgeneral.fn_recupera_canc(v_ty_canc.canc_canc_ex, v_ty_canc.canc_fond_ex, v_fuente);
        --
        IF v_ty_canc.canc_canc IS NULL THEN
            --
            v_ty_canc.canc_fecins       := SYSDATE;
            v_ty_canc.canc_usuains      := USER;
            --
            tbl_qcancelacio_crud.insertar_tbl_tcancelacio(
                                                          v_ty_canc
                                                        , v_canc_canc
                                                        , v_ty_msg
                                                        );
            --
            IF v_ty_msg.cod_msg <> 'OK' THEN
                --
                raise e_error;
                --
            END IF;
            --
        ELSE
            --
            v_ty_canc.canc_fecupd       := SYSDATE;
            v_ty_canc.canc_usuaupd      := USER;
            --
            tbl_qcancelacio_crud.actualizar_tbl_tcancelacio(
                                                              v_ty_canc
                                                            , v_ty_msg
                                                            );
            --
            IF v_ty_msg.cod_msg <> 'OK' THEN
                --
                raise e_error;
                --
            END IF;
            --
        END IF;
        --
    END LOOP;
    --
    v_ty_msg.msg_msg          := 'Proceso Exitoso.';
    --
    v_ty_logs.logs_cod_respu  := v_ty_msg.cod_msg;
    v_ty_logs.logs_msg_resp   := v_ty_msg.msg_msg;
    --
    tbl_qlogsservic_crud.insertar_tbl_tlogsservic(v_ty_logs
                                                , v_logs_logs
                                                , v_ty_msg
                                                );
    --
    IF v_ty_msg.cod_msg <> 'OK' THEN
        --
        raise e_error_e;
        --
    END IF;
    --
    gen_pcontrolpro('SIN_CANC_SIFI', 'CANCELACIONES', 'F', v_ty_msg );
    --
    IF v_ty_msg.cod_msg <> 'OK' THEN
        --
        raise e_error;
        --
    END IF;
    --
    COMMIT;
    --
EXCEPTION
    WHEN e_error THEN
        --
        v_ty_logs.logs_cod_respu  := v_ty_msg.cod_msg;
        v_ty_logs.logs_msg_resp   := v_ty_msg.msg_msg;
        --
        gen_pcontrolpro('SIN_CANC_SIFI', 'CANCELACIONES', 'F', v_ty_msg );
        --
        IF v_ty_msg.cod_msg <> 'OK' THEN
            --
            GEN_PSEGUIMIENTO('Error en gen_qapi_rest.sp_get_canc_api_rest 0.1: '||v_ty_msg.msg_msg);
            --
        END IF;
        --
        tbl_qlogsservic_crud.insertar_tbl_tlogsservic(v_ty_logs
                                                    , v_logs_logs
                                                    , v_ty_msg
                                                    );
        --
        IF v_ty_msg.cod_msg <> 'OK' THEN
            --
            GEN_PSEGUIMIENTO('Error en gen_qapi_rest.sp_get_canc_api_rest 0.2: '||v_ty_msg.msg_msg);
            --
        END IF;
        --
        ROLLBACK;
        --
    WHEN e_error_e THEN
        --
        GEN_PSEGUIMIENTO('Error en gen_qapi_rest.sp_get_canc_api_rest 0.3: '||v_ty_msg.msg_msg);
        gen_pcontrolpro('SIN_CANC_SIFI', 'CANCELACIONES', 'F', v_ty_msg );
        --
        IF v_ty_msg.cod_msg <> 'OK' THEN
            --
            GEN_PSEGUIMIENTO('Error en gen_qapi_rest.sp_get_canc_api_rest 0.4: '||v_ty_msg.msg_msg);
            --
        END IF;
        --
        ROLLBACK;
    WHEN OTHERS THEN
        --
        v_ty_msg.cod_msg          := 'ERROR';
        v_ty_msg.msg_msg          := 'Error en gen_qapi_rest.sp_get_canc_api_rest 05: '||sqlerrm;
        v_ty_logs.logs_cod_respu  := v_ty_msg.cod_msg;
        v_ty_logs.logs_msg_resp   := v_ty_msg.msg_msg;
        --
        gen_pcontrolpro('SIN_CANC_SIFI', 'CANCELACIONES', 'F', v_ty_msg );
        --
        IF v_ty_msg.cod_msg <> 'OK' THEN
            --
            GEN_PSEGUIMIENTO('Error en gen_qapi_rest.sp_get_canc_api_rest 0.5: '||v_ty_msg.msg_msg);
            --
        END IF;
        --
        tbl_qlogsservic_crud.insertar_tbl_tlogsservic(v_ty_logs
                                                    , v_logs_logs
                                                    , v_ty_msg
                                                    );
        --
        IF v_ty_msg.cod_msg <> 'OK' THEN
            --
            GEN_PSEGUIMIENTO('Error en gen_qapi_rest.sp_get_canc_api_rest 0.6: '||v_ty_msg.msg_msg);
            --
        END IF;
        ROLLBACK;
        --
END sp_get_canc_api_rest;
---------------------------------------------------------------------------------------------------
PROCEDURE sp_get_fest_api_rest IS
    --
    v_items_object          JSON_OBJECT_T;
    vt_items                JSON_ARRAY_T;
    vr_item_rec             JSON_OBJECT_T;
    v_json_clob             CLOB;
    v_count                 PLS_INTEGER := 0;
    --
    v_ty_fest               gen_qfestivos_crud.ty_fest;
    v_ty_logs               tbl_qlogsservic_crud.ty_logs;
    v_logs_logs             tbl_tlogsservic.logs_logs%TYPE;
    --
    v_ty_msg                gen_qgeneral.ty_msg;
    e_error                 EXCEPTION;
    e_error_e               EXCEPTION;
    v_fuente                gen_tlistas.list_list%TYPE;
    --
    CURSOR c_fest (pc_fest DATE)IS
        SELECT fest_fest
          FROM gen_tfestivos
         WHERE fest_fest = pc_fest
        ;
    --
    r_fest      c_fest%ROWTYPE;
    --
BEGIN -- Get the CLOB.
    --
    v_ty_msg.cod_msg := 'OK';
    v_ty_logs.logs_id_trans   := TO_CHAR(sysdate,'YYYYDDMMHH24MISS');
    v_ty_logs.logs_apli       := 'EDGE-SIFI';
    v_ty_logs.logs_fecha      := SYSDATE;
    v_ty_logs.logs_terminal   := Sys_Context ('USERENV', 'HOST');
    v_ty_logs.logs_canal      := 'API';
    v_ty_logs.logs_request    := NULL;
    v_ty_logs.logs_response   := NULL;
    v_ty_logs.logs_fecha_resp := SYSDATE;
    v_ty_logs.logs_proceso    := 'SIN_FEST_SIFI';
    v_ty_logs.logs_fecins     := SYSDATE;
    v_ty_logs.logs_usuains    := USER;
    --Cada 5 minutos
    gen_pcontrolpro('SIN_FEST_SIFI', 'FESTIVOS', 'P', v_ty_msg );
    --
    IF v_ty_msg.cod_msg <> 'OK' THEN
        --
        raise e_error;
        --
    END IF;
    --
    v_fuente := gen_qgeneral.id_lista('TBL', 'FUEN_INFO', 'SF');
    --
    v_json_clob := gen_qapi_rest.fn_get_api('fest');
    v_items_object := JSON_OBJECT_T.PARSE(v_json_clob);
    -- Get the ITEMS Array.
    vt_items := v_items_object.get_Array('fest_data');
    -- Get the Record Count.
    v_count := vt_items.get_size;
    --
    --gen_pseguimiento('v_count: '||v_count ||' v_json_clob: '||v_json_clob);
    --
    -- Loop through the items and get the item_id for each.
    FOR i IN 0..v_count -1 LOOP
        --
        vr_item_rec                 := JSON_OBJECT_T(vt_items.get(i));
        v_ty_fest                   := NULL;
        v_ty_fest.fest_fest         := to_date(vr_item_rec.get_String('fest_fest'), 'DD/MM/YYYY');
        --
        OPEN  c_fest (v_ty_fest.fest_fest
                      );
        FETCH c_fest INTO r_fest;
        IF c_fest%NOTFOUND THEN
            --
            v_ty_fest.fest_fecins       := SYSDATE;
            v_ty_fest.fest_usuains      := USER;
            --
            gen_qfestivos_crud.insertar_gen_tfestivos(v_ty_fest
                                                    , v_ty_msg
                                                      );
            --
            IF v_ty_msg.cod_msg <> 'OK' THEN
                --
                raise e_error;
                --
            END IF;
            --
        END IF;
        CLOSE c_fest;
        --
    END LOOP;
    --
    v_ty_msg.msg_msg          := 'Proceso Exitoso.';
    --
    v_ty_logs.logs_cod_respu  := v_ty_msg.cod_msg;
    v_ty_logs.logs_msg_resp   := v_ty_msg.msg_msg;
    --
    tbl_qlogsservic_crud.insertar_tbl_tlogsservic(v_ty_logs
                                                , v_logs_logs
                                                , v_ty_msg
                                                );
    --
    IF v_ty_msg.cod_msg <> 'OK' THEN
        --
        raise e_error_e;
        --
    END IF;
    --
    gen_pcontrolpro('SIN_FEST_SIFI', 'FESTIVOS', 'F', v_ty_msg);
    --
    IF v_ty_msg.cod_msg <> 'OK' THEN
        --
        raise e_error;
        --
    END IF;
    --
    COMMIT;
    --
EXCEPTION
    WHEN e_error THEN
        --
        v_ty_logs.logs_cod_respu  := v_ty_msg.cod_msg;
        v_ty_logs.logs_msg_resp   := v_ty_msg.msg_msg;
        --
        gen_pcontrolpro('SIN_FEST_SIFI', 'FESTIVOS', 'F', v_ty_msg);
        --
        IF v_ty_msg.cod_msg <> 'OK' THEN
            --
            GEN_PSEGUIMIENTO('Error en gen_qapi_rest.sp_get_fest_api_rest 0.1: '||v_ty_msg.msg_msg);
            --
        END IF;
        --
        tbl_qlogsservic_crud.insertar_tbl_tlogsservic(v_ty_logs
                                                    , v_logs_logs
                                                    , v_ty_msg
                                                    );
        --
        IF v_ty_msg.cod_msg <> 'OK' THEN
            --
            GEN_PSEGUIMIENTO('Error en gen_qapi_rest.sp_get_fest_api_rest 0.2: '||v_ty_msg.msg_msg);
            --
        END IF;
        --
        ROLLBACK;
        --
    WHEN e_error_e THEN
        --
        GEN_PSEGUIMIENTO('Error en gen_qapi_rest.sp_get_fest_api_rest 0.3: '||v_ty_msg.msg_msg);
        --
        gen_pcontrolpro('SIN_FEST_SIFI', 'FESTIVOS', 'F', v_ty_msg);
        --
        IF v_ty_msg.cod_msg <> 'OK' THEN
            --
            GEN_PSEGUIMIENTO('Error en gen_qapi_rest.sp_get_fest_api_rest 0.4: '||v_ty_msg.msg_msg);
            --
        END IF;
        --
        ROLLBACK;
        --
    WHEN OTHERS THEN
        --
        v_ty_msg.cod_msg          := 'ERROR';
        v_ty_msg.msg_msg          := 'Error en gen_qapi_rest.sp_get_fest_api_rest 05: '||sqlerrm;
        v_ty_logs.logs_cod_respu  := v_ty_msg.cod_msg;
        v_ty_logs.logs_msg_resp   := v_ty_msg.msg_msg;
        --
        gen_pcontrolpro('SIN_FEST_SIFI', 'FESTIVOS', 'F', v_ty_msg);
        --
        IF v_ty_msg.cod_msg <> 'OK' THEN
            --
            GEN_PSEGUIMIENTO('Error en gen_qapi_rest.sp_get_fest_api_rest 0.5: '||v_ty_msg.msg_msg);
            --
        END IF;
        --
        tbl_qlogsservic_crud.insertar_tbl_tlogsservic(v_ty_logs
                                                    , v_logs_logs
                                                    , v_ty_msg
                                                    );
        --
        IF v_ty_msg.cod_msg <> 'OK' THEN
            --
            GEN_PSEGUIMIENTO('Error en gen_qapi_rest.sp_get_fest_api_rest 0.6: '||v_ty_msg.msg_msg);
            --
        END IF;
        ROLLBACK;
        --
END sp_get_fest_api_rest;
---------------------------------------------------------------------------------------------------
PROCEDURE sp_get_mopf_api_rest IS
    --
    v_items_object          JSON_OBJECT_T;
    vt_items                JSON_ARRAY_T;
    vr_item_rec             JSON_OBJECT_T;
    v_json_clob             CLOB;
    v_count                 PLS_INTEGER := 0;
    --
    v_ty_motp               tbl_qmotporfin_crud.ty_motp;
    v_motp_motp             tbl_tmotporfin.motp_motp%TYPE;
    --
    v_ty_msg                gen_qgeneral.ty_msg;
    v_ty_logs               tbl_qlogsservic_crud.ty_logs;
    v_logs_logs             tbl_tlogsservic.logs_logs%TYPE;
    e_error                 EXCEPTION;
    e_error_e               EXCEPTION;
    v_fuente                gen_tlistas.list_list%TYPE;
    v_var_em                gen_tlistas.list_list%TYPE;
    v_var_bc                gen_tlistas.list_list%TYPE;
    v_sit                   gen_tlistas.list_list%TYPE;
    --
    v_campo1                VARCHAR2(2000);
    v_campo2                VARCHAR2(2000);
    v_campo3                VARCHAR2(2000);
    v_desc_msg              gen_tmensajes.mens_descripcion%TYPE;
    v_tipo                  gen_tmensajes.mens_tipo%TYPE;
    v_tranid                VARCHAR2(30);
    --
BEGIN -- Get the CLOB.
    --
    v_ty_msg.cod_msg := 'OK';
    --Cada 5 minutos
    gen_pcontrolpro('SIN_MOVI_PORF', 'MOVI_PORFIN', 'P', v_ty_msg);
    --
    IF v_ty_msg.cod_msg <> 'OK' THEN
        --
        raise e_error;
        --
    END IF;
    --
    v_json_clob := gen_qapi_rest.fn_get_api('mopf');
    --GEN_PSEGUIMIENTO(SUBSTr('Error en gen_qapi_rest.sp_get_mopf_api_rest v_json_clob: '||v_json_clob, 1, 4000));
    --SELECT json_clob INTO v_json_clob FROM test_json_parsing WHERE json_id = 5;
    -- Parse the JSON CLOB.
    v_items_object := JSON_OBJECT_T.PARSE(v_json_clob);
    -- Get the ITEMS Array.
    vt_items := v_items_object.get_Array('porfin_movi_data');
    -- Get the Record Count.
    v_count := vt_items.get_size;
    --
    v_fuente := gen_qgeneral.id_lista('TBL', 'FUEN_INFO', 'PF');
    v_var_em := gen_qgeneral.id_lista('TBL', 'VARI_HOMO', 'EM');
    v_var_bc := gen_qgeneral.id_lista('TBL', 'VARI_HOMO', 'BC');
    v_sit    := gen_qgeneral.id_lista('TBL', 'SIST_HOMO', 'TB');
    v_tranid := TO_CHAR(sysdate,'YYYYDDMMHH24MISS');
    --
    -- Loop through the items and get the item_id for each.
    FOR i IN 0..v_count -1 LOOP
        --
        BEGIN
            vr_item_rec                 := JSON_OBJECT_T(vt_items.get(i));
            v_ty_motp                   := NULL;
            --GEN_PSEGUIMIENTO('Error en gen_qapi_rest.sp_get_mopf_api_rest v_json_clob 1');
            v_ty_logs                   := NULL;
            v_ty_logs.logs_id_trans     := v_tranid;
            v_ty_logs.logs_apli         := 'EDGE-PORFIN';
            v_ty_logs.logs_fecha        := SYSDATE;
            v_ty_logs.logs_terminal     := Sys_Context ('USERENV', 'HOST');
            v_ty_logs.logs_canal        := 'API';
            v_ty_logs.logs_request      := SUBSTR(vr_item_rec.get_String('port')||'-'||vr_item_rec.get_String('consec'), 1, 50);
            v_ty_logs.logs_response     := NULL;
            v_ty_logs.logs_fecha_resp   := SYSDATE;
            v_ty_logs.logs_proceso      := 'SIN_MOVI_PORF';
            v_ty_logs.logs_fecins       := SYSDATE;
            v_ty_logs.logs_usuains      := USER;
            v_ty_motp.motp_ope_fecha    := TO_DATE(vr_item_rec.get_String('fecha'), 'yyyy/mm/dd');
            --
            IF v_ty_motp.motp_ope_fecha IS NULL THEN
                --
                v_campo1         := 'fecha';
                v_ty_msg.cod_msg := 'ER_WBNN_CP';--El campo {campo1} no puede ser nulo.
                raise e_error;
                --
            END IF;
            --
            IF gen_qgeneral.fn_es_habil(v_ty_motp.motp_ope_fecha) = 'N' THEN
                --
                v_ty_motp.motp_ope_fecha := gen_qgeneral.fn_ste_habil(v_ty_motp.motp_ope_fecha);
                --
            END IF;
            --
            --GEN_PSEGUIMIENTO('Error en gen_qapi_rest.sp_get_mopf_api_rest v_json_clob 2');
            v_ty_motp.motp_det          := vr_item_rec.get_String('det');
            IF v_ty_motp.motp_det IS NULL THEN
                --
                v_campo1         := 'det';
                v_ty_msg.cod_msg := 'ER_WBNN_CP';--El campo {campo1} no puede ser nulo.
                raise e_error;
                --
            END IF;
            --
            --GEN_PSEGUIMIENTO('Error en gen_qapi_rest.sp_get_mopf_api_rest v_json_clob 3');
            v_ty_motp.motp_transac      := vr_item_rec.get_String('transaccion');
            IF v_ty_motp.motp_transac IS NULL THEN
                --
                v_campo1         := 'transaccion';
                v_ty_msg.cod_msg := 'ER_WBNN_CP';--El campo {campo1} no puede ser nulo.
                raise e_error;
                --
            END IF;
            --
            --GEN_PSEGUIMIENTO('Error en gen_qapi_rest.sp_get_mopf_api_rest v_json_clob 4');
            v_ty_motp.motp_especie      := vr_item_rec.get_String('especie');
            IF v_ty_motp.motp_especie IS NULL THEN
                --
                v_campo1         := 'especie';
                v_ty_msg.cod_msg := 'ER_WBNN_CP';--El campo {campo1} no puede ser nulo.
                raise e_error;
                --
            END IF;
            --
            --GEN_PSEGUIMIENTO('Error en gen_qapi_rest.sp_get_mopf_api_rest v_json_clob 5');
            v_ty_motp.motp_consec       := vr_item_rec.get_String('consec');
            IF v_ty_motp.motp_consec IS NULL THEN
                --
                v_campo1         := 'consec';
                v_ty_msg.cod_msg := 'ER_WBNN_CP';--El campo {campo1} no puede ser nulo.
                raise e_error;
                --
            END IF;
            --
            --GEN_PSEGUIMIENTO('Error en gen_qapi_rest.sp_get_mopf_api_rest v_json_clob 6');
            BEGIN
                --
                v_ty_motp.motp_valor_nom        := replace(vr_item_rec.get_String('valor_nominal'),'.',',');
                --
            EXCEPTION
                WHEN OTHERS THEN
                    v_ty_motp.motp_valor_nom        := replace(vr_item_rec.get_String('valor_nominal'),',','.');
            END;
            IF v_ty_motp.motp_valor_nom IS NULL THEN
                --
                v_campo1         := 'valor_nominal';
                v_ty_msg.cod_msg := 'ER_WBNN_CP';--El campo {campo1} no puede ser nulo.
                raise e_error;
                --
            END IF;
            --
            --GEN_PSEGUIMIENTO('Error en gen_qapi_rest.sp_get_mopf_api_rest v_json_clob 7');
            v_ty_motp.motp_emision      := TO_DATE(vr_item_rec.get_String('emision'), 'yyyy/mm/dd');
            IF v_ty_motp.motp_emision IS NULL THEN
                --
                v_campo1         := 'emision';
                v_ty_msg.cod_msg := 'ER_WBNN_CP';--El campo {campo1} no puede ser nulo.
                raise e_error;
                --
            END IF;
            --
            --GEN_PSEGUIMIENTO('Error en gen_qapi_rest.sp_get_mopf_api_rest v_json_clob 8');
            v_ty_motp.motp_vcto         := TO_DATE(vr_item_rec.get_String('vcto'), 'yyyy/mm/dd');
            /*
            IF v_ty_motp.motp_vcto IS NULL THEN
                --
                v_campo1         := 'vcto';
                v_ty_msg.cod_msg := 'ER_WBNN_CP';--El campo {campo1} no puede ser nulo.
                raise e_error;
                --
            END IF;
            */
            --
            --GEN_PSEGUIMIENTO('Error en gen_qapi_rest.sp_get_mopf_api_rest v_json_clob 9');
            BEGIN
                --
                v_ty_motp.motp_vr_reci        := replace(vr_item_rec.get_String('recibido'),'.',',');
                --
            EXCEPTION
                WHEN OTHERS THEN
                    v_ty_motp.motp_vr_reci        := replace(vr_item_rec.get_String('recibido'),',','.');
            END;
            --
            IF v_ty_motp.motp_vr_reci IS NULL THEN
                --
                v_campo1         := 'recibido';
                v_ty_msg.cod_msg := 'ER_WBNN_CP';--El campo {campo1} no puede ser nulo.
                raise e_error;
                --
            END IF;
            --
            --GEN_PSEGUIMIENTO('Error en gen_qapi_rest.sp_get_mopf_api_rest v_json_clob 10');
            v_ty_motp.motp_vr_act       := NULL;
            --
            v_ty_motp.motp_nit          := vr_item_rec.get_String('nit');
            /*
            IF v_ty_motp.motp_nit IS NULL THEN
                --
                v_campo1         := 'nit';
                v_ty_msg.cod_msg := 'ER_WBNN_CP';--El campo {campo1} no puede ser nulo.
                raise e_error;
                --
            END IF;
            --
            GEN_PSEGUIMIENTO('Error en gen_qapi_rest.sp_get_mopf_api_rest v_json_clob 11');
            v_ty_motp.motp_contraparte  := SUBSTR(vr_item_rec.get_String('contraparte'),1 ,20);
            IF v_ty_motp.motp_contraparte IS NULL THEN
                --
                v_campo1         := 'contraparte';
                v_ty_msg.cod_msg := 'ER_WBNN_CP';--El campo {campo1} no puede ser nulo.
                raise e_error;
                --
            END IF;
            */
            --
            --GEN_PSEGUIMIENTO('Error en gen_qapi_rest.sp_get_mopf_api_rest v_json_clob 12');
            v_ty_motp.motp_por          := vr_item_rec.get_String('port');
            IF v_ty_motp.motp_por IS NULL THEN
                --
                v_campo1         := 'port';
                v_ty_msg.cod_msg := 'ER_WBNN_CP';--El campo {campo1} no puede ser nulo.
                raise e_error;
                --
            END IF;
            --GEN_PSEGUIMIENTO('Error en gen_qapi_rest.sp_get_mopf_api_rest v_json_clob 13');
            v_ty_motp.motp_empr         := tbl_qhomologa.fn_recupera_cod_interno(v_sit, v_var_em, v_fuente, v_ty_motp.motp_por);
            --
            IF v_ty_motp.motp_empr IS NULL THEN
                --
                v_campo1         := 'de la empresa';
                v_campo2         := v_ty_motp.motp_por;
                v_ty_msg.cod_msg := 'ER_WBEQ_EM';--'Error al recuperar la equivalencia {campo1} {campo2}, valide que en EDGE exista la homologaci n.';
                raise e_error;
                --
            END IF;
            --
            --GEN_PSEGUIMIENTO('Error en gen_qapi_rest.sp_get_mopf_api_rest v_json_clob 14');
            v_ty_motp.motp_fuente       := v_fuente;
            v_ty_motp.motp_motp         := tbl_qgeneral.fn_recupera_motp(v_ty_motp.motp_por, v_ty_motp.motp_consec, v_fuente);
            --
            IF v_ty_motp.motp_motp IS NULL THEN
                --
                v_ty_motp.motp_fecins       := SYSDATE;
                v_ty_motp.motp_usuains      := USER;
                --
                tbl_qmotporfin_crud.insertar_tbl_tmotporfin(
                                                              v_ty_motp
                                                            , v_motp_motp
                                                            , v_ty_msg
                                                            );
                --
                IF v_ty_msg.cod_msg <> 'OK' THEN
                    --
                    raise e_error_e;
                    --
                END IF;
                --
            ELSE
                --
                v_ty_motp.motp_fecupd       := SYSDATE;
                v_ty_motp.motp_usuaupd      := USER;
                --
                tbl_qmotporfin_crud.actualizar_tbl_tmotporfin(
                                                                  v_ty_motp
                                                                , v_ty_msg
                                                                );
                --
                IF v_ty_msg.cod_msg <> 'OK' THEN
                    --
                    raise e_error_e;
                    --
                END IF;
                --
            END IF;
            --
            v_ty_msg.msg_msg          := 'Proceso Exitoso.';
            --
            v_ty_logs.logs_cod_respu  := v_ty_msg.cod_msg;
            v_ty_logs.logs_msg_resp   := v_ty_msg.msg_msg;
            --
            tbl_qlogsservic_crud.insertar_tbl_tlogsservic(v_ty_logs
                                                        , v_logs_logs
                                                        , v_ty_msg
                                                        );
            --
            IF v_ty_msg.cod_msg <> 'OK' THEN
                --
                raise e_error_e;
                --
            END IF;
            --
            COMMIT;
            --
        EXCEPTION
            WHEN e_error THEN
                --
                v_desc_msg := gen_fmensajes(v_ty_msg.cod_msg, v_tipo);
                --
                IF v_campo1 IS NOT NULL THEN
                    --
                    v_desc_msg := REPLACE(v_desc_msg, '{campo1}', v_campo1);
                    v_desc_msg := REPLACE(v_desc_msg, '{campo2}', v_campo2);
                    v_desc_msg := REPLACE(v_desc_msg, '{campo3}', v_campo3);
                    --
                END IF;
                --
                v_ty_msg.msg_msg          := v_desc_msg;
                v_ty_logs.logs_cod_respu  := v_ty_msg.cod_msg;
                v_ty_logs.logs_msg_resp   := v_ty_msg.msg_msg;
                --
                tbl_qlogsservic_crud.insertar_tbl_tlogsservic(v_ty_logs
                                                            , v_logs_logs
                                                            , v_ty_msg
                                                            );
                --
                IF v_ty_msg.cod_msg <> 'OK' THEN
                    --
                    gen_pcontrolpro('SIN_MOVI_PORF', 'MOVI_PORFIN', 'F', v_ty_msg);
                    --
                    IF v_ty_msg.cod_msg <> 'OK' THEN
                        --
                        GEN_PSEGUIMIENTO('Error en gen_qapi_rest.sp_get_mopf_api_rest 0.1: '||v_ty_msg.msg_msg);
                        raise e_error_e;
                        --
                    END IF;
                    --
                    GEN_PSEGUIMIENTO('Error en gen_qapi_rest.sp_get_mopf_api_rest 0.2: '||v_ty_msg.msg_msg);
                    --
                END IF;
                --
                ROLLBACK;
                --
            WHEN OTHERS THEN
                --
                v_ty_msg.cod_msg          := 'ERROR';
                v_ty_msg.msg_msg          := 'Error en gen_qapi_rest.sp_get_mopf_api_rest 03: '||sqlerrm;
                v_ty_logs.logs_cod_respu  := v_ty_msg.cod_msg;
                v_ty_logs.logs_msg_resp   := v_ty_msg.msg_msg;
                --
                tbl_qlogsservic_crud.insertar_tbl_tlogsservic(v_ty_logs
                                                            , v_logs_logs
                                                            , v_ty_msg
                                                            );
                --
                IF v_ty_msg.cod_msg <> 'OK' THEN
                    --
                    gen_pcontrolpro('SIN_MOVI_PORF', 'MOVI_PORFIN', 'F', v_ty_msg);
                    --
                    IF v_ty_msg.cod_msg <> 'OK' THEN
                        --
                        GEN_PSEGUIMIENTO('Error en gen_qapi_rest.sp_get_mopf_api_rest 0.4: '||v_ty_msg.msg_msg);
                        raise e_error_e;
                        --
                    END IF;
                    --
                    GEN_PSEGUIMIENTO('Error en gen_qapi_rest.sp_get_mopf_api_rest 0.5: '||v_ty_msg.msg_msg);
                    --
                END IF;
                ROLLBACK;
                --
        END;
        --
    END LOOP;
    --
    gen_pcontrolpro('SIN_MOVI_PORF', 'MOVI_PORFIN', 'F', v_ty_msg);
    --
    IF v_ty_msg.cod_msg <> 'OK' THEN
        --
        raise e_error;
        --
    END IF;
    --
    COMMIT;
    --
EXCEPTION
    WHEN e_error_e THEN
        --
        GEN_PSEGUIMIENTO('Error en gen_qapi_rest.sp_get_mopf_api_rest 0.6: '||v_ty_msg.msg_msg);
        --
        gen_pcontrolpro('SIN_MOVI_PORF', 'MOVI_PORFIN', 'F', v_ty_msg);
        --
        IF v_ty_msg.cod_msg <> 'OK' THEN
            --
            GEN_PSEGUIMIENTO('Error en gen_qapi_rest.sp_get_mopf_api_rest 0.7: '||v_ty_msg.msg_msg);
            --
        END IF;
        --
        ROLLBACK;
        --
    WHEN OTHERS THEN
        --
        v_ty_msg.cod_msg          := 'ERROR';
        v_ty_msg.msg_msg          := 'Error en gen_qapi_rest.sp_get_mopf_api_rest 08: '||sqlerrm;
        v_ty_logs.logs_cod_respu  := v_ty_msg.cod_msg;
        v_ty_logs.logs_msg_resp   := v_ty_msg.msg_msg;
        --
        gen_pcontrolpro('SIN_MOVI_PORF', 'MOVI_PORFIN', 'F', v_ty_msg);
        --
        IF v_ty_msg.cod_msg <> 'OK' THEN
            --
            GEN_PSEGUIMIENTO('Error en gen_qapi_rest.sp_get_mopf_api_rest 0.9: '||v_ty_msg.msg_msg);
            --
        END IF;
        --
        tbl_qlogsservic_crud.insertar_tbl_tlogsservic(v_ty_logs
                                                    , v_logs_logs
                                                    , v_ty_msg
                                                    );
        --
        IF v_ty_msg.cod_msg <> 'OK' THEN
            --
            GEN_PSEGUIMIENTO('Error en gen_qapi_rest.sp_get_mopf_api_rest 0.10: '||v_ty_msg.msg_msg);
            --
        END IF;
        ROLLBACK;
END sp_get_mopf_api_rest;
---------------------------------------------------------------------------------------------------
PROCEDURE sp_get_mopm_api_rest IS
    --
    v_items_object          JSON_OBJECT_T;
    vt_items                JSON_ARRAY_T;
    vr_item_rec             JSON_OBJECT_T;
    v_json_clob             CLOB;
    v_count                 PLS_INTEGER := 0;
    --
    v_ty_motm               tbl_qmotmitra_crud.ty_motm;
    v_motm_motm             tbl_tmotmitra.motm_motm%TYPE;
    --
    v_ty_msg                gen_qgeneral.ty_msg;
    v_ty_logs               tbl_qlogsservic_crud.ty_logs;
    v_logs_logs             tbl_tlogsservic.logs_logs%TYPE;
    e_error                 EXCEPTION;
    e_error_e               EXCEPTION;
    v_fuente                gen_tlistas.list_list%TYPE;
    v_var_em                gen_tlistas.list_list%TYPE;
    v_var_bc                gen_tlistas.list_list%TYPE;
    v_sit                   gen_tlistas.list_list%TYPE;
    --
    v_campo1                VARCHAR2(2000);
    v_campo2                VARCHAR2(2000);
    v_campo3                VARCHAR2(2000);
    v_desc_msg              gen_tmensajes.mens_descripcion%TYPE;
    v_tipo                  gen_tmensajes.mens_tipo%TYPE;
    v_tranid                VARCHAR2(30);
    --
BEGIN -- Get the CLOB.
    --
    v_ty_msg.cod_msg          := 'OK';
    --Cada 5 minutos
    gen_pcontrolpro('SIN_MOVI_MITR', 'MOVI_MITRA', 'P', v_ty_msg);
    --
    IF v_ty_msg.cod_msg <> 'OK' THEN
        --
        raise e_error;
        --
    END IF;
    --
    v_json_clob := gen_qapi_rest.fn_get_api('mopm');
    --SELECT json_clob INTO v_json_clob FROM test_json_parsing WHERE json_id = 5;
    -- Parse the JSON CLOB.
    v_items_object := JSON_OBJECT_T.PARSE(v_json_clob);
    -- Get the ITEMS Array.
    vt_items := v_items_object.get_Array('mitra_movi_data');
    -- Get the Record Count.
    v_count := vt_items.get_size;
    --
    v_fuente := gen_qgeneral.id_lista('TBL', 'FUEN_INFO', 'MT');
    v_var_em := gen_qgeneral.id_lista('TBL', 'VARI_HOMO', 'EM');
    v_var_bc := gen_qgeneral.id_lista('TBL', 'VARI_HOMO', 'BC');
    v_sit    := gen_qgeneral.id_lista('TBL', 'SIST_HOMO', 'TB');
    v_tranid := TO_CHAR(sysdate,'YYYYDDMMHH24MISS');
    --
    -- Loop through the items and get the item_id for each.
    FOR i IN 0..v_count -1 LOOP
        --
        BEGIN
            --
            vr_item_rec                 := JSON_OBJECT_T(vt_items.get(i));
            v_ty_motm                   := NULL;
            v_ty_logs                   := NULL;
            v_ty_logs.logs_id_trans     := v_tranid;
            v_ty_logs.logs_apli         := 'EDGE-MITRA';
            v_ty_logs.logs_fecha        := SYSDATE;
            v_ty_logs.logs_terminal     := Sys_Context ('USERENV', 'HOST');
            v_ty_logs.logs_canal        := 'API';
            v_ty_logs.logs_request      := SUBSTR(vr_item_rec.get_String('neg_folio')||'-'||TO_DATE(vr_item_rec.get_String('neg_fecha_cumplimiento'), 'yyyy/mm/dd'), 1, 50);
            v_ty_logs.logs_response     := NULL;
            v_ty_logs.logs_fecha_resp   := SYSDATE;
            v_ty_logs.logs_proceso      := 'SIN_MOVI_MITR';
            v_ty_logs.logs_fecins       := SYSDATE;
            v_ty_logs.logs_usuains      := USER;
            --
            v_ty_motm.motm_folio        := vr_item_rec.get_String('neg_folio');
            IF v_ty_motm.motm_folio IS NULL THEN
                --
                v_campo1         := 'neg_folio';
                v_ty_msg.cod_msg := 'ER_WBNN_CP';--El campo {campo1} no puede ser nulo.
                raise e_error;
                --
            END IF;
            --
            v_ty_motm.motm_operacion      := vr_item_rec.get_String('operacion');
            IF v_ty_motm.motm_operacion IS NULL THEN
                --
                v_campo1         := 'operacion';
                v_ty_msg.cod_msg := 'ER_WBNN_CP';--El campo {campo1} no puede ser nulo.
                raise e_error;
                --
            END IF;
            --
            v_ty_motm.motm_cod_contra      := vr_item_rec.get_String('id_contraparte');
            IF v_ty_motm.motm_cod_contra IS NULL THEN
                --
                v_campo1         := 'id_contraparte';
                v_ty_msg.cod_msg := 'ER_WBNN_CP';--El campo {campo1} no puede ser nulo.
                raise e_error;
                --
            END IF;
            --
            v_ty_motm.motm_desc_contra       := vr_item_rec.get_String('nombre_contraparte');
            IF v_ty_motm.motm_desc_contra IS NULL THEN
                --
                v_campo1         := 'nombre_contraparte';
                v_ty_msg.cod_msg := 'ER_WBNN_CP';--El campo {campo1} no puede ser nulo.
                raise e_error;
                --
            END IF;
            --
            BEGIN
                --
                v_ty_motm.motm_monto        := replace(vr_item_rec.get_String('neg_monto'),'.',',');
                --
            EXCEPTION
                WHEN OTHERS THEN
                    v_ty_motm.motm_monto        := replace(vr_item_rec.get_String('neg_monto'),',','.');
            END;
            IF v_ty_motm.motm_monto IS NULL THEN
                --
                v_campo1         := 'neg_monto';
                v_ty_msg.cod_msg := 'ER_WBNN_CP';--El campo {campo1} no puede ser nulo.
                raise e_error;
                --
            END IF;
            --
            v_ty_motm.motm_fech_cump      := TO_DATE(vr_item_rec.get_String('neg_fecha_cumplimiento'), 'yyyy/mm/dd');
            IF v_ty_motm.motm_fech_cump IS NULL THEN
                --
                v_campo1         := 'neg_fecha_cumplimiento';
                v_ty_msg.cod_msg := 'ER_WBNN_CP';--El campo {campo1} no puede ser nulo.
                raise e_error;
                --
            END IF;
            --
            IF gen_qgeneral.fn_es_habil(v_ty_motm.motm_fech_cump) = 'N' THEN
                --
                v_ty_motm.motm_fech_cump := gen_qgeneral.fn_ste_habil(v_ty_motm.motm_fech_cump);
                --
            END IF;
            --
            v_ty_motm.motm_cod_trader          := vr_item_rec.get_String('tra_codigo');
            IF v_ty_motm.motm_cod_trader IS NULL THEN
                --
                v_campo1         := 'tra_codigo';
                v_ty_msg.cod_msg := 'ER_WBNN_CP';--El campo {campo1} no puede ser nulo.
                raise e_error;
                --
            END IF;
            --
            v_ty_motm.motm_desc_trader  := vr_item_rec.get_String('tra_nombre');
            IF v_ty_motm.motm_desc_trader IS NULL THEN
                --
                v_campo1         := 'tra_nombre';
                v_ty_msg.cod_msg := 'ER_WBNN_CP';--El campo {campo1} no puede ser nulo.
                raise e_error;
                --
            END IF;
            --
            v_ty_motm.motm_destino          := vr_item_rec.get_String('ope_portafolio');
            IF v_ty_motm.motm_destino IS NULL THEN
                --
                v_campo1         := 'ope_portafolio';
                v_ty_msg.cod_msg := 'ER_WBNN_CP';--El campo {campo1} no puede ser nulo.
                raise e_error;
                --
            END IF;
            --
            v_ty_motm.motm_estado          := vr_item_rec.get_String('ope_estado');
            IF v_ty_motm.motm_estado IS NULL THEN
                --
                v_campo1         := 'ope_estado';
                v_ty_msg.cod_msg := 'ER_WBNN_CP';--El campo {campo1} no puede ser nulo.
                raise e_error;
                --
            END IF;
            --
            v_ty_motm.motm_empr         := tbl_qhomologa.fn_recupera_cod_interno(v_sit, v_var_em, v_fuente, v_ty_motm.motm_destino);
            --
            IF v_ty_motm.motm_empr IS NULL THEN
                --
                v_campo1         := 'de la empresa';
                v_campo2         := v_ty_motm.motm_destino;
                v_ty_msg.cod_msg := 'ER_WBEQ_EM';--'Error al recuperar la equivalencia {campo1} {campo2}, valide que en EDGE exista la homologaci n.';
                raise e_error;
                --
            END IF;
            --
            v_ty_motm.motm_fuente       := v_fuente;
            v_ty_motm.motm_motm         := tbl_qgeneral.fn_recupera_motm(v_ty_motm.motm_folio, v_ty_motm.motm_fech_cump, v_fuente);
            --
            IF v_ty_motm.motm_motm IS NULL THEN
                --
                v_ty_motm.motm_fecins       := SYSDATE;
                v_ty_motm.motm_usuains      := USER;
                --
                tbl_qmotmitra_crud.insertar_tbl_tmotmitra(
                                                          v_ty_motm
                                                        , v_motm_motm
                                                        , v_ty_msg
                                                        );
                --
                IF v_ty_msg.cod_msg <> 'OK' THEN
                    --
                    raise e_error_e;
                    --
                END IF;
                --
            ELSE
                --
                v_ty_motm.motm_fecupd       := SYSDATE;
                v_ty_motm.motm_usuaupd      := USER;
                --
                tbl_qmotmitra_crud.actualizar_tbl_tmotmitra(
                                                            v_ty_motm
                                                          , v_ty_msg
                                                            );
                --
                IF v_ty_msg.cod_msg <> 'OK' THEN
                    --
                    raise e_error_e;
                    --
                END IF;
                --
            END IF;
            --
            v_ty_msg.msg_msg          := 'Proceso Exitoso.';
            --
            v_ty_logs.logs_cod_respu  := v_ty_msg.cod_msg;
            v_ty_logs.logs_msg_resp   := v_ty_msg.msg_msg;
            --
            tbl_qlogsservic_crud.insertar_tbl_tlogsservic(v_ty_logs
                                                        , v_logs_logs
                                                        , v_ty_msg
                                                        );
            --
            IF v_ty_msg.cod_msg <> 'OK' THEN
                --
                raise e_error_e;
                --
            END IF;
            --
            COMMIT;
            --
        EXCEPTION
            WHEN e_error THEN
                --
                v_desc_msg := gen_fmensajes(v_ty_msg.cod_msg, v_tipo);
                --
                IF v_campo1 IS NOT NULL THEN
                    --
                    v_desc_msg := REPLACE(v_desc_msg, '{campo1}', v_campo1);
                    v_desc_msg := REPLACE(v_desc_msg, '{campo2}', v_campo2);
                    v_desc_msg := REPLACE(v_desc_msg, '{campo3}', v_campo3);
                    --
                END IF;
                --
                v_ty_msg.msg_msg          := v_desc_msg;
                v_ty_logs.logs_cod_respu  := v_ty_msg.cod_msg;
                v_ty_logs.logs_msg_resp   := v_ty_msg.msg_msg;
                --
                tbl_qlogsservic_crud.insertar_tbl_tlogsservic(v_ty_logs
                                                            , v_logs_logs
                                                            , v_ty_msg
                                                            );
                --
                IF v_ty_msg.cod_msg <> 'OK' THEN
                    --
                    gen_pcontrolpro('SIN_MOVI_PORF', 'MOVI_PORFIN', 'F', v_ty_msg);
                    --
                    IF v_ty_msg.cod_msg <> 'OK' THEN
                        --
                        GEN_PSEGUIMIENTO('Error en gen_qapi_rest.sp_get_mopm_api_rest 0.1: '||v_ty_msg.msg_msg);
                        raise e_error_e;
                        --
                    END IF;
                    --
                    GEN_PSEGUIMIENTO('Error en gen_qapi_rest.sp_get_mopm_api_rest 0.2: '||v_ty_msg.msg_msg);
                    --
                END IF;
                --
                ROLLBACK;
                --
            WHEN OTHERS THEN
                --
                v_ty_msg.cod_msg          := 'ERROR';
                v_ty_msg.msg_msg          := 'Error en gen_qapi_rest.sp_get_mopm_api_rest 03: '||sqlerrm;
                v_ty_logs.logs_cod_respu  := v_ty_msg.cod_msg;
                v_ty_logs.logs_msg_resp   := v_ty_msg.msg_msg;
                --
                tbl_qlogsservic_crud.insertar_tbl_tlogsservic(v_ty_logs
                                                            , v_logs_logs
                                                            , v_ty_msg
                                                            );
                --
                IF v_ty_msg.cod_msg <> 'OK' THEN
                    --
                    gen_pcontrolpro('SIN_MOVI_PORF', 'MOVI_PORFIN', 'F', v_ty_msg);
                    --
                    IF v_ty_msg.cod_msg <> 'OK' THEN
                        --
                        GEN_PSEGUIMIENTO('Error en gen_qapi_rest.sp_get_mopm_api_rest 0.4: '||v_ty_msg.msg_msg);
                        raise e_error_e;
                        --
                    END IF;
                    --
                    GEN_PSEGUIMIENTO('Error en gen_qapi_rest.sp_get_mopm_api_rest 0.5: '||v_ty_msg.msg_msg);
                    --
                END IF;
                ROLLBACK;
                --
        END;
        --
    END LOOP;
    --
    v_ty_msg.msg_msg          := 'Proceso Exitoso.';
    --
    gen_pcontrolpro('SIN_MOVI_MITR', 'MOVI_MITRA', 'F', v_ty_msg);
    --
    IF v_ty_msg.cod_msg <> 'OK' THEN
        --
        raise e_error;
        --
    END IF;
    --
    COMMIT;
    --
EXCEPTION
    WHEN e_error_e THEN
        --
        GEN_PSEGUIMIENTO('Error en gen_qapi_rest.sp_get_mopm_api_rest 0.6: '||v_ty_msg.msg_msg);
        --
        gen_pcontrolpro('SIN_MOVI_MITR', 'MOVI_MITRA', 'F', v_ty_msg);
        --
        IF v_ty_msg.cod_msg <> 'OK' THEN
            --
            GEN_PSEGUIMIENTO('Error en gen_qapi_rest.sp_get_mopm_api_rest 0.7: '||v_ty_msg.msg_msg);
            --
        END IF;
        --
        ROLLBACK;
        --
    WHEN OTHERS THEN
        --
        v_ty_msg.cod_msg          := 'ERROR';
        v_ty_msg.msg_msg          := 'Error en gen_qapi_rest.sp_get_mopm_api_rest 08: '||sqlerrm;
        v_ty_logs.logs_cod_respu  := v_ty_msg.cod_msg;
        v_ty_logs.logs_msg_resp   := v_ty_msg.msg_msg;
        --
        gen_pcontrolpro('SIN_MOVI_MITR', 'MOVI_MITRA', 'F', v_ty_msg);
        --
        IF v_ty_msg.cod_msg <> 'OK' THEN
            --
            GEN_PSEGUIMIENTO('Error en gen_qapi_rest.sp_get_mopm_api_rest 0.9: '||v_ty_msg.msg_msg);
            --
        END IF;
        --
        tbl_qlogsservic_crud.insertar_tbl_tlogsservic(v_ty_logs
                                                    , v_logs_logs
                                                    , v_ty_msg
                                                    );
        --
        IF v_ty_msg.cod_msg <> 'OK' THEN
            --
            GEN_PSEGUIMIENTO('Error en gen_qapi_rest.sp_get_mopm_api_rest 0.10: '||v_ty_msg.msg_msg);
            --
        END IF;
        ROLLBACK;
END sp_get_mopm_api_rest;
---------------------------------------------------------------------------------------------------
FUNCTION fn_movi_bizagi(p_body CLOB DEFAULT NULL
                        ) RETURN CLOB AS
    --
    resultado           CLOB;
    v_resJson           CLOB;
    v_fuente            gen_tlistas.list_list%TYPE;
    v_fuensf            gen_tlistas.list_list%TYPE;
    v_var_em            gen_tlistas.list_list%TYPE;
    v_var_bc            gen_tlistas.list_list%TYPE;
    v_sit               gen_tlistas.list_list%TYPE;
    vr_item_rec         JSON_OBJECT_T;
    v_items_object      JSON_OBJECT_T;
    vt_items            JSON_ARRAY_T;
    v_count             PLS_INTEGER := 0;
    --
    v_ty_tran           gen_qapi_rest.ty_tran;
    v_ty_mvbi           gen_qapi_rest.ty_mvbi;
    v_ty_logs           tbl_qlogsservic_crud.ty_logs;
    v_logs_logs         tbl_tlogsservic.logs_logs%TYPE;
    v_ty_motb           tbl_qmotbbiza_crud.ty_motb;
    v_motb_motb         tbl_tmotbbiza.motb_motb%TYPE;
    v_ty_msg            gen_qgeneral.ty_msg;
    v_tipo              gen_tmensajes.mens_tipo%TYPE;
    v_desc_msg          gen_tmensajes.mens_descripcion%TYPE;
    --
    CURSOR c_data (pc_json CLOB)IS
        SELECT data.*
          FROM (SELECT pc_json json_column FROM dual) a
                     , json_table(a.json_column, '$[*]'
                           columns( motb_caso                   VARCHAR(4000) path '$.motb_caso'
                                  , nested path '$.transaccion[*]'
                                        columns( transaccion        VARCHAR2(4000) path '$.transaccion'
                                               , aplicacion         VARCHAR2(4000) path '$.aplicacion'
                                               , fecha              VARCHAR2(4000) path '$.fecha'
                                               , hora               VARCHAR2(4000) path '$.hora'
                                               , terminal           VARCHAR2(4000) path '$.terminal'
                                               , usuario            VARCHAR2(4000) path '$.usuario'
                                               , canal              VARCHAR2(4000) path '$.canal'
                                                )
                                  , nested path '$.movimientosResponse[*]'
                                        columns( nested path '$.movimientos[*]'
                                               columns( motb_empresa               VARCHAR2(4000) path '$.motb_empresa'
                                                      , motb_banco                 VARCHAR2(4000) path '$.motb_banco'
                                                      , motb_nrocta                VARCHAR2(4000) path '$.motb_nrocta'
                                                      , motb_fecha                 VARCHAR2(4000) path '$.motb_fecha'
                                                      , motb_descripcion           VARCHAR2(4000) path '$.motb_descripcion'
                                                      , motb_valor                 VARCHAR2(4000) path '$.motb_valor'
                                                      , motb_estado                VARCHAR2(4000) path '$.motb_estado'
                                                      , motb_tipo_oper             VARCHAR2(4000) path '$.motb_tipo_oper'
                                                      , motb_gmf                   VARCHAR2(4000) path '$.motb_gmf'
                                                )
                                                )
                                )
                ) data
        ;
    --
    r_data  c_data%ROWTYPE;
    --
    --JSON salida
    v_items_obj             json_object_t := json_object_t();
    vr_item_accept          json_object_t := json_object_t();
    vt_items_array_accept   json_array_t  := json_array_t ();
    l_json_clob             CLOB;
    --
    e_error     EXCEPTION;
    v_campo1    VARCHAR2(2000);
    v_campo2    VARCHAR2(2000);
    v_campo3    VARCHAR2(2000);
    --
BEGIN
    --
    --Se asigna el JSON del body a la variable a recorrer
    v_resJson := p_body;
    --
    IF v_resJson IS NOT NULL THEN
        --
        v_fuente := gen_qgeneral.id_lista('TBL', 'FUEN_INFO', 'BZ');
        v_fuensf := gen_qgeneral.id_lista('TBL', 'FUEN_INFO', 'SF');
        v_var_em := gen_qgeneral.id_lista('TBL', 'VARI_HOMO', 'EM');
        v_var_bc := gen_qgeneral.id_lista('TBL', 'VARI_HOMO', 'BC');
        v_sit    := gen_qgeneral.id_lista('TBL', 'SIST_HOMO', 'TB');
        --Se recuperan los valores del JSON
        FOR i IN c_data (v_resJson
                        )LOOP
            --
            IF NVL(v_count, 0) = 0 THEN
                --
                --Se llena type de transacci n para realizar validaciones
                v_ty_tran             := NULL;
                v_ty_tran.transaccion := i.transaccion;
                v_ty_tran.aplicacion  := i.aplicacion ;
                v_ty_tran.fecha       := i.fecha      ;
                v_ty_tran.hora        := i.hora       ;
                v_ty_tran.terminal    := i.terminal   ;
                v_ty_tran.usuario     := i.usuario    ;
                v_ty_tran.canal       := i.canal      ;
                --
                gen_qapi_rest.sp_validar_dat_tran( p_ty_tran => v_ty_tran
                                                 , p_campo1  => v_campo1
                                                 , p_campo2  => v_campo2
                                                 , p_campo3  => v_campo3
                                                 , p_ty_msg  => v_ty_msg
                                                );
                --
                IF v_ty_msg.cod_msg <> 'OK' THEN
                    --
                    raise e_error;
                    --
                END IF;
                --
                --Se llena type para almacenar el log de consumo.
                v_ty_logs                 := NULL;
                v_ty_logs.logs_id_trans   := i.transaccion;
                v_ty_logs.logs_apli       := i.aplicacion;
                v_ty_logs.logs_fecha      := TO_DATE(TO_CHAR(i.fecha||' '||i.hora), 'DDMMYYYY HH24MISS');
                v_ty_logs.logs_terminal   := i.terminal;
                v_ty_logs.logs_canal      := i.canal;
                v_ty_logs.logs_request    := v_resJson;
                v_ty_logs.logs_proceso    := 'CONS_BIZA';
                v_ty_logs.logs_fecins     := SYSDATE;
                v_ty_logs.logs_usuains    := i.usuario;
                --
                tbl_qlogsservic_crud.insertar_tbl_tlogsservic(
                                                              p_ty_logs     => v_ty_logs
                                                            , p_logs_logs   => v_logs_logs
                                                            , p_ty_msg      => v_ty_msg
                                                            );
                --
                IF v_ty_msg.cod_msg <> 'OK' THEN
                    --
                    raise e_error;
                    --
                END IF;
                --
                DELETE 
                  FROM tbl_tmotbbiza
                 WHERE motb_caso = i.motb_caso
                ;
                --
            ELSE
                --
                /*
                GEN_PSEGUIMIENTO('fn_movi_bizagi motb_empresa: '||i.motb_empresa
                             || ' motb_banco: '||i.motb_banco
                             || ' motb_nrocta: '||i.motb_nrocta
                             || ' motb_fecha: '||i.motb_fecha
                             || ' motb_descripcion: '||i.motb_descripcion
                             || ' motb_valor: '||i.motb_valor
                             || ' motb_estado: '||i.motb_estado
                             || ' motb_tipo_oper: '||i.motb_tipo_oper
                             || ' motb_gmf: '||i.motb_gmf
                                    );
                */
                --
                --Se llena type de negocio para realizar validaciones
                v_ty_mvbi                   := NULL;
                v_ty_mvbi.motb_caso         := i.motb_caso       ;
                v_ty_mvbi.motb_empresa      := i.motb_empresa    ;
                v_ty_mvbi.motb_banco        := i.motb_banco      ;
                v_ty_mvbi.motb_nrocta       := i.motb_nrocta     ;
                v_ty_mvbi.motb_fecha        := i.motb_fecha      ;
                v_ty_mvbi.motb_descripcion  := i.motb_descripcion;
                v_ty_mvbi.motb_valor        := i.motb_valor      ;
                v_ty_mvbi.motb_estado       := i.motb_estado     ;
                v_ty_mvbi.motb_tipo_oper    := i.motb_tipo_oper  ;
                v_ty_mvbi.motb_gmf          := i.motb_gmf        ;
                --
                gen_qapi_rest.sp_validar_dat_movi( p_ty_mvbi => v_ty_mvbi
                                                 , p_campo1  => v_campo1
                                                 , p_campo2  => v_campo2
                                                 , p_campo3  => v_campo3
                                                 , p_ty_msg  => v_ty_msg
                                                );
                --
                IF v_ty_msg.cod_msg <> 'OK' THEN
                    --
                    raise e_error;
                    --
                END IF;
                --
                --Se llena type para almacenar los movimientos enviados por BIZAGI.
                v_ty_motb                  := NULL;
                v_ty_motb.motb_caso        := i.motb_caso;
                v_ty_motb.motb_empresa     := i.motb_empresa;
                v_ty_motb.motb_empr        := tbl_qgeneral.recupera_empr(v_ty_motb.motb_empresa, v_fuensf);
                GEN_PSEGUIMIENTO('fn_movi_bizagi v_sit: '||v_sit
                                        || ' v_var_em: '||v_var_em
                                        || ' v_fuente'||v_fuente
                                        || ' i.motb_empresa'||i.motb_empresa
                                        || ' v_ty_motb.motb_empr'||v_ty_motb.motb_empr
                                    );
                --
                IF v_ty_motb.motb_empr IS NULL THEN
                    --
                    v_campo1         := 'de la empresa';
                    v_campo2         := i.motb_empresa;
                    v_ty_msg.cod_msg := 'ER_WBCN_ED';--'Error, código {campo1} {campo2}, no existe en EDGE.';
                    raise e_error;
                    --
                END IF;
                --
                v_ty_motb.motb_banco       := i.motb_banco;
                --v_ty_motb.motb_banc        := tbl_qhomologa.fn_recupera_cod_interno(v_sit, v_var_bc, v_fuente, i.motb_banco);
                v_ty_motb.motb_banc        := tbl_qgeneral.recupera_banc(v_ty_motb.motb_banco, v_fuensf);
                --
                IF v_ty_motb.motb_banc IS NULL THEN
                    --
                    v_campo1         := 'del banco';
                    v_campo2         := i.motb_banco;
                    --v_ty_msg.cod_msg := 'ER_WBEQ_EM';--'Error al recuperar la equivalencia {campo1} {campo2}, valide que en EDGE exista la homologaci n.';
                    v_ty_msg.cod_msg := 'ER_WBCN_ED';--'Error, Código {campo1} {campo2}, no existe en EDGE.'
                    raise e_error;
                    --
                END IF;
                --
                v_ty_motb.motb_nrocta      := NULL;
                v_ty_motb.motb_cuen        := NULL;
                --
                v_ty_motb.motb_fecha       := TO_DATE(i.motb_fecha, 'DDMMYYYY');
                v_ty_motb.motb_descripcion := i.motb_descripcion;
                v_ty_motb.motb_valor       := TO_NUMBER(i.motb_valor);
                v_ty_motb.motb_esta        := i.motb_estado;
                v_ty_motb.motb_tipo_oper   := i.motb_tipo_oper;
                v_ty_motb.motb_gmf         := i.motb_gmf;
                v_ty_motb.motb_fuente      := v_fuente;
                v_ty_motb.motb_fecins      := SYSDATE;
                v_ty_motb.motb_usuains     := v_ty_logs.logs_usuains;
                --
                tbl_qmotbbiza_crud.insertar_tbl_tmotbbiza(p_ty_motb   => v_ty_motb
                                                        , p_motb_motb => v_motb_motb
                                                        , p_ty_msg    => v_ty_msg
                                                        );
                --
                IF v_ty_msg.cod_msg <> 'OK' THEN
                    --
                    raise e_error;
                    --
                END IF;
                --
            END IF;
            --
            v_count := v_count + 1;
            --
        END LOOP c_data;
        --
    END IF;
    --
    vr_item_accept.PUT('transaccion', v_ty_tran.transaccion);
    vr_item_accept.PUT('Fec_resp', TO_CHAR(SYSDATE, 'DDMMYYYY'));
    vr_item_accept.PUT('Hor_resp', TO_CHAR(SYSDATE, 'HH24MISS'));
    vr_item_accept.PUT('Cod_resp', 'OK');
    vr_item_accept.PUT('Msg_resp', 'Transacción realizada exitosamente');
    vt_items_array_accept.APPEND (vr_item_accept);
    --
    v_items_obj.PUT ('Respuesta', vt_items_array_accept);
    l_json_clob := v_items_obj.to_clob;
    --
    v_ty_logs.logs_response   := l_json_clob;
    v_ty_logs.logs_cod_respu  := 'OK';
    v_ty_logs.logs_msg_resp   := 'Transacción realizada exitosamente';
    v_ty_logs.logs_fecha_resp := SYSDATE;
    v_ty_logs.logs_logs       := v_logs_logs;
    --
    tbl_qlogsservic_crud.actualizar_tbl_tlogsservic(
                                                    p_ty_logs     => v_ty_logs
                                                  , p_ty_msg      => v_ty_msg
                                                    );
    --
    IF v_ty_msg.cod_msg <> 'OK' THEN
        --
        raise e_error;
        --
    END IF;
    --
    COMMIT;
    --
    RETURN l_json_clob;
    --
EXCEPTION
    WHEN e_error THEN
        --
        v_desc_msg := gen_fmensajes(v_ty_msg.cod_msg, v_tipo);
        --
        IF v_campo1 IS NOT NULL THEN
            --
            v_desc_msg := REPLACE(v_desc_msg, '{campo1}', v_campo1);
            v_desc_msg := REPLACE(v_desc_msg, '{campo2}', v_campo2);
            v_desc_msg := REPLACE(v_desc_msg, '{campo3}', v_campo3);
            --
        END IF;
        --
        vr_item_accept.PUT('transaccion', v_ty_tran.transaccion);
        vr_item_accept.PUT('Fec_resp', TO_CHAR(SYSDATE, 'DDMMYYYY'));
        vr_item_accept.PUT('Hor_resp', TO_CHAR(SYSDATE, 'HH24MISS'));
        vr_item_accept.PUT('Cod_resp', v_ty_msg.cod_msg);
        vr_item_accept.PUT('Msg_resp', v_desc_msg);
        vt_items_array_accept.APPEND (vr_item_accept);
        --
        v_items_obj.PUT ('Respuesta', vt_items_array_accept);
        l_json_clob := v_items_obj.to_clob;
        --
        v_ty_logs.logs_response   := l_json_clob;
        v_ty_logs.logs_cod_respu  := v_ty_msg.cod_msg;
        v_ty_logs.logs_msg_resp   := v_desc_msg;
        v_ty_logs.logs_fecha_resp := SYSDATE;
        v_ty_logs.logs_logs       := v_logs_logs;
        --
        tbl_qlogsservic_crud.actualizar_tbl_tlogsservic(
                                                        p_ty_logs     => v_ty_logs
                                                      , p_ty_msg      => v_ty_msg
                                                        );
        --
        IF v_ty_msg.cod_msg <> 'OK' THEN
            --
            raise e_error;
            --
        END IF;
        --
        ROLLBACK;
        --
        RETURN l_json_clob;
        --
    WHEN OTHERS THEN
        --
        v_ty_msg.cod_msg := 'ER_NO_CTRL';
        v_ty_msg.msg_msg := 'Error no controlado, gen_qapi_rest.fn_movi_bizagi '||sqlerrm;
        vr_item_accept.PUT('transaccion', v_ty_tran.transaccion);
        vr_item_accept.PUT('Fec_resp', TO_CHAR(SYSDATE, 'DDMMYYYY'));
        vr_item_accept.PUT('Hor_resp', TO_CHAR(SYSDATE, 'HH24MISS'));
        vr_item_accept.PUT('Cod_resp', v_ty_msg.cod_msg);
        vr_item_accept.PUT('Msg_resp', v_ty_msg.msg_msg);
        vt_items_array_accept.APPEND (vr_item_accept);
        --
        v_items_obj.PUT ('Respuesta', vt_items_array_accept);
        l_json_clob := v_items_obj.to_clob;
        --
        v_ty_logs.logs_response   := l_json_clob;
        v_ty_logs.logs_cod_respu  := v_ty_msg.cod_msg;
        v_ty_logs.logs_msg_resp   := v_ty_msg.msg_msg;
        v_ty_logs.logs_fecha_resp := SYSDATE;
        v_ty_logs.logs_logs       := v_logs_logs;
        --
        tbl_qlogsservic_crud.actualizar_tbl_tlogsservic(
                                                        p_ty_logs     => v_ty_logs
                                                      , p_ty_msg      => v_ty_msg
                                                        );
        --
        IF v_ty_msg.cod_msg <> 'OK' THEN
            --
            raise e_error;
            --
        END IF;
        --
        ROLLBACK;
        --
        RETURN l_json_clob;
        --
END fn_movi_bizagi;
---------------------------------------------------------------------------------------------------
PROCEDURE sp_validar_dat_movi( p_ty_mvbi       gen_qapi_rest.ty_mvbi
                             , p_campo1    OUT VARCHAR2
                             , p_campo2    OUT VARCHAR2
                             , p_campo3    OUT VARCHAR2
                             , p_ty_msg    OUT gen_qgeneral.ty_msg
                          )IS
    --
    e_error     EXCEPTION;
    --
BEGIN
    --
    p_ty_msg.cod_msg := 'OK';
    --
    IF p_ty_mvbi.motb_caso IS NULL OR p_ty_mvbi.motb_caso = '' THEN
        --
        p_campo1         := 'motb_caso';
        p_ty_msg.cod_msg := 'ER_WBNN_CP';--El campo {campo1} no puede ser nulo.
        raise e_error;
        --
    ELSE
        --
        gen_qapi_rest.sp_valida_fmto(p_long     => LENGTH(p_ty_mvbi.motb_caso)
                                   , p_perm     => 9
                                   , p_colu     => 'motb_caso'
                                   , p_dato     => p_ty_mvbi.motb_caso
                                   , p_tipo_dat => 'A'
                                   , p_campo1   => p_campo1
                                   , p_campo2   => p_campo2
                                   , p_campo3   => p_campo3
                                   , p_ty_msg   => p_ty_msg
                                    );
        --
        IF p_ty_msg.cod_msg <> 'OK' THEN
            --
            raise e_error;
            --
        END IF;
        --
    END IF;
    --
    IF p_ty_mvbi.motb_empresa IS NULL OR p_ty_mvbi.motb_empresa = '' THEN
        --
        p_campo1         := 'motb_empresa';
        p_ty_msg.cod_msg := 'ER_WBNN_CP';--El campo {campo1} no puede ser nulo.
        raise e_error;
        --
    ELSE
        --
        gen_qapi_rest.sp_valida_fmto(p_long     => LENGTH(p_ty_mvbi.motb_empresa)
                                   , p_perm     => 50
                                   , p_colu     => 'motb_empresa'
                                   , p_dato     =>  p_ty_mvbi.motb_empresa
                                   , p_tipo_dat => 'A'
                                   , p_campo1   => p_campo1
                                   , p_campo2   => p_campo2
                                   , p_campo3   => p_campo3
                                   , p_ty_msg   => p_ty_msg
                                    );
        --
        IF p_ty_msg.cod_msg <> 'OK' THEN
            --
            raise e_error;
            --
        END IF;
        --
    END IF;
    --
    IF p_ty_mvbi.motb_banco IS NULL OR p_ty_mvbi.motb_banco = '' THEN
        --
        p_campo1         := 'motb_banco';
        p_ty_msg.cod_msg := 'ER_WBNN_CP';--El campo {campo1} no puede ser nulo.
        raise e_error;
        --
    ELSE
        --
        gen_qapi_rest.sp_valida_fmto(p_long => LENGTH(p_ty_mvbi.motb_banco)
                                   , p_perm => 50
                                   , p_colu => 'motb_banco'
                                   , p_dato =>  p_ty_mvbi.motb_banco
                                   , p_tipo_dat => 'A'
                                   , p_campo1 => p_campo1
                                   , p_campo2 => p_campo2
                                   , p_campo3 => p_campo3
                                   , p_ty_msg => p_ty_msg
                                    );
        --
        IF p_ty_msg.cod_msg <> 'OK' THEN
            --
            raise e_error;
            --
        END IF;
        --
    END IF;
    --
    IF p_ty_mvbi.motb_nrocta IS NOT NULL THEN
        --
        gen_qapi_rest.sp_valida_fmto(p_long => LENGTH(p_ty_mvbi.motb_nrocta)
                                   , p_perm => 50
                                   , p_colu => 'motb_nrocta'
                                   , p_dato =>  p_ty_mvbi.motb_nrocta
                                   , p_tipo_dat => 'A'
                                   , p_campo1 => p_campo1
                                   , p_campo2 => p_campo2
                                   , p_campo3 => p_campo3
                                   , p_ty_msg => p_ty_msg
                                    );
        --
        IF p_ty_msg.cod_msg <> 'OK' THEN
            --
            raise e_error;
            --
        END IF;
        --
    END IF;
    --
    IF p_ty_mvbi.motb_fecha IS NULL OR p_ty_mvbi.motb_fecha = '' THEN
        --
        p_campo1         := 'motb_fecha';
        p_ty_msg.cod_msg := 'ER_WBNN_CP';--El campo {campo1} no puede ser nulo.
        raise e_error;
        --
    ELSE
        --
        gen_qapi_rest.sp_valida_fmto(p_long => LENGTH(p_ty_mvbi.motb_fecha)
                                   , p_perm => 8
                                   , p_colu => 'motb_fecha'
                                   , p_dato =>  p_ty_mvbi.motb_fecha
                                   , p_tipo_dat => 'F'
                                   , p_campo1 => p_campo1
                                   , p_campo2 => p_campo2
                                   , p_campo3 => p_campo3
                                   , p_ty_msg => p_ty_msg
                                    );
        --
        IF p_ty_msg.cod_msg <> 'OK' THEN
            --
            raise e_error;
            --
        END IF;
        --
    END IF;
    --
    IF p_ty_mvbi.motb_descripcion IS NULL OR p_ty_mvbi.motb_descripcion = '' THEN
        --
        p_campo1         := 'motb_descripcion';
        p_ty_msg.cod_msg := 'ER_WBNN_CP';--El campo {campo1} no puede ser nulo.
        raise e_error;
        --
    ELSE
        --
        gen_qapi_rest.sp_valida_fmto(p_long => LENGTH(p_ty_mvbi.motb_descripcion)
                                   , p_perm => 200
                                   , p_colu => 'motb_descripcion'
                                   , p_dato =>  p_ty_mvbi.motb_descripcion
                                   , p_tipo_dat => 'A'
                                   , p_campo1 => p_campo1
                                   , p_campo2 => p_campo2
                                   , p_campo3 => p_campo3
                                   , p_ty_msg => p_ty_msg
                                    );
        --
        IF p_ty_msg.cod_msg <> 'OK' THEN
            --
            raise e_error;
            --
        END IF;
        --
    END IF;
    --
    IF p_ty_mvbi.motb_valor IS NULL OR p_ty_mvbi.motb_valor = '' THEN
        --
        p_campo1         := 'motb_valor';
        p_ty_msg.cod_msg := 'ER_WBNN_CP';--El campo {campo1} no puede ser nulo.
        raise e_error;
        --
    ELSE
        --
        gen_qapi_rest.sp_valida_fmto(p_long     => LENGTH(p_ty_mvbi.motb_valor)
                                   , p_perm     => 22
                                   , p_colu     => 'motb_valor'
                                   , p_dato     =>  p_ty_mvbi.motb_valor
                                   , p_tipo_dat => 'N'
                                   , p_campo1   => p_campo1
                                   , p_campo2   => p_campo2
                                   , p_campo3   => p_campo3
                                   , p_ty_msg   => p_ty_msg
                                    );
        --
        IF p_ty_msg.cod_msg <> 'OK' THEN
            --
            raise e_error;
            --
        END IF;
        --
    END IF;
    --
    IF p_ty_mvbi.motb_estado IS NULL OR p_ty_mvbi.motb_estado = '' THEN
        --
        p_campo1         := 'motb_estado';
        p_ty_msg.cod_msg := 'ER_WBNN_CP';--El campo {campo1} no puede ser nulo.
        raise e_error;
        --
    ELSE
        --
        gen_qapi_rest.sp_valida_fmto(p_long     => LENGTH(p_ty_mvbi.motb_estado)
                                   , p_perm     => 30
                                   , p_colu     => 'motb_estado'
                                   , p_dato     =>  p_ty_mvbi.motb_estado
                                   , p_tipo_dat => 'A'
                                   , p_campo1   => p_campo1
                                   , p_campo2   => p_campo2
                                   , p_campo3   => p_campo3
                                   , p_ty_msg   => p_ty_msg
                                    );
        --
        IF p_ty_msg.cod_msg <> 'OK' THEN
            --
            raise e_error;
            --
        END IF;
        --
    END IF;
    --
    IF p_ty_mvbi.motb_tipo_oper IS NULL OR p_ty_mvbi.motb_tipo_oper = '' THEN
        --
        p_campo1         := 'motb_tipo_oper';
        p_ty_msg.cod_msg := 'ER_WBNN_CP';--El campo {campo1} no puede ser nulo.
        raise e_error;
        --
    ELSE
        --
        gen_qapi_rest.sp_valida_fmto(p_long     => LENGTH(p_ty_mvbi.motb_tipo_oper)
                                   , p_perm     => 50
                                   , p_colu     => 'motb_tipo_oper'
                                   , p_dato     =>  p_ty_mvbi.motb_tipo_oper
                                   , p_tipo_dat => 'A'
                                   , p_campo1   => p_campo1
                                   , p_campo2   => p_campo2
                                   , p_campo3   => p_campo3
                                   , p_ty_msg   => p_ty_msg
                                    );
        --
        IF p_ty_msg.cod_msg <> 'OK' THEN
            --
            raise e_error;
            --
        END IF;
        --
    END IF;
    --
    IF p_ty_mvbi.motb_gmf IS NULL OR p_ty_mvbi.motb_gmf = '' THEN
        --
        p_campo1         := 'motb_gmf';
        p_ty_msg.cod_msg := 'ER_WBNN_CP';--El campo {campo1} no puede ser nulo.
        raise e_error;
        --
    ELSE
        --
        gen_qapi_rest.sp_valida_fmto(p_long     => LENGTH(p_ty_mvbi.motb_gmf)
                                   , p_perm     => 1
                                   , p_colu     => 'motb_gmf'
                                   , p_dato     =>  p_ty_mvbi.motb_gmf
                                   , p_tipo_dat => 'A'
                                   , p_campo1   => p_campo1
                                   , p_campo2   => p_campo2
                                   , p_campo3   => p_campo3
                                   , p_ty_msg => p_ty_msg
                                    );
        --
        IF p_ty_msg.cod_msg <> 'OK' THEN
            --
            raise e_error;
            --
        END IF;
        --
    END IF;
    --
    p_ty_msg.msg_msg := 'Transaccion Exitosa';
    --
EXCEPTION
    WHEN e_error THEN
        RETURN;
    WHEN OTHERS THEN
        p_campo1 := 'gen_qapi_rest.sp_validar_dat_movi';
        p_campo2 := SUBSTR(SQLERRM, 1, 100);
        p_ty_msg.cod_msg := 'ER_NO_CTRL';--Error no controlado, {campo1}:  {campo2}.
        RETURN;
END sp_validar_dat_movi;
---------------------------------------------------------------------------------------------------
PROCEDURE sp_validar_dat_tran( p_ty_tran       gen_qapi_rest.ty_tran
                             , p_campo1    OUT VARCHAR2
                             , p_campo2    OUT VARCHAR2
                             , p_campo3    OUT VARCHAR2
                             , p_ty_msg    OUT gen_qgeneral.ty_msg
                          )IS
    --
    e_error     EXCEPTION;
    --
BEGIN
    --
    p_ty_msg.cod_msg := 'OK';
    --
    IF p_ty_tran.transaccion IS NULL THEN
        --
        p_campo1         := 'transaccion';
        p_ty_msg.cod_msg := 'ER_WBNN_CP';--El campo {campo1} no puede ser nulo.
        --
    ELSE
        --
        gen_qapi_rest.sp_valida_fmto(p_long => LENGTH(p_ty_tran.transaccion)
                                   , p_perm => 50
                                   , p_colu => 'transaccion'
                                   , p_dato =>  p_ty_tran.transaccion
                                   , p_tipo_dat => 'A'
                                   , p_campo1 => p_campo1
                                   , p_campo2 => p_campo2
                                   , p_campo3 => p_campo3
                                   , p_ty_msg => p_ty_msg
                                    );
        --
        IF p_ty_msg.cod_msg <> 'OK' THEN
            --
            raise e_error;
            --
        END IF;
        --
    END IF;
    --
    IF p_ty_tran.aplicacion IS NULL THEN
        --
        p_campo1         := 'aplicacion';
        p_ty_msg.cod_msg := 'ER_WBNN_CP';--El campo {campo1} no puede ser nulo.
        --
    ELSE
        --
        gen_qapi_rest.sp_valida_fmto(p_long => LENGTH(p_ty_tran.aplicacion)
                                   , p_perm => 50
                                   , p_colu => 'aplicacion'
                                   , p_dato =>  p_ty_tran.aplicacion
                                   , p_tipo_dat => 'A'
                                   , p_campo1 => p_campo1
                                   , p_campo2 => p_campo2
                                   , p_campo3 => p_campo3
                                   , p_ty_msg => p_ty_msg
                                    );
        --
        IF p_ty_msg.cod_msg <> 'OK' THEN
            --
            raise e_error;
            --
        END IF;
        --
    END IF;
    --
    IF p_ty_tran.fecha      IS NULL THEN
        --
        p_campo1         := 'fecha';
        p_ty_msg.cod_msg := 'ER_WBNN_CP';--El campo {campo1} no puede ser nulo.
        --
    ELSE
        --
        gen_qapi_rest.sp_valida_fmto(p_long => LENGTH(p_ty_tran.fecha)
                                   , p_perm => 8
                                   , p_colu => 'fecha'
                                   , p_dato =>  p_ty_tran.fecha
                                   , p_tipo_dat => 'F'
                                   , p_campo1 => p_campo1
                                   , p_campo2 => p_campo2
                                   , p_campo3 => p_campo3
                                   , p_ty_msg => p_ty_msg
                                    );
        --
        IF p_ty_msg.cod_msg <> 'OK' THEN
            --
            raise e_error;
            --
        END IF;
        --
    END IF;
    --
    IF p_ty_tran.hora       IS NULL THEN
        --
        p_campo1         := 'hora';
        p_ty_msg.cod_msg := 'ER_WBNN_CP';--El campo {campo1} no puede ser nulo.
        --
    ELSE
        --
        gen_qapi_rest.sp_valida_fmto(p_long => LENGTH(p_ty_tran.hora)
                                   , p_perm => 6
                                   , p_colu => 'hora'
                                   , p_dato =>  p_ty_tran.hora
                                   , p_tipo_dat => 'H'
                                   , p_campo1 => p_campo1
                                   , p_campo2 => p_campo2
                                   , p_campo3 => p_campo3
                                   , p_ty_msg => p_ty_msg
                                    );
        --
        IF p_ty_msg.cod_msg <> 'OK' THEN
            --
            raise e_error;
            --
        END IF;
        --
    END IF;
    --
    IF p_ty_tran.terminal   IS NULL THEN
        --
        p_campo1         := 'terminal';
        p_ty_msg.cod_msg := 'ER_WBNN_CP';--El campo {campo1} no puede ser nulo.
        --
    ELSE
        --
        gen_qapi_rest.sp_valida_fmto(p_long => LENGTH(p_ty_tran.terminal)
                                   , p_perm => 20
                                   , p_colu => 'terminal'
                                   , p_dato =>  p_ty_tran.terminal
                                   , p_tipo_dat => 'A'
                                   , p_campo1 => p_campo1
                                   , p_campo2 => p_campo2
                                   , p_campo3 => p_campo3
                                   , p_ty_msg => p_ty_msg
                                    );
        --
        IF p_ty_msg.cod_msg <> 'OK' THEN
            --
            raise e_error;
            --
        END IF;
        --
    END IF;
    --
    IF p_ty_tran.usuario    IS NULL THEN
        --
        p_campo1         := 'usuario';
        p_ty_msg.cod_msg := 'ER_WBNN_CP';--El campo {campo1} no puede ser nulo.
        --
    ELSE
        --
        gen_qapi_rest.sp_valida_fmto(p_long     => LENGTH(p_ty_tran.usuario)
                                   , p_perm     => 20
                                   , p_colu     => 'usuario'
                                   , p_dato     =>  p_ty_tran.usuario
                                   , p_tipo_dat => 'A'
                                   , p_campo1   => p_campo1
                                   , p_campo2   => p_campo2
                                   , p_campo3   => p_campo3
                                   , p_ty_msg   => p_ty_msg
                                    );
        --
        IF p_ty_msg.cod_msg <> 'OK' THEN
            --
            raise e_error;
            --
        END IF;
        --
    END IF;
    --
    IF p_ty_tran.canal      IS NULL THEN
        --
        p_campo1         := 'canal';
        p_ty_msg.cod_msg := 'ER_WBNN_CP';--El campo {campo1} no puede ser nulo.
        --
    ELSE
        --
        gen_qapi_rest.sp_valida_fmto(p_long     => LENGTH(p_ty_tran.canal)
                                   , p_perm     => 20
                                   , p_colu     => 'canal'
                                   , p_dato     =>  p_ty_tran.canal
                                   , p_tipo_dat => 'A'
                                   , p_campo1   => p_campo1
                                   , p_campo2   => p_campo2
                                   , p_campo3   => p_campo3
                                   , p_ty_msg => p_ty_msg
                                    );
        --
        IF p_ty_msg.cod_msg <> 'OK' THEN
            --
            raise e_error;
            --
        END IF;
        --
    END IF;
    --
    p_ty_msg.msg_msg := 'Transaccion Exitosa';
    --
EXCEPTION
    WHEN e_error THEN
        RETURN;
    WHEN OTHERS THEN
        p_campo1 := 'gen_qapi_rest.sp_validar_dat_tran';
        p_campo2 := SUBSTR(SQLERRM, 1, 100);
        p_ty_msg.cod_msg := 'ER_NO_CTRL';--Error no controlado, {campo1}:  {campo2}.
        RETURN;
END sp_validar_dat_tran;
---------------------------------------------------------------------------------------------------
PROCEDURE sp_valida_fmto( p_long           NUMBER
                        , p_perm           NUMBER
                        , p_colu           VARCHAR2
                        , p_dato           VARCHAR2
                        , p_tipo_dat       VARCHAR2
                        , p_campo1     OUT VARCHAR2
                        , p_campo2     OUT VARCHAR2
                        , p_campo3     OUT VARCHAR2
                        , p_ty_msg     OUT gen_qgeneral.ty_msg
                          )IS
    --
    e_error     EXCEPTION;
    --
    v_fecha     DATE;
    v_number    NUMBER;
    --
BEGIN
    --
    p_ty_msg.cod_msg := 'OK';
    --
    IF p_long > p_perm THEN
        --
        p_campo1 := p_colu;
        p_campo2 := p_perm;
        p_campo3 := p_long;
        p_ty_msg.cod_msg := 'ER_WBLG_CP';--Longitud no v lida para el campo {campo1}, permitida {campo2} actual {campo3}.
        raise e_error;
        --
    END IF;
    --
    IF p_tipo_dat = 'F' THEN --Fecha
        --
        BEGIN
            --
            v_fecha := TO_DATE(p_dato, 'DDMMYYYY');
            --
        EXCEPTION
            WHEN OTHERS THEN
                --
                p_campo1 := p_colu;
                p_campo2 := 'DDMMYYYY';
                p_ty_msg.cod_msg := 'ER_WBDT_NV';--Dato no valido para el campo {campo1}, debe ser en formato {campo2}.
                raise e_error;
                --
        END;
        --
    ELSIF p_tipo_dat = 'N' THEN --N merico
        --
        BEGIN
            --
            v_number := TO_NUMBER(p_dato);
            --
        EXCEPTION
            WHEN OTHERS THEN
                --
                p_campo1 := p_colu;
                p_campo2 := 'N merico';
                p_ty_msg.cod_msg := 'ER_WBDT_NV';--Dato no valido para el campo {campo1}, debe ser en formato {campo2}.
                raise e_error;
                --
        END;
        --
    ELSIF p_tipo_dat = 'H' THEN --Hora
        --
        BEGIN
            --
            v_fecha := to_date(p_dato, 'hh24miss');
            --
        EXCEPTION
            WHEN OTHERS THEN
                --
                p_campo1 := p_colu;
                p_campo2 := 'HH24MISS';
                p_ty_msg.cod_msg := 'ER_WBDT_NV';--Dato no valido para el campo {campo1}, debe ser en formato {campo2}.
                raise e_error;
                --
        END;
        --
    END IF;
    --
    p_ty_msg.msg_msg := 'Transaccion Exitosa';
    --
EXCEPTION
    WHEN e_error THEN
        RETURN;
    WHEN OTHERS THEN
        p_campo1 := 'gen_qapi_rest.sp_valida_fmto';
        p_campo2 := SUBSTR(SQLERRM, 1, 100);
        p_ty_msg.cod_msg := 'ER_NO_CTRL';--Error no controlado, {campo1}:  {campo2}.
        RETURN;
END sp_valida_fmto;
--Fin 1001 14/12/2023 cramirezs
---------------------------------------------------------------------------------------------------
END gen_qapi_rest;
/
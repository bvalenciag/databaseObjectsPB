--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       31/01/2024 Cramirezs    000001       * Se crea datos reporte bancolombia
--                       Kilonova
-- ========== ========== ============ ============ ============================================================================================================
--
/***************************************************************************************/
prompt
prompt Creando datos en TBL_TREPORSEBRA BANCOLOMBIA
prompt
--
DECLARE
    --
    v_banc          tbl_tbancos.banc_externo%TYPE       := 7;                         --Código de banco externo
    v_repo          tbl_treporsebra.repo_reporte%TYPE   := 'BANCOLOMBIA/BANCOLOMBIA'; --Nombre de reporte.
    v_tipo          tbl_treporsebra.repo_tipo%TYPE      := 'A';                       --I-Ingreso, E-Egreso, -A-Ambos
    v_ty_msg        gen_qgeneral.ty_msg;
    --
BEGIN
    --
    tbl_qreporsebra.sp_ins_upd_reporsebra(v_banc  
                                        , v_repo  
                                        , v_tipo  
                                        , v_ty_msg
                                        );
    --
    IF v_ty_msg.cod_msg <> 'OK' THEN
        --
        DBMS_OUTPUT.PUT_LINE('**** v_banc: '||v_banc
                               ||' v_repo: '||v_repo
                               ||' v_tipo: '||v_tipo
                               ||' Error: ' ||v_ty_msg.msg_msg
                               );
        --
    ELSE
        --
        DBMS_OUTPUT.PUT_LINE('Se creo v_banc: '||v_banc
                                  ||' v_repo: '||v_repo
                                  ||' v_tipo: '||v_tipo
                               );
        --
    END IF;
    --
END;
/
/***************************************************************************************/
prompt
prompt Creando datos en TBL_TREPORSEBRA BOGOTA
prompt
--
DECLARE
    --
    v_banc          tbl_tbancos.banc_externo%TYPE       := 1;                         --Código de banco externo
    v_repo          tbl_treporsebra.repo_reporte%TYPE   := 'BOGOTA/CartaBogota';      --Nombre de reporte.
    v_tipo          tbl_treporsebra.repo_tipo%TYPE      := 'A';                       --I-Ingreso, E-Egreso, -A-Ambos
    v_ty_msg        gen_qgeneral.ty_msg;
    --
BEGIN
    --
    tbl_qreporsebra.sp_ins_upd_reporsebra(v_banc  
                                        , v_repo  
                                        , v_tipo  
                                        , v_ty_msg
                                        );
    --
    IF v_ty_msg.cod_msg <> 'OK' THEN
        --
        DBMS_OUTPUT.PUT_LINE('**** v_banc: '||v_banc
                               ||' v_repo: '||v_repo
                               ||' v_tipo: '||v_tipo
                               ||' Error: ' ||v_ty_msg.msg_msg
                               );
        --
    ELSE
        --
        DBMS_OUTPUT.PUT_LINE('Se creo v_banc: '||v_banc
                                  ||' v_repo: '||v_repo
                                  ||' v_tipo: '||v_tipo
                               );
        --
    END IF;
    --
END;
/
/***************************************************************************************/
prompt
prompt Creando datos en TBL_TREPORSEBRA OCCIDENTE
prompt
--
DECLARE
    --
    v_banc          tbl_tbancos.banc_externo%TYPE       := 23;                         --Código de banco externo
    v_repo          tbl_treporsebra.repo_reporte%TYPE   := 'OCCIDENTE/OCCIDENTE';      --Nombre de reporte.
    v_tipo          tbl_treporsebra.repo_tipo%TYPE      := 'A';                        --I-Ingreso, E-Egreso, -A-Ambos
    v_ty_msg        gen_qgeneral.ty_msg;
    --
BEGIN
    --
    tbl_qreporsebra.sp_ins_upd_reporsebra(v_banc  
                                        , v_repo  
                                        , v_tipo  
                                        , v_ty_msg
                                        );
    --
    IF v_ty_msg.cod_msg <> 'OK' THEN
        --
        DBMS_OUTPUT.PUT_LINE('**** v_banc: '||v_banc
                               ||' v_repo: '||v_repo
                               ||' v_tipo: '||v_tipo
                               ||' Error: ' ||v_ty_msg.msg_msg
                               );
        --
    ELSE
        --
        DBMS_OUTPUT.PUT_LINE('Se creo v_banc: '||v_banc
                                  ||' v_repo: '||v_repo
                                  ||' v_tipo: '||v_tipo
                               );
        --
    END IF;
    --
END;
/
/***************************************************************************************/
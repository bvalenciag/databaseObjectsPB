prompt
prompt PACKAGE: TBL_QREPORSEBRA
prompt
CREATE OR REPLACE PACKAGE tbl_qreporsebra IS
--
-- Reúne funciones y procedimientos directamente relacionados con el procedimiento de generación reportes sebra
--
-- #VERSION: 1001
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       31/01/2024 Cramirezs    000001       * Se crea paquete.
--                       Kilonova
-- ========== ========== ============ ============ ============================================================================================================
-- 1001       22/03/2024 Jmartinezm   000002       * Se nueva funcion cuen_traslado_ingreso.
--                       Kilonova
-- ========== ========== ============ ============ ============================================================================================================
--
-------------------------------------------------------------------------------------------------
--Types
-------------------------------------------------------------------------------------------------
--
--
-------------------------------------------------------------------------------------------------
--Procedure - Function
-------------------------------------------------------------------------------------------------
--
PROCEDURE sp_ins_upd_reporsebra(p_banc          tbl_tbancos.banc_externo%TYPE
                              , p_repo          tbl_treporsebra.repo_reporte%TYPE
                              , p_tipo          tbl_treporsebra.repo_tipo%TYPE
                              , p_ty_msg    OUT gen_qgeneral.ty_msg
                                );
--
-------------------------------------------------------------------------------------------------
--
FUNCTION fn_name_report(p_tras      tbl_ttrasebra.tras_tras%TYPE
                       )RETURN tbl_treporsebra.repo_reporte%TYPE;
--
-------------------------------------------------------------------------------------------------
--
FUNCTION fn_numero_a_texto (p_valor NUMBER
                            )RETURN VARCHAR2;
--
-------------------------------------------------------------------------------------------------
--
FUNCTION fn_valor_variable(p_vari   tbl_tentidades.enti_vari%TYPE
                           )RETURN tbl_tentidades.enti_descripcion%TYPE;
--
-------------------------------------------------------------------------------------------------
-- ini  1001       22/03/2024 Jmartinezm
FUNCTION fn_cuen_traslado_ingreso(p_empr   tbl_tempresas.empr_empr%TYPE
                                , p_banc   tbl_tbancos.banc_banc%TYPE
                                , p_sigla  VARCHAR2
                                )RETURN tbl_tcuentasban.cuen_nrocta%TYPE;
-- fin  1001       22/03/2024 Jmartinezm
-------------------------------------------------------------------------------------------------
--
FUNCTION fn_genera_url(p_tras    tbl_ttrasebra.tras_tras%TYPE
                     , p_proc    VARCHAR2
                                )RETURN VARCHAR2;
END tbl_qreporsebra;
/
prompt
prompt PACKAGE BODY: tbl_qreporsebra
prompt
--
CREATE OR REPLACE PACKAGE BODY tbl_qreporsebra IS
--
-- #VERSION: 1001
--
---------------------------------------------------------------------------------------------------
PROCEDURE sp_ins_upd_reporsebra(p_banc          tbl_tbancos.banc_externo%TYPE
                              , p_repo          tbl_treporsebra.repo_reporte%TYPE
                              , p_tipo          tbl_treporsebra.repo_tipo%TYPE
                              , p_ty_msg    OUT gen_qgeneral.ty_msg
                                )IS
    PRAGMA AUTONOMOUS_TRANSACTION;
    --
    e_error      EXCEPTION;
    --
    CURSOR c_banc IS
        SELECT banc_banc
          FROM tbl_tbancos
         WHERE banc_externo = p_banc
           AND banc_fuente = gen_qgeneral.id_lista('TBL', 'FUEN_INFO', 'SF')
        ;
    --
    r_banc  c_banc%ROWTYPE;
    --
    CURSOR c_repo (pc_banc  tbl_treporsebra.repo_banc%TYPE)IS
        SELECT repo_repo
          FROM tbl_treporsebra
         WHERE repo_banc = pc_banc
           AND repo_tipo = UPPER(p_tipo)
        ;
    --
    r_repo  c_repo%ROWTYPE;
    --
BEGIN
    --
    p_ty_msg.cod_msg := 'OK';
    --
    IF UPPER(p_tipo) NOT IN ('I', 'E', 'A') THEN
        --
        p_ty_msg.msg_msg := 'Error, tipo reporte debe ser I-Ingreso, E-Egreso, A-Ambos.';
        raise e_error;
        --
    END IF;
    --
    OPEN  c_banc ;
    FETCH c_banc INTO r_banc;
    IF c_banc%NOTFOUND THEN
        CLOSE c_banc;
        p_ty_msg.msg_msg := 'Error, código de banco '|| p_banc ||', no existe.';
        raise e_error;
    END IF;
    CLOSE c_banc;
    --
    OPEN  c_repo (r_banc.banc_banc);
    FETCH c_repo INTO r_repo;
    IF c_repo%NOTFOUND THEN
        --
        INSERT INTO tbl_treporsebra (
              repo_banc                                      , repo_tipo   
            , repo_reporte                                   , repo_fecins 
            , repo_usuains
        )VALUES(
              r_banc.banc_banc                               , UPPER(p_tipo)
            , p_repo                                         , SYSDATE
            , USER
            );
        --
    ELSE
        --
        UPDATE tbl_treporsebra
           SET repo_tipo    = p_tipo
             , repo_reporte = p_repo
             , repo_fecupd  = SYSDATE
             , repo_usuaupd = USER
         WHERE repo_repo   = r_repo.repo_repo
        ;
        --
    END IF;
    CLOSE c_repo;
    --
    COMMIT;
    --
    p_ty_msg.msg_msg := 'Transaccion Exitosa';
    --
EXCEPTION
    WHEN e_error THEN
        p_ty_msg.cod_msg := 'ERROR';
    WHEN OTHERS THEN
        p_ty_msg.cod_msg := 'ORA'||ltrim(to_char(sqlcode, '000000'));
        p_ty_msg.msg_msg := 'tbl_qreporsebra.sp_ins_upd_reporsebra. '|| to_char(sysdate,'dd/mm/yyyy hh24miss')||'. Error: '||SQLERRM;
END sp_ins_upd_reporsebra;
---------------------------------------------------------------------------------------------------
FUNCTION fn_name_report(p_tras      tbl_ttrasebra.tras_tras%TYPE
                       )RETURN tbl_treporsebra.repo_reporte%TYPE IS
    --
    v_valor     tbl_treporsebra.repo_reporte%TYPE;
    --
    CURSOR c_tras IS
        SELECT list_sigla
             , tras_banc
          FROM tbl_ttrasebra
             , gen_tlistas
         WHERE tras_tipo_oper = list_list
           AND tras_tras      = p_tras
        ;
    --
    r_tras      c_tras%ROWTYPE;
    --
    CURSOR c_jrd(pc_banc   tbl_treporsebra.repo_banc%TYPE
               , pc_tipo   tbl_treporsebra.repo_tipo%TYPE
                )IS
        SELECT repo_reporte
          FROM tbl_treporsebra
         WHERE repo_banc = pc_banc
           AND DECODE(repo_tipo, 'A', pc_tipo, repo_tipo) = pc_tipo
        ;
    --
BEGIN
    --
    v_valor := NULL;
    --
    OPEN  c_tras;
    FETCH c_tras INTO r_tras;
    CLOSE c_tras;
    --
    OPEN  c_jrd (r_tras.tras_banc
               , r_tras.list_sigla
                );
    FETCH c_jrd INTO v_valor;
    CLOSE c_jrd;
    --
    RETURN v_valor;
    --
END fn_name_report;
---------------------------------------------------------------------------------------------------
FUNCTION fn_numero_a_texto (p_valor NUMBER
                            )RETURN VARCHAR2 IS
     --
     --  Funcion para convertir un valor a letras
     --
       XAL4      NUMBER;
       xal3      number;
       xal2      number;
       xal1      number;
       xal       number;
       Centavos  varchar2(300);
       Cen       number;
       Dec       number;
       Valor     number;
       Traduc    varchar2(300);
       Pesos     varchar2(20);
       Traducida varchar2(300);
       --
       --
BEGIN
    --
    Traducida :='';
    valor := nvl(abs(p_valor),0);
    xal4  := trunc(valor / 1000000000000);
    xal3  := trunc((valor - xal4 * 1000000000000)/ 1000000000);
    xal2  := trunc((valor - xal4 * 1000000000000 -xal3 * 1000000000)/1000000);
    xal1  := trunc((valor  - xal4 * 1000000000000 -xal3 *1000000000 - xal2 * 1000000)/1000);
    xal   := trunc((valor  - xal4 * 1000000000000 -xal3 * 1000000000 - xal2 * 1000000 - xal1 * 1000));
    --
    IF mod(Valor, 1000000) = 0 THEN
        --
        Pesos := ' De Pesos ';
        --
    ELSE
        --
        Pesos := ' Pesos ';
        --
    END IF;
    --
    IF valor <=999999999999999 THEN
        --
        -- Mas de Cien Mil millones
        --
        IF xal4 >0 THEN
            --
            IF xal4 = 100 THEN
                --
                Traducida := Traducida||' Cien ';
                --
            ELSE
                Cen := trunc((xal4)/100);
                Dec := xal4 - Cen * 100;
                --
                SELECT cent_letras INTO traduc 
                  FROM gen_tcentenas
                 WHERE cent_cent = cen
                ;
                --
                Traducida := Traducida||' '||ltrim(traduc)||' ';
                --
                SELECT dece_letras INTO traduc 
                  FROM gen_tdecenas
                 WHERE dece_dece = dec
                ;
                --
                Traducida := Traducida||' '||ltrim(traduc)||' ';
                --
            END IF;
            --
            IF xal4 >1 THEN
                --
                Traducida := Traducida||' billones ';
                --
            ELSE
                --
                Traducida := Traducida||' Billon ';
                --
            END IF;
            --
        END IF;
        --
        -- Mas de Mil millones
        --
        IF xal3 >0 THEN
            --
            IF xal3 = 100 THEN
                --
                Traducida := Traducida||' Cien ';
            ELSE
                --
                Cen := trunc((xal3)/100);
                Dec := xal3 - Cen * 100;
                --
                SELECT cent_letras INTO traduc 
                  FROM gen_tcentenas
                 WHERE cent_cent = cen
                ;
                --
                Traducida := Traducida||' '||ltrim(traduc)||' ';
                SELECT dece_letras INTO traduc 
                  FROM gen_tdecenas
                 WHERE dece_dece = dec
                ;
                --
                Traducida := Traducida||' '||ltrim(traduc)||' ';
                --
            END IF;
            --
            Traducida := Traducida||' Mil ';
            --
        END IF;
        --
        -- Mas de Un millon
        --
        IF xal2 > 0 THEN
            --
            IF xal2 = 100 THEN
                --
                Traducida := Traducida||' Cien ';
                --
            ELSE
                --
                Cen := trunc((xal2)/100);
                Dec := xal2 - Cen * 100;
                --
                SELECT cent_letras INTO traduc 
                  FROM gen_tcentenas
                 WHERE cent_cent = cen
                ;
                --
                Traducida := Traducida||' '||ltrim(traduc)||' ';
                SELECT dece_letras INTO traduc 
                  FROM gen_tdecenas
                 WHERE dece_dece = dec
                ;
                --
                Traducida := Traducida||' '||ltrim(traduc)||' ';
                --
            END IF;
            --
            IF xal2 >1 THEN
                --
                Traducida := Traducida||' Millones ';
                --
            ELSE
                --
                Traducida := Traducida||' Millon ';
                --
            END IF;
            --IF XAL1 =0 AND XAL =0 THEN
            --  Traducida := Traducida||' DE ';
            --END IF;
        ELSIF (xal3 > 0) THEN
            --
            Traducida := Traducida || ' Millones ';
            --
        END IF;
        --
        -- fin de mas de UN million
        --
        IF XAL1 >0 THEN
            --
            IF xal1 = 100 THEN
                --
                Traducida := Traducida||' Cien ';
                --
            ELSE
                --
                Cen := trunc((xal1)/100);
                Dec := xal1 - Cen * 100;
                SELECT cent_letras INTO traduc 
                  FROM gen_tcentenas
                 WHERE cent_cent = cen
                ;
                --
                Traducida := Traducida||' '||ltrim(traduc)||' ';
                --
                SELECT dece_letras into traduc 
                  FROM gen_tdecenas
                 WHERE dece_dece = dec
                ;
                --
                Traducida := Traducida||' '||ltrim(traduc)||' ';
                --
            END IF;
            --
            Traducida := Traducida||' Mil ';
            --
        END IF;
        --
        -- fin de xal1 > 0
        --
        IF XAL >0 THEN
            --
            IF xal = 100 THEN
                --
                Traducida := Traducida||' Cien ';
            ELSE
                --
                Cen := trunc((xal)/100);
                Dec := xal - Cen * 100;
                SELECT cent_letras INTO traduc 
                  FROM gen_tcentenas
                 WHERE cent_cent = cen
                ;
                --
                Traducida := Traducida||' '||ltrim(traduc)||' ';
                SELECT dece_letras into traduc 
                  FROM gen_tdecenas
                 WHERE dece_dece = dec
                ;
                --
                Traducida := Traducida||' '||ltrim(traduc)||' ';
                --
            END IF;
            --
        END IF;
        --
        -- fin de xal > 0
        --
        --  * else
        --  *valores de cero y uno
        IF valor = 0  THEN
            --
            Traducida := ' Cero Pesos ';
            --
        ELSIF valor = 1 THEN
            --
            Traducida := ' un Peso ';
            --
        ELSE
            --
            Traducida := Traducida || Pesos;
            --
        END IF;
        --
    END IF;
    -- Centavos
    Centavos := to_char((Valor-trunc(valor))*100);
    --
    IF TO_NUMBER(Centavos) > 0 THEN
        --
        Traducida := Traducida||' Con '||Centavos||'/100';
        --
    END IF;
    --
    Traducida := ltrim(rtrim(Traducida))||' Mcte';
    --  Traducida := substr(Traducida||texto,1,255);
    LOOP
        --
        Traducida := replace(Traducida, '  ', ' ');
        --
        IF instr(Traducida, '  ')=0 THEN
            --
            EXIT;
            --
        END IF;
        --
    END LOOP;
    --
    RETURN (Traducida);
    --
END fn_numero_a_texto;
---------------------------------------------------------------------------------------------------
FUNCTION fn_valor_variable(p_vari   tbl_tentidades.enti_vari%TYPE
                           )RETURN tbl_tentidades.enti_descripcion%TYPE IS
    --
    v_valor     tbl_tentidades.enti_descripcion%TYPE;
    --
    CURSOR c_enti IS
        SELECT enti_descripcion
          FROM tbl_tentidades
         WHERE enti_vari = p_vari
        ; 
    --
BEGIN
    --
    v_valor := NULL;
    --
    OPEN  c_enti;
    FETCH c_enti INTO v_valor;
    CLOSE c_enti;
    --
    RETURN v_valor;
    --
END fn_valor_variable;
---------------------------------------------------------------------------------------------------
-- ini 1001       22/03/2024 Jmartinezm
FUNCTION fn_cuen_traslado_ingreso(p_empr   tbl_tempresas.empr_empr%TYPE
                                , p_banc   tbl_tbancos.banc_banc%TYPE
                                , p_sigla  VARCHAR2
                                )RETURN tbl_tcuentasban.cuen_nrocta%TYPE IS
    --
    v_valor     tbl_tcuentasban.cuen_nrocta%TYPE;
    --
    CURSOR c_cuen(p_descri VARCHAR2) IS
        SELECT cuen_nrocta
          FROM tbl_vcuentasbantras
         WHERE empr_empr = p_empr
         AND banc_banc = p_banc
         AND list_descri = DECODE(p_descri,'E', 'Egreso', 'I', 'Ingreso')
        ; 
    --
BEGIN
    --
    v_valor := NULL;
    --
    OPEN  c_cuen (p_sigla);
    FETCH c_cuen INTO v_valor;
    CLOSE c_cuen;
    --
    RETURN v_valor;
    --
END fn_cuen_traslado_ingreso;
-- fin 1001       22/03/2024 Jmartinezm
---------------------------------------------------------------------------------------------------
--
FUNCTION fn_genera_url(p_tras    tbl_ttrasebra.tras_tras%TYPE
                     , p_proc    VARCHAR2
                                )RETURN VARCHAR2 IS
    --
    v_report_url  gen_tparametros.para_valor%TYPE;
    v_data_sourc  gen_tparametros.para_valor%TYPE;
    v_encoding    gen_tparametros.para_valor%TYPE;
    v_modu        gen_tparametros.para_modu%TYPE;
    v_file_name   VARCHAR2(200);
    v_cod_banc    NUMBER;
    v_docs_blob   BLOB;
    v_docs_mime   VARCHAR2(1000);
    v_url         VARCHAR2(500);
    v_rep_name    VARCHAR2(100);
    v_params      VARCHAR2(100);
    v_api_view    VARCHAR2(100);  
    --
    CURSOR c_banc IS
        SELECT TRAS_BANC 
          FROM TBL_VTRASEBRA
         WHERE TRAS_TRAS = p_tras
        ;
    --
BEGIN
    --
    IF p_proc = 'S' THEN --Sebra
        --
        OPEN  c_banc ;
        FETCH c_banc INTO v_cod_banc;
        CLOSE c_banc;
        --
        v_file_name  := 'TRAS_SEBRA_'||p_tras||'_BANCO_'||v_cod_banc||'.pdf';
        v_rep_name   := tbl_qreporsebra.fn_name_report(p_tras);
        v_params     := 'P_TRAS='||p_tras;
        --
    END IF;
    --
    v_modu       := gen_qgeneral.id_lista('GEN', 'MODU_EDGE', 'GEN');
    v_report_url := gen_qgeneral.recupera_parametro(v_modu, 'JASP_REPORT_URL');
    v_data_sourc := gen_qgeneral.recupera_parametro(v_modu, 'JASP_DATA_SOURC');
    v_encoding   := gen_qgeneral.recupera_parametro(v_modu, 'JASP_REP_ENCODI');
    v_api_view   := gen_qgeneral.recupera_parametro(v_modu, 'JASP_APIVIEWPDF');
    --
    xlog ('show report', 'url (orig):' || v_report_url);
    --
    xlib_jasperreports.set_report_url(v_report_url);
    --
    xlib_jasperreports.get_report (
        p_rep_name           => v_rep_name,
        p_rep_format         => 'pdf',
        p_data_source        => v_data_sourc,
        p_rep_locale         => 'de_DE',
        p_rep_encoding       => v_encoding,
        p_additional_params  => v_params,
        p_out_blob           => v_docs_blob,
        p_out_mime_type      => v_docs_mime
    );
    --
    EXECUTE IMMEDIATE 'TRUNCATE TABLE TBL_TDOCS';
    --
    INSERT INTO TBL_TDOCS (DOCS_NAME, DOCS_FILE, DOCS_MIME) VALUES (v_file_name, v_docs_blob, v_docs_mime);
    --
    COMMIT;
    --
    v_url := v_api_view || v_file_name;
    --
    RETURN v_url;
EXCEPTION
    WHEN OTHERS THEN
        xlog('show report', substr(dbms_utility.format_error_backtrace, 1, 3500), 'ERROR');
        RETURN NULL;                        
END fn_genera_url;
--
---------------------------------------------------------------------------------------------------
--
END tbl_qreporsebra;
/

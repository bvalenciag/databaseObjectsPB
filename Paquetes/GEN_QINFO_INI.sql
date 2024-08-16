prompt
prompt PACKAGE: GEN_QINFO_INI
prompt
CREATE OR REPLACE PACKAGE gen_qinfo_ini IS
--
-- Reúne funciones y procedimientos directamente relacionados con el procedimiento de información inicial
--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       14/02/2024 Cramirezs    000001       * Se crea paquete.
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
PROCEDURE sp_info_basi;
--
-------------------------------------------------------------------------------------------------
--
END gen_qinfo_ini;
/
prompt
prompt PACKAGE BODY: gen_qinfo_ini
prompt
--
CREATE OR REPLACE PACKAGE BODY gen_qinfo_ini IS
--
-- #VERSION: 1000
--
---------------------------------------------------------------------------------------------------
PROCEDURE sp_info_basi IS
    --
    e_error      EXCEPTION;
    --
    v_modu      gen_tlistas.list_list%TYPE;
    v_dato      gen_tlistas.list_list%TYPE;
    --
    v_ty_msg    gen_qgeneral.ty_msg;
    --
BEGIN
    --
    v_ty_msg.cod_msg := 'OK';
    v_modu := gen_qgeneral.id_lista('GEN', 'MODU_EDGE', 'TBL'); --Tablero
    v_dato := gen_qgeneral.id_lista('GEN', 'TIPO_DATO', 'A');   --Alfanumerico
    --
    gen_qparametros.sp_ins_gen_tparametros(v_modu, 'FECH_CONS_MOVI', 'Fecha para sincronización de movimientos en servicios API, NA ejecuta el SYSDATE.', v_dato, 'NA', 'N');
    --Inicio parametrización weblogic reportes Jasper
    v_modu := gen_qgeneral.id_lista('GEN', 'MODU_EDGE', 'GEN'); --General
    gen_qparametros.sp_ins_gen_tparametros(v_modu, 'JASP_REPORT_URL', 'Ruta Weblogic que contiene el jri de JASPER.', v_dato, 'http://172.31.0.52:7001/jri/report', 'N');
    gen_qparametros.sp_ins_gen_tparametros(v_modu, 'JASP_DATA_SOURC', 'Nombre Data source parametrizado en el weblogic que contiene el jri de JASPER.', v_dato, 'JaspertRecaudoDS', 'N');
    gen_qparametros.sp_ins_gen_tparametros(v_modu, 'JASP_REP_ENCODI', 'Encoding para la generación de reportes JASPER.', v_dato, 'UTF-8', 'N');
    gen_qparametros.sp_ins_gen_tparametros(v_modu, 'JASP_APIVIEWPDF', 'Ruta API creada para mostrar PDF con nombre dinámico.', v_dato, 'http://172.31.0.52:7001/recaudo/recaudo/viewdoc/document/', 'N');
    --Fin parametrización weblogic reportes Jasper
    --
    --Inicio parametrización reportes cartas
    --Carta BANCOLOMBIA tipo Ambos aplica para Ingreso y Egreso
    tbl_qreporsebra.sp_ins_upd_reporsebra(7, 'Cartas/CartaBancolombia', 'A', v_ty_msg);
    --
    IF v_ty_msg.cod_msg <> 'OK' THEN
        --
        raise_application_error( -20001, 'Error insertando banco 7 v_repo: Cartas/CartaBancolombia v_tipo: A Error: ' ||v_ty_msg.msg_msg);
        --
    END IF;
    --Carta BOGOTA tipo Ambos aplica para Ingreso y Egreso
    tbl_qreporsebra.sp_ins_upd_reporsebra(1, 'Cartas/CartaBogota', 'A', v_ty_msg);
    --
    IF v_ty_msg.cod_msg <> 'OK' THEN
        --
        raise_application_error( -20001, 'Error insertando banco 1 v_repo: Cartas/CartaBogota v_tipo: A Error: ' ||v_ty_msg.msg_msg);
        --
    END IF;
    --Carta OCCIDENTE tipo Ambos aplica para Ingreso y Egreso
    tbl_qreporsebra.sp_ins_upd_reporsebra(23, 'Cartas/CartaOccidente', 'A', v_ty_msg);
    --
    IF v_ty_msg.cod_msg <> 'OK' THEN
        --
        raise_application_error( -20001, 'Error insertando banco 23 v_repo: Cartas/OCCIDENTE v_tipo: A Error: ' ||v_ty_msg.msg_msg);
        --
    END IF;
    --Carta POPULAR tipo Ambos aplica para Ingreso y Egreso
    tbl_qreporsebra.sp_ins_upd_reporsebra(2, 'Cartas/CartaPopular', 'A', v_ty_msg);
    --
    IF v_ty_msg.cod_msg <> 'OK' THEN
        --
        raise_application_error( -20001, 'Error insertando banco 2 v_repo: Cartas/CartaPopular v_tipo: A Error: ' ||v_ty_msg.msg_msg);
        --
    END IF;
    --Carta COLPATRIA tipo Ambos aplica para Ingreso y Egreso
    tbl_qreporsebra.sp_ins_upd_reporsebra(19, 'Cartas/CartaColpatria', 'A', v_ty_msg);
    --
    IF v_ty_msg.cod_msg <> 'OK' THEN
        --
        raise_application_error( -20001, 'Error insertando banco 19 v_repo: Cartas/CartaColpatria v_tipo: A Error: ' ||v_ty_msg.msg_msg);
        --
    END IF;
    --Carta Agraria tipo Ingreso
    tbl_qreporsebra.sp_ins_upd_reporsebra(40, 'Cartas/CartaAgrarioAdicion', 'I', v_ty_msg);
    --
    IF v_ty_msg.cod_msg <> 'OK' THEN
        --
        raise_application_error( -20001, 'Error insertando banco 40 v_repo: Cartas/CartaAgrarioAdicion v_tipo: I Error: ' ||v_ty_msg.msg_msg);
        --
    END IF;
    --Carta Agraria tipo Egreso
    tbl_qreporsebra.sp_ins_upd_reporsebra(40, 'Cartas/CartaAgrarioRetiro', 'E', v_ty_msg);
    --
    IF v_ty_msg.cod_msg <> 'OK' THEN
        --
        raise_application_error( -20001, 'Error insertando banco 40 v_repo: Cartas/CartaAgrarioRetiro v_tipo: E Error: ' ||v_ty_msg.msg_msg);
        --
    END IF;
    --
    --Carta Serfinanza Ambos aplica para Ingreso y Egreso
    tbl_qreporsebra.sp_ins_upd_reporsebra(69, 'Cartas/CartaSerfinanza', 'A', v_ty_msg);
    --
    IF v_ty_msg.cod_msg <> 'OK' THEN
        --
        raise_application_error( -20001, 'Error insertando banco 69 v_repo: Cartas/CartaSerfinanza v_tipo: A Error: ' ||v_ty_msg.msg_msg);
        --
    END IF;
    --
    --Carta Helm Ambos aplica para Ingreso y Egreso
    tbl_qreporsebra.sp_ins_upd_reporsebra(523, 'Cartas/CartaHelm', 'A', v_ty_msg);
    --
    IF v_ty_msg.cod_msg <> 'OK' THEN
        --
        raise_application_error( -20001, 'Error insertando banco 14 v_repo: Cartas/CartaHelm v_tipo: A Error: ' ||v_ty_msg.msg_msg);
        --
    END IF;
    --
    --Carta Coop Central Ambos aplica para Ingreso y Egreso
    tbl_qreporsebra.sp_ins_upd_reporsebra(66, 'Cartas/CartaCoopCentral', 'A', v_ty_msg);
    --
    IF v_ty_msg.cod_msg <> 'OK' THEN
        --
        raise_application_error( -20001, 'Error insertando banco 66 v_repo: Cartas/CartaCoopCentral v_tipo: A Error: ' ||v_ty_msg.msg_msg);
        --
    END IF;
    --
    --Carta WWB Ambos aplica para Ingreso y Egreso
    tbl_qreporsebra.sp_ins_upd_reporsebra(53, 'Cartas/CartaWWB', 'A', v_ty_msg);
    --
    IF v_ty_msg.cod_msg <> 'OK' THEN
        --
        raise_application_error( -20001, 'Error insertando banco 53 v_repo: Cartas/CartaWWB v_tipo: A Error: ' ||v_ty_msg.msg_msg);
        --
    END IF;
    --
    --Carta Confiar Ambos aplica para Ingreso y Egreso
    tbl_qreporsebra.sp_ins_upd_reporsebra(292, 'Cartas/CartaConfiar', 'A', v_ty_msg);
    --
    IF v_ty_msg.cod_msg <> 'OK' THEN
        --
        raise_application_error( -20001, 'Error insertando banco 292 v_repo: Cartas/CartaConfiar v_tipo: A Error: ' ||v_ty_msg.msg_msg);
        --
    END IF;    
    --
    --Carta Multibank Ambos aplica para Ingreso y Egreso
    tbl_qreporsebra.sp_ins_upd_reporsebra(64, 'Cartas/CartaMultibank', 'A', v_ty_msg);
    --
    IF v_ty_msg.cod_msg <> 'OK' THEN
        --
        raise_application_error( -20001, 'Error insertando banco 64 v_repo: Cartas/CartaMultibank v_tipo: A Error: ' ||v_ty_msg.msg_msg);
        --
    END IF;   
    --
    --Carta Corfidiario Ambos aplica para Ingreso y Egreso
    tbl_qreporsebra.sp_ins_upd_reporsebra(211, 'Cartas/CartaCorfidiario', 'A', v_ty_msg);
    --
    IF v_ty_msg.cod_msg <> 'OK' THEN
        --
        raise_application_error( -20001, 'Error insertando banco 211 v_repo: Cartas/CartaCorfidiario v_tipo: A Error: ' ||v_ty_msg.msg_msg);
        --
    END IF;     
    --
    --Carta Mi Banco Ambos aplica para Ingreso y Egreso
    tbl_qreporsebra.sp_ins_upd_reporsebra(45, 'Cartas/CartaMibanco', 'A', v_ty_msg);
    --
    IF v_ty_msg.cod_msg <> 'OK' THEN
        --
        raise_application_error( -20001, 'Error insertando banco 45 v_repo: Cartas/CartaMibanco v_tipo: A Error: ' ||v_ty_msg.msg_msg);
        --
    END IF;  
    --
    --Carta Santander Ambos aplica para Ingreso y Egreso
    tbl_qreporsebra.sp_ins_upd_reporsebra(65, 'Cartas/CartaSantander', 'A', v_ty_msg);
    --
    IF v_ty_msg.cod_msg <> 'OK' THEN
        --
        raise_application_error( -20001, 'Error insertando banco 65 v_repo: Cartas/CartaSantander v_tipo: A Error: ' ||v_ty_msg.msg_msg);
        --
    END IF;   
    --
    --Carta Coomeva Ambos aplica para Ingreso y Egreso
    tbl_qreporsebra.sp_ins_upd_reporsebra(61, 'Cartas/CartaBancoomeva', 'A', v_ty_msg);
    --
    IF v_ty_msg.cod_msg <> 'OK' THEN
        --
        raise_application_error( -20001, 'Error insertando banco 61 v_repo: Cartas/CartaBancoomeva v_tipo: A Error: ' ||v_ty_msg.msg_msg);
        --
    END IF; 
    --
    --Carta Banco caja social Ambos aplica para Ingreso y Egreso
    tbl_qreporsebra.sp_ins_upd_reporsebra(32, 'Cartas/CartaBCSC', 'A', v_ty_msg);
    --
    IF v_ty_msg.cod_msg <> 'OK' THEN
        --
        raise_application_error( -20001, 'Error insertando banco 32 v_repo: Cartas/CartaBCSC v_tipo: A Error: ' ||v_ty_msg.msg_msg);
        --
    END IF;    
    --Carta AvVillas Ambos aplica para Ingreso y Egreso
    tbl_qreporsebra.sp_ins_upd_reporsebra(52, 'Cartas/CartaAvvillas', 'A', v_ty_msg);
    --
    IF v_ty_msg.cod_msg <> 'OK' THEN
        --
        raise_application_error( -20001, 'Error insertando banco 52 v_repo: Cartas/CartaAvvillas v_tipo: A Error: ' ||v_ty_msg.msg_msg);
        --
    END IF;                   
    --
    --Carta Falabella Ambos aplica para Ingreso y Egreso
    tbl_qreporsebra.sp_ins_upd_reporsebra(62, 'Cartas/CartaFalabella', 'A', v_ty_msg);
    --
    IF v_ty_msg.cod_msg <> 'OK' THEN
        --
        raise_application_error( -20001, 'Error insertando banco 62 v_repo: Cartas/CartaFalabella v_tipo: A Error: ' ||v_ty_msg.msg_msg);
        --
    END IF;   
    --Carta BBVA Ambos aplica para Ingreso y Egreso
    tbl_qreporsebra.sp_ins_upd_reporsebra(13, 'Cartas/CartaBbva', 'A', v_ty_msg);
    --
    IF v_ty_msg.cod_msg <> 'OK' THEN
        --
        raise_application_error( -20001, 'Error insertando banco 13 v_repo: Cartas/CartaBbva v_tipo: A Error: ' ||v_ty_msg.msg_msg);
        --
    END IF;            
    --Carta Pichincha Ambos aplica para Ingreso y Egreso
    tbl_qreporsebra.sp_ins_upd_reporsebra(60, 'Cartas/CartaPich', 'A', v_ty_msg);
    --
    IF v_ty_msg.cod_msg <> 'OK' THEN
        --
        raise_application_error( -20001, 'Error insertando banco 60 v_repo: Cartas/CartaPich v_tipo: A Error: ' ||v_ty_msg.msg_msg);
        --
    END IF; 
    --Carta Giros Ambos aplica para Ingreso y Egreso
    tbl_qreporsebra.sp_ins_upd_reporsebra(408, 'Cartas/CartaGiros', 'A', v_ty_msg);
    --
    IF v_ty_msg.cod_msg <> 'OK' THEN
        --
        raise_application_error( -20001, 'Error insertando banco 408 v_repo: Cartas/CartaGiros v_tipo: A Error: ' ||v_ty_msg.msg_msg);
        --
    END IF;     
    --Carta Sudameris Ambos aplica para Ingreso y Egreso
    tbl_qreporsebra.sp_ins_upd_reporsebra(12, 'Cartas/CartaSudameris', 'A', v_ty_msg);
    --
    IF v_ty_msg.cod_msg <> 'OK' THEN
        --
        raise_application_error( -20001, 'Error insertando banco 12 v_repo: Cartas/CartaSudameris v_tipo: A Error: ' ||v_ty_msg.msg_msg);
        --
    END IF;   
    --Carta Davivienda Ambos aplica para Ingreso y Egreso
    tbl_qreporsebra.sp_ins_upd_reporsebra(51, 'Cartas/CartaDavivienda', 'A', v_ty_msg);
    --
    IF v_ty_msg.cod_msg <> 'OK' THEN
        --
        raise_application_error( -20001, 'Error insertando banco 51 v_repo: Cartas/CartaDavivienda v_tipo: A Error: ' ||v_ty_msg.msg_msg);
        --
    END IF;        
    --Fin parametrización reportes cartas
    --    
EXCEPTION
    WHEN OTHERS THEN
        raise_application_error( -20001, 'Error en NC sp_info_basi: '||sqlerrm);
END sp_info_basi;
---------------------------------------------------------------------------------------------------
--
END gen_qinfo_ini;
/
--
Execute gen_qinfo_ini.sp_info_basi;
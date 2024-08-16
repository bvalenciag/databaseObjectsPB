set serveroutput on size unlimited
--
DECLARE
    p_traslado                   NUMBER := 1;           --Número de traslado
    p_tipo_tra                   VARCHAR2(2) := 'CR';   --DB-Debito, CR-Credito
    p_tbl_banc_nego              SYS_REFCURSOR;
    p_tbl_banc_reci              SYS_REFCURSOR;
    p_tbl_banc_envi              SYS_REFCURSOR;
    p_tbl_banc_comi              SYS_REFCURSOR;
    --
    TYPE ty_rec_nego IS RECORD
    (
          ciudad                VARCHAR2(100)       --Descripción de la ciudad
        , ano                   NUMBER(4)           --Ano YYYY
        , mes                   NUMBER(2)           --Mes MM
        , dia                   NUMBER(2)           --Dia DD
        , razon                 VARCHAR2(100)       --Nombre o razón social
        , tipo_docu             VARCHAR(3)          --Tipo de documento CC, NIT, CE, PB 
        , identif               VARCHAR2(20)        --Número de identificación
        , dv                    NUMBER(2)           --Digito de verificación
        , Observ                VARCHAR2(200)       --Observación
    );
    --
    v_rec_nego   ty_rec_nego;
    --
    TYPE ty_rec_reci IS RECORD
    (
            entidad               VARCHAR2(100)       --Entidad financiera/empresa
          , cuen_depo             NUMBER(8)           --Cuenta de deposito
          , portafolio            VARCHAR2(3)         --Portafolio Número
          , valor                 NUMBER(22,2)        --Valor
          , fecha_ing             VARCHAR2(10)        --Fecha de ingreso de los fondos
          , tipo_cuen             VARCHAR2(3)         --Tipo de cuenta, CR-Corriente, CA-Ahorros
          , num_cuen              VARCHAR2(11)        --Número de cuenta
    );
    --
    v_rec_reci   ty_rec_reci;
    --
    TYPE ty_rec_envi IS RECORD
    (
            tipo_cuen             VARCHAR2(3)         --Tipo de cuenta, CR-Corriente, CA-Ahorros
          , num_cuen              VARCHAR2(11)        --Número de cuenta    
          , entidad               VARCHAR2(100)       --Entidad financiera/empresa
          , valor                 NUMBER(22,2)        --Valor
          , cuen_depo             NUMBER(8)           --Cuenta de deposito
          , portafolio            VARCHAR2(3)         --Portafolio Número 
    );
    --
    v_rec_envi   ty_rec_envi;
    --
    TYPE ty_rec_comi IS RECORD
    (
          tipo_cuen             VARCHAR2(3)         --Tipo de cuenta, CR-Corriente, CA-Ahorros
        , num_cuen              VARCHAR2(11)        --Número de cuenta    
    );
    --
    v_rec_comi   ty_rec_comi;
    --
BEGIN
    --
    tbl_qvpl_banc.sp_sebra_banc(
                                  p_traslado    
                                , p_tipo_tra        
                                , p_tbl_banc_nego
                                , p_tbl_banc_reci
                                , p_tbl_banc_envi
                                , p_tbl_banc_comi
                                );
    --
    DBMS_OUTPUT.PUT_LINE('************nego************');
    --  
    LOOP
        FETCH p_tbl_banc_nego INTO v_rec_nego;
        EXIT  WHEN  p_tbl_banc_nego%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE('ciudad    = '||v_rec_nego.ciudad);
        DBMS_OUTPUT.PUT_LINE('ano       = '||v_rec_nego.ano);
        DBMS_OUTPUT.PUT_LINE('mes       = '||v_rec_nego.mes);
        DBMS_OUTPUT.PUT_LINE('dia       = '||v_rec_nego.dia);
        DBMS_OUTPUT.PUT_LINE('razon     = '||v_rec_nego.razon);
        DBMS_OUTPUT.PUT_LINE('tipo_docu = '||v_rec_nego.tipo_docu);
        DBMS_OUTPUT.PUT_LINE('identif   = '||v_rec_nego.identif);
        DBMS_OUTPUT.PUT_LINE('dv        = '||v_rec_nego.dv);
        DBMS_OUTPUT.PUT_LINE('Observ    = '||v_rec_nego.Observ);
    END LOOP;
    CLOSE    p_tbl_banc_nego;
    --
    DBMS_OUTPUT.PUT_LINE(' ');
    DBMS_OUTPUT.PUT_LINE('*************Reci*************');
    --
    LOOP
        FETCH p_tbl_banc_reci INTO v_rec_reci;
        EXIT  WHEN  p_tbl_banc_reci%NOTFOUND;
        --
        DBMS_OUTPUT.PUT_LINE('entidad    = '||v_rec_reci.entidad   );
        DBMS_OUTPUT.PUT_LINE('cuen_depo  = '||v_rec_reci.cuen_depo );
        DBMS_OUTPUT.PUT_LINE('portafolio = '||v_rec_reci.portafolio);
        DBMS_OUTPUT.PUT_LINE('valor      = '||v_rec_reci.valor     );
        DBMS_OUTPUT.PUT_LINE('fecha_ing  = '||v_rec_reci.fecha_ing );
        DBMS_OUTPUT.PUT_LINE('tipo_cuen  = '||v_rec_reci.tipo_cuen );
        DBMS_OUTPUT.PUT_LINE('num_cuen   = '||v_rec_reci.num_cuen  );
    END LOOP; 
    CLOSE    p_tbl_banc_reci;
    DBMS_OUTPUT.PUT_LINE(' ');
    DBMS_OUTPUT.PUT_LINE('*************Envi*************');
    LOOP
        FETCH p_tbl_banc_envi INTO v_rec_envi;
        EXIT  WHEN  p_tbl_banc_envi%NOTFOUND;
        --
        DBMS_OUTPUT.PUT_LINE('tipo_cuen  = '||v_rec_envi.tipo_cuen );
        DBMS_OUTPUT.PUT_LINE('num_cuen   = '||v_rec_envi.num_cuen  );
        DBMS_OUTPUT.PUT_LINE('entidad    = '||v_rec_envi.entidad   );
        DBMS_OUTPUT.PUT_LINE('valor      = '||v_rec_envi.valor     );
        DBMS_OUTPUT.PUT_LINE('cuen_depo  = '||v_rec_envi.cuen_depo );
        DBMS_OUTPUT.PUT_LINE('portafolio = '||v_rec_envi.portafolio);
    END LOOP;
    CLOSE    p_tbl_banc_envi;
    --
    DBMS_OUTPUT.PUT_LINE(' ');
    DBMS_OUTPUT.PUT_LINE('*************Comi*************');
    LOOP
        FETCH p_tbl_banc_comi INTO v_rec_comi;
        EXIT  WHEN  p_tbl_banc_comi%NOTFOUND;
        --
        DBMS_OUTPUT.PUT_LINE('tipo_cuen = ' ||v_rec_comi.tipo_cuen);
        DBMS_OUTPUT.PUT_LINE('num_cuen  = ' ||v_rec_comi.num_cuen );
    END LOOP;
    CLOSE    p_tbl_banc_comi;
    --
rollback; 
END;

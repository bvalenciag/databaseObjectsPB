prompt
prompt PACKAGE: GEN_QGENERAL
prompt
create or replace PACKAGE gen_qgeneral IS
--
-- Reúne funciones y procedimientos directamente relacionados con procedimientos generales
--
-- #VERSION: 1003
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 0.1       10/10/2023  CRAMIREZ      000001       * Se crea paquete.
-- 0.2       24/11/2023  MZABALA       000001       * Se crea las funciones fn_encrypt y fn_decrypt para encryptación de passwords.
-- ========== ========== ============ ============ ============================================================================================================
-- 1003       09/01/2024 cramirezs    000001       * Se crean funciones fn_es_habil, fn_ste_habil, fn_ant_habil para validar la fecha.
--                       Kilonova     MVP_2
-- ========== ========== ============ ============ ============================================================================================================
--
g_key           RAW(32767)  := UTL_RAW.cast_to_raw('12345678');
g_pad_chr       VARCHAR2(1) := '~';
--
-------------------------------------------------------------------------------------------------
--Types
-------------------------------------------------------------------------------------------------
--
--Control de mensajes a retornar.
TYPE ty_msg IS RECORD (
      cod_msg   gen_tmensajes.mens_mens%TYPE
    , msg_msg   gen_tmensajes.mens_descripcion%TYPE
);
--
TYPE ty_msgs IS TABLE OF ty_msg;
--

 TYPE ty_number IS RECORD(
          num_val number
          );


 TYPE ty_number_data IS TABLE OF ty_number INDEX BY BINARY_INTEGER;

    vg_ty_number_data ty_number_data;

    TYPE t_data_number IS TABLE OF ty_number;

-------------------------------------------------------------------------------------------------
--Procedure - Function
-------------------------------------------------------------------------------------------------
--
--
FUNCTION FN_FILL_STRING_TO_TABLE (iv_string in varchar2, iv_delim char) RETURN BOOLEAN;
--
FUNCTION FN_GET_STRING_TO_TABLE (iv_string in varchar2, iv_delim char) RETURN t_data_number PIPELINED;

-------------------------------------------------------------------------------------------------
FUNCTION ldap( p_username  IN VARCHAR2
             , p_password  IN VARCHAR2
              )RETURN BOOLEAN;
--
-------------------------------------------------------------------------------------------------
FUNCTION p_secu(p_secuencia   IN     VARCHAR2
              , p_mensaje     OUT    VARCHAR2
                )RETURN NUMBER;
-------------------------------------------------------------------------------------------------
FUNCTION id_lista( p_modulo gen_tlistas.list_modulo%TYPE
                 , p_lista  gen_tlistas.list_lista%TYPE
                 , p_sigla  gen_tlistas.list_sigla%TYPE
                )RETURN gen_tlistas.list_list%TYPE;
-------------------------------------------------------------------------------------------------
FUNCTION id_estado( p_modulo gen_testados.esta_modulo %TYPE
                  , p_lista  gen_testados.esta_lista  %TYPE
                  , p_sigla  gen_testados.esta_sigla  %TYPE
                    )RETURN gen_testados.esta_esta%TYPE;
-------------------------------------------------------------------------------------------------
FUNCTION id_lista_desc( p_list   gen_tlistas.list_list %TYPE
                )RETURN gen_tlistas.list_descri%TYPE;
-------------------------------------------------------------------------------------------------
FUNCTION desc_empr( p_empr  tbl_tempresas.empr_empr%TYPE
                      )RETURN tbl_tempresas.empr_descripcion%TYPE;
-------------------------------------------------------------------------------------------------
FUNCTION desc_banc( p_banc  tbl_tbancos.banc_banc%TYPE
                      )RETURN tbl_tbancos.banc_descripcion%TYPE;
-------------------------------------------------------------------------------------------------
FUNCTION desc_esta( p_esta  gen_testados.esta_esta%TYPE
                      )RETURN gen_testados.esta_descri%TYPE;
-------------------------------------------------------------------------------------------------                      
FUNCTION recupera_parametro( p_modu         gen_tparametros.para_modu%TYPE
                           , p_siglas       gen_tparametros.para_siglas%TYPE
                           )RETURN gen_tparametros.para_valor%TYPE;
-------------------------------------------------------------------------------------------------                      
function fn_encrypt(v_string varchar2) return raw deterministic;
------------------------------------------------------------------------------------------------- 
function fn_decrypt(v_string raw) return varchar2 deterministic;
--
--Ini 1003 09/01/2024 cramirezs
----------------------------------------------------------------------------------------------------
FUNCTION fn_es_habil (p_fech DATE
                     ) RETURN VARCHAR2;
----------------------------------------------------------------------------------------------------
FUNCTION fn_ste_habil (p_fech DATE 
                        ) RETURN DATE;
----------------------------------------------------------------------------------------------------
FUNCTION fn_ant_habil ( p_fech DATE
                        ) RETURN DATE;
---------------------------------------------------------------------------------------------------
--Fin 1003 09/01/2024 cramirezs
--
END gen_qgeneral;
/
--
prompt
prompt PACKAGE BODY: gen_qgeneral
prompt
--
create or replace PACKAGE BODY gen_qgeneral IS
--
-- #VERSION: 1003
--
--Variables globale del paquete
encryption_type PLS_INTEGER := SYS.DBMS_CRYPTO.ENCRYPT_AES
         + SYS.DBMS_CRYPTO.CHAIN_CBC
         + SYS.DBMS_CRYPTO.PAD_PKCS5;

encryption_key RAW(24):='FCF50295B0A28167FF88218A2EF8575102A20874305C8F2A';
---------------------------------------------------------------------------------------------------
FUNCTION ldap( p_username  IN VARCHAR2
             , p_password  IN VARCHAR2
              )RETURN BOOLEAN IS
    --
    l_retval PLS_INTEGER;
    l_retval2 PLS_INTEGER;
    l_session dbms_ldap.session;
    l_ldap_host VARCHAR2(256);
    l_ldap_port VARCHAR2(256);
    l_ldap_user VARCHAR2(256);
    l_ldap_base VARCHAR2(256);
    --
BEGIN
    --
    l_retval := -1;
    dbms_ldap.use_exception := TRUE;
    l_ldap_host := 'ldap.forumsys.com';
    l_ldap_port := '389';
    l_ldap_user := 'uid='||p_username||',dc=example,dc=com';
    --
    GEN_PSEGUIMIENTO('vali_ldap l_ldap_host: '||l_ldap_host
                            ||' l_ldap_port: '||l_ldap_port
                            );
    l_session := dbms_ldap.init(l_ldap_host, l_ldap_port);
    GEN_PSEGUIMIENTO('vali_ldap paso');
    l_retval := dbms_ldap.simple_bind_s(l_session,l_ldap_user,p_password);
    --
    l_retval2 := dbms_ldap.unbind_s(l_session);
    RETURN TRUE;
    --
    /*
EXCEPTION
    WHEN OTHERS THEN
        GEN_PSEGUIMIENTO('vali_ldap sqlerrm '||sqlerrm);
        RETURN FALSE;
        dbms_output.put_line(rpad('ldap session ', 25, ' ') || ': ' ||
        rawtohex(substr(l_session, 1, 8)) || '(returned from init)');
        dbms_output.put_line('error: ' || SQLERRM || ' ' || SQLCODE);
        dbms_output.put_line('user: ' || l_ldap_user);
        dbms_output.put_line('host: ' || l_ldap_host);
        dbms_output.put_line('port: ' || l_ldap_port);
        l_retval := dbms_ldap.unbind_s(l_session);
        DBMS_OUTPUT.PUT_LINE('FALSE_inT'||SQLERRM);*/
END ldap;
---------------------------------------------------------------------------------------------------
FUNCTION p_secu(p_secuencia   IN     VARCHAR2
              , p_mensaje     OUT    VARCHAR2
                )RETURN NUMBER IS
    --
    v_sql       varchar2(2000);
    v_valor     NUMBER;
    --
BEGIN
    --
    p_mensaje := NULL;
    --
    v_sql := 'SELECT '||p_secuencia||'.nextval INTO :v_siguiente FROM DUAL';
    EXECUTE IMMEDIATE V_sql INTO v_valor;
    --
    RETURN v_valor;
    --
EXCEPTION
    WHEN OTHERS THEN
        p_mensaje := substr('p_secu ('||p_secuencia||') Status:'||sqlerrm,1,300);
        v_valor := 0;
        RETURN v_valor;
END p_secu;
---------------------------------------------------------------------------------------------------
FUNCTION id_lista( p_modulo gen_tlistas.list_modulo %TYPE
                 , p_lista  gen_tlistas.list_lista  %TYPE
                 , p_sigla  gen_tlistas.list_sigla  %TYPE
                )RETURN gen_tlistas.list_list%TYPE IS
    --
    v_valor     gen_tlistas.list_list%TYPE;
    --
    CURSOR c_list IS
        SELECT list_list
          FROM gen_tlistas
         WHERE list_modulo = p_modulo
           AND list_lista  = p_lista
           AND list_sigla  = p_sigla
    ;
    --
BEGIN
    --
    v_valor := NULL;
    --
    OPEN  c_list;
    FETCH c_list INTO v_valor;
    CLOSE c_list;
    --
    RETURN v_valor;
    --
EXCEPTION
    WHEN OTHERS THEN
        v_valor := NULL;
        RETURN v_valor;
END id_lista;
---------------------------------------------------------------------------------------------------
FUNCTION id_lista_desc( p_list   gen_tlistas.list_list %TYPE
                    )RETURN gen_tlistas.list_descri%TYPE IS
    --
    v_valor     gen_tlistas.list_descri%TYPE;
    --
    CURSOR c_list IS
        SELECT list_descri
          FROM gen_tlistas
         WHERE list_list = p_list
    ;
    --
BEGIN
    --
    v_valor := NULL;
    --
    OPEN  c_list;
    FETCH c_list INTO v_valor;
    CLOSE c_list;
    --
    RETURN v_valor;
    --
EXCEPTION
    WHEN OTHERS THEN
        v_valor := NULL;
        RETURN v_valor;
END id_lista_desc;
---------------------------------------------------------------------------------------------------
FUNCTION id_estado( p_modulo gen_testados.esta_modulo %TYPE
                  , p_lista  gen_testados.esta_lista  %TYPE
                  , p_sigla  gen_testados.esta_sigla  %TYPE
                    )RETURN gen_testados.esta_esta%TYPE IS
    --
    v_valor     gen_testados.esta_esta%TYPE;
    --
    CURSOR c_esta IS
        SELECT esta_esta
          FROM gen_testados
         WHERE esta_modulo = p_modulo
           AND esta_lista  = p_lista
           AND esta_sigla  = p_sigla
    ;
    --
BEGIN
    --
    v_valor := NULL;
    --
    OPEN  c_esta;
    FETCH c_esta INTO v_valor;
    CLOSE c_esta;
    --
    RETURN v_valor;
    --
EXCEPTION
    WHEN OTHERS THEN
        v_valor := NULL;
        RETURN v_valor;
END id_estado;
---------------------------------------------------------------------------------------------------
FUNCTION desc_empr( p_empr  tbl_tempresas.empr_empr%TYPE
                      )RETURN tbl_tempresas.empr_descripcion%TYPE IS
    --
    v_valor      tbl_tempresas.empr_descripcion%TYPE;
    --
    CURSOR c_empr IS
        SELECT empr_descripcion
          FROM tbl_tempresas
         WHERE empr_empr = p_empr
        ;
    --
BEGIN
    --
    v_valor := NULL;
    --
    OPEN  c_empr ;
    FETCH c_empr INTO v_valor;
    IF c_empr%NOTFOUND THEN
        v_valor := NULL;
    END IF;
    CLOSE c_empr;
    --
    RETURN (v_valor);
    --
EXCEPTION
    WHEN OTHERS THEN
        v_valor := NULL;
END desc_empr;
---------------------------------------------------------------------------------------------------
FUNCTION desc_banc( p_banc  tbl_tbancos.banc_banc%TYPE
                      )RETURN tbl_tbancos.banc_descripcion%TYPE IS
    --
    v_valor      tbl_tbancos.banc_descripcion%TYPE;
    --
    CURSOR c_banc IS
        SELECT banc_descripcion
          FROM tbl_tbancos
         WHERE banc_banc = p_banc
        ;
    --
BEGIN
    --
    v_valor := NULL;
    --
    OPEN  c_banc ;
    FETCH c_banc INTO v_valor;
    IF c_banc%NOTFOUND THEN
        v_valor := NULL;
    END IF;
    CLOSE c_banc;
    --
    RETURN (v_valor);
    --
EXCEPTION
    WHEN OTHERS THEN
        v_valor := NULL;
END desc_banc;
---------------------------------------------------------------------------------------------------
FUNCTION FN_FILL_STRING_TO_TABLE (iv_string in varchar2, iv_delim char) 
RETURN BOOLEAN
IS
    l_string_array    APEX_APPLICATION_GLOBAL.VC_ARR2;
    l_contador        number:=0;
BEGIN
    l_string_array:=APEX_UTIL.STRING_TO_TABLE(iv_string,iv_delim);

    FOR n IN 1..l_string_array.count LOOP
        vg_ty_number_data(l_contador).num_val:=l_string_array(n);
        l_contador:=l_contador+1;
    END LOOP;
    RETURN TRUE;
END FN_FILL_STRING_TO_TABLE;
---------------------------------------------------------------------------------------------------
FUNCTION FN_GET_STRING_TO_TABLE (iv_string in varchar2, iv_delim char) 
RETURN t_data_number PIPELINED IS
        v_fill_data boolean;
        l_index PLS_INTEGER;
    BEGIN

        v_fill_data:=FN_FILL_STRING_TO_TABLE(iv_string,iv_delim);
        IF v_fill_data THEN

            l_index:=  vg_ty_number_data.FIRST;

            IF vg_ty_number_data.COUNT >0 THEN

                    WHILE (l_index IS NOT NULL)
                    LOOP
                        pipe row (vg_ty_number_data(l_index));
                        l_index:=vg_ty_number_data.NEXT(l_index);
                    END LOOP;

            END IF; 

        END IF;
        RETURN;
END FN_GET_STRING_TO_TABLE;
---------------------------------------------------------------------------------------------------                    
FUNCTION desc_esta( p_esta  gen_testados.esta_esta%TYPE
                      )RETURN gen_testados.esta_descri%TYPE IS
    --
    v_valor      gen_testados.esta_descri%TYPE;
    --
    CURSOR c_esta IS
        SELECT esta_descri
          FROM gen_testados
         WHERE esta_esta = p_esta
        ;
    --
BEGIN
    --
    v_valor := NULL;
    --
    OPEN  c_esta ;
    FETCH c_esta INTO v_valor;
    IF c_esta%NOTFOUND THEN
        v_valor := NULL;
    END IF;
    CLOSE c_esta;
    --
    RETURN (v_valor);
    --
EXCEPTION
    WHEN OTHERS THEN
        v_valor := NULL;
END desc_esta;
---------------------------------------------------------------------------------------------------
FUNCTION recupera_parametro( p_modu         gen_tparametros.para_modu%TYPE
                           , p_siglas       gen_tparametros.para_siglas%TYPE
                           )RETURN gen_tparametros.para_valor%TYPE IS
    --
    v_valor      gen_tparametros.para_valor%TYPE;
    v_fech       DATE;
    --
    CURSOR c_para IS
        SELECT para_valor
          FROM gen_tparametros
         WHERE para_modu = p_modu
           AND para_siglas  = p_siglas
        ;
    --
BEGIN
    --
    v_valor := NULL;
    --
    OPEN  c_para ;
    FETCH c_para INTO v_valor;
    IF c_para%NOTFOUND THEN
        v_valor := NULL;
    END IF;
    CLOSE c_para;
    --
    IF gen_qgeneral.id_lista('GEN','MODU_EDGE','TBL') = p_modu AND p_siglas = 'FECH_CONS_MOVI' THEN 
        --
        begin
            --
            v_fech := TO_DATE(v_valor, 'dd/mm/yyyy');
            --
          exception
            when others then
              v_valor := TO_CHAR(sysdate, 'dd/mm/yyyy');
        end;
        --   
    END IF;
    --
    RETURN (v_valor);
    --
EXCEPTION
    WHEN OTHERS THEN
        v_valor := NULL;
END recupera_parametro;
---------------------------------------------------------------------------------------------------
function fn_encrypt(v_string varchar2) return raw deterministic
  is
    encrypte_raw RAW(2000);
  begin
--Utilizando el paquete DBMS_CRYPTO y la función ENCRYPT pasamos el tipo de encriptación y la llave para encriptación
    encrypte_raw:=DBMS_CRYPTO.ENCRYPT(
            src => utl_raw.cast_to_raw(v_string)
          , typ =>  encryption_type
          , key => encryption_key
          );

      return encrypte_raw;

  end fn_encrypt;
---------------------------------------------------------------------------------------------------
  function fn_decrypt( v_string raw) return varchar2 deterministic
  is
    decrypted_raw RAW(2000);
  begin
--Utilizando el paquete DBMS_CRYPTO y la función DECRYPT pasamos el tipo de encriptación y la llave para la desencriptación
    decrypted_raw:=DBMS_CRYPTO.DECRYPT(
            src => v_string
          , typ => encryption_type
          , key => encryption_key
          );
    return (utl_raw.cast_to_varchar2(decrypted_raw));

  end fn_decrypt;
---------------------------------------------------------------------------------------------------
--Ini 1003 09/01/2024 cramirezs
FUNCTION fn_es_habil (p_fech DATE
                     ) RETURN VARCHAR2 IS
    --
    v_valor     VARCHAR2(1);
    --
    CURSOR c_fest IS
        SELECT 'N'
          FROM gen_tfestivos
         WHERE fest_Fest = p_fech
        ;
    --
BEGIN
    --
    v_valor := 'S';
    --
    IF ( TO_CHAR(p_fech, 'fmDAY', 'nls_date_language= english') IN ( 'SATURDAY', 'SUNDAY' ) ) THEN-- Fin de Semana
        --
        v_valor := 'N';
        --
    ELSE--Si no es fin de semana se valida festivos
        --
        OPEN c_fest;
        FETCH c_fest INTO v_valor;
        IF ( c_fest%FOUND ) THEN
          v_valor := 'N';
        ELSE
          v_valor := 'S';
        END IF;
        CLOSE c_fest;
        --
      END IF;
      --
      RETURN( v_valor );
      --
END fn_es_habil;
----------------------------------------------------------------------------------------------------
FUNCTION fn_ste_habil (p_fech DATE 
                        ) RETURN DATE IS
    --
    v_valor     DATE;
    --
BEGIN
    --
    v_valor  := p_fech;
    --
    WHILE gen_qgeneral.fn_es_habil( v_valor ) = 'N' LOOP
        --
        v_valor := v_valor + 1;
        --
    END LOOP;
    --
    RETURN( v_valor );
    --
END fn_ste_habil;
----------------------------------------------------------------------------------------------------
FUNCTION fn_ant_habil ( p_fech DATE
                        ) RETURN DATE IS
    --
    v_valor     DATE;
    --
BEGIN 
    --
    v_valor  := p_fech - 1;
    --
    WHILE gen_qgeneral.fn_es_habil( v_valor ) = 'N' LOOP
        --
        v_valor := v_valor - 1;
        --
    END LOOP;
    --
    RETURN (v_valor);
    --
END fn_ant_habil;        
---------------------------------------------------------------------------------------------------
--Fin 1003 09/01/2024 cramirezs
END gen_qgeneral;
/
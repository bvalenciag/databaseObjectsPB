prompt
prompt PACKAGE: TBL_QHOMOLOGA
prompt
create or replace PACKAGE tbl_qhomologa IS
--
-- Reúne funciones y procedimientos directamente relacionados con el procedimiento de la tabla TBL_THOMOLOGA
--
-- #VERSION: 1001
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       03/11/2023 Jmartinezm    000001       * Se crea paquete.
--                       Kilonova
-- ========== ========== ============ ============ ============================================================================================================
-- 1001       14/12/2023 cramirezs    000001       * Se crea función fn_recupera_cod_interno
--                       Kilonova     MVP_2
-- ========== ========== ============ ============ ============================================================================================================
--
-------------------------------------------------------------------------------------------------
--Types
-------------------------------------------------------------------------------------------------
--
TYPE ty_homo IS RECORD(
      homo_sist         tbl_thomologa.homo_sist  %TYPE
    , homo_sist_desc    gen_tlistas.list_descri   %TYPE
    , homo_vari         tbl_thomologa.homo_vari  %TYPE
    , homo_vari_desc    VARCHAR2(200)
    , homo_dato         tbl_thomologa.homo_dato  %TYPE
    , homo_dato_desc    gen_tlistas.list_descri   %TYPE
    , homo_sis_ext      tbl_thomologa.homo_sis_ext  %TYPE
    , homo_sis_ext_desc gen_tlistas.list_descri   %TYPE
    , homo_val_sisext   tbl_thomologa.homo_val_sisext  %TYPE
    , homo_fecins       tbl_thomologa.homo_fecins  %TYPE
    , homo_usuains      tbl_thomologa.homo_usuains %TYPE
    , homo_fecupd       tbl_thomologa.homo_fecupd  %TYPE
    , homo_usuaupd      tbl_thomologa.homo_usuaupd %TYPE
);
--
TYPE ty_homo_data IS TABLE OF ty_homo INDEX BY BINARY_INTEGER;
--
vg_ty_homo_data TY_HOMO_DATA;
--
TYPE t_data_homo IS TABLE OF ty_homo;
--

-------------------------------------------------------------------------------------------------
--Procedure - Function
-------------------------------------------------------------------------------------------------
--
FUNCTION fill_homo_type RETURN BOOLEAN;
--
FUNCTION get_tbl_homo RETURN t_data_homo PIPELINED;
--
-------------------------------------------------------------------------------------------------
--
FUNCTION desc_dato( p_modulo gen_tlistas.list_modulo%TYPE
                  , p_lista  gen_tlistas.list_lista%TYPE
                  , p_sigla  gen_tlistas.list_sigla%TYPE
                  , p_dato   NUMBER
                    )RETURN VARCHAR2 ;
--
--Ini 1001 14/12/2023 cramirezs
-------------------------------------------------------------------------------------------------
--
FUNCTION fn_recupera_cod_interno(p_sit  tbl_thomologa.homo_sist%TYPE
                               , p_var  tbl_thomologa.homo_vari%TYPE
                               , p_sis  tbl_thomologa.homo_sis_ext%TYPE
                               , p_val  tbl_thomologa.homo_val_sisext%TYPE
                                )RETURN tbl_thomologa.homo_dato%TYPE;
--
--Fin 1001 14/12/2023 cramirezs
-------------------------------------------------------------------------------------------------
--
END tbl_qhomologa;
/
prompt
prompt PACKAGE BODY: TBL_QHOMOLOGA
prompt
--
create or replace PACKAGE BODY tbl_qhomologa IS
--
-- #VERSION: 1001
--
---------------------------------------------------------------------------------------------------
FUNCTION fill_homo_type RETURN BOOLEAN IS
    --
    v_contador number:=0;
    --
    CURSOR c_data IS
        SELECT homo_sist                                                                homo_sist
             , gen_qgeneral.id_lista_desc(homo_sist)                                    homo_sist_desc
             , homo_vari                                                                homo_vari
             , list_descri                                                              homo_vari_desc
             , homo_dato                                                                homo_dato
             , tbl_qhomologa.desc_dato(list_modulo, list_lista, list_sigla, homo_dato)  homo_dato_desc
             , homo_sis_ext                                                             homo_sis_ext
             , gen_qgeneral.id_lista_desc(homo_sis_ext)                                 homo_sis_ext_desc
             , homo_val_sisext                                                          homo_val_sisext
             , homo_fecins                                                              homo_fecins
             , homo_usuains                                                             homo_usuains
             , homo_fecupd                                                              homo_fecupd
             , homo_usuaupd                                                             homo_usuaupd
          FROM tbl_thomologa
             , gen_tlistas
         WHERE homo_vari = list_list
           AND list_modulo = 'TBL'
           AND list_lista = 'VARI_HOMO'
        ;
    --
BEGIN
    --
    FOR i IN c_data LOOP
        --
        vg_ty_homo_data(v_contador).homo_sist           := i.homo_sist;
        vg_ty_homo_data(v_contador).homo_sist_desc      := i.homo_sist_desc;
        vg_ty_homo_data(v_contador).homo_vari           := i.homo_vari;
        vg_ty_homo_data(v_contador).homo_vari_desc      := i.homo_vari_desc;
        vg_ty_homo_data(v_contador).homo_dato           := i.homo_dato;
        vg_ty_homo_data(v_contador).homo_dato_desc      := i.homo_dato_desc;
        vg_ty_homo_data(v_contador).homo_sis_ext        := i.homo_sis_ext;
        vg_ty_homo_data(v_contador).homo_sis_ext_desc   := i.homo_sis_ext_desc;
        vg_ty_homo_data(v_contador).homo_val_sisext     := i.homo_val_sisext;
        vg_ty_homo_data(v_contador).homo_fecins         := i.homo_fecins;
        vg_ty_homo_data(v_contador).homo_usuains        := i.homo_usuains;
        vg_ty_homo_data(v_contador).homo_fecupd         := i.homo_fecupd;
        vg_ty_homo_data(v_contador).homo_usuaupd        := i.homo_usuaupd;
        --
        v_contador:=v_contador+1;
        --
    END LOOP c_data;
    --
    RETURN TRUE;
    --
   END fill_homo_type;
--
---------------------------------------------------------------------------------------------------
--
FUNCTION get_tbl_homo RETURN t_data_homo PIPELINED
IS
    v_fill_data boolean;
    l_index PLS_INTEGER;
BEGIN
    v_fill_data:=fill_homo_type;
    IF v_fill_data THEN
        l_index:=  vg_ty_homo_data.FIRST;
        IF vg_ty_homo_data.COUNT >0 THEN
                WHILE (l_index IS NOT NULL)
                LOOP
                    pipe row (vg_ty_homo_data(l_index));
                    l_index:=vg_ty_homo_data.NEXT(l_index);
                END LOOP;
        END IF;
    END IF;
    RETURN;
END get_tbl_homo;
--
---------------------------------------------------------------------------------------------------
--
FUNCTION desc_dato( p_modulo gen_tlistas.list_modulo%TYPE
                  , p_lista  gen_tlistas.list_lista%TYPE
                  , p_sigla  gen_tlistas.list_sigla%TYPE
                  , p_dato   NUMBER
                    )RETURN VARCHAR2 IS
    --
    v_descri      VARCHAR2(200);
    --
BEGIN
    --
    v_descri := NULL;
    --
    IF p_modulo = 'TBL' AND p_lista = 'VARI_HOMO' AND p_sigla = 'EM' THEN
        --
        v_descri := SUBSTR(gen_qgeneral.desc_empr(p_dato), 1, 200);
        --
    ELSIF p_modulo = 'TBL' AND p_lista = 'VARI_HOMO' AND p_sigla = 'BC' THEN
        --
        v_descri := SUBSTR(gen_qgeneral.desc_banc(p_dato), 1, 200);
        --
    END IF;
    --
    RETURN (v_descri);
    --
EXCEPTION
    WHEN OTHERS THEN
        v_descri := NULL;
        RETURN (v_descri);
END desc_dato;
--
---------------------------------------------------------------------------------------------------
--Ini 1001 14/12/2023 cramirezs
FUNCTION fn_recupera_cod_interno(p_sit  tbl_thomologa.homo_sist%TYPE
                               , p_var  tbl_thomologa.homo_vari%TYPE
                               , p_sis  tbl_thomologa.homo_sis_ext%TYPE
                               , p_val  tbl_thomologa.homo_val_sisext%TYPE
                                )RETURN tbl_thomologa.homo_dato%TYPE IS
    --
    v_valor     tbl_thomologa.homo_dato%TYPE;
    --
    CURSOR c_dato IS
        SELECT homo_dato
          FROM tbl_thomologa
         WHERE homo_sist = p_sit
           AND homo_vari = p_var
           AND homo_sis_ext = p_sis
           AND homo_val_sisext = p_val
        ;
    --
    r_DATO    c_DATO%ROWTYPE;
    --
BEGIN
    --
    --GEN_PSEGUIMIENTO('fn_movi_bizagi fn_recupera_cod_interno 1');
    v_valor := NULL;
    --
    --GEN_PSEGUIMIENTO('fn_movi_bizagi fn_recupera_cod_interno 2');
    OPEN  c_dato ;
    FETCH c_dato INTO v_valor;
    IF c_dato%NOTFOUND THEN
        v_valor := NULL;
    END IF;
    CLOSE c_dato;
    --GEN_PSEGUIMIENTO('fn_movi_bizagi fn_recupera_cod_interno 3');
    --
    RETURN v_valor;
    --
EXCEPTION
    WHEN OTHERS THEN
        --GEN_PSEGUIMIENTO('fn_movi_bizagi fn_recupera_cod_interno 4 '||sqlerrm);
        v_valor := NULL;
END fn_recupera_cod_interno;
--Fin 1001 14/12/2023 cramirezs
---------------------------------------------------------------------------------------------------
--
END tbl_qhomologa;
/
prompt
prompt PACKAGE: TBL_QBANCOS_CRUD
prompt
create or replace PACKAGE tbl_qbancos_crud IS
--
-- Reúne funciones y procedimientos directamente relacionados con la tabla tbl_tbancos
--
-- #VERSION: 1001
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       25/10/2023 Cramirezs    000001       * Se crea paquete.
--                       Kilonova
-- ========== ========== ============ ============ ============================================================================================================
-- 1001       18/03/2024 Jmartinezm    000001       * Se agrega una nueva columna al type y se añade al actualizar.
--                       Kilonova      MVP_2
-- ========== ========== ============ ============ ============================================================================================================
--
-------------------------------------------------------------------------------------------------
--Type
-------------------------------------------------------------------------------------------------
TYPE ty_banc IS RECORD(
     banc_banc          tbl_tbancos.banc_banc       %TYPE
   , banc_externo       tbl_tbancos.banc_externo    %TYPE
   , banc_descripcion   tbl_tbancos.banc_descripcion%TYPE
   , banc_fuente        tbl_tbancos.banc_fuente     %TYPE
   , banc_tipo_tasa     tbl_tbancos.banc_tipo_tasa  %TYPE
   , banc_rangos        tbl_tbancos.banc_rangos     %TYPE
   , banc_fecins        tbl_tbancos.banc_fecins     %TYPE
   , banc_usuains       tbl_tbancos.banc_usuains    %TYPE
   , banc_fecupd        tbl_tbancos.banc_fecupd     %TYPE
   , banc_usuaupd       tbl_tbancos.banc_usuaupd    %TYPE
   , banc_tasa_agru     tbl_tbancos.banc_tasa_agru  %TYPE -- 1001       18/03/2024 Jmartinezm 
);
-------------------------------------------------------------------------------------------------
--Procedure - Function
-------------------------------------------------------------------------------------------------
/**
 * Description: Insertar en la tabla tbl_tbancos
 *
 * Author: Cramirezs
 * Created: 25/10/2023
 *
 * Param: p_ty_bancos Description: Type de la tabla
 * Param: p_ty_erro Description: Type de errores
 */
PROCEDURE insertar_tbl_tbancos(
                                  p_ty_banc      tbl_qbancos_crud.ty_banc
                                , p_banc_banc  OUT tbl_tbancos.banc_banc%TYPE
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                );
-------------------------------------------------------------------------------------------------
/**
 * Description: Actualizar en la tabla tbl_tbancos
 *
 * Author: Cramirezs
 * Created: 25/10/2023
 *
 * Param: p_ty_bancos Description: Type de la tabla
 * Param: p_ty_erro Description: Type de errores
 */
PROCEDURE actualizar_tbl_tbancos(
                                  p_ty_banc         tbl_qbancos_crud.ty_banc
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                );
-------------------------------------------------------------------------------------------------
/**
 * Description: Eliminar en la tabla tbl_tbancos
 *
 * Author: Cramirezs
 * Created: 2023/10/2023
 *
 * Param: p_ty_bancos Description: Type de la tabla
 * Param: p_ty_erro Description: Type de errores
 */
PROCEDURE eliminar_tbl_tbancos(
                                  p_ty_banc         tbl_qbancos_crud.ty_banc
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                );
-------------------------------------------------------------------------------------------------
--
END tbl_qbancos_crud;
/
prompt
prompt PACKAGE BODY: TBL_QBANCOS_CRUD
prompt
--
create or replace PACKAGE BODY tbl_qbancos_crud IS
--
-- #VERSION: 1001
--
---------------------------------------------------------------------------------------------------
PROCEDURE insertar_tbl_tbancos(
                                  p_ty_banc        tbl_qbancos_crud.ty_banc
                                , p_banc_banc  OUT tbl_tbancos.banc_banc%TYPE
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                )IS
    --
    e_error      EXCEPTION;
    v_banc_banc  tbl_tbancos.banc_banc%TYPE;
    --
BEGIN
    --
    p_ty_msg.cod_msg := 'OK';
    --
    v_banc_banc := gen_qgeneral.p_secu('tbl_sbancos', p_ty_msg.msg_msg);
    --
    IF p_ty_msg.msg_msg IS NOT NULL THEN
        raise e_error;
    END IF;
    --
    INSERT INTO tbl_tbancos
        (
              banc_banc
            , banc_externo
            , banc_descripcion
            , banc_fuente
            , banc_tipo_tasa
            , banc_rangos
            , banc_fecins
            , banc_usuains
        )VALUES
        (
              v_banc_banc
            , p_ty_banc.banc_externo
            , p_ty_banc.banc_descripcion
            , p_ty_banc.banc_fuente
            , p_ty_banc.banc_tipo_tasa
            , p_ty_banc.banc_rangos
            , p_ty_banc.banc_fecins
            , p_ty_banc.banc_usuains
        );
    --
    p_banc_banc         := v_banc_banc;
    p_ty_msg.msg_msg := 'Transaccion Exitosa';
    --
EXCEPTION
     WHEN e_error THEN
        p_ty_msg.cod_msg := 'ERR_SEC';
     WHEN OTHERS THEN
        p_ty_msg.cod_msg := 'ORA'||ltrim(to_char(sqlcode, '000000'));
        p_ty_msg.msg_msg := 'tbl_qbancos_crud.insertar_tbl_tbancos. '|| to_char(sysdate,'dd/mm/yyyy hh24miss')||'. Error: '||SQLERRM;
END insertar_tbl_tbancos;
--------------------------------------------------------------------------------------------------
PROCEDURE actualizar_tbl_tbancos(
                                  p_ty_banc      tbl_qbancos_crud.ty_banc
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                )IS
    --
BEGIN
    --
    p_ty_msg.cod_msg := 'OK';
    --
    UPDATE tbl_tbancos SET
          banc_externo     = NVL(p_ty_banc.banc_externo    , banc_externo    )
        , banc_descripcion = NVL(p_ty_banc.banc_descripcion, banc_descripcion)
        , banc_fuente      = NVL(p_ty_banc.banc_fuente     , banc_fuente     )
        , banc_tipo_tasa   = NVL(p_ty_banc.banc_tipo_tasa  , banc_tipo_tasa  )
        , banc_rangos      = NVL(p_ty_banc.banc_rangos     , banc_rangos     )
        , banc_fecupd      = NVL(p_ty_banc.banc_fecupd, SYSDATE)
        , banc_usuaupd     = NVL(p_ty_banc.banc_usuaupd, USER)
        , banc_tasa_agru   = NVL(p_ty_banc.banc_tasa_agru  , banc_tasa_agru  ) -- 1001       18/03/2024 Jmartinezm 
    WHERE banc_banc = p_ty_banc.banc_banc
    ;
    --
    p_ty_msg.msg_msg := 'Transaccion Exitosa';
    --
EXCEPTION
    WHEN OTHERS THEN
        p_ty_msg.cod_msg := 'ORA'||ltrim(to_char(sqlcode, '000000'));
        p_ty_msg.msg_msg := 'tbl_qbancos_crud.actualizar_tbl_tbancos. '|| to_char(sysdate,'dd/mm/yyyy hh24miss')||'. Error: '||SQLERRM;
END actualizar_tbl_tbancos;
--------------------------------------------------------------------------------------------------
PROCEDURE eliminar_tbl_tbancos(
                                  p_ty_banc         tbl_qbancos_crud.ty_banc
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                )IS
    --
BEGIN
    --
    p_ty_msg.cod_msg := 'OK';
    --
    DELETE FROM tbl_tbancos
        WHERE banc_banc = p_ty_banc.banc_banc
    ;
    --
    p_ty_msg.msg_msg := 'Transaccion Exitosa';
    --
EXCEPTION
    WHEN OTHERS THEN
        p_ty_msg.cod_msg := 'ORA'||ltrim(to_char(sqlcode, '000000'));
        p_ty_msg.msg_msg := 'tbl_qbancos_crud.eliminar_tbl_tbancos '|| to_char(sysdate,'dd/mm/yyyy hh24miss')||'. Error: '||SQLERRM;
END eliminar_tbl_tbancos;
--------------------------------------------------------------------------------------------------
END tbl_qbancos_crud;
/
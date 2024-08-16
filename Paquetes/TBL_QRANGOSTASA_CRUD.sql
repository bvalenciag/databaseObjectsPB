prompt
prompt PACKAGE: TBL_QRANGOSTASA_CRUD
prompt
create or replace PACKAGE tbl_qrangostasa_crud IS
--
-- Reúne funciones y procedimientos directamente relacionados con la tabla tbl_trangostasa
--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       28/11/2023 Jmartinezm    00001       * Se crea paquete.
--                       Kilonova
-- ========== ========== ============ ============ ============================================================================================================
-- 1001       09/04/2024 Jmartinezm    00002       * Se crea paquete.
--                       Kilonova      MVP_2
-- ========== ========== ============ ============ ============================================================================================================
--
-------------------------------------------------------------------------------------------------
--Type
-------------------------------------------------------------------------------------------------
TYPE ty_rang IS RECORD(
     rang_rang     tbl_trangostasa.rang_rang    %TYPE
   , rang_banc     tbl_trangostasa.rang_banc    %TYPE
   , rang_val_ini  tbl_trangostasa.rang_val_ini %TYPE
   , rang_val_fin  tbl_trangostasa.rang_val_fin %TYPE
   , rang_tasa_ea  tbl_trangostasa.rang_tasa_ea %TYPE
   , rang_empr     tbl_trangostasa.rang_empr    %TYPE  -- 1001       09/04/2024 Jmartinezm 
   , rang_fecins   tbl_trangostasa.rang_fecins  %TYPE
   , rang_usuains  tbl_trangostasa.rang_usuains %TYPE
   , rang_fecupd   tbl_trangostasa.rang_fecupd  %TYPE
   , rang_usuaupd  tbl_trangostasa.rang_usuaupd %TYPE
);
-------------------------------------------------------------------------------------------------
--Procedure - Function
-------------------------------------------------------------------------------------------------
/**
 * Description: Insertar en la tabla tbl_trangostasa
 *
 * Author: Jmartinezm
 * Created: 28/11/2023
 *
 * Param: p_ty_rang Description: Type de la tabla
 * Param: p_ty_msg Description: Type de errores
 */
PROCEDURE insertar_tbl_trangostasa(
                                  p_ty_rang        tbl_qrangostasa_crud.ty_rang
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                );
-------------------------------------------------------------------------------------------------
/**
 * Description: Actualizar en la tabla tbl_trangostasa
 *
 * Author: Jmartinezm
 * Created: 28/11/2023
 *
 * Param: p_ty_rang Description: Type de la tabla
 * Param: p_ty_msg Description: Type de errores
 */
PROCEDURE actualizar_tbl_trangostasa(
                                  p_ty_rang         tbl_qrangostasa_crud.ty_rang
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                );
-------------------------------------------------------------------------------------------------
/**
 * Description: Eliminar en la tabla tbl_trangostasa
 *
 * Author: Jmartinezm
 * Created: 2023/11/2023
 *
 * Param: p_ty_rang Description: Type de la tabla
 * Param: p_ty_msg Description: Type de errores
 */
PROCEDURE eliminar_tbl_trangostasa(
                                  p_ty_rang         tbl_qrangostasa_crud.ty_rang
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                );
-------------------------------------------------------------------------------------------------
--
END tbl_qrangostasa_crud;
/
prompt
prompt PACKAGE BODY: TBL_QRANGOSTASA_CRUD
prompt
create or replace PACKAGE BODY tbl_qrangostasa_crud IS
--
-- #VERSION: 1000
--
---------------------------------------------------------------------------------------------------
PROCEDURE insertar_tbl_trangostasa(
                                  p_ty_rang        tbl_qrangostasa_crud.ty_rang
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                )IS
    --
    e_error      EXCEPTION;
    --e_error_tasa      EXCEPTION; antes  1001  09/04/2024 Jmartinezm 
    v_rang_rang  tbl_trangostasa.rang_rang%TYPE;
    --
BEGIN
    -- Verificación de solapamiento de rangos
    /*
    antes  1001  09/04/2024 Jmartinezm
    FOR rango IN (SELECT RANG_VAL_INI, RANG_VAL_FIN
                 FROM TBL_TRANGOSTASA
                 WHERE RANG_BANC = p_ty_rang.rang_banc) LOOP
        IF (p_ty_rang.rang_val_ini <= rango.rang_val_fin AND p_ty_rang.rang_val_fin >= rango.rang_val_ini) THEN
            raise e_error_tasa
        END IF
    END LOOP
    --
       -- Verificación de valor final no inferior al inicial
    IF p_ty_rang.rang_val_ini > p_ty_rang.rang_val_fin THEN
        raise e_error_tasa
    END IF
    antes  1001  09/04/2024 Jmartinezm
    */  
    --
    p_ty_msg.cod_msg := 'OK';
    --
    v_rang_rang := gen_qgeneral.p_secu('tbl_srangostasa', p_ty_msg.msg_msg);
    --
    IF p_ty_msg.msg_msg IS NOT NULL THEN
        raise e_error;
    END IF;
    --
    INSERT INTO tbl_trangostasa
        (
              rang_rang
            , rang_banc
            , rang_val_ini
            , rang_val_fin
            , rang_tasa_ea
            , rang_empr   --  ini 1001       09/04/2024 Jmartinezm 
            , rang_fecins
            , rang_usuains
        )VALUES
        (
              v_rang_rang
            , p_ty_rang.rang_banc
            , p_ty_rang.rang_val_ini
            , p_ty_rang.rang_val_fin
            , p_ty_rang.rang_tasa_ea
            , p_ty_rang.rang_empr  -- ini 1001       09/04/2024 Jmartinezm 
            , p_ty_rang.rang_fecins
            , p_ty_rang.rang_usuains
        );
    --
    p_ty_msg.msg_msg := 'Proceso Exitoso';
    --
EXCEPTION
     --WHEN e_error_tasa THEN
     --    p_ty_msg.msg_msg := 'Valor no permitido. Por favor verifique.' antes  1001  09/04/2024 Jmartinezm
     WHEN e_error THEN
         p_ty_msg.cod_msg := 'ERR_SEC';
     WHEN OTHERS THEN
         p_ty_msg.cod_msg := 'ORA'||ltrim(to_char(sqlcode, '000000'));
         p_ty_msg.msg_msg := 'tbl_qrangostasa_crud.insertar_tbl_trangostasa. '|| to_char(sysdate,'dd/mm/yyyy hh24miss')||'. Error: '||SQLERRM;
END insertar_tbl_trangostasa;
--------------------------------------------------------------------------------------------------
PROCEDURE actualizar_tbl_trangostasa(
                                  p_ty_rang         tbl_qrangostasa_crud.ty_rang
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                )IS
BEGIN
    /* 
    antes  1001  09/04/2024 Jmartinezm
    -- Verificación de solapamiento de rangos
    FOR rango IN (select rang_val_ini, rang_val_fin
                 from tbl_trangostasa
                 where rang_banc = p_ty_rang.rang_banc
                 and rang_rang <> p_ty_rang.rang_rang) LOOP
        IF (p_ty_rang.rang_val_ini <= rango.rang_val_fin AND p_ty_rang.rang_val_fin >= rango.rang_val_ini) THEN
            raise e_error_tasa;
        END IF;
    END LOOP;
    --
       -- Verificación de valor final no inferior al inicial
    IF p_ty_rang.rang_val_ini > p_ty_rang.rang_val_fin OR p_ty_rang.rang_tasa_ea<0 THEN
        raise e_error_tasa;
    END IF;
    antes  1001  09/04/2024 Jmartinezm
    */
    --
    --
    p_ty_msg.cod_msg := 'OK';
    --
    UPDATE tbl_trangostasa SET
          rang_val_ini = NVL(p_ty_rang.rang_val_ini, rang_val_ini)
        , rang_val_fin = NVL(p_ty_rang.rang_val_fin, rang_val_fin)
        , rang_tasa_ea = NVL(p_ty_rang.rang_tasa_ea, rang_tasa_ea)
        , rang_empr    = NVL(p_ty_rang.rang_empr   , rang_empr   )  --  1001  09/04/2024 Jmartinezm
        , rang_fecupd  = NVL(p_ty_rang.rang_fecupd , SYSDATE     )
        , rang_usuaupd = NVL(p_ty_rang.rang_usuaupd, USER        )
    WHERE rang_rang = p_ty_rang.rang_rang
    ;
    --
    p_ty_msg.msg_msg := 'Proceso Exitoso';
    --
EXCEPTION
     --WHEN e_error_tasa THEN
      --   p_ty_msg.msg_msg := 'Valor no permitido. Por favor verifique.';
     WHEN OTHERS THEN
         p_ty_msg.cod_msg := 'ORA'||ltrim(to_char(sqlcode, '000000'));
         p_ty_msg.msg_msg := 'tbl_qrangostasa_crud.insertar_tbl_trangostasa. '|| to_char(sysdate,'dd/mm/yyyy hh24miss')||'. Error: '||SQLERRM;
END actualizar_tbl_trangostasa;
--------------------------------------------------------------------------------------------------
PROCEDURE eliminar_tbl_trangostasa(
                                  p_ty_rang         tbl_qrangostasa_crud.ty_rang
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                )IS
    --
BEGIN
    --
    p_ty_msg.cod_msg := 'OK';
    --
    DELETE FROM tbl_trangostasa
        WHERE rang_rang = p_ty_rang.rang_rang
    ;
    --
    p_ty_msg.msg_msg := 'Proceso Exitoso';
    --
EXCEPTION
    WHEN OTHERS THEN
        p_ty_msg.cod_msg := 'ORA'||ltrim(to_char(sqlcode, '000000'));
        p_ty_msg.msg_msg := 'tbl_qrangostasa_crud.eliminar_tbl_trangostasa '|| to_char(sysdate,'dd/mm/yyyy hh24miss')||'. Error: '||SQLERRM;
END eliminar_tbl_trangostasa;
--------------------------------------------------------------------------------------------------
END tbl_qrangostasa_crud;
/
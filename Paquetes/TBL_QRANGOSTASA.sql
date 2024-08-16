prompt
prompt PACKAGE: TBL_QRANGOSTASA
prompt
CREATE OR REPLACE PACKAGE tbl_qrangostasa IS
--
-- Reúne funciones y procedimientos directamente relacionados con el procedimiento de rangostasa
--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       09/04/2024 Jmartinezm    000001       * Se crea paquete.
--                       Kilonova      MVP_2
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
PROCEDURE insertar_tbl_trangostasa_banco(
                                  p_ty_rang        tbl_qrangostasa_crud.ty_rang
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                );
--
-------------------------------------------------------------------------------------------------
--
PROCEDURE insertar_tbl_trangostasa_empr(
                                  p_ty_rang        tbl_qrangostasa_crud.ty_rang
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                );
--
-------------------------------------------------------------------------------------------------
--
PROCEDURE actualizar_tbl_trangostasa_banco(
                                  p_ty_rang         tbl_qrangostasa_crud.ty_rang
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                );
--
-------------------------------------------------------------------------------------------------
--
PROCEDURE actualizar_tbl_trangostasa_empr(
                                  p_ty_rang         tbl_qrangostasa_crud.ty_rang
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                );                         
--
-------------------------------------------------------------------------------------------------
--
END tbl_qrangostasa;
/
prompt
prompt PACKAGE BODY: tbl_qrangostasa
prompt
--
CREATE OR REPLACE PACKAGE BODY tbl_qrangostasa IS
--
-- #VERSION: 1000
--
---------------------------------------------------------------------------------------------------
PROCEDURE insertar_tbl_trangostasa_banco(
                                  p_ty_rang        tbl_qrangostasa_crud.ty_rang
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                )IS
    --
    e_error             EXCEPTION;
    e_error_tasa        EXCEPTION;
    --
BEGIN
    -- Verificación de solapamiento de rangos
    FOR rango IN (SELECT RANG_VAL_INI, RANG_VAL_FIN
                 FROM TBL_TRANGOSTASA
                 WHERE RANG_BANC = p_ty_rang.rang_banc) LOOP
        IF (p_ty_rang.rang_val_ini <= rango.rang_val_fin AND p_ty_rang.rang_val_fin >= rango.rang_val_ini) THEN
            raise e_error_tasa;
        END IF;
    END LOOP;
    --
       -- Verificación de valor final no inferior al inicial
    IF p_ty_rang.rang_val_ini > p_ty_rang.rang_val_fin THEN
        raise e_error_tasa;
    END IF;
    --
    tbl_qrangostasa_crud.insertar_tbl_trangostasa(p_ty_rang, p_ty_msg);
    --
    IF p_ty_msg.cod_msg <> 'OK' THEN
        RAISE e_error;
    --
    ELSE
    --
        p_ty_msg.msg_msg := 'Proceso Exitoso';
    --
    END IF;
    --    
EXCEPTION
     WHEN e_error_tasa THEN
         p_ty_msg.msg_msg := 'Valor no permitido. Por favor verifique.';
     WHEN e_error THEN
         return;
     WHEN OTHERS THEN
         p_ty_msg.cod_msg := 'ORA'||ltrim(to_char(sqlcode, '000000'));
         p_ty_msg.msg_msg := 'tbl_qrangostasa_crud.insertar_tbl_trangostasa. '|| to_char(sysdate,'dd/mm/yyyy hh24miss')||'. Error: '||SQLERRM;
END insertar_tbl_trangostasa_banco;
---------------------------------------------------------------------------------------------------
PROCEDURE insertar_tbl_trangostasa_empr(
                                  p_ty_rang        tbl_qrangostasa_crud.ty_rang
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                )IS
    --
    e_error             EXCEPTION;
    e_error_tasa        EXCEPTION;
    --
BEGIN
    -- Verificación de solapamiento de rangos
    FOR rango IN (SELECT RANG_VAL_INI, RANG_VAL_FIN
                 FROM TBL_TRANGOSTASA
                 WHERE RANG_BANC = p_ty_rang.rang_banc
                 AND RANG_EMPR  = p_ty_rang.rang_empr) LOOP
        IF (p_ty_rang.rang_val_ini <= rango.rang_val_fin AND p_ty_rang.rang_val_fin >= rango.rang_val_ini) THEN
            raise e_error_tasa;
        END IF;
    END LOOP;
    --
       -- Verificación de valor final no inferior al inicial
    IF p_ty_rang.rang_val_ini > p_ty_rang.rang_val_fin THEN
        raise e_error_tasa;
    END IF;
    --
    tbl_qrangostasa_crud.insertar_tbl_trangostasa(p_ty_rang, p_ty_msg);
    --
    IF p_ty_msg.cod_msg <> 'OK' THEN
        RAISE e_error;
    --
    ELSE
    --
        p_ty_msg.msg_msg := 'Proceso Exitoso';
    --
    END IF;
    --    
EXCEPTION
     WHEN e_error_tasa THEN
         p_ty_msg.msg_msg := 'Valor no permitido. Por favor verifique.';
     WHEN e_error THEN
         return;
     WHEN OTHERS THEN
         p_ty_msg.cod_msg := 'ORA'||ltrim(to_char(sqlcode, '000000'));
         p_ty_msg.msg_msg := 'tbl_qrangostasa_crud.insertar_tbl_trangostasa. '|| to_char(sysdate,'dd/mm/yyyy hh24miss')||'. Error: '||SQLERRM;
END insertar_tbl_trangostasa_empr;
---------------------------------------------------------------------------------------------------
PROCEDURE actualizar_tbl_trangostasa_banco(
                                  p_ty_rang         tbl_qrangostasa_crud.ty_rang
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                )IS
    e_error_tasa      EXCEPTION;
    e_error           EXCEPTION;
    --
BEGIN
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
    --
   tbl_qrangostasa_crud.actualizar_tbl_trangostasa(p_ty_rang, p_ty_msg);
    --
    IF p_ty_msg.cod_msg <> 'OK' THEN
        RAISE e_error;
    --
    ELSE
    --
        p_ty_msg.msg_msg := 'Proceso Exitoso';
    --
    END IF;
    --
EXCEPTION
     WHEN e_error_tasa THEN
         p_ty_msg.msg_msg := 'Valor no permitido. Por favor verifique.';
     WHEN e_error THEN
         return;         
     WHEN OTHERS THEN
         p_ty_msg.cod_msg := 'ORA'||ltrim(to_char(sqlcode, '000000'));
         p_ty_msg.msg_msg := 'tbl_qrangostasa_crud.insertar_tbl_trangostasa. '|| to_char(sysdate,'dd/mm/yyyy hh24miss')||'. Error: '||SQLERRM;
END actualizar_tbl_trangostasa_banco;
---------------------------------------------------------------------------------------------------
PROCEDURE actualizar_tbl_trangostasa_empr(
                                  p_ty_rang         tbl_qrangostasa_crud.ty_rang
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                )IS
    e_error_tasa      EXCEPTION;
    e_error           EXCEPTION;
    --
BEGIN
    -- Verificación de solapamiento de rangos
    FOR rango IN (select rang_val_ini, rang_val_fin
                 from tbl_trangostasa
                 where rang_banc = p_ty_rang.rang_banc
                 and rang_empr   = p_ty_rang.rang_empr
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
    --
   tbl_qrangostasa_crud.actualizar_tbl_trangostasa(p_ty_rang, p_ty_msg);
    --
    IF p_ty_msg.cod_msg <> 'OK' THEN
        RAISE e_error;
    --
    ELSE
    --
        p_ty_msg.msg_msg := 'Proceso Exitoso';
    --
    END IF;
    --
EXCEPTION
     WHEN e_error_tasa THEN
         p_ty_msg.msg_msg := 'Valor no permitido. Por favor verifique.';
     WHEN e_error THEN
         return;         
     WHEN OTHERS THEN
         p_ty_msg.cod_msg := 'ORA'||ltrim(to_char(sqlcode, '000000'));
         p_ty_msg.msg_msg := 'tbl_qrangostasa_crud.insertar_tbl_trangostasa. '|| to_char(sysdate,'dd/mm/yyyy hh24miss')||'. Error: '||SQLERRM;
END actualizar_tbl_trangostasa_empr;
---------------------------------------------------------------------------------------------------
--
END tbl_qrangostasa;
/
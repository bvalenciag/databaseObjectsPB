prompt
prompt PACKAGE: TBL_QLOGSSERVIC_CRUD
prompt
CREATE OR REPLACE PACKAGE tbl_qlogsservic_crud IS
--
-- Reúne funciones y procedimientos directamente relacionados con la tabla tbl_tlogsservic
--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       12/12/2023 Cramirezs    000001       * Se crea paquete.
--                       Kilonova     MVP_2
-- ========== ========== ============ ============ ============================================================================================================
--
-------------------------------------------------------------------------------------------------
--Type
-------------------------------------------------------------------------------------------------
TYPE ty_logs IS RECORD(
     logs_logs          tbl_tlogsservic.logs_logs%TYPE
   , logs_id_trans      tbl_tlogsservic.logs_id_trans%TYPE
   , logs_apli          tbl_tlogsservic.logs_apli%TYPE
   , logs_fecha         tbl_tlogsservic.logs_fecha%TYPE
   , logs_terminal      tbl_tlogsservic.logs_terminal%TYPE
   , logs_canal         tbl_tlogsservic.logs_canal%TYPE
   , logs_request       tbl_tlogsservic.logs_request%TYPE
   , logs_response      tbl_tlogsservic.logs_response%TYPE
   , logs_cod_respu     tbl_tlogsservic.logs_cod_respu%TYPE
   , logs_msg_resp      tbl_tlogsservic.logs_msg_resp%TYPE
   , logs_fecha_resp    tbl_tlogsservic.logs_fecha_resp%TYPE
   , logs_proceso       tbl_tlogsservic.logs_proceso%TYPE
   , logs_fecins        tbl_tlogsservic.logs_fecins%TYPE
   , logs_usuains       tbl_tlogsservic.logs_usuains%TYPE
   , logs_fecupd        tbl_tlogsservic.logs_fecupd%TYPE
   , logs_usuaupd       tbl_tlogsservic.logs_usuaupd%TYPE
);
-------------------------------------------------------------------------------------------------
--Procedure - Function
-------------------------------------------------------------------------------------------------
/**
 * Description: Insertar en la tabla tbl_tlogsservic
 *
 * Author: Cramirezs
 * Created: 12/12/2023
 *
 * Param: p_ty_logs Description: Type de la tabla
 * Param: p_ty_msg Description: Type de errores
 */
PROCEDURE insertar_tbl_tlogsservic(
                                  p_ty_logs        tbl_qlogsservic_crud.ty_logs
                                , p_logs_logs  OUT  tbl_tlogsservic.logs_logs%TYPE
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                );
-------------------------------------------------------------------------------------------------
/**
 * Description: Actualizar en la tabla tbl_tlogsservic
 *
 * Author: Cramirezs
 * Created: 12/12/2023
 *
 * Param: p_ty_logs Description: Type de la tabla
 * Param: p_ty_msg Description: Type de errores
 */
PROCEDURE actualizar_tbl_tlogsservic(
                                  p_ty_logs         tbl_qlogsservic_crud.ty_logs
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                );
-------------------------------------------------------------------------------------------------    
/**
 * Description: Eliminar en la tabla tbl_tlogsservic
 *
 * Author: Cramirezs
 * Created: 2023/12/2023
 *
 * Param: p_ty_logs Description: Type de la tabla
 * Param: p_ty_msg Description: Type de errores
 */                      
PROCEDURE eliminar_tbl_tlogsservic(
                                  p_ty_logs         tbl_qlogsservic_crud.ty_logs
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                );
-------------------------------------------------------------------------------------------------
--
END tbl_qlogsservic_crud;
/
prompt
prompt PACKAGE BODY: tbl_qlogsservic_crud
prompt
--
CREATE OR REPLACE PACKAGE BODY tbl_qlogsservic_crud IS
--
-- #VERSION: 1000
--
---------------------------------------------------------------------------------------------------
PROCEDURE insertar_tbl_tlogsservic(
                                  p_ty_logs        tbl_qlogsservic_crud.ty_logs
                                , p_logs_logs  OUT  tbl_tlogsservic.logs_logs%TYPE
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                )IS
    PRAGMA AUTONOMOUS_TRANSACTION;
    --
    e_error      EXCEPTION;
    v_logs_logs  tbl_tlogsservic.logs_logs%TYPE;
    --
BEGIN
    --
    p_ty_msg.cod_msg := 'OK';
    --
    v_logs_logs := gen_qgeneral.p_secu('tbl_slogsservic', p_ty_msg.msg_msg);
    --
    IF p_ty_msg.msg_msg IS NOT NULL THEN
        raise e_error;
    END IF;
    --
    INSERT INTO tbl_tlogsservic
        (
              logs_logs
            , logs_id_trans  
            , logs_apli      
            , logs_fecha     
            , logs_terminal  
            , logs_canal     
            , logs_request   
            , logs_response  
            , logs_cod_respu 
            , logs_msg_resp  
            , logs_fecha_resp
            , logs_proceso   
            , logs_fecins
            , logs_usuains
        )VALUES
        (
              v_logs_logs
            , p_ty_logs.logs_id_trans  
            , p_ty_logs.logs_apli      
            , p_ty_logs.logs_fecha     
            , p_ty_logs.logs_terminal  
            , p_ty_logs.logs_canal     
            , p_ty_logs.logs_request   
            , p_ty_logs.logs_response  
            , p_ty_logs.logs_cod_respu 
            , p_ty_logs.logs_msg_resp  
            , p_ty_logs.logs_fecha_resp
            , p_ty_logs.logs_proceso   
            , p_ty_logs.logs_fecins
            , p_ty_logs.logs_usuains
        );
    --
    COMMIT;
    --
    p_logs_logs         := v_logs_logs;
    p_ty_msg.msg_msg := 'Transaccion Exitosa';
    --
EXCEPTION
     WHEN e_error THEN
         p_ty_msg.cod_msg := 'ERR_SEC';
     WHEN OTHERS THEN
         p_ty_msg.cod_msg := 'ORA'||ltrim(to_char(sqlcode, '000000'));
         p_ty_msg.msg_msg := 'tbl_qlogsservic_crud.insertar_tbl_tlogsservic. '|| to_char(sysdate,'dd/mm/yyyy hh24miss')||'. Error: '||SQLERRM;
END insertar_tbl_tlogsservic;
--------------------------------------------------------------------------------------------------
PROCEDURE actualizar_tbl_tlogsservic(
                                  p_ty_logs         tbl_qlogsservic_crud.ty_logs
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                )IS
    PRAGMA AUTONOMOUS_TRANSACTION;
    --
BEGIN
    --
    p_ty_msg.cod_msg := 'OK';
    --
    UPDATE tbl_tlogsservic SET
          logs_id_trans   = NVL(p_ty_logs.logs_id_trans  , logs_id_trans  )
        , logs_apli       = NVL(p_ty_logs.logs_apli      , logs_apli      )
        , logs_fecha      = NVL(p_ty_logs.logs_fecha     , logs_fecha     )
        , logs_terminal   = NVL(p_ty_logs.logs_terminal  , logs_terminal  )
        , logs_canal      = NVL(p_ty_logs.logs_canal     , logs_canal     )
        , logs_request    = NVL(p_ty_logs.logs_request   , logs_request   )
        , logs_response   = NVL(p_ty_logs.logs_response  , logs_response  )
        , logs_cod_respu  = NVL(p_ty_logs.logs_cod_respu , logs_cod_respu )
        , logs_msg_resp   = NVL(p_ty_logs.logs_msg_resp  , logs_msg_resp  )
        , logs_fecha_resp = NVL(p_ty_logs.logs_fecha_resp, logs_fecha_resp)
        , logs_proceso    = NVL(p_ty_logs.logs_proceso   , logs_proceso   )
        , logs_fecupd     = NVL(p_ty_logs.logs_fecupd    , SYSDATE        )
        , logs_usuaupd    = NVL(p_ty_logs.logs_usuaupd   , USER           )
    WHERE logs_logs = p_ty_logs.logs_logs
    ;
    --
    COMMIT;
    p_ty_msg.msg_msg := 'Transaccion Exitosa';
    --
EXCEPTION
    WHEN OTHERS THEN
        p_ty_msg.cod_msg := 'ORA'||ltrim(to_char(sqlcode, '000000'));
        p_ty_msg.msg_msg := 'tbl_qlogsservic_crud.actualizar_tbl_tlogsservic. '|| to_char(sysdate,'dd/mm/yyyy hh24miss')||'. Error: '||SQLERRM;
END actualizar_tbl_tlogsservic;
--------------------------------------------------------------------------------------------------
PROCEDURE eliminar_tbl_tlogsservic(
                                  p_ty_logs         tbl_qlogsservic_crud.ty_logs
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                )IS
    --
BEGIN
    --
    p_ty_msg.cod_msg := 'OK';
    --
    DELETE FROM tbl_tlogsservic 
        WHERE logs_logs = p_ty_logs.logs_logs
    ;
    --
    p_ty_msg.msg_msg := 'Transaccion Exitosa';
    --
EXCEPTION
    WHEN OTHERS THEN
        p_ty_msg.cod_msg := 'ORA'||ltrim(to_char(sqlcode, '000000'));
        p_ty_msg.msg_msg := 'tbl_qlogsservic_crud.eliminar_tbl_tlogsservic '|| to_char(sysdate,'dd/mm/yyyy hh24miss')||'. Error: '||SQLERRM;
END eliminar_tbl_tlogsservic;
--------------------------------------------------------------------------------------------------
END tbl_qlogsservic_crud;
/
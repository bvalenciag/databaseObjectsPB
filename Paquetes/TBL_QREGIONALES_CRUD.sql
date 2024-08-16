prompt
prompt PACKAGE: TBL_QREGIONALES_CRUD
prompt
CREATE OR REPLACE PACKAGE tbl_qregionales_crud IS
--
-- Reúne funciones y procedimientos directamente relacionados con la tabla tbl_tregionales
--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       14/12/2023 Cramirezs    000001       * Se crea paquete.
--                       Kilonova     MVP_2
-- ========== ========== ============ ============ ============================================================================================================
--
-------------------------------------------------------------------------------------------------
--Type
-------------------------------------------------------------------------------------------------
TYPE ty_regi IS RECORD( 
     regi_regi           tbl_tregionales.regi_regi          %TYPE
   , regi_empr           tbl_tregionales.regi_empr          %TYPE
   , regi_empr_ex        tbl_tregionales.regi_empr_ex       %TYPE
   , regi_banc           tbl_tregionales.regi_banc          %TYPE
   , regi_banc_ex        tbl_tregionales.regi_banc_ex       %TYPE
   , regi_fecha          tbl_tregionales.regi_fecha         %TYPE
   , regi_adic_reales    tbl_tregionales.regi_adic_reales   %TYPE
   , regi_reti_reales    tbl_tregionales.regi_reti_reales   %TYPE
   , regi_fuente         tbl_tregionales.regi_fuente        %TYPE
   , regi_fecins         tbl_tregionales.regi_fecins        %TYPE
   , regi_usuains        tbl_tregionales.regi_usuains       %TYPE
   , regi_fecupd         tbl_tregionales.regi_fecupd        %TYPE
   , regi_usuaupd        tbl_tregionales.regi_usuaupd       %TYPE
);
-------------------------------------------------------------------------------------------------
--Procedure - Function
-------------------------------------------------------------------------------------------------
/**
 * Description: Insertar en la tabla tbl_tregionales
 *
 * Author: Cramirezs
 * Created: 14/12/2023
 *
 * Param: p_ty_regi Description: Type de la tabla
 * Param: p_ty_msg Description: Type de errores
 */
PROCEDURE insertar_tbl_tregionales(
                                  p_ty_regi        tbl_qregionales_crud.ty_regi
                                , p_regi_regi  OUT  tbl_tregionales.regi_regi%TYPE
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                );
-------------------------------------------------------------------------------------------------
/**
 * Description: Actualizar en la tabla tbl_tregionales
 *
 * Author: Cramirezs
 * Created: 14/12/2023
 *
 * Param: p_ty_regi Description: Type de la tabla
 * Param: p_ty_msg Description: Type de errores
 */
PROCEDURE actualizar_tbl_tregionales(
                                  p_ty_regi         tbl_qregionales_crud.ty_regi
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                );
-------------------------------------------------------------------------------------------------    
/**
 * Description: Eliminar en la tabla tbl_tregionales
 *
 * Author: Cramirezs
 * Created: 2023/12/2023
 *
 * Param: p_ty_regi Description: Type de la tabla
 * Param: p_ty_msg Description: Type de errores
 */                      
PROCEDURE eliminar_tbl_tregionales(
                                  p_ty_regi         tbl_qregionales_crud.ty_regi
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                );
-------------------------------------------------------------------------------------------------
--
END tbl_qregionales_crud;
/
prompt
prompt PACKAGE BODY: tbl_qregionales_crud
prompt
--
CREATE OR REPLACE PACKAGE BODY tbl_qregionales_crud IS
--
-- #VERSION: 1000
--
---------------------------------------------------------------------------------------------------
PROCEDURE insertar_tbl_tregionales(
                                  p_ty_regi        tbl_qregionales_crud.ty_regi
                                , p_regi_regi  OUT  tbl_tregionales.regi_regi%TYPE
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                )IS
    --
    e_error      EXCEPTION;
    v_regi_regi  tbl_tregionales.regi_regi%TYPE;
    --
BEGIN
    --
    p_ty_msg.cod_msg := 'OK';
    --
    v_regi_regi := gen_qgeneral.p_secu('tbl_sregionales', p_ty_msg.msg_msg);
    --
    IF p_ty_msg.msg_msg IS NOT NULL THEN
        raise e_error;
    END IF;
    --
    INSERT INTO tbl_tregionales
        (
              regi_regi
            , regi_empr          
            , regi_empr_ex       
            , regi_banc          
            , regi_banc_ex       
            , regi_fecha         
            , regi_adic_reales   
            , regi_reti_reales   
            , regi_fuente        
            , regi_fecins
            , regi_usuains
        )VALUES
        (
              v_regi_regi
            , p_ty_regi.regi_empr          
            , p_ty_regi.regi_empr_ex       
            , p_ty_regi.regi_banc          
            , p_ty_regi.regi_banc_ex       
            , p_ty_regi.regi_fecha         
            , p_ty_regi.regi_adic_reales   
            , p_ty_regi.regi_reti_reales   
            , p_ty_regi.regi_fuente        
            , p_ty_regi.regi_fecins
            , p_ty_regi.regi_usuains
        );
    --
    p_regi_regi         := v_regi_regi;
    p_ty_msg.msg_msg := 'Proceso Exitoso';
    --
EXCEPTION
     WHEN e_error THEN
         p_ty_msg.cod_msg := 'ERR_SEC';
     WHEN OTHERS THEN
         p_ty_msg.cod_msg := 'ORA'||ltrim(to_char(sqlcode, '000000'));
         p_ty_msg.msg_msg := 'tbl_qregionales_crud.insertar_tbl_tregionales. '|| to_char(sysdate,'dd/mm/yyyy hh24miss')||'. Error: '||SQLERRM;
END insertar_tbl_tregionales;
--------------------------------------------------------------------------------------------------
PROCEDURE actualizar_tbl_tregionales(
                                  p_ty_regi         tbl_qregionales_crud.ty_regi
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                )IS
    --
BEGIN
    --
    p_ty_msg.cod_msg := 'OK';
    --
    UPDATE tbl_tregionales SET
          regi_empr           = NVL(p_ty_regi.regi_empr          , regi_empr          )
        , regi_empr_ex        = NVL(p_ty_regi.regi_empr_ex       , regi_empr_ex       )
        , regi_banc           = NVL(p_ty_regi.regi_banc          , regi_banc          )
        , regi_banc_ex        = NVL(p_ty_regi.regi_banc_ex       , regi_banc_ex       )
        , regi_fecha          = NVL(p_ty_regi.regi_fecha         , regi_fecha         )
        , regi_adic_reales    = NVL(p_ty_regi.regi_adic_reales   , regi_adic_reales   )
        , regi_reti_reales    = NVL(p_ty_regi.regi_reti_reales   , regi_reti_reales   )
        , regi_fuente         = NVL(p_ty_regi.regi_fuente        , regi_fuente        )
        , regi_fecupd         = NVL(p_ty_regi.regi_fecupd        , SYSDATE            )
        , regi_usuaupd        = NVL(p_ty_regi.regi_usuaupd       , USER               )
    WHERE regi_regi = p_ty_regi.regi_regi
    ;
    --
    p_ty_msg.msg_msg := 'Proceso Exitoso';
    --
EXCEPTION
    WHEN OTHERS THEN
        p_ty_msg.cod_msg := 'ORA'||ltrim(to_char(sqlcode, '000000'));
        p_ty_msg.msg_msg := 'tbl_qregionales_crud.actualizar_tbl_tregionales. '|| to_char(sysdate,'dd/mm/yyyy hh24miss')||'. Error: '||SQLERRM;
END actualizar_tbl_tregionales;
--------------------------------------------------------------------------------------------------
PROCEDURE eliminar_tbl_tregionales(
                                  p_ty_regi         tbl_qregionales_crud.ty_regi
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                )IS
    --
BEGIN
    --
    p_ty_msg.cod_msg := 'OK';
    --
    DELETE FROM tbl_tregionales 
        WHERE regi_regi = p_ty_regi.regi_regi
    ;
    --
    p_ty_msg.msg_msg := 'Proceso Exitoso';
    --
EXCEPTION
    WHEN OTHERS THEN
        p_ty_msg.cod_msg := 'ORA'||ltrim(to_char(sqlcode, '000000'));
        p_ty_msg.msg_msg := 'tbl_qregionales_crud.eliminar_tbl_tregionales '|| to_char(sysdate,'dd/mm/yyyy hh24miss')||'. Error: '||SQLERRM;
END eliminar_tbl_tregionales;
--------------------------------------------------------------------------------------------------
END tbl_qregionales_crud;
/
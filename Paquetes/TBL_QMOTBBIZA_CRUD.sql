prompt
prompt PACKAGE: TBL_QMOTBBIZA_CRUD
prompt
CREATE OR REPLACE PACKAGE TBL_QMOTBBIZA_CRUD IS
--
-- Reúne funciones y procedimientos directamente relacionados con la tabla tbl_tmotbbiza
--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       24/11/2023 Cramirezs    000001       * Se crea paquete.
--                       Kilonova     MVP_2
-- ========== ========== ============ ============ ============================================================================================================
--
-------------------------------------------------------------------------------------------------
--Type
-------------------------------------------------------------------------------------------------
TYPE ty_motb IS RECORD(
     motb_motb          tbl_tmotbbiza.motb_motb        %TYPE 
   , motb_caso          tbl_tmotbbiza.motb_caso        %TYPE
   , motb_empresa       tbl_tmotbbiza.motb_empresa     %TYPE
   , motb_empr          tbl_tmotbbiza.motb_empr        %TYPE
   , motb_banco         tbl_tmotbbiza.motb_banco       %TYPE
   , motb_banc          tbl_tmotbbiza.motb_banc        %TYPE
   , motb_nrocta        tbl_tmotbbiza.motb_nrocta      %TYPE
   , motb_cuen          tbl_tmotbbiza.motb_cuen        %TYPE
   , motb_fecha         tbl_tmotbbiza.motb_fecha       %TYPE
   , motb_descripcion   tbl_tmotbbiza.motb_descripcion %TYPE
   , motb_valor         tbl_tmotbbiza.motb_valor       %TYPE
   , motb_esta          tbl_tmotbbiza.motb_esta        %TYPE
   , motb_tipo_oper     tbl_tmotbbiza.motb_tipo_oper   %TYPE
   , motb_gmf           tbl_tmotbbiza.motb_gmf         %TYPE
   , motb_fuente        tbl_tmotbbiza.motb_fuente      %TYPE
   , motb_fecins        tbl_tmotbbiza.motb_fecins      %TYPE
   , motb_usuains       tbl_tmotbbiza.motb_usuains     %TYPE
   , motb_fecupd        tbl_tmotbbiza.motb_fecupd      %TYPE
   , motb_usuaupd       tbl_tmotbbiza.motb_usuaupd     %TYPE
);
-------------------------------------------------------------------------------------------------
--Procedure - Function
-------------------------------------------------------------------------------------------------
/**
 * Description: Insertar en la tabla tbl_tmotbbiza
 *
 * Author: Cramirezs
 * Created: 24/11/2023
 *
 * Param: p_ty_motb Description: Type de la tabla
 * Param: p_ty_msg Description: Type de errores
 */
PROCEDURE insertar_tbl_tmotbbiza(
                                  p_ty_motb        tbl_qmotbbiza_crud.ty_motb
                                , p_motb_motb  OUT tbl_tmotbbiza.motb_motb%TYPE
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                );
-------------------------------------------------------------------------------------------------
/**
 * Description: Actualizar en la tabla tbl_tmotbbiza
 *
 * Author: Cramirezs
 * Created: 24/11/2023
 *
 * Param: p_ty_motb Description: Type de la tabla
 * Param: p_ty_msg Description: Type de errores
 */
PROCEDURE actualizar_tbl_tmotbbiza(
                                  p_ty_motb        tbl_qmotbbiza_crud.ty_motb
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                );
-------------------------------------------------------------------------------------------------    
/**
 * Description: Eliminar en la tabla tbl_tmotbbiza
 *
 * Author: Cramirezs
 * Created: 2023/11/2023
 *
 * Param: p_ty_motb Description: Type de la tabla
 * Param: p_ty_msg Description: Type de errores
 */                      
PROCEDURE eliminar_tbl_tmotbbiza(
                                  p_ty_motb        tbl_qmotbbiza_crud.ty_motb
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                );
-------------------------------------------------------------------------------------------------
--
END tbl_qmotbbiza_crud;
/
prompt
prompt PACKAGE BODY: tbl_qmotbbiza_crud
prompt
--
CREATE OR REPLACE PACKAGE BODY tbl_qmotbbiza_crud IS
--
-- #VERSION: 1000
--
---------------------------------------------------------------------------------------------------
PROCEDURE insertar_tbl_tmotbbiza(
                                  p_ty_motb        tbl_qmotbbiza_crud.ty_motb
                                , p_motb_motb  OUT tbl_tmotbbiza.motb_motb%TYPE
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                )IS
    --
    e_error      EXCEPTION;
    v_motb_motb  tbl_tmotbbiza.motb_motb%TYPE;
    --
BEGIN
    --
    p_ty_msg.cod_msg := 'OK';
    --
    v_motb_motb := gen_qgeneral.p_secu('tbl_smotbbiza', p_ty_msg.msg_msg);
    --
    IF p_ty_msg.msg_msg IS NOT NULL THEN
        raise e_error;
    END IF;
    --
    INSERT INTO tbl_tmotbbiza
        (
              motb_motb
            , motb_caso       
            , motb_empresa    
            , motb_empr
            , motb_banco      
            , motb_banc
            , motb_nrocta     
            , motb_cuen       
            , motb_fecha      
            , motb_descripcion
            , motb_valor      
            , motb_esta     
            , motb_tipo_oper  
            , motb_gmf        
            , motb_fuente     
            , motb_fecins
            , motb_usuains
        )VALUES
        (
              v_motb_motb
            , p_ty_motb.motb_caso       
            , p_ty_motb.motb_empresa    
            , p_ty_motb.motb_empr
            , p_ty_motb.motb_banco      
            , p_ty_motb.motb_banc      
            , p_ty_motb.motb_nrocta     
            , p_ty_motb.motb_cuen       
            , p_ty_motb.motb_fecha      
            , p_ty_motb.motb_descripcion
            , p_ty_motb.motb_valor      
            , p_ty_motb.motb_esta
            , p_ty_motb.motb_tipo_oper  
            , p_ty_motb.motb_gmf        
            , p_ty_motb.motb_fuente     
            , p_ty_motb.motb_fecins
            , p_ty_motb.motb_usuains
        );
    --
    p_motb_motb      := v_motb_motb;
    p_ty_msg.msg_msg := 'Transaccion Exitosa';
    --
EXCEPTION
     WHEN e_error THEN
         p_ty_msg.cod_msg := 'ERR_SEC';
     WHEN OTHERS THEN
         p_ty_msg.cod_msg := 'ORA'||ltrim(to_char(sqlcode, '000000'));
         p_ty_msg.msg_msg := 'tbl_qmotbbiza_crud.insertar_tbl_tmotbbiza. '|| to_char(sysdate,'dd/mm/yyyy hh24miss')||'. Error: '||SQLERRM;
END insertar_tbl_tmotbbiza;
--------------------------------------------------------------------------------------------------
PROCEDURE actualizar_tbl_tmotbbiza(
                                  p_ty_motb         tbl_qmotbbiza_crud.ty_motb
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                )IS
    --
BEGIN
    --
    p_ty_msg.cod_msg := 'OK';
    --
    UPDATE tbl_tmotbbiza SET
          motb_caso        = NVL(p_ty_motb.motb_caso       , motb_caso       )
        , motb_empresa     = NVL(p_ty_motb.motb_empresa    , motb_empresa    )
        , motb_empr        = NVL(p_ty_motb.motb_empr       , motb_empr       )
        , motb_banco       = NVL(p_ty_motb.motb_banco      , motb_banco      )
        , motb_banc        = NVL(p_ty_motb.motb_banc       , motb_banc       )
        , motb_nrocta      = NVL(p_ty_motb.motb_nrocta     , motb_nrocta     )
        , motb_cuen        = NVL(p_ty_motb.motb_cuen       , motb_cuen       )
        , motb_fecha       = NVL(p_ty_motb.motb_fecha      , motb_fecha      )
        , motb_descripcion = NVL(p_ty_motb.motb_descripcion, motb_descripcion)
        , motb_valor       = NVL(p_ty_motb.motb_valor      , motb_valor      )
        , motb_esta        = NVL(p_ty_motb.motb_esta       , motb_esta       )
        , motb_tipo_oper   = NVL(p_ty_motb.motb_tipo_oper  , motb_tipo_oper  )
        , motb_gmf         = NVL(p_ty_motb.motb_gmf        , motb_gmf        )
        , motb_fuente      = NVL(p_ty_motb.motb_fuente     , motb_fuente     )
        , motb_fecupd      = NVL(p_ty_motb.motb_fecupd, SYSDATE)
        , motb_usuaupd     = NVL(p_ty_motb.motb_usuaupd, USER)
    WHERE motb_motb = p_ty_motb.motb_motb
    ;
    --
    p_ty_msg.msg_msg := 'Transaccion Exitosa';
    --
EXCEPTION
    WHEN OTHERS THEN
        p_ty_msg.cod_msg := 'ORA'||ltrim(to_char(sqlcode, '000000'));
        p_ty_msg.msg_msg := 'tbl_qmotbbiza_crud.actualizar_tbl_tmotbbiza. '|| to_char(sysdate,'dd/mm/yyyy hh24miss')||'. Error: '||SQLERRM;
END actualizar_tbl_tmotbbiza;
--------------------------------------------------------------------------------------------------
PROCEDURE eliminar_tbl_tmotbbiza(
                                  p_ty_motb         tbl_qmotbbiza_crud.ty_motb
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                )IS
    --
BEGIN
    --
    p_ty_msg.cod_msg := 'OK';
    --
    DELETE FROM tbl_tmotbbiza 
        WHERE motb_motb = p_ty_motb.motb_motb
    ;
    --
    p_ty_msg.msg_msg := 'Transaccion Exitosa';
    --
EXCEPTION
    WHEN OTHERS THEN
        p_ty_msg.cod_msg := 'ORA'||ltrim(to_char(sqlcode, '000000'));
        p_ty_msg.msg_msg := 'tbl_qmotbbiza_crud.eliminar_tbl_tmotbbiza '|| to_char(sysdate,'dd/mm/yyyy hh24miss')||'. Error: '||SQLERRM;
END eliminar_tbl_tmotbbiza;
--------------------------------------------------------------------------------------------------
END TBL_QMOTBBIZA_CRUD;
/
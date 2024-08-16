create or replace PACKAGE tbl_qcuentasban_crud IS
--
-- Reúne funciones y procedimientos directamente relacionados con la tabla tbl_tcuentasban
--
-- #VERSION: 1002
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       25/10/2023 Cramirezs    000001       * Se crea paquete.
--                       Kilonova
-- ========== ========== ============ ============ ============================================================================================================
-- 1001       10/01/2024 Jmartinezm    000001       * Se agregan algunas columnas.
--                       Kilonova       MVP2
-- ========== ========== ============ ============ ============================================================================================================
-- 1002       30/04/2024 Jmartinezm    000002       * Se agrega columna.
--                       Kilonova       MVP2
-- ========== ========== ============ ============ ============================================================================================================
--
-------------------------------------------------------------------------------------------------
--Type
-------------------------------------------------------------------------------------------------
TYPE ty_cuen IS RECORD(
     cuen_cuen          tbl_tcuentasban.cuen_cuen           %TYPE
   , cuen_empr          tbl_tcuentasban.cuen_empr           %TYPE
   , cuen_banc          tbl_tcuentasban.cuen_banc           %TYPE
   , cuen_nrocta        tbl_tcuentasban.cuen_nrocta         %TYPE
   , cuen_descripcion   tbl_tcuentasban.cuen_descripcion    %TYPE
   , cuen_tipo          tbl_tcuentasban.cuen_tipo           %TYPE
   , cuen_esta          tbl_tcuentasban.cuen_esta           %TYPE
   , cuen_sincroniza    tbl_tcuentasban.cuen_sincroniza     %TYPE
   , cuen_tasa_ea       tbl_tcuentasban.cuen_tasa_ea        %TYPE
   , cuen_sldmincor     tbl_tcuentasban.cuen_sldmincor      %TYPE -- 1001 10/01/2024 jmartinezm
   , cuen_tipo_oper     tbl_tcuentasban.cuen_tipo_oper      %TYPE -- 1001 10/01/2024 jmartinezm
   , cuen_cta_cud       tbl_tcuentasban.cuen_cta_cud        %TYPE -- 1001 10/01/2024 jmartinezm
   , cuen_sebra         tbl_tcuentasban.cuen_sebra          %TYPE -- 1002 30/04/2024 Jmartinezm 
   , cuen_fecins        tbl_tcuentasban.cuen_fecins         %TYPE
   , cuen_usuains       tbl_tcuentasban.cuen_usuains        %TYPE
   , cuen_fecupd        tbl_tcuentasban.cuen_fecupd         %TYPE
   , cuen_usuaupd       tbl_tcuentasban.cuen_usuaupd        %TYPE
);
-------------------------------------------------------------------------------------------------
--Procedure - Function
-------------------------------------------------------------------------------------------------
/**
 * Description: Insertar en la tabla tbl_tcuentasban
 *
 * Author: Cramirezs
 * Created: 25/10/2023
 *
 * Param: p_ty_cuen Description: Type de la tabla
 * Param: p_ty_msg Description: Type de errores
 */
PROCEDURE insertar_tbl_tcuentasban(
                                  p_ty_cuen        tbl_qcuentasban_crud.ty_cuen
                                , p_cuen_cuen  OUT  tbl_tcuentasban.cuen_cuen%TYPE
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                );
-------------------------------------------------------------------------------------------------
/**
 * Description: Actualizar en la tabla tbl_tcuentasban
 *
 * Author: Cramirezs
 * Created: 25/10/2023
 *
 * Param: p_ty_cuen Description: Type de la tabla
 * Param: p_ty_msg Description: Type de errores
 */
PROCEDURE actualizar_tbl_tcuentasban(
                                  p_ty_cuen         tbl_qcuentasban_crud.ty_cuen
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                );
-------------------------------------------------------------------------------------------------
/**
 * Description: Eliminar en la tabla tbl_tcuentasban
 *
 * Author: Cramirezs
 * Created: 2023/10/2023
 *
 * Param: p_ty_cuen Description: Type de la tabla
 * Param: p_ty_msg Description: Type de errores
 */
PROCEDURE eliminar_tbl_tcuentasban(
                                  p_ty_cuen         tbl_qcuentasban_crud.ty_cuen
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                );
-------------------------------------------------------------------------------------------------
--
END tbl_qcuentasban_crud;
/
create or replace PACKAGE BODY tbl_qcuentasban_crud IS
--
-- #VERSION: 1002
--
---------------------------------------------------------------------------------------------------
PROCEDURE insertar_tbl_tcuentasban(
                                  p_ty_cuen        tbl_qcuentasban_crud.ty_cuen
                                , p_cuen_cuen  OUT  tbl_tcuentasban.cuen_cuen%TYPE
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                )IS
    --
    e_error      EXCEPTION;
    v_cuen_cuen  tbl_tcuentasban.cuen_cuen%TYPE;
    --
BEGIN
    --
    p_ty_msg.cod_msg := 'OK';
    --
    v_cuen_cuen := gen_qgeneral.p_secu('tbl_scuentasban', p_ty_msg.msg_msg);
    --
    IF p_ty_msg.msg_msg IS NOT NULL THEN
        raise e_error;
    END IF;
    --
    INSERT INTO tbl_tcuentasban
        (
              cuen_cuen
            , cuen_empr
            , cuen_banc
            , cuen_nrocta
            , cuen_descripcion
            , cuen_tipo
            , cuen_esta
            , cuen_sincroniza
            , cuen_tasa_ea
            , cuen_sebra
            , cuen_fecins
            , cuen_usuains
        )VALUES
        (
              v_cuen_cuen
            , p_ty_cuen.cuen_empr
            , p_ty_cuen.cuen_banc
            , p_ty_cuen.cuen_nrocta
            , p_ty_cuen.cuen_descripcion
            , p_ty_cuen.cuen_tipo
            , p_ty_cuen.cuen_esta
            , p_ty_cuen.cuen_sincroniza
            , p_ty_cuen.cuen_tasa_ea
            , p_ty_cuen.cuen_sebra -- 1002 30/04/2024 Jmartinezm 
            , p_ty_cuen.cuen_fecins
            , p_ty_cuen.cuen_usuains
        );
    --
    p_cuen_cuen         := v_cuen_cuen;
    p_ty_msg.msg_msg := 'Transaccion Exitosa';
    --
EXCEPTION
     WHEN e_error THEN
         p_ty_msg.cod_msg := 'ERR_SEC';
     WHEN OTHERS THEN
         p_ty_msg.cod_msg := 'ORA'||ltrim(to_char(sqlcode, '000000'));
         p_ty_msg.msg_msg := 'tbl_qcuentasban_crud.insertar_tbl_tcuentasban. '|| to_char(sysdate,'dd/mm/yyyy hh24miss')||'. Error: '||SQLERRM;
END insertar_tbl_tcuentasban;
--------------------------------------------------------------------------------------------------
PROCEDURE actualizar_tbl_tcuentasban(
                                  p_ty_cuen         tbl_qcuentasban_crud.ty_cuen
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                )IS
    --
BEGIN
    --
    p_ty_msg.cod_msg := 'OK';
    --
    UPDATE tbl_tcuentasban SET
          cuen_empr         = NVL(p_ty_cuen.cuen_empr       , cuen_empr       )
        , cuen_banc         = NVL(p_ty_cuen.cuen_banc       , cuen_banc       )
        , cuen_nrocta       = NVL(p_ty_cuen.cuen_nrocta     , cuen_nrocta     )
        , cuen_descripcion  = NVL(p_ty_cuen.cuen_descripcion, cuen_descripcion)
        , cuen_tipo         = NVL(p_ty_cuen.cuen_tipo       , cuen_tipo       )
        , cuen_esta         = NVL(p_ty_cuen.cuen_esta       , cuen_esta       )
        , cuen_sincroniza   = NVL(p_ty_cuen.cuen_sincroniza , cuen_sincroniza )
        , cuen_tasa_ea      = NVL(p_ty_cuen.cuen_tasa_ea    , cuen_tasa_ea    )
        , cuen_sldmincor    = NVL(p_ty_cuen.cuen_sldmincor  , cuen_sldmincor  ) -- 1001 10/01/2024 jmartinezm
        , cuen_tipo_oper    = NVL(p_ty_cuen.cuen_tipo_oper  , cuen_tipo_oper  ) -- 1001 10/01/2024 jmartinezm
        , cuen_cta_cud      = NVL(p_ty_cuen.cuen_cta_cud    , cuen_cta_cud    ) -- 1001 10/01/2024 jmartinezm
        , cuen_sebra        = NVL(p_ty_cuen.cuen_sebra      , cuen_sebra      ) -- 1002 30/04/2024 Jmartinezm 
        , cuen_fecupd       = NVL(p_ty_cuen.cuen_fecupd     , SYSDATE)
        , cuen_usuaupd      = NVL(p_ty_cuen.cuen_usuaupd    , USER)
    WHERE cuen_cuen = p_ty_cuen.cuen_cuen
    ;
    --
    p_ty_msg.msg_msg := 'Proceso Exitoso';
    --
EXCEPTION
    WHEN OTHERS THEN
        p_ty_msg.cod_msg := 'ORA'||ltrim(to_char(sqlcode, '000000'));
        p_ty_msg.msg_msg := 'tbl_qcuentasban_crud.actualizar_tbl_tcuentasban. '|| to_char(sysdate,'dd/mm/yyyy hh24miss')||'. Error: '||SQLERRM;
END actualizar_tbl_tcuentasban;
--------------------------------------------------------------------------------------------------
PROCEDURE eliminar_tbl_tcuentasban(
                                  p_ty_cuen         tbl_qcuentasban_crud.ty_cuen
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                )IS
    --
BEGIN
    --
    p_ty_msg.cod_msg := 'OK';
    --
    UPDATE  tbl_tcuentasban
        SET cuen_tasa_ea = null
        WHERE cuen_cuen = p_ty_cuen.cuen_cuen
    ;
    --
    p_ty_msg.msg_msg := 'Proceso Exitoso';
    --
EXCEPTION
    WHEN OTHERS THEN
        p_ty_msg.cod_msg := 'ORA'||ltrim(to_char(sqlcode, '000000'));
        p_ty_msg.msg_msg := 'tbl_qcuentasban_crud.eliminar_tbl_tcuentasban '|| to_char(sysdate,'dd/mm/yyyy hh24miss')||'. Error: '||SQLERRM;
END eliminar_tbl_tcuentasban;
--------------------------------------------------------------------------------------------------
END tbl_qcuentasban_crud;
/
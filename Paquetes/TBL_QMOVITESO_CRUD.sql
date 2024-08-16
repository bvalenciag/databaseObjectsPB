prompt
prompt PACKAGE: TBL_QMOVITESO_CRUD
prompt
create or replace PACKAGE tbl_qmoviteso_crud IS
--
-- Reúne funciones y procedimientos directamente relacionados con la tabla tbl_tmoviteso
--
-- #VERSION: 1001
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       26/10/2023 Cramirezs    000001       * Se crea paquete.
--                       Kilonova
-- ========== ========== ============ ============ ============================================================================================================
-- 1001       06/02/2024 Jmartinez    000002       * Se crea nueva columna para la tabla.
--                       Kilonova
-- ========== ========== ============ ============ ============================================================================================================
--
-------------------------------------------------------------------------------------------------
--Type
-------------------------------------------------------------------------------------------------
TYPE ty_movi IS RECORD(
     movi_movi          tbl_tmoviteso.movi_movi%TYPE
   , movi_nrocom        tbl_tmoviteso.movi_nrocom%TYPE
   , movi_fecmov        tbl_tmoviteso.movi_fecmov%TYPE
   , movi_tpco          tbl_tmoviteso.movi_tpco%TYPE
   , movi_cias          tbl_tmoviteso.movi_cias%TYPE
   , movi_rengln        tbl_tmoviteso.movi_rengln%TYPE
   , movi_cuen          tbl_tmoviteso.movi_cuen%TYPE
   , movi_fecha         tbl_tmoviteso.movi_fecha%TYPE
   , movi_descripcion   tbl_tmoviteso.movi_descripcion%TYPE
   , movi_fuente        tbl_tmoviteso.movi_fuente%TYPE
   , movi_valor         tbl_tmoviteso.movi_valor%TYPE
   , movi_esta          tbl_tmoviteso.movi_esta%TYPE
   , movi_tipo_oper     tbl_tmoviteso.movi_tipo_oper%TYPE
   , movi_encargo       tbl_tmoviteso.movi_encargo%TYPE -- 1001  06/02/2024 Jmartinez 
   , movi_fecins        tbl_tmoviteso.movi_fecins%TYPE
   , movi_usuains       tbl_tmoviteso.movi_usuains%TYPE
   , movi_fecupd        tbl_tmoviteso.movi_fecupd%TYPE
   , movi_usuaupd       tbl_tmoviteso.movi_usuaupd%TYPE
);
-------------------------------------------------------------------------------------------------
--Procedure - Function
-------------------------------------------------------------------------------------------------
/**
 * Description: Insertar en la tabla tbl_tmoviteso
 *
 * Author: Cramirezs
 * Created: 26/10/2023
 *
 * Param: p_ty_movi Description: Type de la tabla
 * Param: p_ty_msg Description: Type de errores
 */
PROCEDURE insertar_tbl_tmoviteso(
                                  p_ty_movi        tbl_qmoviteso_crud.ty_movi
                                , p_movi_movi  OUT  tbl_tmoviteso.movi_movi%TYPE
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                );
-------------------------------------------------------------------------------------------------
/**
 * Description: Actualizar en la tabla tbl_tmoviteso
 *
 * Author: Cramirezs
 * Created: 26/10/2023
 *
 * Param: p_ty_movi Description: Type de la tabla
 * Param: p_ty_msg Description: Type de errores
 */
PROCEDURE actualizar_tbl_tmoviteso(
                                  p_ty_movi         tbl_qmoviteso_crud.ty_movi
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                );
-------------------------------------------------------------------------------------------------
/**
 * Description: Eliminar en la tabla tbl_tmoviteso
 *
 * Author: Cramirezs
 * Created: 2023/10/2023
 *
 * Param: p_ty_movi Description: Type de la tabla
 * Param: p_ty_msg Description: Type de errores
 */
PROCEDURE eliminar_tbl_tmoviteso(
                                  p_ty_movi         tbl_qmoviteso_crud.ty_movi
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                );
-------------------------------------------------------------------------------------------------
--
END tbl_qmoviteso_crud;
/
prompt
prompt PACKAGE BODY: TBL_QMOVITESO_CRUD
prompt
--
create or replace PACKAGE BODY tbl_qmoviteso_crud IS
--
-- #VERSION: 1000
--
---------------------------------------------------------------------------------------------------
PROCEDURE insertar_tbl_tmoviteso(
                                  p_ty_movi        tbl_qmoviteso_crud.ty_movi
                                , p_movi_movi  OUT  tbl_tmoviteso.movi_movi%TYPE
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                )IS
    --
    e_error      EXCEPTION;
    v_movi_movi  tbl_tmoviteso.movi_movi%TYPE;
    --
BEGIN
    --
    p_ty_msg.cod_msg := 'OK';
    --
    v_movi_movi := gen_qgeneral.p_secu('tbl_smoviteso', p_ty_msg.msg_msg);
    --
    IF p_ty_msg.msg_msg IS NOT NULL THEN
        raise e_error;
    END IF;
    --
    INSERT INTO tbl_tmoviteso
        (
              movi_movi
            , movi_nrocom
            , movi_fecmov
            , movi_tpco
            , movi_cias
            , movi_rengln
            , movi_cuen
            , movi_fecha
            , movi_descripcion
            , movi_fuente
            , movi_valor
            , movi_esta
            , movi_tipo_oper
            , movi_encargo -- 1001       06/02/2024 Jmartinez 
            , movi_fecins
            , movi_usuains
        )VALUES
        (
              v_movi_movi
            , p_ty_movi.movi_nrocom
            , p_ty_movi.movi_fecmov
            , p_ty_movi.movi_tpco
            , p_ty_movi.movi_cias
            , p_ty_movi.movi_rengln
            , p_ty_movi.movi_cuen
            , p_ty_movi.movi_fecha
            , p_ty_movi.movi_descripcion
            , p_ty_movi.movi_fuente
            , p_ty_movi.movi_valor
            , p_ty_movi.movi_esta
            , p_ty_movi.movi_tipo_oper
            , p_ty_movi.movi_encargo -- 1001       06/02/2024 Jmartinez 
            , p_ty_movi.movi_fecins
            , p_ty_movi.movi_usuains
        );
    --
    p_movi_movi         := v_movi_movi;
    p_ty_msg.msg_msg := 'Transaccion Exitosa';
    --
EXCEPTION
     WHEN e_error THEN
         p_ty_msg.cod_msg := 'ERR_SEC';
     WHEN OTHERS THEN
         p_ty_msg.cod_msg := 'ORA'||ltrim(to_char(sqlcode, '000000'));
         p_ty_msg.msg_msg := 'tbl_qmoviteso_crud.insertar_tbl_tmoviteso. '|| to_char(sysdate,'dd/mm/yyyy hh24miss')||'. Error: '||SQLERRM;
END insertar_tbl_tmoviteso;
--------------------------------------------------------------------------------------------------
PROCEDURE actualizar_tbl_tmoviteso(
                                  p_ty_movi         tbl_qmoviteso_crud.ty_movi
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                )IS
    --
BEGIN
    --
    p_ty_msg.cod_msg := 'OK';
    --
    UPDATE tbl_tmoviteso SET
          movi_nrocom       = NVL(p_ty_movi.movi_nrocom, movi_nrocom)
        , movi_fecmov       = NVL(p_ty_movi.movi_fecmov, movi_fecmov)
        , movi_tpco         = NVL(p_ty_movi.movi_tpco, movi_tpco)
        , movi_cias         = NVL(p_ty_movi.movi_cias, movi_cias)
        , movi_rengln       = NVL(p_ty_movi.movi_rengln, movi_rengln)
        , movi_cuen         = NVL(p_ty_movi.movi_cuen, movi_cuen)
        , movi_fecha        = NVL(p_ty_movi.movi_fecha, movi_fecha)
        , movi_descripcion  = NVL(p_ty_movi.movi_descripcion, movi_descripcion)
        , movi_fuente       = NVL(p_ty_movi.movi_fuente, movi_fuente)
        , movi_valor        = NVL(p_ty_movi.movi_valor, movi_valor)
        , movi_esta         = NVL(p_ty_movi.movi_esta, movi_esta)
        , movi_tipo_oper    = NVL(p_ty_movi.movi_tipo_oper, movi_tipo_oper)
        , movi_encargo      = NVL(p_ty_movi.movi_encargo, movi_encargo) -- 1001       06/02/2024 Jmartinez 
        , movi_fecupd       = NVL(p_ty_movi.movi_fecupd, SYSDATE)
        , movi_usuaupd      = NVL(p_ty_movi.movi_usuaupd, USER)
    WHERE movi_movi = p_ty_movi.movi_movi
    ;
    --
    p_ty_msg.msg_msg := 'Transaccion Exitosa';
    --
EXCEPTION
    WHEN OTHERS THEN
        p_ty_msg.cod_msg := 'ORA'||ltrim(to_char(sqlcode, '000000'));
        p_ty_msg.msg_msg := 'tbl_qmoviteso_crud.actualizar_tbl_tmoviteso. '|| to_char(sysdate,'dd/mm/yyyy hh24miss')||'. Error: '||SQLERRM;
END actualizar_tbl_tmoviteso;
--------------------------------------------------------------------------------------------------
PROCEDURE eliminar_tbl_tmoviteso(
                                  p_ty_movi         tbl_qmoviteso_crud.ty_movi
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                )IS
    --
BEGIN
    --
    p_ty_msg.cod_msg := 'OK';
    --
    DELETE FROM tbl_tmoviteso
        WHERE movi_movi = p_ty_movi.movi_movi
    ;
    --
    p_ty_msg.msg_msg := 'Transaccion Exitosa';
    --
EXCEPTION
    WHEN OTHERS THEN
        p_ty_msg.cod_msg := 'ORA'||ltrim(to_char(sqlcode, '000000'));
        p_ty_msg.msg_msg := 'tbl_qmoviteso_crud.eliminar_tbl_tmoviteso '|| to_char(sysdate,'dd/mm/yyyy hh24miss')||'. Error: '||SQLERRM;
END eliminar_tbl_tmoviteso;
--------------------------------------------------------------------------------------------------
END tbl_qmoviteso_crud;
/

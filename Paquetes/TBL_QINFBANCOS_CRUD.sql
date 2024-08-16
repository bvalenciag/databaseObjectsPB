prompt
prompt PACKAGE: TBL_QINFBANCOS_CRUD
prompt
CREATE OR REPLACE PACKAGE tbl_qinfbancos_crud IS
--
-- Reúne funciones y procedimientos directamente relacionados con la tabla tbl_tinfbancos
--
-- #VERSION: 1002
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       23/01/2024 Jmartinezm    00001       * Se crea paquete.
--                       Kilonova      MVP2
-- ========== ========== ============ ============ ============================================================================================================
-- 1001       21/02/2024 Jmartinezm    00002       * Se agrega una columna.
--                       Kilonova      MVP2
-- ========== ========== ============ ============ ============================================================================================================
-- 1002       22/03/2024 Jmartinezm    00003       * Se agrega una columna.
--                       Kilonova      MVP2
-- ========== ========== ============ ============ ============================================================================================================
--
-------------------------------------------------------------------------------------------------
--Type
-------------------------------------------------------------------------------------------------
TYPE ty_infb IS RECORD(
     infb_infb          tbl_tinfbancos.infb_infb            %TYPE
   , infb_banc          tbl_tinfbancos.infb_banc            %TYPE
   , infb_nit           tbl_tinfbancos.infb_nit             %TYPE
   , infb_desti         tbl_tinfbancos.infb_desti           %TYPE
   , infb_cargo         tbl_tinfbancos.infb_cargo           %TYPE
   , infb_dv            tbl_tinfbancos.infb_dv              %TYPE
   , infb_dir           tbl_tinfbancos.infb_dir             %TYPE
   , infb_ciudad        tbl_tinfbancos.infb_ciudad          %TYPE
   , infb_fax           tbl_tinfbancos.infb_fax             %TYPE
   , infb_telefono      tbl_tinfbancos.infb_telefono        %TYPE
   , infb_ref           tbl_tinfbancos.infb_ref             %TYPE
   , infb_concep        tbl_tinfbancos.infb_concep          %TYPE
   , infb_oficina       tbl_tinfbancos.infb_oficina         %TYPE -- 1001       21/02/2024 Jmartinezm
   , infb_refegr        tbl_tinfbancos.infb_refegr          %TYPE -- 1001       21/02/2024 Jmartinezm
   , infb_comision      tbl_tinfbancos.infb_comision        %TYPE -- 1002       22/03/2024 Jmartinezm
   , infb_comision_m    tbl_tinfbancos.infb_comision_m      %TYPE -- 1002       22/03/2024 Jmartinezm
   , infb_cuen_cud_cod  tbl_tinfbancos.infb_cuen_cud_cod    %TYPE -- 1002       22/03/2024 Jmartinezm
   , infb_cuen_cud_desc tbl_tinfbancos.infb_cuen_cud_desc   %TYPE -- 1002       22/03/2024 Jmartinezm
   , infb_portafolio    tbl_tinfbancos.infb_portafolio      %TYPE -- 1002       22/03/2024 Jmartinezm
   , infb_fecins        tbl_tinfbancos.infb_fecins          %TYPE
   , infb_usuains       tbl_tinfbancos.infb_usuains         %TYPE
   , infb_fecupd        tbl_tinfbancos.infb_fecupd          %TYPE
   , infb_usuaupd       tbl_tinfbancos.infb_usuaupd         %TYPE
);
-------------------------------------------------------------------------------------------------
--Procedure - Function
-------------------------------------------------------------------------------------------------
/**
 * Description: Insertar en la tabla tbl_tinfbancos
 *
 * Author: Jmartinezm
 * Created: 23/01/2024
 *
 * Param: p_ty_infb Description: Type de la tabla
 * Param: p_ty_msg Description: Type de errores
 */
PROCEDURE insertar_tbl_tinfbancos(
                                  p_ty_infb        tbl_qinfbancos_crud.ty_infb
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                );
-------------------------------------------------------------------------------------------------
/**
 * Description: Actualizar en la tabla tbl_tinfbancos
 *
 * Author: Jmartinezm
 * Created: 23/01/2024
 *
 * Param: p_ty_infb Description: Type de la tabla
 * Param: p_ty_msg Description: Type de errores
 */
PROCEDURE actualizar_tbl_tinfbancos(
                                  p_ty_infb         tbl_qinfbancos_crud.ty_infb
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                );
-------------------------------------------------------------------------------------------------    
/**
 * Description: Eliminar en la tabla tbl_tinfbancos
 *
 * Author: Jmartinezm
 * Created: 2024/01/2024
 *
 * Param: p_ty_infb Description: Type de la tabla
 * Param: p_ty_msg Description: Type de errores
 */                      
PROCEDURE eliminar_tbl_tinfbancos(
                                  p_ty_infb         tbl_qinfbancos_crud.ty_infb
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                );
-------------------------------------------------------------------------------------------------
--
END tbl_qinfbancos_crud;
/
prompt
prompt PACKAGE BODY: tbl_qinfbancos_crud
prompt
--
CREATE OR REPLACE PACKAGE BODY tbl_qinfbancos_crud IS
--
-- #VERSION: 1002
--
---------------------------------------------------------------------------------------------------
PROCEDURE insertar_tbl_tinfbancos(
                                  p_ty_infb        tbl_qinfbancos_crud.ty_infb
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                )IS
    --
    e_error      EXCEPTION;
    v_infb_infb  tbl_tinfbancos.infb_infb%TYPE;
    --
BEGIN
    --
    p_ty_msg.cod_msg := 'OK';
    --
    v_infb_infb := gen_qgeneral.p_secu('tbl_sinfbancos', p_ty_msg.msg_msg);
    --
    IF p_ty_msg.msg_msg IS NOT NULL THEN
        raise e_error;
    END IF;
    --
    INSERT INTO tbl_tinfbancos
        (
              infb_infb
            , infb_banc
            , infb_nit
            , infb_desti
            , infb_cargo
            , infb_dv
            , infb_dir
            , infb_ciudad
            , infb_fax
            , infb_telefono
            , infb_ref
            , infb_concep
            , infb_oficina          -- 1001       21/02/2024 Jmartinezm
            , infb_refegr           -- 1001       21/02/2024 Jmartinezm
            , infb_comision         -- 1002       22/03/2024 Jmartinezm
            , infb_comision_m       -- 1002       22/03/2024 Jmartinezm
            , infb_cuen_cud_cod     -- 1002       22/03/2024 Jmartinezm
            , infb_cuen_cud_desc    -- 1002       22/03/2024 Jmartinezm
            , infb_portafolio       -- 1002       22/03/2024 Jmartinezm
            , infb_fecins
            , infb_usuains
        )VALUES
        (
              v_infb_infb
            , p_ty_infb.infb_banc
            , p_ty_infb.infb_nit
            , p_ty_infb.infb_desti
            , p_ty_infb.infb_cargo
            , p_ty_infb.infb_dv
            , p_ty_infb.infb_dir
            , p_ty_infb.infb_ciudad
            , p_ty_infb.infb_fax
            , p_ty_infb.infb_telefono
            , p_ty_infb.infb_ref
            , p_ty_infb.infb_concep
            , p_ty_infb.infb_oficina            -- 1001       21/02/2024 Jmartinezm
            , p_ty_infb.infb_refegr             -- 1001       21/02/2024 Jmartinezm
            , p_ty_infb.infb_comision           -- 1002       22/03/2024 Jmartinezm
            , p_ty_infb.infb_comision_m         -- 1002       22/03/2024 Jmartinezm
            , p_ty_infb.infb_cuen_cud_cod       -- 1002       22/03/2024 Jmartinezm
            , p_ty_infb.infb_cuen_cud_desc      -- 1002       22/03/2024 Jmartinezm
            , p_ty_infb.infb_portafolio         -- 1002       22/03/2024 Jmartinezm
            , p_ty_infb.infb_fecins
            , p_ty_infb.infb_usuains
        );
    --
    p_ty_msg.msg_msg := 'Proceso Exitoso';
    --
EXCEPTION
     WHEN e_error THEN
         p_ty_msg.cod_msg := 'ERR_SEC';
     WHEN OTHERS THEN
         p_ty_msg.cod_msg := 'ORA'||ltrim(to_char(sqlcode, '000000'));
         p_ty_msg.msg_msg := 'tbl_qinfbancos_crud.insertar_tbl_tinfbancos. '|| to_char(sysdate,'dd/mm/yyyy hh24miss')||'. Error: '||SQLERRM;
END insertar_tbl_tinfbancos;
--------------------------------------------------------------------------------------------------
PROCEDURE actualizar_tbl_tinfbancos(
                                  p_ty_infb         tbl_qinfbancos_crud.ty_infb
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                )IS
    --
BEGIN
    --
    p_ty_msg.cod_msg := 'OK';
    --
    UPDATE tbl_tinfbancos SET
          infb_banc         = NVL(p_ty_infb.infb_banc, infb_banc)
        , infb_nit          = NVL(p_ty_infb.infb_nit, infb_nit)
        , infb_desti        = NVL(p_ty_infb.infb_desti, infb_desti)
        , infb_cargo        = NVL(p_ty_infb.infb_cargo, infb_cargo)
        , infb_dv           = NVL(p_ty_infb.infb_dv, infb_dv)
        , infb_dir          = NVL(p_ty_infb.infb_dir, infb_dir)
        , infb_ciudad       = NVL(p_ty_infb.infb_ciudad, infb_ciudad)
        , infb_fax          = NVL(p_ty_infb.infb_fax, infb_fax)
        , infb_telefono     = NVL(p_ty_infb.infb_telefono, infb_telefono)
        , infb_ref          = NVL(p_ty_infb.infb_ref, infb_ref)
        , infb_concep       = NVL(p_ty_infb.infb_concep, infb_concep)
        , infb_oficina      = NVL(p_ty_infb.infb_oficina, infb_oficina)             -- 1001       21/02/2024 Jmartinezm
        , infb_refegr       = NVL(p_ty_infb.infb_refegr, infb_refegr)               -- 1001       21/02/2024 Jmartinezm
        , infb_comision     = NVL(p_ty_infb.infb_comision, infb_comision)           -- 1002       22/03/2024 Jmartinezm
        , infb_comision_m   = NVL(p_ty_infb.infb_comision_m, infb_comision_m)       -- 1002       22/03/2024 Jmartinezm
        , infb_cuen_cud_cod = NVL(p_ty_infb.infb_cuen_cud_cod, infb_cuen_cud_cod)   -- 1002       22/03/2024 Jmartinezm
        , infb_cuen_cud_desc= NVL(p_ty_infb.infb_cuen_cud_desc, infb_cuen_cud_desc) -- 1002       22/03/2024 Jmartinezm
        , infb_portafolio   = NVL(p_ty_infb.infb_portafolio, infb_portafolio)       -- 1002       22/03/2024 Jmartinezm
        , infb_fecupd       = NVL(p_ty_infb.infb_fecupd, SYSDATE)
        , infb_usuaupd      = NVL(p_ty_infb.infb_usuaupd, USER)
    WHERE infb_infb = p_ty_infb.infb_infb
    ;
    --
    p_ty_msg.msg_msg := 'Proceso Exitoso';
    --
EXCEPTION
    WHEN OTHERS THEN
        p_ty_msg.cod_msg := 'ORA'||ltrim(to_char(sqlcode, '000000'));
        p_ty_msg.msg_msg := 'tbl_qinfbancos_crud.actualizar_tbl_tinfbancos. '|| to_char(sysdate,'dd/mm/yyyy hh24miss')||'. Error: '||SQLERRM;
END actualizar_tbl_tinfbancos;
--------------------------------------------------------------------------------------------------
PROCEDURE eliminar_tbl_tinfbancos(
                                  p_ty_infb         tbl_qinfbancos_crud.ty_infb
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                )IS
    --
BEGIN
    --
    p_ty_msg.cod_msg := 'OK';
    --
    DELETE FROM tbl_tinfbancos 
        WHERE infb_infb = p_ty_infb.infb_infb
    ;
    --
    p_ty_msg.msg_msg := 'Proceso Exitoso';
    --
EXCEPTION
    WHEN OTHERS THEN
        p_ty_msg.cod_msg := 'ORA'||ltrim(to_char(sqlcode, '000000'));
        p_ty_msg.msg_msg := 'tbl_qinfbancos_crud.eliminar_tbl_tinfbancos '|| to_char(sysdate,'dd/mm/yyyy hh24miss')||'. Error: '||SQLERRM;
END eliminar_tbl_tinfbancos;
--------------------------------------------------------------------------------------------------
END tbl_qinfbancos_crud;
/
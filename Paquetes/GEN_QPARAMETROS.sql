prompt
prompt PACKAGE: GEN_QPARAMETROS
prompt
CREATE OR REPLACE PACKAGE gen_qparametros IS
--
-- Reúne funciones y procedimientos directamente relacionados con el procedimiento de parametros
--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       14/02/2024 Cramirezs    000001       * Se crea paquete.
--                       Kilonova
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
PROCEDURE sp_ins_gen_tparametros(p_modu           gen_tparametros.para_modu%TYPE
                               , p_sigl           gen_tparametros.para_siglas%TYPE
                               , p_desc           gen_tparametros.para_descripcion%TYPE
                               , p_tipo           gen_tparametros.para_tipo_dato%TYPE
                               , p_valo           gen_tparametros.para_valor%TYPE
                               , p_visi           gen_tparametros.para_visible %TYPE
                            );
--
-------------------------------------------------------------------------------------------------
--
-------------------------------------------------------------------------------------------------
--
END gen_qparametros;
/
prompt
prompt PACKAGE BODY: gen_qparametros
prompt
--
CREATE OR REPLACE PACKAGE BODY gen_qparametros IS
--
-- #VERSION: 1000
--
---------------------------------------------------------------------------------------------------
PROCEDURE sp_ins_gen_tparametros(p_modu           gen_tparametros.para_modu%TYPE
                               , p_sigl           gen_tparametros.para_siglas%TYPE
                               , p_desc           gen_tparametros.para_descripcion%TYPE
                               , p_tipo           gen_tparametros.para_tipo_dato%TYPE
                               , p_valo           gen_tparametros.para_valor%TYPE
                               , p_visi           gen_tparametros.para_visible %TYPE
                          )IS
    PRAGMA AUTONOMOUS_TRANSACTION; 
    --
    e_error      EXCEPTION;
    --
    CURSOR c_para IS
        SELECT para_para 
          FROM gen_tparametros
         WHERE para_modu   = p_modu
           AND para_siglas = p_sigl
        ;
    --
    r_para      c_para%ROWTYPE;
    --
BEGIN
    --
    OPEN  c_para ;
    FETCH c_para INTO r_para;
    IF c_para%NOTFOUND THEN
        --
        INSERT INTO gen_tparametros (
              para_para
            , para_modu
            , para_siglas
            , para_descripcion
            , para_tipo_dato
            , para_valor
            , para_visible
            , para_fecins
            , para_usuains
        )VALUES(
              gen_sparametros.NEXTVAL
            , p_modu
            , p_sigl
            , p_desc
            , p_tipo
            , p_valo
            , p_visi
            , SYSDATE
            , USER
        );
        --
    /*
    ELSE
        --
        UPDATE gen_tparametros
           SET para_descripcion = p_desc
             , para_tipo_dato   = p_tipo
             , para_valor       = p_valo
             , para_visible     = p_visi
             , para_fecupd      = SYSDATE
             , para_usuaupd     = USER
         WHERE para_para        = r_para.para_para
        ;
        */
        --
    END IF;
    CLOSE c_para;
    --
    COMMIT;
    --
EXCEPTION
    WHEN OTHERS THEN
        raise_application_error( -20000, 'Error en sp_ins_gen_tparametros: '||sqlerrm);
END sp_ins_gen_tparametros;
---------------------------------------------------------------------------------------------------
--
END gen_qparametros;
/
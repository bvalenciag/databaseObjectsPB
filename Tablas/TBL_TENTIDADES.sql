--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       24/01/2024 Jbeniteze    000001       * Se crea tabla.
--                       Kilonova     MVP2
-- ========== ========== ============ ============ ============================================================================================================
--
/**********************************************************************************/
Prompt
Prompt Creando tabla TBL_TENTIDADES
Prompt
/**********************************************************************************/
CREATE TABLE tbl_tentidades(
      enti_enti         NUMBER(9)                           CONSTRAINT nn_tbl_tenti_enti NOT NULL
    , enti_vari         NUMBER(9)                           CONSTRAINT nn_tbl_tenti_vari NOT NULL
    , enti_descripcion  VARCHAR2(1000)                      CONSTRAINT nn_tbl_tenti_descripcion NOT NULL
    , enti_fecins       DATE DEFAULT SYSDATE                CONSTRAINT nn_tbl_tenti_fecins NOT NULL
    , enti_usuains      VARCHAR2(20) DEFAULT USER           CONSTRAINT nn_tbl_tenti_user NOT NULL
    , enti_fecupd       DATE
    , enti_usuaupd      VARCHAR2(20)
)
;
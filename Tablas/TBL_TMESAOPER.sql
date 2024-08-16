--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       26/12/2023 Jmartinezm    00001       * Se crea tabla.
--                       Kilonova      MVP2
-- ========== ========== ============ ============ ============================================================================================================
--
/**********************************************************************************/
Prompt
Prompt Creando tabla TBL_TMESAOPER
Prompt
/**********************************************************************************/
CREATE TABLE tbl_tmesaoper(
      mesa_mesa         NUMBER(9)                           CONSTRAINT nn_tbl_tmesa_mesa NOT NULL
    , mesa_fecha        DATE
    , mesa_empr         NUMBER(9)                           CONSTRAINT nn_tbl_tmesa_empr NOT NULL
    , mesa_banc         NUMBER(9)                           
    , mesa_oper         NUMBER(9)                        
    , mesa_descripcion  VARCHAR2(200)
    , mesa_ticket       VARCHAR2(50)
    , mesa_valor        NUMBER(20,2)                        CONSTRAINT nn_tbl_tmesa_valor NOT NULL
    , mesa_fecins       DATE DEFAULT SYSDATE                CONSTRAINT nn_tbl_tmesa_fecins NOT NULL
    , mesa_usuains      VARCHAR2(20) DEFAULT USER           CONSTRAINT nn_tbl_tmesa_user NOT NULL
    , mesa_fecupd       DATE
    , mesa_usuaupd      VARCHAR2(20)
)
;
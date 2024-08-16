--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       01/02/2024 Cramirezs    000001       * Se crea tabla.
--                       Kilonova
-- ========== ========== ============ ============ ============================================================================================================
--
/**********************************************************************************/
Prompt
Prompt Creando tabla GEN_TDECENAS
Prompt
/**********************************************************************************/
CREATE TABLE gen_tdecenas(
      dece_dece         NUMBER(9)                           CONSTRAINT nn_gen_tdece_dece   NOT NULL
    , dece_letras       VARCHAR2(100)                       
    , dece_fecins       DATE DEFAULT SYSDATE                CONSTRAINT nn_gen_tdece_fecins NOT NULL
    , dece_usuains      VARCHAR2(20) DEFAULT USER           CONSTRAINT nn_gen_tdece_user   NOT NULL
    , dece_fecupd       DATE
    , dece_usuaupd      VARCHAR2(20)
)
;
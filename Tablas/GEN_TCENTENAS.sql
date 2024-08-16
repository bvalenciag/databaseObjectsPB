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
Prompt Creando tabla GEN_TCENTENAS
Prompt
/**********************************************************************************/
CREATE TABLE gen_tcentenas(
      cent_cent         NUMBER(9)                           CONSTRAINT nn_gen_tcent_cent   NOT NULL
    , cent_letras       VARCHAR2(100)                       
    , cent_fecins       DATE DEFAULT SYSDATE                CONSTRAINT nn_gen_tcent_fecins NOT NULL
    , cent_usuains      VARCHAR2(20) DEFAULT USER           CONSTRAINT nn_gen_tcent_user   NOT NULL
    , cent_fecupd       DATE
    , cent_usuaupd      VARCHAR2(20)
)
;
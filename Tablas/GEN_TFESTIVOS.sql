--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       04/01/2024 Cramirezs    000001       * Se crea tabla.
--                       Kilonova     MVP_2
-- ========== ========== ============ ============ ============================================================================================================
--
/**********************************************************************************/
Prompt
Prompt Creando tabla GEN_TFESTIVOS
Prompt
/**********************************************************************************/
CREATE TABLE gen_tfestivos(
      fest_fest         DATE                                CONSTRAINT nn_gen_tfest_fest NOT NULL
    , fest_fecins       DATE DEFAULT SYSDATE                CONSTRAINT nn_gen_tfest_fecins NOT NULL
    , fest_usuains      VARCHAR2(20) DEFAULT USER           CONSTRAINT nn_gen_tfest_user NOT NULL
    , fest_fecupd       DATE
    , fest_usuaupd      VARCHAR2(20)
)
;
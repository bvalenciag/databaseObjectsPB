--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       03/01/2023 Cramirezs    000001       * Se crea tabla.
--                       Kilonova
-- ========== ========== ============ ============ ============================================================================================================
--
/**********************************************************************************/
Prompt
Prompt Creando tabla GEN_TCONTROLPRO
Prompt
/**********************************************************************************/
CREATE TABLE gen_tcontrolpro(
      cont_proceso      VARCHAR2(20)                        CONSTRAINT nn_gen_tcont_proceso NOT NULL
    , cont_llave        VARCHAR2(100)                       CONSTRAINT nn_gen_tcont_llave   NOT NULL
    , cont_sesion       VARCHAR2(50)                        CONSTRAINT nn_gen_tcont_sesion  NOT NULL
    , cont_maquina      VARCHAR2(50)                        CONSTRAINT nn_gen_tcont_maquina NOT NULL
    , cont_estado       VARCHAR2(1)                         CONSTRAINT nn_gen_tcont_estado  NOT NULL
    , cont_fecins       DATE DEFAULT SYSDATE                CONSTRAINT nn_gen_tcont_fecins NOT NULL
    , cont_usuains      VARCHAR2(20) DEFAULT USER           CONSTRAINT nn_gen_tcont_user NOT NULL
    , cont_fecupd       DATE
    , cont_usuaupd      VARCHAR2(20)
)
;
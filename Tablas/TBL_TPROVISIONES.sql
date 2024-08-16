--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       08/08/2024 Jmartinezm    000001       * Se crea tabla.
--                       Kilonova
-- ========== ========== ============ ============ ============================================================================================================
--
/**********************************************************************************/
Prompt
Prompt Creando tabla TBL_TPROVISIONES
Prompt
/**********************************************************************************/
CREATE TABLE tbl_tprovisiones(
      prov_prov             NUMBER(9)                           CONSTRAINT nn_tbl_tprov_prov NOT NULL
    , prov_empr_externo     VARCHAR2(50)
    , prov_empr             NUMBER(9)
    , prov_banc_externo     VARCHAR2(50)
    , prov_banc             NUMBER(9)
    , prov_valor            NUMBER
    , prov_log              NUMBER
    , prov_empr_descripcion VARCHAR2(200)
    , prov_banc_descripcion VARCHAR2(200)
    , prov_fecins           DATE DEFAULT SYSDATE                CONSTRAINT nn_tbl_tprov_fecins NOT NULL
    , prov_usuains          VARCHAR2(20) DEFAULT USER           CONSTRAINT nn_tbl_tprov_user NOT NULL
    , prov_fecupd           DATE
    , prov_usuaupd          VARCHAR2(20)
)
;
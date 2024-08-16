--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       25/06/2024 Jmartinezm    000001       * Se crea llave primaria.
--                       Kilonova      MVP_2
-- ========== ========== ============ ============ ============================================================================================================
--
/**********************************************************************************/
Prompt
Prompt Creando llave primaria de la tabla TBL_TEMPXMAND
Prompt
/**********************************************************************************/
ALTER TABLE tbl_tempxmand
    ADD CONSTRAINT pk_tbl_tempxmand PRIMARY KEY ( empx_empx )
        USING INDEX TABLESPACE ts_iedge;
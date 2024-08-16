--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       30/04/2024 Jmartinezm    000001       * Se crean datos.
--                       Kilonova     
-- ========== ========== ============ ============ ============================================================================================================
--
prompt
prompt Insertando registros en GEN_TESTADOS
prompt
INSERT INTO gen_testados(esta_esta, esta_modulo, esta_lista, esta_sigla, esta_descri, esta_fecins, esta_usuains)
             VALUES(gen_sestados.nextval, 'GEN', 'BASICOS', 'S', 'Si', SYSDATE, USER);
--
INSERT INTO gen_testados(esta_esta, esta_modulo, esta_lista, esta_sigla, esta_descri, esta_fecins, esta_usuains)
             VALUES(gen_sestados.nextval, 'GEN', 'BASICOS', 'N', 'No', SYSDATE, USER);
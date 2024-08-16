--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       10/01/2024 Cramirezs    000001       * Se crean datos.
--                       Kilonova     MVP_2
-- ========== ========== ============ ============ ============================================================================================================
--
prompt
prompt Insertando registros en gen_testados
prompt
--Estados traslados.
INSERT INTO gen_testados(esta_esta, esta_modulo, esta_lista, esta_sigla, esta_descri, esta_fecins, esta_usuains)
             VALUES(gen_sestados.nextval, 'TBL', 'ESTA_TRAS', 'A', 'Activo', SYSDATE, USER);
--
INSERT INTO gen_testados(esta_esta, esta_modulo, esta_lista, esta_sigla, esta_descri, esta_fecins, esta_usuains)
             VALUES(gen_sestados.nextval, 'TBL', 'ESTA_TRAS', 'X', 'Anulado', SYSDATE, USER);
--
--Estados impresión.
INSERT INTO gen_testados(esta_esta, esta_modulo, esta_lista, esta_sigla, esta_descri, esta_fecins, esta_usuains)
             VALUES(gen_sestados.nextval, 'TBL', 'ESTA_IMPR', 'S', 'Si', SYSDATE, USER);
--
INSERT INTO gen_testados(esta_esta, esta_modulo, esta_lista, esta_sigla, esta_descri, esta_fecins, esta_usuains)
             VALUES(gen_sestados.nextval, 'TBL', 'ESTA_IMPR', 'N', 'No', SYSDATE, USER);

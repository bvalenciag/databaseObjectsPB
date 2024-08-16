--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       24/01/2024 Jmartinezm   000001       * Se crea Data.
--                       Kilonova     MVP2
-- ========== ========== ============ ============ ============================================================================================================
--
prompt
prompt Insertando registros en gen_tlistas
prompt
--Estados sebra
INSERT INTO gen_tlistas(list_list, list_modulo, list_lista, list_sigla, list_Descri, list_fecins, list_usuains)
             VALUES(GEN_SLISTAS.nextval, 'TBL', 'CONT_ENTI', 'S', 'Si', SYSDATE, USER);
--
INSERT INTO gen_tlistas(list_list, list_modulo, list_lista, list_sigla, list_Descri, list_fecins, list_usuains)
             VALUES(GEN_SLISTAS.nextval, 'TBL', 'CONT_ENTI', 'N', 'No', SYSDATE, USER);
--
--Fuente Info
INSERT INTO gen_tlistas(list_list, list_modulo, list_lista, list_sigla, list_Descri, list_fecins, list_usuains)
             VALUES(GEN_SLISTAS.nextval, 'TBL', 'FUEN_INFO', 'BZ', 'BIZAGI', SYSDATE, USER);
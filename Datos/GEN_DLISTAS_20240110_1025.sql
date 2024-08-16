--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       20/10/2023 Cramirezs    000001       * Se crea Data.
--                       Kilonova     MVP_2
-- ========== ========== ============ ============ ============================================================================================================
--
prompt
prompt Insertando registros en gen_tlistas
prompt
--Tipo de operación
INSERT INTO gen_tlistas(list_list, list_modulo, list_lista, list_sigla, list_Descri, list_fecins, list_usuains)
             VALUES(GEN_SLISTAS.nextval, 'TBL', 'TIPO_OPER', 'E', 'Egreso', SYSDATE, USER);
--
INSERT INTO gen_tlistas(list_list, list_modulo, list_lista, list_sigla, list_Descri, list_fecins, list_usuains)
             VALUES(GEN_SLISTAS.nextval, 'TBL', 'TIPO_OPER', 'I', 'Ingreso', SYSDATE, USER);
--
--Fuente Info
INSERT INTO gen_tlistas(list_list, list_modulo, list_lista, list_sigla, list_Descri, list_fecins, list_usuains)
             VALUES(GEN_SLISTAS.nextval, 'TBL', 'FUEN_INFO', 'BZ', 'BIZAGI', SYSDATE, USER);
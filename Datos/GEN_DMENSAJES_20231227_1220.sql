--
-- #VERSION: 1001
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       10/10/2023 Cramirezs    000001       * Se crean datos para la tabla GEN_TMENSAJES.
--                       Kilonova     MVP_2
-- ========== ========== ============ ============ ============================================================================================================
--
prompt
prompt Insertando registros en gen_tmensajes
prompt
--
INSERT INTO gen_tmensajes(mens_mens, mens_descripcion, mens_tipo, mens_fecins, mens_usuains)
     VALUES('ER_WBEQ_EM', 'Error al recuperar la equivalencia {campo1} {campo2}, valide que en EDGE exista la homologación.', 'E', SYSDATE, USER);
--
INSERT INTO gen_tmensajes(mens_mens, mens_descripcion, mens_tipo, mens_fecins, mens_usuains)
     VALUES('ER_WBCN_ED', 'Error, código {campo1} {campo2}, no existe en EDGE.', 'E', SYSDATE, USER);
--
INSERT INTO gen_tmensajes(mens_mens, mens_descripcion, mens_tipo, mens_fecins, mens_usuains)
     VALUES('ER_RGID_EX', 'Ya existe un registro con esta identificación. Por favor verifique.', 'E', SYSDATE, USER);
--
INSERT INTO gen_tmensajes(mens_mens, mens_descripcion, mens_tipo, mens_fecins, mens_usuains)
     VALUES('ER_VLOR_NP', 'Valor no permitido. Por favor verifique.', 'E', SYSDATE, USER);              
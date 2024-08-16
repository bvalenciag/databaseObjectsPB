--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       03/01/2023 Cramirezs    000001       * Se crean comentarios.
--                       Kilonova
-- ========== ========== ============ ============ ============================================================================================================
--
/**********************************************************************************/
Prompt
Prompt Generando Comentarios de la tabla GEN_TCONTROLPRO
Prompt
/**********************************************************************************/
COMMENT ON TABLE  gen_tcontrolpro                                   IS 'Almacena control de procesos para control de concurrecncia.';
COMMENT ON COLUMN gen_tcontrolpro.cont_proceso                      IS 'Nombre del proceso el cual lleva el control.';
COMMENT ON COLUMN gen_tcontrolpro.cont_llave                        IS 'Llave para controlar el bloqueo del proceso.';
COMMENT ON COLUMN gen_tcontrolpro.cont_sesion                       IS 'Código de sesión.';
COMMENT ON COLUMN gen_tcontrolpro.cont_maquina                      IS 'Código de maquina.';
COMMENT ON COLUMN gen_tcontrolpro.cont_estado                       IS 'Estado, P-Procesando, F-Finalizado.';
COMMENT ON COLUMN gen_tcontrolpro.cont_fecins                       IS 'Fecha en la que se realiza la inserción del registro.';
COMMENT ON COLUMN gen_tcontrolpro.cont_usuains                      IS 'Usuario que realizo la inserción del registro.';
COMMENT ON COLUMN gen_tcontrolpro.cont_fecupd                       IS 'Ultima fecha de actualización del registro.';
COMMENT ON COLUMN gen_tcontrolpro.cont_usuaupd                      IS 'Ultimo usuario que actualizo el registro.';
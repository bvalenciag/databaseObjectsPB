--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       25/10/2023 Cramirezs    000001       * Se crea job para ejecución información de negocio cada 30 minutos.
--                       Kilonova
-- ========== ========== ============ ============ ============================================================================================================
--
begin
  begin
    dbms_scheduler.drop_job('TBL_JAPI_REST_MOPM');
  exception
    when others then
	  null;
  end;
  dbms_scheduler.create_job
  (
    job_name => 'TBL_JAPI_REST_MOPM', 
    job_type => 'STORED_PROCEDURE', 
    job_action => 'gen_qapi_rest.api_rest_mopm', 
    start_date => TO_TIMESTAMP_TZ('2024/01/09 08:00:20.000000 America/Bogota','yyyy/mm/dd hh24:mi:ss.ff tzr'),
    repeat_interval => 'freq=MINUTELY;interval=5',    
    enabled => true,
    comments => 'Ejecuta el consumo de saldos expuestos desde el APEX de MITRA.'
  );
end;
/
--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       13/02/2024 Cramirezs    000001       * Se crea columna.
--                       Kilonova
-- ========== ========== ============ ============ ============================================================================================================
--
/**********************************************************************************/
Prompt
Prompt Renombrando constraint de la tabla TBL_TREPORSEBRA
Prompt
--
ALTER TABLE tbl_treporsebra 
    RENAME CONSTRAINT nn_tbl_trepo_jrd_id TO nn_tbl_trepo_reporte;
--
/**********************************************************************************/
Prompt
Prompt Renombrando columna de la tabla TBL_TREPORSEBRA
Prompt
ALTER TABLE tbl_treporsebra 
    RENAME COLUMN repo_jrd_id TO repo_reporte;
--
/**********************************************************************************/
Prompt
Prompt Inactivando constraint de la tabla TBL_TREPORSEBRA
Prompt
--
alter table tbl_treporsebra
  disable validate
  constraint nn_tbl_trepo_reporte;
/**********************************************************************************/
Prompt
Prompt Modicando columna de la tabla TBL_TREPORSEBRA
Prompt
--
ALTER TABLE tbl_treporsebra
    MODIFY repo_reporte VARCHAR2(200);
--
/**********************************************************************************/
Prompt
Prompt Activando constraint de la tabla TBL_TREPORSEBRA
Prompt
--
alter table tbl_treporsebra
  enable validate
  constraint nn_tbl_trepo_reporte;
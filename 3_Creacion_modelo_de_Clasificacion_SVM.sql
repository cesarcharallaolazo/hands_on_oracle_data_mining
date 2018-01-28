--DROP TABLE svm_model_settings;

----creando tabla de configuracion del modelo de clasificacion
CREATE TABLE svm_model_settings (
  setting_name  VARCHAR2(30),
  setting_value VARCHAR2(30));
 
---- create and populate a class weight table
CREATE TABLE svmc_sh_sample_class_wt (
  target_value NUMBER,
  class_weight NUMBER );
INSERT INTO svmc_sh_sample_class_wt VALUES (0,0.35);
INSERT INTO svmc_sh_sample_class_wt VALUES (1,0.65);
----

-- insertando parametros al modelo
 
INSERT INTO svm_model_settings (setting_name, setting_value) VALUES
  ('ALGO_NAME', 'ALGO_SUPPORT_VECTOR_MACHINES' );
INSERT INTO svm_model_settings (setting_name, setting_value) VALUES
  ('svms_kernel_function', 'svms_linear');
  
INSERT INTO svm_model_settings (setting_name, setting_value) VALUES
  ('clas_weights_table_name', 'svmc_sh_sample_class_wt');
INSERT INTO svm_model_settings (setting_name, setting_value) VALUES
  ('prep_auto', 'off');

INSERT INTO svm_model_settings (setting_name, setting_value) VALUES
     ('prep_auto','prep_auto_on');
-----
SELECT * FROM svm_model_settings;


--- Eliminamos si es que hubiera un modelo anterior con el mismo nombre
 BEGIN
  DBMS_DATA_MINING.DROP_MODEL(model_name => 'svm_model_01');
END;
 
 
------------------------  CREATE THE MODEL -------------------------------------
DECLARE
BEGIN
  DBMS_DATA_MINING.CREATE_MODEL(
    model_name          => 'svm_model_01',
    mining_function     => to_char(dbms_data_mining.Classification),
    data_table_name     => 'atributos_modelo_normalizados',
    case_id_column_name => 'ID',
    target_column_name  => 'PROMEDIO',
    settings_table_name => 'svm_model_settings' );
END;

--select de verificacion de creacion del modelo
select model_name, mining_function, algorithm, creation_date, build_duration FROM all_mining_models;

--
COMMIT;

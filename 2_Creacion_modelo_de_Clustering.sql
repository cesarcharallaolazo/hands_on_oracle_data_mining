--DROP TABLE kmeans_configuracion;

----creando tabla de configuracion del modelo de Clustering
CREATE TABLE kmeans_configuracion (
 setting_name VARCHAR2(30),
 setting_value VARCHAR2(4000)
 );
 
-- insertando parametros al modelo
 
 -- parametro de modelo a usarse: 'ALGO_KMEANS'
INSERT INTO kmeans_configuracion (setting_name, setting_value) VALUES
 ('ALGO_NAME', 'ALGO_KMEANS');
 
 -- parametro de clusters a crearse: 10
 INSERT INTO kmeans_configuracion (setting_name, setting_value) VALUES
 ('CLUS_NUM_CLUSTERS' , TO_CHAR(10));
 
 -- parametro de distancias a usarse en el modelo: 'KMNS_EUCLIDEAN'
  INSERT INTO kmeans_configuracion (setting_name, setting_value) VALUES
 ('KMNS_DISTANCE' , 'KMNS_EUCLIDEAN');
 
 -- parametro de iteracion a usarse en el modelo: 10
 INSERT INTO kmeans_configuracion (setting_name, setting_value) VALUES
 ('KMNS_ITERATIONS' , TO_CHAR(10));
 
 -- preparacion automatica: OFF
 INSERT INTO kmeans_configuracion (setting_name, setting_value) VALUES
 ('PREP_AUTO' , 'OFF');
 
 -- KMNS_NUM_BINS
 INSERT INTO kmeans_configuracion (setting_name, setting_value) VALUES
 ('KMNS_NUM_BINS' , TO_CHAR(11));
 
 -- detalles a generarse en el modelo
 INSERT INTO kmeans_configuracion (setting_name, setting_value) VALUES
 ('KMNS_DETAILS' , 'KMNS_DETAILS_ALL');
 
  -- criterio de corte
 INSERT INTO kmeans_configuracion (setting_name, setting_value) VALUES
 ('KMNS_SPLIT_CRITERION' , 'KMNS_VARIANCE');
----

--select de comprobacion de tbl de configuracion del modelo
 select * from kmeans_configuracion
 
--- Eliminamos si es que hubiera un modelo anterior con el mismo nombre
 BEGIN
  DBMS_DATA_MINING.DROP_MODEL(model_name => 'Clustering_01');
END;
 
--- Creando modelo de Clustering 
 DECLARE
 BEGIN
  DBMS_DATA_MINING.CREATE_MODEL(
  --nombre del modelo
    model_name          => 'Clustering_01',
  --tipo de modelo general a usarse: CLUSTERING
    mining_function     => to_char(dbms_data_mining.CLUSTERING),
  --tabla de atributos preparados que entraran al modelo
    data_table_name     => 'atributos_modelo_normalizados',
  --ID de tabla de atributos preparados que entraran al modelo  
    case_id_column_name => 'id',
  --tabla de configuracion del modelo
    settings_table_name => 'kmeans_configuracion');
 END;
-----

--select de verificacion de creacion del modelo
select model_name, mining_function, algorithm, creation_date, build_duration FROM all_mining_models;

--
COMMIT;
--- CONSULTANDO EL MODELO DE CLUSTERING / CLASIFICATION

--- ejemplo para consulta de modelo de clustering

--- clusters generados
SELECT *  FROM TABLE(DBMS_DATA_MINING.GET_MODEL_DETAILS_KM('Clustering_01'));

--- transformaciones de atributos del modelo
SELECT * FROM TABLE( DBMS_DATA_MINING.get_model_transformations( 'Clustering_01' ));

--- configuraciones del modelo
SELECT * FROM TABLE(DBMS_DATA_MINING.get_model_settings( 'Clustering_01') );

--- se elimina tbl 'atributos_con_clusters' si es que existiera alguna anterior con ese nombre
DROP TABLE atributos_con_clusters

--- asignacion de cluster (consulta del modelo)
BEGIN 
DBMS_DATA_MINING.APPLY (
      'Clustering_01' , --model_name           IN VARCHAR2,
     'atributos_modelo_normalizados' , --  data_table_name      IN VARCHAR2,
     'ID' , -- case_id_column_name  IN VARCHAR2,
      'atributos_con_clusters' , -- result_table_name    IN VARCHAR2,
      NULL --data_schema_name     IN VARCHAR2 DEFAULT NULL);
 );
 END;
  
--- verificando data en tabla 'atributos_con_clusters'
select * from atributos_con_clusters;
select count(*) cantidad from atributos_con_clusters;

--  
COMMIT;  
  
---PREPARANDO DATA DE TABLA ATRIBUTOS PARA EL CLUSTERING
---------REFERENCIAS :
---------  DBMS_DATA_MINING : https://docs.oracle.com/cd/B28359_01/appdev.111/b28419/d_datmin.htm#CACGCHCE    
---------  DBMS_DATA_MINING_TRANSFORM : https://docs.oracle.com/cd/B28359_01/appdev.111/b28419/d_dmtran.htm#i1011812

---creamos vista de atributos a usarse en el modelo , debe incluirse el campo ID 
 CREATE VIEW atributos_modelo_svm_sin_normalizar as ( SELECT 
 ID, VALORES_MENORES_0,
SUM_VALORES_MAY1_MEN0,
PERCENTIL_0,PROMEDIO,
PORCENTAJE_DER_MEN_0,
COEF_CORRELACION,DESVIACION_EST,
BLOQUES_MENORES_0,PENDIENTE_B,
PERCENTIL_10,PERCENTIL_5,
PORCENTAJE_IZQ_MEN_0, VALORES_MAYORES_1
FROM VISTA_ENTRENAMIENTO_AMPLIADA_FINAL );

-- CREAMOS TABLA VACIA DE PARAMETROS DE NORMALIZACION
DECLARE
BEGIN
     DBMS_DATA_MINING_TRANSFORM.CREATE_NORM_LIN('parametros_normalizacion');
END;
----

-- POBLAMOS TABLA PARAMETROS DE NORMALIZACION
-- ( tabla parametro de normalizacion , tabla o vista de atributos del modelo, lista de atributos a excluir de la normalizacion ,  
--   digitos significativos a considerarse , esquema donde esta la tbl parametro de normalizacion, esquema donde esta la  tbl o vista de atributos del modelo)
EXEC DBMS_DATA_MINING_TRANSFORM.INSERT_NORM_LIN_MINMAX (  'parametros_normalizacion',   'atributos_modelo_svm_sin_normalizar' , NULL  , 20 , null, null );
--

--DROP TABLE parametros_normalizacion
--DESCRIBE parametros_normalizacion
--SELECT * FROM parametros_normalizacion

-- Si queremos eliminar aquellas columnas que no queremos normalizar 
DELETE FROM parametros_normalizacion WHERE COL in ( 'ID' );


 -- CREAMOS LA VISTA DE ATRIBUTOS NORMALIZADOS (tabla parametros de normalizacion(input), tabla o vista de atributos (input) , vista de atributos normalizados (output))
BEGIN
   DBMS_DATA_MINING_TRANSFORM.XFORM_NORM_LIN(
      'parametros_normalizacion', 'atributos_modelo', 'atributos_modelo_normalizados');
END;
---

---select de comprobacion
SELECT * FROM atributos_modelo_normalizados;

---
COMMIT;

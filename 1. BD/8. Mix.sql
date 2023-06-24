-- Crear un Indice

CREATE INDEX nombre ON tabla (atributo);

-----------------------------------------------------------------------------
-----------------------------------------------------------------------------

-- Mostrar una TABLA
SELECT * FROM tabla;

-- → Ejemplo ←
SELECT * FROM ama_carnavales_anuales;
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------

-- Mostrar una COLUMNA
SELECT columna1, columna2 FROM tabla;

-- → Ejemplo ←
SELECT ano, fecha_ini FROM ama_carnavales_anuales;

-----------------------------------------------------------------------------
-----------------------------------------------------------------------------

-- Mostrar una FILA especifica
SELECT * FROM nombre_de_tabla 
WHERE condicion;

-- → Ejemplo ←
SELECT * FROM ama_eventos
WHERE ano = 5;

-----------------------------------------------------------------------------
-----------------------------------------------------------------------------

-- Mostrar varias FILAS
SELECT columna1, columna2, columna3 FROM nombre_de_tabla 
WHERE condicion;

-- → Ejemplo ←
SELECT * FROM ama_roles
WHERE nombre = 'c';

-----------------------------------------------------------------------------
-----------------------------------------------------------------------------

-- Mostrar varias FILAS de TABLAS distintas
SELECT t1.columna1, t2.columna2
FROM tabla1 AS t1
JOIN tabla2 AS t2 
ON t1.columna3 = t2.columna4;
WHERE t1.columna5 = valor_condicion;

-- FIXME:
-- → Ejemplo ←
SELECT pa.nombre, cl.nombre
FROM ama_participaciones AS pa
JOIN ama_clientes AS cl 
ON pa.columna3 = t2.columna4;
WHERE pa.correo = valor_condicion; 

-----------------------------------------------------------------------------
-----------------------------------------------------------------------------

-- Eliminar FILA
DELETE FROM tabla
WHERE condicion;

-- → Ejemplo ←
DELETE FROM ama_hist_grupos
WHERE id_escuela = 5;

-----------------------------------------------------------------------------
-----------------------------------------------------------------------------

-- Eliminar una COLUMNA
ALTER TABLE tabla
DROP COLUMN columna;

-- → Ejemplo ←
ALTER TABLE ama_clientes
DROP COLUMN apellido1;

-- Eliminar una TABLA
DROP TABLE tabla CASCADE;

-- → Ejemplo ←
DROP TABLE ama_clientes CASCADE;

-----------------------------------------------------------------------------
-----------------------------------------------------------------------------

-- Editar una COLUMNA
ALTER TABLE tabla
ALTER COLUMN nombre TYPE variable
-- → Ejemplo ←
ALTER TABLE ama_empresas
ALTER COLUMN nombre TYPE varchar(21);

-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
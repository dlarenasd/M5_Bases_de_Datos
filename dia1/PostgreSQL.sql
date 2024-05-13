--Esto es un comentario

SELECT * FROM demo;
-- solo obtener la columna name
SELECT name FROM demo;
-- solo obtener los id
select id from demo;
--solo obtener los hint
SELECT hint from demo; 
-- mezclar varias columnas
select id, HINT from demo;

--CLÁUSULA WHERE ->filtra, establece condiciones 
SELECT * FROM demo where id = 5; 
-- ojo con el formato de los valores, mira antes de trabajar 
SELECT * FROM demo where hint = '300'; -- por ejemplo sin las comillas no lo reconoce dado que es de texto 
-- where con OR
SELECT * from demo where id = 5 or id = 8; 
SELECT * from demo where id = 5 or id = 3; 
-- WHERE CON AND
SELECT * from demo where id = 5 and id = 8; 

--CLÁUSULA LIMIT
SELECT * FROM demo LIMIT 3;
--CLAUSULA WHERE Y LIMIT 
SELECT * FROM demo WHERE ID < 6 LIMIT 4;

--CLAUSULA ORDER BY
SELECT * FROM demo order by id DESC;
SELECT * FROM demo order by NAME DESC;
SELECT * FROM demo order by hint DESC;
SELECT hint, NAME from demo order by 1 asc; --el 1 pide ir de columna 1 a columna 2

--Admin1234
-- inner join (unir por elemento común dos tablas)
/* 
SELECT * 
FROM TABLAA A
INNER JOIN TABLAB B  -- SE RECOMIENDA AGREGAR COMO TABLA A LA QUE TENGA LA COLUMNA COMÚN COMO PRIMARY KEY
ON A.KEY = B.KEY;
*/
SELECT * 
FROM productos A
INNER JOIN pedidos_detalle B
ON A.id_producto = B.id_producto;

SELECT  * -- A.*, B.*
FROM productos A
INNER JOIN pedidos_detalle B
ON A.id_producto = B.id_producto;

SELECT  A.nombre, A.precio, B.id_pedido, B.cantidad-- * -- A.*, B.*
FROM productos A
INNER JOIN pedidos_detalle B
ON A.id_producto = B.id_producto;


-- LEFT JOIN
/*
SELECT *
FROM TABLAA A      -- SE RECOMIENDA AGREGAR COMO TABLAA AQUELLA TABLA QUE TENGA LA PK
LEFT JOIN TABLAB B
ON A.KEY = B.KEY
WHERE B.KEY IS NULL
;
*/
SELECT * 
FROM productos A
LEFT JOIN pedidos_detalle B
on A.id_producto = B.id_producto
WHERE B.id_producto IS NULL; --SIN WHERE SOLICITA TODO EL A JUNTO CON LAS COINCIDENCIAS DE B

-- RIGHT JOIN
/*
SELECT *
FROM TABLAA A      -- SE RECOMIENDA AGREGAR COMO TABLAA AQUELLA TABLA QUE TENGA LA PK
RIGHT JOIN TABLAB B
ON A.KEY = B.KEY
WHERE A.KEY IS NULL
;
*/
SELECT * 
FROM productos A
RIGHT JOIN pedidos_detalle B
on A.id_producto = B.id_producto
WHERE A.id_producto IS NULL; ----SIN WHERE SOLICITA TODO EL B JUNTO CON LAS COINCIDENCIAS DE A

--FULL OUTER JOIN
/* SELECT *
FROM TABLAA A      -- SE RECOMIENDA AGREGAR COMO TABLAA AQUELLA TABLA QUE TENGA LA PK
FULL OUTER JOIN TABLAB B
ON A.KEY = B.KEY 
*/
SELECT * 
FROM productos A
FULL OUTER JOIN pedidos_detalle B
on A.id_producto = B.id_producto;
--FULL OUTER JOIN
/* SELECT *
FROM TABLAA A      -- este full outer join es para reportar todos los registros SIN coincidencias
FULL OUTER JOIN TABLAB B
ON A.KEY = B.KEY 
WHERE A.KEY IS NULL OR B.KEY IS NULL
*/ 
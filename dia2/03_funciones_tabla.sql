-- Crear la tabla con el nombre 'PRODUCTOS'
CREATE TABLE PRODUCTOS (
    id INT,
    nombre_producto VARCHAR(50),
    precio INT,
    en_stock BOOLEAN,
    categoria VARCHAR(50)
);

-- Insertar datos en la tabla 'PRODUCTOS'
INSERT INTO PRODUCTOS (id, nombre_producto, precio, en_stock, categoria) VALUES (1, 'Cápsulas para Hornear', 298, TRUE, 'Panadería');
INSERT INTO PRODUCTOS (id, nombre_producto, precio, en_stock, categoria) VALUES (2, 'Mollejas de Ternera', 6552, FALSE, 'Carnicería');
INSERT INTO PRODUCTOS (id, nombre_producto, precio, en_stock, categoria) VALUES (3, 'Sistema Automático de Jabón Oneshot', 6667, TRUE, 'Higiene');
INSERT INTO PRODUCTOS (id, nombre_producto, precio, en_stock, categoria) VALUES (4, 'Galletas de la Fortuna', 882, TRUE, 'Panadería');
INSERT INTO PRODUCTOS (id, nombre_producto, precio, en_stock, categoria) VALUES (5, 'Aceite de Trufa Blanca', 5900, FALSE, 'Gourmet');
INSERT INTO PRODUCTOS (id, nombre_producto, precio, en_stock, categoria) VALUES (6, 'Aperitivo de Salmón Ahumado con Eneldo', 1263, TRUE, 'Aperitivos');
INSERT INTO PRODUCTOS (id, nombre_producto, precio, en_stock, categoria) VALUES (7, 'Baguette Pequeña', 5366, FALSE, 'Panadería');
INSERT INTO PRODUCTOS (id, nombre_producto, precio, en_stock, categoria) VALUES (8, 'Copas de Licor de Chocolate con Papel de Aluminio', 2797, FALSE, 'Gourmet');
INSERT INTO PRODUCTOS (id, nombre_producto, precio, en_stock, categoria) VALUES (9, 'Jugo de Manzana, 341 Ml', 3654, FALSE, 'Bebidas');
INSERT INTO PRODUCTOS (id, nombre_producto, precio, en_stock, categoria) VALUES (10, 'Mero Fresco', 1266, FALSE, 'Pescadería');
INSERT INTO PRODUCTOS (id, nombre_producto, precio, en_stock, categoria) VALUES (11, 'Leche Condensada', 5998, FALSE, 'Lácteos');
INSERT INTO PRODUCTOS (id, nombre_producto, precio, en_stock, categoria) VALUES (12, 'Pajitas - Regulares', 9688, FALSE, 'Utensilios de Bebida');
INSERT INTO PRODUCTOS (id, nombre_producto, precio, en_stock, categoria) VALUES (13, 'Cerveza - Alexander Kieths, Pale Ale', 4173, FALSE, 'Bebidas Alcohólicas');
INSERT INTO PRODUCTOS (id, nombre_producto, precio, en_stock, categoria) VALUES (14, 'Arroz - Basmati', 1036, TRUE, 'Abarrotes');
INSERT INTO PRODUCTOS (id, nombre_producto, precio, en_stock, categoria) VALUES (15, 'Arándanos Congelados', 2462, TRUE, 'Congelados');
INSERT INTO PRODUCTOS (id, nombre_producto, precio, en_stock, categoria) VALUES (16, 'Ecolab - Limpiador de Cal', 8092, FALSE, 'Limpieza');
INSERT INTO PRODUCTOS (id, nombre_producto, precio, en_stock, categoria) VALUES (17, 'Vermut - Dulce, Cinzano', 6639, FALSE, 'Bebidas Alcohólicas');
INSERT INTO PRODUCTOS (id, nombre_producto, precio, en_stock, categoria) VALUES (18, 'Kohlrabi', 7868, FALSE, 'Verduras');
INSERT INTO PRODUCTOS (id, nombre_producto, precio, en_stock, categoria) VALUES (19, 'Champiñón - Morilla Congelada', 7208, FALSE, 'Congelados');
INSERT INTO PRODUCTOS (id, nombre_producto, precio, en_stock, categoria) VALUES (20, 'Sirope - Monin, Amaretto', 5486, FALSE, 'Bebidas');

-- Crear la tabla de ventas
CREATE TABLE VENTAS (
    id_venta INT,
    fecha DATE,
    producto VARCHAR(50),
    cantidad INT,
    precio_unitario INT
);

-- Insertar datos en la tabla 'VENTAS'
INSERT INTO VENTAS (id_venta, fecha, producto, cantidad, precio_unitario) VALUES (1, '2024-01-01', 'Camiseta', 3, 150);
INSERT INTO VENTAS (id_venta, fecha, producto, cantidad, precio_unitario) VALUES (2, '2024-01-03', 'Pantalón', 2, 300);
INSERT INTO VENTAS (id_venta, fecha, producto, cantidad, precio_unitario) VALUES (3, '2024-01-04', 'Sudadera', 1, 250);
INSERT INTO VENTAS (id_venta, fecha, producto, cantidad, precio_unitario) VALUES (4, '2024-01-04', 'Zapatillas', 1, 500);
INSERT INTO VENTAS (id_venta, fecha, producto, cantidad, precio_unitario) VALUES (5, '2024-01-05', 'Camiseta', 2, 150);
INSERT INTO VENTAS (id_venta, fecha, producto, cantidad, precio_unitario) VALUES (6, '2024-01-07', 'Gorra', 4, 100);
INSERT INTO VENTAS (id_venta, fecha, producto, cantidad, precio_unitario) VALUES (7, '2024-01-08', 'Bufanda', 3, 120);
INSERT INTO VENTAS (id_venta, fecha, producto, cantidad, precio_unitario) VALUES (8, '2024-01-09', 'Pantalón', 1, 300);
INSERT INTO VENTAS (id_venta, fecha, producto, cantidad, precio_unitario) VALUES (9, '2024-01-10', 'Camiseta', 1, 150);
INSERT INTO VENTAS (id_venta, fecha, producto, cantidad, precio_unitario) VALUES (10, '2024-01-11', 'Sudadera', 2, 250);



-- FUNCIONES
SELECT * FROM productos order by LENGTH(nombre_producto); --ORDER ES ASCENDENTE POR DEFECTO(DAME TODOS LOS PRODUCTOS ORDENADOR POR CANTIDAD DE CARACTERES EN EL NOMBRE)

SELECT *, LENGTH(nombre_producto) FROM productos order by LENGTH(nombre_producto); --además reporta en una nueva columna el length de cada producto

Select *, left(categoria,3) as codigo from productos;  -- con la función left se puede pedir que entregue una cantidad de caratceres, con as establecemos una columna con el alias código

-- FUNCIONES DE AGREGADO
-- SUMA( SUM ())
SELECT SUM(precio) FROM productos; -- dame la suma de todos los precios de la tabla productos, usar con datos integer
-- PROMEDIO (AVG())
SELECT AVG(precio) FROM productos;
-- Máximo (MAX())
SELECT MAX(precio) FROM productos;
-- Mínimo (MIN())
SELECT MIN(precio) FROM productos;
-- Contar (COUNT())
SELECT COUNT(en_stock) from productos where en_stock = 't'; --Cuenta la cantidad de productos con stock
SELECT COUNT(precio) from productos where precio > 7000; -- Cuenta la cantidad de precios sobre 7000
select AVG(precio) from productos where en_stock ='t'; --Calcula el promedio de los productos que tienen stock

-- AGRUPAR (GROUP BY)
SELECT * FROM productos order by categoria;
SELECT max(precio) from productos GROUP BY categoria; --solo muestra los precios máximos de cada categoría
SELECT categoria, max(precio) from productos GROUP BY categoria; --solicito que muestre dos columnas, categoría y el precio máximo (por categoría) de los productos 
SELECT categoria, max(precio) from productos GROUP BY categoria order by categoria; -- así pdría solicitarse que se ordenen de manera alfabética
SELECT categoria, max(precio) from productos GROUP BY categoria order by max; -- ordena los datos por el max
-- SOLO PUEDE SOLICITARSE DATOS QUE ESTÉN AGRUPADOS
SELECT nombre_producto, max(precio) from productos GROUP BY categoria; -- ERROR:  la columna «productos.nombre_producto» debe aparecer en la cláusula GROUP BY o ser usada en una función de agregación
SELECT nombre_producto, CATEGORIA, max(precio) from productos WHERE LENGTH(nombre_producto) > 15 GROUP BY categoria, nombre_producto; --forzar el group by

-- 1. ¿Cuál es el promedio de ventas?
SELECT * FROM VENTAS;
SELECT AVG(precio_unitario) FROM VENTAS; -- PROMEDIO DEL PRECIO UNITARIO DE CADA VENTA
SELECT *, (CANTIDAD * precio_unitario) as venta_final from ventas; -- variable temporal a partir de una operatoria (SE PUEDE USAR * PARA MULTIPLICAR)
SELECT AVG(CANTIDAD * precio_unitario) from ventas; --promedio de ventas
--2. ¿Cuál es el promedio de ventas por producto?
select * from ventas;
select producto from ventas group by producto; --agrupar productos 
select producto, AVG(CANTIDAD * precio_unitario) from ventas group by producto;
-- 3. ¿Cuál es el promedio de ventas por producto después del '2024-01-05'?
select producto, AVG(CANTIDAD * precio_unitario) from ventas where fecha > '2024-01-05' group by producto;
-- ¿Qué tipo de producto generó la venta más alta?
--? select producto, AVG(CANTIDAD * precio_unitario) from ventas group by PRODUCTO; 
-- 1. ¿Cuántos productos se vendieron en cada fecha?
sum(cantidad) from ventas group by fecha;--?
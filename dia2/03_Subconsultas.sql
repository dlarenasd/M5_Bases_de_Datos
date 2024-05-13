-- Creación de la tabla 'productos'
CREATE TABLE productos (
    id_producto INT PRIMARY KEY,
    nombre VARCHAR(255),
    precio DECIMAL(10, 2)
);-- Otros campos según tus necesidades

-- Inserción de datos en la tabla 'productos'
INSERT INTO productos (id_producto, nombre, precio)
VALUES
    (1, 'Producto A', 20.99),
    (2, 'Producto B', 15.50),
    (3, 'Producto C', 25.75),
    (4, 'Producto D', 18.50),
    (5, 'Producto E', 30.25),
    (6, 'Producto F', 12.75),
    (7, 'Producto G', 22.99),
    (8, 'Producto H', 15.00),
    (9, 'Producto I', 28.50),
    (10, 'Producto J', 19.99),
    (11, 'Producto K', 10.50),
    (12, 'Producto L', 24.75),
    (13, 'Producto M', 16.50);

-- Creación de la tabla 'pedidos_detalle'
CREATE TABLE pedidos_detalle (
    id_pedido_detalle INT PRIMARY KEY,
    id_pedido INT,
    id_producto INT,
    cantidad INT
);-- Otros campos según tus necesidades

-- Inserción de datos en la tabla 'pedidos_detalle'
INSERT INTO pedidos_detalle (id_pedido_detalle, id_pedido, id_producto, cantidad)
VALUES
    (1, 101, 1, 3),
    (2, 101, 2, 2),
    (3, 102, 1, 1),
    (4, 103, 3, 4),
    (5, 104, 4, 2),
    (6, 104, 5, 1),
    (7, 105, 6, 3),
    (8, 105, 7, 2),
    (9, 106, 8, 1),
    (10, 107, 9, 4),
    (11, 107, 10, 2),
    (12, 108, 11, 3),
    (13, 109, 12, 2),
    (14, 110, 13, 1);

--SUBCONSULTAS
SELECT * from productos;
SELECT * from pedidos_detalle;

-- obtener todos los productos que el precio esté sobre el precio promedio
select avg(precio) from productos; -- 20.1515384615384615
select * from productos where precio >  20.1515384615384615;  -- es problemático porque es un valor estático y puede variar en el futuro
select * from productos where precio >  (SELECT avg(precio) from productos); -- mediante una subconsulta se puede obtener el valor de manera dinámica

-- encontrar los productos que se han vendido más de una vez
SELECT * from productos;
SELECT * from pedidos_detalle;

--agrupar por producto
select id_producto, count(id_producto) as cant
from pedidos_detalle 
--where count(id_producto) >1  ERROR:  no se permiten funciones de agregación en WHERE
group by id_producto; --esto reporta todos los productos y cuántas veces fueron vendidos

--consulta variable
select *
from (
    select id_producto, count(id_producto) as cant
    from pedidos_detalle 
    group by id_producto
) as temporal
where cant > 1;  --definiendo una tabla temporal se puede usar un where y solicitar solo el que tiene más de una venta

select * 
from productos
where id_producto in (
    select id_producto
    from (
        select id_producto, count(id_producto) as cant
        from pedidos_detalle 
        group by id_producto
    ) as temporal
where cant > 1
); --a la consulta se le agrega una subconsulta para obtener el valor

select * from productos WHERE id_producto in (20, 1, 55, 3);

INSERT INTO productos (id_producto, nombre, precio)
VALUES (14, 'Producto 14', 25.74); --agregando un producto para un ejercicio de join
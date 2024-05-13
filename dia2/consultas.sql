CREATE DATABASE "Diego"
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LOCALE_PROVIDER = 'libc'
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

-- lo primero a realizar es conectarse a la base de datos desde la terminal-->psql -U postgres (postgres es el usuario)
-- Paso 1: Accedemos al cliente de postgresql via el terminal.
-- Paso 2: Crea una base de datos llamada prueba1.
CREATE DATABASE prueba2; -- sentencia SQL usa ;
-- Paso 3: Lista las bases de datos creadas.
\l --
-- Paso 4: Conéctate a la base de datos.
\c prueba1  -- You are now connected to database "prueba1" as user "postgres".

-- Paso X: Salir de la terminal de postgres.
\q

-- VARCHAR = STR
create table clientes(
    nombre varchar(30),
    apellido varchar(30)
);
-- listar las tablas de una base de datos
\d 
-- detalla una tabla (ingresando el nombre)
\d clientes

\d+ clientes

--insertar valores a una tabla
insert into clientes (nombre, apellido) values ('Diego','Larenas');
insert into clientes (nombre, apellido) values ('Verónica','Bartolotti');
insert into clientes values ('Juan Carlos', 'Maguire'); --> se puede obviar la especificación de las columnas, pero se complica cuando hay campos opcionales
insert into clientes (apellido, nombre) values ('Mardo', 'Javi'); --> se puede establecer el orden en que vamos a ingresar datos
--consultar registros en una tabla
select * from clientes;
select * from clientes order by nombre desc;

-- BORRAR ALGÚN REGISTRO DE LA TABLA
delete from clientes where nombre = 'Javi';

-- ELIMINAR los datos de una tabla (¡RESPALDAR ANTES!)
delete from clientes; --> no usar where para especificar

insert into clientes values ('Ignacio', 'Mc-Manus');
insert into clientes values ('Valentina', 'Reyes');
insert into clientes values ('Diego', 'Ramoneda');
insert into clientes values ('Sofía', 'Gozze');



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


-- FUNCION IN( DETERMINA SI UN VALOR SE ENCUENTRA EN UNA LISTA ESPECIFICADA) 
select * from productos WHERE id_producto in (20, 1, 55, 3);

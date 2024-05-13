-- ● Paso 1: Crear una base de datos
create database nombre_base_de_datos;
-- ● Paso 2: Mostrar todas las tablas de una base de datos.
\dt; --ver la tabla con mas detalle
-- ● Paso 3: Mostrar una tabla en específica.
\dt nombre_tabla;

-- ● Paso 4: Modificar un campo de una tabla.
ALTER TABLE cuentas ADD fecha DATE;

-- ● Paso 5: Eliminar una tabla de la base de datos.
delete from cuentas; -- borrar registros, los datos
drop table cuentas; --borrar la estructura de datos

--CREACIÓN DE UNA TABLA
create table clientes (
    id int primary key, 
    nombre varchar not null, 
    rut int unique not null,--considerar cómo es el rut 77.777.777-7
    dv char not null 
    );

select concat (rut, '-', dv) as rut_completo from clientes;
/* select concat('77777777','-','7') as rut_completo from clientes; */

/*1. Primero creamos y definimos el nombre.
2. Entre paréntesis indicamos los campos que estarán presentes en la tabla.
3. Para cada campo indicamos el tipo de dato y sus restricciones.*/

CREATE TABLE products (
    product_no integer NOT NULL,
    name text NOT NULL,
    price numeric
);

insert into products values(012,'producto 1',0100);
select * from products;
/* product_no |    name    | price
--------------+------------+-------
            12| producto 1 |   100
*/

insert into products values(012,'producto 1');
/* product_no |    name    | price
--------------+------------+-------
            12| producto 1 |
*/

CREATE TABLE products (
    product_no integer NOT NULL,
    name text NOT NULL,
    price numeric default 0
);
insert into products values(012,'producto 1', 0100);
insert into products values(013,'producto 2'); --ahora tendrá precio 0 porque se le asignó un valor por defecto en la creación de tabla
insert into products values(014,'producto 3', null); --al ingresar un null dejará el campo vacío
/*
product_no |    name    | price 
-----------+------------+-------
        12 | producto 1 |   100
        13 | producto 2 |     0
        14 | producto 3 |       
*/

drop table products;

CREATE TABLE products (
    id integer PRIMARY KEY,
    name text not null default '',
    price numeric default 0
);
insert into products values(012,'producto 1', 0100);
insert into products values(013,'producto 2'); --ahora tendrá precio 0 porque se le asignó un valor por defecto en la creación de tabla
insert into products values(014,'producto 3', null); --al ingresar un null dejará el campo vacío

CREATE TABLE orders (
    id integer PRIMARY KEY,
    product_id integer REFERENCES products (id),
    quantity integer
);

\d+ products
\d+ orders
--CÓMO AGREGAR UN CONSTRAINT A UNA TABLA
ALTER TABLE IF EXISTS public.orders
ADD CONSTRAINT check_quantity CHECK (quantity >=0) --ADD CONSTRAINT nombre_restricción TIPO_RESTRICCIÓN [CHECK, UNIQUE, NOT NULL...] (CONDICIÓN)
NOT VALID; --LANZAR ERROR SI SE ROMPE LA CONDICIÓN


/*
Crear una tabla para clientes con los campos:
a. ID           int serial PRIMARY KEY
b. Nombre       varchar(50) not null
c. Apellido     varchar(50) not null
d. Rut          varchar(12) not null unique 
e. Teléfono     varchar(20) default ''
f. Email        varchar     unique


CREATE SEQUENCE public.products_id_seq
    INCREMENT 1
    START 100
    MINVALUE 100
    MAXVALUE 999999
    CACHE 1
    OWNED BY products.id;

ALTER SEQUENCE public.products_id_seq
    OWNER TO postgres;

select nextval('orders_id_seq')
*/
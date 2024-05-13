/*
La base de datos de Mawashi Cars SPA debe contener por los momentos dos tablas, una
para autos y otra para ventas.
En la tabla de autos existirán los campos:
● ID
● marca
● modelo
● año
● color
● precio

En la tabla ventas:
● Fecha
● Id_auto
● Cliente
● Referencia
● Cantidad
● Método de pago.
*/
CREATE DATABASE mawashi_cars; 
\c mawashi_cars;

CREATE TABLE autos(
    id serial PRIMARY KEY,
    marca varchar (25) not null default '',
    modelo varchar (25) not null default '',
    año varchar (25) not null default '', 
    color varchar (25),
    precio float
);

CREATE TABLE ventas(
    id serial PRIMARY KEY, 
    fecha date not null,
    id_auto int,  
    cliente varchar (50) ,
    referencia int not NULL ,
    cantidad int , 
    metodo_pago varchar (20),
    FOREIGN KEY (id_auto) references autos(id)
);
--● Paso 5: Insertamos registros en la tabla autos.
insert into autos (id, marca, modelo, año, color, precio) values (1, 'Toyota', 'Corolla Araya', '1991', 'Blanco', 1200000);
insert into autos (id, marca, modelo, año, color, precio) values (2, 'Mazda', 'Mazda 3', '2000', 'Azul',2000000);
insert into autos (id, marca, modelo, año, color, precio) values (3, 'Chevrolet', 'Spark', '1998', 'Verde Oscuro', 1200000);
INSERT INTO autos (id, marca, modelo, año, color, precio) VALUES (4, 'Nissan', 'Versa', 2018, 'Gris Plata', 5000000);
INSERT INTO autos (id, marca, modelo, año, color, precio) VALUES (5, 'Hyundai', 'Accent', 2022, 'Rojo', 10500000);
INSERT INTO autos (id, marca, modelo, año, color, precio) VALUES (6, 'Kia', 'Rio', 2020, 'Negro', 8000000);
INSERT INTO autos (id, marca, modelo, año, color, precio) VALUES (7, 'Volkswagen', 'Gol', 2015, 'Azul Marino', 3500000);
INSERT INTO autos (id, marca, modelo, año, color, precio) VALUES (8, 'Fiat', 'Mobi', 2017, 'Blanco', 2800000);
INSERT INTO autos (id, marca, modelo, año, color, precio) VALUES (9, 'Suzuki', 'Swift', 2019, 'Gris Oxford', 6200000);
INSERT INTO autos (id, marca, modelo, año, color, precio) VALUES (10, 'Peugeot', '208', 2021, 'Rojo', 9800000);

--● Paso 6: Insertamos algunas ventas.
insert into ventas (fecha, id_auto, cliente, referencia, cantidad,metodo_pago) values('2020-10-15', 1, 'Chuck', 43224, 12000000,'Débito');
insert into ventas (fecha, id_auto, cliente, referencia, cantidad, metodo_pago) values('2020-11-15', 1, 'Donnie', 43334, 12000000, 'Transfer');
insert into ventas (fecha, id_auto, cliente, referencia, cantidad, metodo_pago) values('2020-12-15', 3, 'Jet', 43444, 12000000, 'Cheque');
insert into ventas (fecha, id_auto, cliente, referencia, cantidad, metodo_pago) values('2021-01-05', 1, 'Peter', 43335, 12000000, 'Débito');
insert into ventas (fecha, id_auto, cliente, referencia, cantidad, metodo_pago) values('2021-01-15', 1, 'Abigail', 43554, 12000000, 'Transfer');
insert into ventas (fecha, id_auto, cliente, referencia, cantidad, metodo_pago) values('2021-02-01', 3, 'Jhon', 43456, 12000000, 'Cheque');
INSERT INTO ventas (fecha, id_auto, cliente, referencia, cantidad, metodo_pago) VALUES ('2021-02-01', 2, 'Walter', 54321, 2000000, 'Efectivo');
INSERT INTO ventas (fecha, id_auto, cliente, referencia, cantidad, metodo_pago) VALUES ('2021-03-15', 3, 'Sarah', 54322, 1200000, 'Tarjeta');
INSERT INTO ventas (fecha, id_auto, cliente, referencia, cantidad, metodo_pago) VALUES ('2021-04-05', 4, 'Jessica', 54323, 5000000, 'Débito');
INSERT INTO ventas (fecha, id_auto, cliente, referencia, cantidad, metodo_pago) VALUES ('2021-05-25', 5, 'Luis', 54324, 10500000, 'Transfer');

/*● Paso 7: Obtenemos un reporte con el nombre de los clientes registrados en la tabla venta,
junto con la marca y el modelo del auto asociado a la venta realizada.*/
select cliente, marca, modelo
from ventas 
inner join autos
on ventas.id_auto = autos.id;

/*La empresa Mawashi Cars ha notado que aproximadamente un 30% de sus autos no se han
vendido y está considerando la posibilidad de negociar un convenio con una compañía
aliada con estos vehículos, pero necesitará una tabla que muestre los autos que no han sido
vendidos.
Realizar la consulta necesaria para obtener todos los autos cuyos id no se encuentran en la
tabla Ventas.
*/
select autos.id, marca, modelo, año, color, precio from autos 
left join ventas 
on autos.id = ventas.id_auto
where ventas.id_auto is null
order by precio;

/* id |   marca    | modelo | año  |    color    | precio
------+------------+--------+------+-------------+---------
    8 | Fiat       | Mobi   | 2017 | Blanco      | 2800000
    7 | Volkswagen | Gol    | 2015 | Azul Marino | 3500000
    9 | Suzuki     | Swift  | 2019 | Gris Oxford | 6200000
    6 | Kia        | Rio    | 2020 | Negro       | 8000000
    10| Peugeot    | 208    | 2021 | Rojo        | 9800000
*/

/*
El dueño de la empresa Mawashi Cars se dio cuenta que para facilitar el proceso de
auditoría, sería beneficioso saber los registros que no tienen relación entre ambas tablas
para hacer el cruce con la información cedida anteriormente y terminar la auditoría.
Realizar la sentencia SQL necesaria para satisfacer este requerimiento.*/

select * from autos
full outer join ventas
on autos.id = ventas.id_auto
where autos.id is null or ventas.id_auto is null;

/*
    id|   marca    | modelo | año  |    color    | precio  | id | fecha | id_auto | cliente | referencia | cantidad | metodo_pago 
------+------------+--------+------+-------------+---------+----+-------+---------+---------+------------+----------+-------------
    10| Peugeot    | 208    | 2021 | Rojo        | 9800000 |    |       |         |         |            |          |
    8 | Fiat       | Mobi   | 2017 | Blanco      | 2800000 |    |       |         |         |            |          |
    6 | Kia        | Rio    | 2020 | Negro       | 8000000 |    |       |         |         |            |          |
    9 | Suzuki     | Swift  | 2019 | Gris Oxford | 6200000 |    |       |         |         |            |          |
    7 | Volkswagen | Gol    | 2015 | Azul Marino | 3500000 |    |       |         |         |            |          |
  */
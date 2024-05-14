drop database if exists productos_feria;

create database productos_feria;
\c productos_feria;

drop table if exists compras; --siempre eliminar primero la tabla relacional si quieres partir de 0
drop table if exists clientes ;
drop table if exists productos ;

create table clientes(
    id serial primary key,
    nombre varchar(50) not null,
    apellido varchar(50) not null,
    direccion varchar(250) not null,
    dni varchar(50) not null unique
);

create table productos(
    id serial primary key,
    codigo varchar(250) not null unique
);

create table compras(
    id serial primary key,
    cliente_id int,
    producto_id int,
    foreign key(cliente_id) references clientes(id),
    foreign key(producto_id) references productos(id) 
);

-- INSERT
insert into clientes(nombre, apellido, direccion, dni) values('Diego', 'Larenas', 'Cardenal Antonio Samoré 01355', '12.345.678-9'),
('Juan', 'Pérez', 'Callejón 3, Casa D', '11.111.111-6'),
('Pedro', 'Pérez', 'Callejón 3, Casa D', '11.888.111-6'),
('María', 'Soto', 'Callejón 3, Casa A', '11.111.999-6');

insert into productos (codigo) values ('producto1'), 
('producto2'),
('producto3'), 
('producto4');

insert into compras (cliente_id, producto_id) values(1, 1),
(2,1), 
(2,2), 
(3,1);
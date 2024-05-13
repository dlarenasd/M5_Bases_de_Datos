create DATABASE desafio2_diego_larenas013;
\c desafio2_diego_larenas013

CREATE TABLE IF NOT EXISTS INSCRITOS(
    cantidad INT, 
    fecha DATE, 
    fuente VARCHAR);

INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 44, '01/01/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 56, '01/01/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 39, '01/02/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 81, '01/02/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 12, '01/03/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 91, '01/03/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 48, '01/04/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 45, '01/04/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 55, '01/05/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 33, '01/05/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 18, '01/06/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 12, '01/06/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 34, '01/07/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 24, '01/07/2021', 'Página' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 83, '01/08/2021', 'Blog' );
INSERT INTO INSCRITOS(cantidad, fecha, fuente)
VALUES ( 99, '01/08/2021', 'Página' );
/*
Aplicando los conceptos y herramientas aprendidas hasta ahora, crea las querys SQL
necesarias que contesten las siguientes preguntas.
1. ¿Cuántos registros hay?
2. ¿Cuántos inscritos hay en total?
3. ¿Cuál o cuáles son los registros de mayor antigüedad?
HINT: ocupar subconsultas
4. ¿Cuántos inscritos hay por día? (entendiendo un día como una fecha distinta de
ahora en adelante)
5. ¿Qué día se inscribieron la mayor cantidad de personas y cuántas personas se
inscribieron en ese día?
*/

alter table inscritos add column id serial;
alter table inscritos add primary key(id);
select * from inscritos;

-- 1. ¿Cuántos registros hay?
select count(*) as registros_totales from inscritos ;
/* registros_totales
-------------------
        16
*/

--2. ¿Cuántos inscritos hay en total?
select sum(cantidad) as total_inscritos from inscritos;
/*
total_inscritos 
-----------------
    774         */

--3. ¿Cuál o cuáles son los registros de mayor antigüedad?

select id, fecha, cantidad, fuente
from inscritos
where fecha in (
    select fecha
    from (
        select fecha from inscritos 
        group by fecha 
        order by fecha 
        limit 1
    ));

/* id |   fecha    | cantidad | fuente 
------+------------+----------+--------
    1 | 2021-01-01 |       44 | Blog
    2 | 2021-01-01 |       56 | Página */

-- 4. ¿Cuántos inscritos hay por día? (entendiendo un día como una fecha distinta de ahora en adelante)
select fecha, sum(cantidad) as inscritos_por_dia 
from inscritos 
group by fecha 
order by fecha;
/*    fecha    | inscritos_por_dia
---------------+-------------------
    2021-01-01 |               100
    2021-02-01 |               120
    2021-03-01 |               103
    2021-04-01 |                93
    2021-05-01 |                88
    2021-06-01 |                30
    2021-07-01 |                58
    2021-08-01 |               182
*/
select * from inscritos;

--5. ¿Qué día se inscribieron la mayor cantidad de personas y cuántas personas se inscribieron en ese día?
select fecha, sum(cantidad) as total_inscritos 
from inscritos 
group by fecha 
order by total_inscritos desc limit 1;
/*
    fecha    | total_inscritos 
-------------+-----------------
  2021-08-01 |             182 */
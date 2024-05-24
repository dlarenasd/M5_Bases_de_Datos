--4. Crea las tablas respetando los nombres, tipos, claves primarias y foráneas y tipos de datos.(1 punto)
DROP TABLE IF EXISTS respuestas;
DROP TABLE IF EXISTS preguntas;
DROP TABLE IF EXISTS usuarios;

CREATE TABLE preguntas(
    id int PRIMARY KEY,
    pregunta varchar(255),
    respuesta_correcta varchar
);
\d preguntas

CREATE TABLE usuarios(
    id int PRIMARY KEY,
    nombre varchar(255),
    edad int
);
\d usuarios

CREATE TABLE respuestas(
    id int PRIMARY KEY,
    respuesta varchar(255),
    usuario_id int,
    pregunta_id int,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
    FOREIGN KEY (pregunta_id) REFERENCES preguntas(id)
);
\d respuestas


/*5. Agrega 5 registros a la tabla preguntas, de los cuales: (1 punto)
a. 1. La primera pregunta debe ser contestada correctamente por dos usuarios distintos
b. 2. La pregunta 2 debe ser contestada correctamente por un usuario.
c. 3. Los otros dos registros deben ser respuestas incorrectas.
Hint: Contestada correctamente significa que la respuesta indicada en la tabla 
respuestas es exactamente igual al texto indicado en la tabla de preguntas.*/
INSERT INTO preguntas values (1, '¿Cuál es la capital de Uruguay?', 'Montevideo'),
(2, '¿Cuál es la capital de Gabón?', 'Libreville'),
(3, '¿Cuál es la capital de Rumania?', 'Bucarest'),
(4, '¿Cuál es la capital de Corea del Sur?', 'Seúl'),
(5, '¿Cuál es la capital de Australia?', 'Canberra');

select * from preguntas;

INSERT INTO usuarios values (1, 'Felipe', 25),
(2, 'Sofía', 30),
(3, 'Diego', 32),
(4, 'Verónica', 32);

select * from usuarios;

INSERT INTO respuestas values (1, 'Montevideo', 1, 1),
(2, 'Gabón City', 1, 2),
(3, 'Montevideo', 2, 1),
(4, 'Libreville', 2, 2),
(5, 'Budapest', 2, 3);

select * from respuestas;

--6. Cuenta la cantidad de respuestas correctas totales por usuario (independiente de la pregunta). (1 punto)
select usuarios.id, usuarios.nombre, count(usuarios.nombre) as correctas_por_usuario
from respuestas
left join usuarios on respuestas.usuario_id = usuarios.id
left join preguntas on respuestas.pregunta_id = preguntas.id
where respuestas.respuesta in (preguntas.respuesta_correcta)
group by usuarios.id, usuarios.nombre
order by usuarios.id;

select usuarios.id, usuarios.nombre, count(case when preguntas.respuesta_correcta = respuestas.respuesta then 1 end) as correctas_por_usuario
from respuestas
full outer join usuarios on respuestas.usuario_id = usuarios.id
left join preguntas on respuestas.pregunta_id = preguntas.id
group by usuarios.id, usuarios.nombre
order by usuarios.id;
/* CORRECCIÓN PROFESOR (RECORDAR EL USO DE LA SENTENCIA FILTER)
SELECT usuarios.nombre, COUNT(respuestas.respuesta)
FILTER(WHERE respuestas.respuesta = preguntas.respuesta_correcta)
FROM usuarios
LEFT JOIN respuestas ON respuestas.usuario_id = usuarios.id
LEFT JOIN preguntas ON respuestas.pregunta_id = preguntas.id
GROUP BY usuarios.nombre;
*/

--7. Por cada pregunta, en la tabla preguntas, cuenta cuántos usuarios tuvieron la respuesta correcta. (1 punto)
select preguntas.id, preguntas.pregunta, count(case when preguntas.respuesta_correcta = respuestas.respuesta then 1 end) as usuarios_correctos
from preguntas
left join respuestas
on preguntas.id = respuestas.pregunta_id
group by preguntas.id, preguntas.pregunta
order by preguntas.id;

select preguntas.id, preguntas.pregunta, count(case when preguntas.respuesta_correcta = respuestas.respuesta then 1 end) as usuarios_correctos
from respuestas
full outer join preguntas on respuestas.pregunta_id = preguntas.id
group by preguntas.id, preguntas.pregunta
order by preguntas.id;
/*8. Implementa borrado en cascada de las respuestas al borrar un usuario y borrar el
primer usuario para probar la implementación. (1 punto)*/
\d respuestas

ALTER TABLE respuestas 
DROP CONSTRAINT respuestas_usuario_id_fkey, 
ADD CONSTRAINT respuestas_usuario_id_fkey
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
    ON DELETE CASCADE;

DELETE FROM usuarios where id = 1;
select * from usuarios;
select * from respuestas;

--9. Crea una restricción que impida insertar usuarios menores de 18 años en la base de datos. (1 punto)
ALTER TABLE usuarios ADD CONSTRAINT check_edad check(edad >= 18);
\d usuarios

INSERT INTO usuarios values (5, 'Pedro', 15);

--10. Altera la tabla existente de usuarios agregando el campo email con la restricción de único. (1 punto)
ALTER TABLE usuarios ADD COLUMN email varchar(100) UNIQUE;
\d usuarios


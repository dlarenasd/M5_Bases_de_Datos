-- Crear la tabla Autores
CREATE TABLE Autores (
    AutorID INT PRIMARY KEY,
    NombreAutor VARCHAR(50) NOT NULL
);

-- Crear la tabla Libros
CREATE TABLE Libros (
    LibroID INT PRIMARY KEY,
    Titulo VARCHAR(100) NOT NULL,
    AutorID INT,
    FOREIGN KEY (AutorID) REFERENCES Autores(AutorID)
);

-- Inserts adicionales para la tabla Autores
INSERT INTO Autores (AutorID, NombreAutor) VALUES (2, 'Autor A');
INSERT INTO Autores (AutorID, NombreAutor) VALUES (3, 'Autor B');
INSERT INTO Autores (AutorID, NombreAutor) VALUES (4, 'Autor C');
INSERT INTO Autores (AutorID, NombreAutor) VALUES (5, 'Autor D');
INSERT INTO Autores (AutorID, NombreAutor) VALUES (6, 'Autor E');
INSERT INTO Autores (AutorID, NombreAutor) VALUES (7, 'Autor F');
INSERT INTO Autores (AutorID, NombreAutor) VALUES (8, 'Autor G');
INSERT INTO Autores (AutorID, NombreAutor) VALUES (9, 'Autor H');
INSERT INTO Autores (AutorID, NombreAutor) VALUES (10, 'Autor I');

-- Inserts adicionales para la tabla Libros
INSERT INTO Libros (LibroID, Titulo, AutorID) VALUES (102, 'Libro 1', 2);
INSERT INTO Libros (LibroID, Titulo, AutorID) VALUES (103, 'Libro 2', 3);
INSERT INTO Libros (LibroID, Titulo, AutorID) VALUES (104, 'Libro 3', 4);
INSERT INTO Libros (LibroID, Titulo, AutorID) VALUES (105, 'Libro 4', 5);
INSERT INTO Libros (LibroID, Titulo, AutorID) VALUES (106, 'Libro 5', 6);
INSERT INTO Libros (LibroID, Titulo, AutorID) VALUES (107, 'Libro 6', 7);
INSERT INTO Libros (LibroID, Titulo, AutorID) VALUES (108, 'Libro 7', 8);
INSERT INTO Libros (LibroID, Titulo, AutorID) VALUES (109, 'Libro 8', 9);
INSERT INTO Libros (LibroID, Titulo, AutorID) VALUES (110, 'Libro 9', 10);

INSERT INTO Libros (LibroID, Titulo, AutorID) VALUES (111, 'Libro 10', 1); --ingreso de un libro cuyo autor no está vinculado a la tabla de autores
-- ERROR:  inserción o actualización en la tabla «libros» viola la llave foránea «libros_autorid_fkey»
-- DETAIL:  La llave (autorid)=(1) no está presente en la tabla «autores».

-- ● Insertemos un autor con un autor_id 2 el cual ya existe en la tabla Autores. 
-- Deberías recibir un error porque autor_id es una clave primaria y no puede repetirse.
INSERT INTO Autores (AutorID, NombreAutor) VALUES (2, 'Nuevo autor');
-- ERROR:  llave duplicada viola restricción de unicidad «autores_pkey»
-- DETAIL:  Ya existe la llave (autorid)=(2).

-- ● Insertemos un libro con un autor_id 1 que no existe en la tabla Autores. 
--Deberías recibir un error debido a la restricción de clave foránea.
INSERT INTO Libros (libroID, Titulo, autorID) VALUES (101, 'Libro Ejemplo', 1);
-- ERROR:  inserción o actualización en la tabla «libros» viola la llave foránea «libros_autorid_fkey»
-- DETAIL:  La llave (autorid)=(1) no está presente en la tabla «autores».

--● Ahora, intentemos eliminar al autor con el autor_id 2, que tiene un libro asociado: 
-- deberías recibir un error que indica que la operación de eliminación viola la restricción de clave foránea
DELETE FROM Autores WHERE autorid = 2;
-- ERROR:  update o delete en «autores» viola la llave foránea «libros_autorid_fkey» en la tabla «libros»
-- DETAIL:  La llave (autorid)=(2) todavía es referida desde la tabla «libros».


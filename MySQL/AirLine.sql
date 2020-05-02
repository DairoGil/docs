CREATE DATABASE airline; 

USE airline;

CREATE TABLE airplanes (
	planecode int auto_increment primary key, 
    description varchar(50), 
    capacity int
);

CREATE TABLE flights (
	numflight int auto_increment primary key, 
    planecode  int, 
    dateflight datetime,
    origin varchar(50),
    destination varchar(50)
);

CREATE TABLE passenger (
	id int primary key, 
    namep  varchar(50) not null, 
    birthdate date not null,
    email varchar(50) not null,
    telephone varchar(50)
); 

CREATE TABLE passengerList (
	id int auto_increment primary key,
    numflight int,
    idpassenger int
); 

ALTER TABLE flights ADD CONSTRAINT fk_AirFli 
FOREIGN KEY (planecode) 
REFERENCES airplanes(planecode) 
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE passengerList ADD CONSTRAINT fk_FliLis
FOREIGN KEY (numflight) 
REFERENCES flights(numflight) 
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE passengerList ADD CONSTRAINT fk_PasLis
FOREIGN KEY (idpassenger) 
REFERENCES passenger(id) 
ON DELETE NO ACTION
ON UPDATE CASCADE;

INSERT INTO airplanes VALUES(NULL, 'modelo 80', 50);
INSERT INTO airplanes VALUES(NULL, 'modelo 90', 100); 

INSERT INTO flights VALUES
(NULL, 1, now(), 'Bogotá','Cartagena'), 
(NULL, 2, now(), 'Medellín', 'Panamá');

INSERT INTO passenger VALUES
(1, 'Pepe perez', '1990-03-03', '@gmail',12345),
(2, 'Pepito perez', '1991-03-03', '@gmail',12345),
(3, 'Jose perez', '1992-03-03', '@gmail',12345),
(4, 'Ramiro perez', '1993-03-03', '@gmail',12345),
(5, 'Camilo perez', '1994-03-03', '@gmail',12345),
(6, 'Daniela perez', '1995-03-03', '@gmail',12345),
(7, 'Diana perez', '1996-03-03', '@gmail',12345),
(8, 'Lucia perez', '1997-03-03', '@gmail',12345),
(9, 'Carolina perez', '1998-03-03', '@gmail',12345),
(10, 'Laura perez', '1999-03-03', '@gmail',12345);

INSERT INTO passengerList(numflight, idpassenger) VALUES
(1, 1), (1, 2), (1, 3), (1, 4), (1, 5), (2, 6), (2, 7), (2, 8), (2, 9), (2, 10);

CREATE PROCEDURE flightPassenger(numflight int)
SELECT passenger.* 
FROM passengerList INNER JOIN  passenger 
ON passengerList.idpassenger=passenger.id 
WHERE passengerList.numflight=numflight;

call airline.flightPassenger(1);

-- Conexión a PostgreSQL
\c postgres

-- Creación de la base de datos
CREATE DATABASE control1_g3;

\c control1_g3;

CREATE TABLE IF NOT EXISTS comuna (
	id_comuna serial PRIMARY KEY,
	nombre varchar(50));

CREATE TABLE IF NOT EXISTS peluqueria (
 	id_peluqueria serial PRIMARY KEY,
  	nombre varchar(50),
  	direccion varchar(50),
  	id_comuna int,
  	telefono varchar(50),
 	email varchar(50),
	foreign key (id_comuna) references comuna(id_comuna) ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE IF NOT EXISTS cliente (
  	id_cliente serial PRIMARY KEY,
  	nombre varchar(50),
  	correo varchar(50),
  	telefono varchar(50),
  	genero varchar(50),
  	id_comuna int,
	foreign key (id_comuna) references comuna(id_comuna) ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE IF NOT EXISTS detalle (
	id_detalle SERIAL PRIMARY KEY,
	servicio varchar(50), 
	precio int);

CREATE TABLE IF NOT EXISTS peluquero (
  	id_peluquero serial PRIMARY KEY,
	nombre varchar(50),
  	correo varchar(50),
  	telefono varchar(50),
 	id_peluqueria int,
	foreign key (id_peluqueria) references peluqueria(id_peluqueria) ON DELETE CASCADE ON UPDATE CASCADE);
	
CREATE TABLE IF NOT EXISTS sueldo(
	id_sueldo serial PRIMARY KEY,
	fecha date,
	cantidad int,
	id_peluquero int,
	foreign key (id_peluquero) references peluquero(id_peluquero) ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE IF NOT EXISTS cita (
  	id_cita serial PRIMARY KEY,
	dia varchar(50),
  	hora varchar(50),
 	duracion_cita int,
  	anio int,
 	mes varchar(50),
  	id_cliente int,
  	id_peluquero int,
  	id_detalle int,
 	id_peluqueria int,
	foreign key (id_cliente) references Cliente(id_cliente) ON DELETE CASCADE ON UPDATE CASCADE,
	foreign key (id_peluquero) references Peluquero(id_peluquero) ON DELETE CASCADE ON UPDATE CASCADE,
	foreign key (id_detalle) references Detalle(id_detalle) ON DELETE CASCADE ON    UPDATE CASCADE,
	foreign key (id_peluqueria) references Peluqueria(id_peluqueria) ON DELETE CASCADE ON UPDATE CASCADE);
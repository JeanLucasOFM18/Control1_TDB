# Control1_TDB
Archivos orientados a la resolución del control 1 de TDB para el grupo 3.

Diccionario de datos

1.- Tabla “comuna”: Tabla que contiene las comunas de la BD. id_comuna (serial): Variable de tipo serial que se autogenera para dar un identificador único a cada comuna. nombre (varchar): Cadena de caracteres con el nombre de la comuna.

2.- Tabla “peluqueria”: Tabla que contiene las peluquerias de las BD. id_peluqueria (serial): Variable de tipo serial que se autogenera para dar un identificador único a cada peluqueria. nombre (varchar): Cadena de caracteres con el nombre de la peluquería. direccion (varchar): Cadena de caracteres con la dirección de la peluquería. id_comuna (int): Referencia a la tabla comuna con el id de la comuna en la que se encuentra la peluquería. telefono (varchar): Cadena de caracteres con el teléfono de la peluquería. correo (varchar): Cadena de caracteres con el correo de la peluquería.

3.- Tabla “cliente”: Tabla que contiene los clientes de la BD. id_cliente (serial): Variable de tipo serial que se autogenera para dar un identificador único a cada cliente. nombre (varchar): Cadena de caracteres con el nombre del cliente. correo (varchar): Cadena de caracteres con el correo del cliente. telefono (varchar): Cadena de caracteres con el teléfono del cliente. genero (varchar): Cadena de caracteres con el género del cliente. id_comuna (int): Referencia a la tabla comuna con el id en el que reside el cliente.

4.- Tabla “detalle”: Tabla que posee el detalle del servicio de la peluquería y el valor de este. id_detalle (serial): Variable de tipo serial que se autogenera para dar un identificador único a cada detalle. servicio (varchar): Cadena de caracteres con el nombre del servicio realizado. precio (int): Variable numérica que representa el valor del servicio.

5.- Tabla “peluquero”: Tabla que contiene los peluqueros de la BD. id_peluquero: (serial): Variable de tipo serial que se autogenera para dar un identificador único a cada peluquero. nombre (varchar): Cadena de caracteres con el nombre del peluquero. correo (varchar): Cadena de caracteres con el correo del peluquero. telefono (varchar): Cadena de caracteres con el teléfono del peluquero. id_peluqueria: Referencia a la tabla peluquería con el id de la peluquería en la que trabaja el peluquero.

6.- Tabla “sueldo”: Tabla que indica los detalles relacionados al sueldo de un peluquero. id_sueldo (serial): Variable de tipo serial que se autogenera para dar un identificador único a sueldo. fecha (date): Variable de tipo DATE que indica el año, mes y día de la generación del sueldo. cantidad (int): Variable de tipo entera que corresponde al monto mensual recibido id_peluquero (int): Referencia a la tabla peluquero con el id del peluquero al que le corresponde el sueldo.

7.- Tabla “cita”: Tabla que contiene las citas de la BD con los datos más importantes de esta. id_cita (serial): Variable de tipo serial que se autogenera para dar un identificador único a cada cita. dia (varchar): Cadena de caracteres con el día de la cita. hora (varchar): Cadena de caracteres con la hora de la cita. duracion_cita (int): Valor numérico con la duración de la cita. anio (int): Valor numérico con el año de la cita. mes (varchar): Cadena de caracteres con el mes de la cita. id_cliente (int): Referencia a la tabla cliente con el id del cliente que participará en la cita. id_peluquero (int): Referencia a la tabla peluquero con el id del peluquero que atiende a la cita generada id_detalle (int): Referencia a la tabla detalle con el id del detalle que posee el servicio a realizar en la cita. id_peluqueria (int): Referencia a la tabla peluquería con el id de la peluquería donde se realiza la cita.

Comandos Script

-- 1 SCRIPT
-- Para crear la BBDD
psql -U nombre_usuario -f dbCreate.sql

-- 2 SCRIPT
-- Para conectarse a la BBDD
psql -U nombre_de_usuario -d control1_g3
-- Para crear tablas y llenarlas
\i loadData.sql

-- 3 SCRIPT
-- Para cargar las sentencias
\i runStatements.sql
INSERT INTO comuna (nombre) 
VALUES 
    ('Santiago'),
    ('Providencia'),
    ('Lo Barnechea'),
    ('Las Condes'),
    ('La Reina'),
    ('Vitacura'),
    ('San Miguel'),
    ('Estación Central'),
    ('Quinta Normal'),
    ('La Florida'),
    ('Puente Alto'),
    ('Maipu');
	
INSERT INTO peluqueria (nombre, direccion, id_comuna, telefono, correo) 
VALUES 
    ('Peluquería Carmen', 'Av. Providencia 1234', 2, '+56 9 1234 5678', 'carmen@peluqueria.com'),
    ('Peluquería Cristina', 'Av. Los Leones 4321', 2, '+56 9 8765 4321', 'cristina@peluqueria.com'),
    ('Peluquería Estilo', 'Av. Irarrázaval 5678', 3, '+56 9 4567 8910', 'estilo@peluqueria.com'),
    ('Peluquería Fina', 'Av. Apoquindo 9876', 4, '+56 9 2345 6789', 'fina@peluqueria.com'),
    ('Peluquería Glamour', 'Av. Kennedy 6543', 4, '+56 9 8901 2345', 'glamour@peluqueria.com');

INSERT INTO cliente (nombre, correo, telefono, genero, id_comuna) 
VALUES 
    ('Maria Gonzalez', 'mariagonzalez@gmail.com', '+56987654321', 'F', 3),
    ('Juan Perez', ' juanperez@hotmail.com', '+56912345678', 'M', 4),
    ('Carla Sanchez', 'carlasanchez@yahoo.com', '+56955555555', 'F', 4),
    ('Pedro Lopez', 'pedrolopez@gmail.com', '+56977777777', 'M', 3),
    ('Lorena Torres', 'lorenatorres@hotmail.com', '+56944444444', 'F', 2),
    ('Jorge Fernandez', 'jorgefernandez@gmail.com', '+56999999999', 'M', 2),
    ('Laura Martinez', 'lauramartinez@gmail.com', '+56922222222', 'F', 1),
    ('Andres Soto', 'andressoto@hotmail.com', '+56933333333', 'M', 4),
    ('Ana Ramirez', 'anaramirez@gmail.com', '+56988888888', 'F', 2),
    ('Mario Gutierrez', 'mariogutierrez@yahoo.com', '+56977777777', 'M', 2),
    ('Isabel Diaz', 'isabeldiaz@hotmail.com', '+56966666666', 'F', 4),
    ('Rodrigo Gomez', 'rodrigogomez@gmail.com', '+56955555555', 'M', 1),
    ('Florencia Vega','florenciavega@hotmail.com', '+56944444444', 'F', 5),
    ('Gabriel Molina', 'gabrielmolina@gmail.com', '+56933333333', 'M', 8),
    ('Valentina  Herrera', 'valentinaherrera@hotmail.com', '+56922222222', 'F', 3);

INSERT INTO peluquero (nombre, correo, telefono, id_peluqueria) 
VALUES 
	('Matías Fuentes', 'matiasfuentes@gmail.com', '+56911111111', 1),
    ('Antonia Pinto', 'antoniapinto@gmail.com', '+56999999999', 4),
    ('Pablo Vásquez', 'pablovasquez@hotmail.com', '+56988888888', 5),
    ('Catalina Rojas', 'catalinarojas@yahoo.com', '+56977777777', 5),
    ('Emilio Muñoz', 'emiliomunoz@hotmail.com', '+56966666666', 2),
	('Daniela García', 'danielagarcia@gmail.com', '+56955555555', 3),
    ('Francisco Navarro', 'francisconavarro@hotmail.com', '+56944444444', 1),
    ('Carolina Sandoval', 'carolinasandoval@gmail.com', '+56933333333', 2);
	
INSERT INTO detalle (servicio, precio)
VALUES
	('Teñido', 5000),
	('Fade', 7000),
	('Pelo y Barba', 10000),
	('Buzz', 10000),
	('Diseño en Pelo', 9000),
    ('Comb Over', 7000),
    ('Pixie', 8000),
    ('Lob', 11000),
    ('Blunt Cut', 12000);

INSERT INTO sueldo (fecha, cantidad, id_peluquero)
VALUES 
    ('2020-01-01', 800000, 1),
    ('2020-03-15', 950000, 2),
    ('2020-06-10', 600000, 3),
    ('2020-08-20', 700000, 4),
    ('2020-11-05', 850000, 5),
    ('2021-02-14', 500000, 6),
    ('2021-04-30', 750000, 7),
    ('2021-07-08', 900000, 8);
  
INSERT INTO cita (dia, hora, duracion_cita, anio, mes, id_cliente, id_peluquero, id_detalle, id_peluqueria) 
VALUES
    ('16', '10:30', '60', '2023', '04', 1, 1, 1, 2),
    ('3', '10:30', '60', '2023', '04', 9, 1, 1, 3),
    ('14', '10:30', '60', '2023', '04', 10, 1, 1, 4),
    ('2', '10:30', '60', '2023', '04', 2, 2, 1, 1),
    ('16', '11:30', '60', '2023', '04', 1, 1, 1, 2),
    ('3', '11:30', '60', '2023', '04', 9, 1, 1, 3),
    ('14', '11:30', '60', '2023', '04', 10, 1, 1, 4),
    ('2', '11:30', '60', '2023', '04', 2, 2, 1, 4),
    ('12', '11:30', '90', '2023', '04', 3, 2, 2, 3),
    ('12', '14:00', '90', '2023', '04', 3, 2, 2, 1),
    ('17', '16:30', '120', '2023', '04', 3, 3, 3, 5),
    ('18', '11:00', '60', '2023', '04', 4, 4, 4, 4),
    ('19', '11:30', '90', '2023', '04', 5, 5, 5, 2),
    ('20', '15:30', '120', '2019', '04', 6, 2, 6, 2),
    ('21', '12:00', '60', '2023', '04', 7, 1, 7, 1),
    ('22', '10:00', '90', '2022', '04', 8, 4, 8, 4),
    ('23', '13:00', '120', '2023', '04', 9, 4, 5, 1),
    ('24', '16:00', '60', '2026', '04', 10, 5, 7, 4),
    ('1', '10:30', '60', '2021', '04', 1, 1, 1, 3),
    ('2', '14:00', '90', '2021', '04', 2, 2, 2, 2),
    ('3', '16:30', '120', '2021', '04', 3, 3, 3, 4),
    ('4', '11:00', '60', '2021', '04', 4, 4, 4, 5),
    ('5', '13:30', '90', '2021', '04', 5, 5, 5, 1),
    ('6', '15:30', '120', '2021', '04', 6, 5, 2, 3),
    ('7', '12:00', '60', '2021', '04', 7, 2, 1, 4),
    ('8', '10:00', '90', '2021', '04', 8, 1, 3, 5),
    ('9', '13:00', '120', '2021', '04', 9, 4, 3, 2),
    ('10', '16:00', '60', '2021', '04', 10, 5, 1, 5),
    ('15', '10:30', '60', '2021', '05', 1, 1, 1, 1),
    ('16', '14:00', '90', '2021', '05', 2, 2, 2, 3),
    ('17', '16:30', '120', '2021', '06', 3, 3, 3, 1),
    ('18', '11:00', '60', '2021', '05', 4, 4, 4, 1),
    ('19', '13:30', '90', '2021', '08', 5, 5, 5, 3),
    ('20', '15:30', '120', '2011', '09', 6, 3, 6, 5),
    ('21', '12:00', '60', '2021', '01', 7, 2, 7, 5),
    ('22', '10:00', '90', '2021', '01', 8, 2, 8, 4),
    ('23', '13:00', '120', '2021', '01', 9, 1, 3, 4),
    ('24', '16:00', '60', '2021', '01', 10, 4, 5, 2),
    ('1', '10:30', '60', '2021', '12', 1, 1, 1, 1),
    ('2', '14:00', '90', '2021', '11', 2, 2, 2, 3),
    ('3', '16:30', '120', '2021', '11', 3, 3, 3, 5),
    ('4', '11:00', '60', '2021', '10', 4, 4, 4, 3),
    ('5', '13:30', '90', '2021', '01', 5, 5, 5, 3),
    ('6', '15:30', '120', '2021', '02', 6, 5, 2, 1),
    ('7', '12:00', '60', '2021', '02', 7, 2, 1, 2),
    ('8', '10:00', '90', '2021', '02', 8, 1, 3, 2),
    ('9', '13:00', '120', '2021', '12', 9, 4, 3, 4);

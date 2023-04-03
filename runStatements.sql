SELECT * FROM comuna;
SELECT * FROM peluqueria;
SELECT * FROM cliente;
SELECT * FROM detalle;
SELECT * FROM cita;
SELECT * FROM peluquero;
SELECT * FROM sueldo;


-- 1
WITH horarios_cita as (SELECT c.dia, c.mes, c.anio, c.id_peluqueria, COUNT(*) as cantidad_citas
FROM cita c
GROUP BY c.dia, c.mes, c.anio, c.id_peluqueria),

menos_citas as (SELECT c.id_peluqueria, MIN(c.cantidad_citas) as menor_cantidad
FROM horarios_cita c
GROUP BY c.id_peluqueria)

SELECT h.dia, h.mes, h.anio, h.id_peluqueria, h.cantidad_citas, co.nombre
FROM horarios_cita h, menos_citas m, comuna co, peluqueria p
WHERE co.id_comuna = p.id_comuna AND p.id_peluqueria = h.id_peluqueria
AND h.id_peluqueria = m.id_peluqueria AND h.cantidad_citas = m.menor_cantidad
ORDER BY h.id_peluqueria ASC;

-- 2
WITH
	cantidad_gastada_cliente_por_peluqueria_mensual AS (
    	SELECT c.id_cliente, p.id_peluqueria, ci.mes, SUM(d.precio::NUMERIC) AS gasto
    	FROM cliente c, cita ci, peluqueria p, detalle d
    	WHERE c.id_cliente = ci.id_cliente AND ci.id_peluqueria = p.id_peluqueria AND ci.id_detalle = d.id_detalle
    	GROUP BY c.id_cliente, p.id_peluqueria, ci.mes
	),

	clientes_que_mas_gastaron AS (
    	SELECT cpm.mes, cpm.id_cliente, cpm.id_peluqueria, MAX(cpm.gasto) AS max_gasto
    	FROM cantidad_gastada_cliente_por_peluqueria_mensual cpm
    	GROUP BY cpm.mes, cpm.id_cliente, cpm.id_peluqueria
	)

SELECT c.nombre AS cliente, com.nombre AS comuna_cliente, p.nombre AS peluqueria, com_p.nombre AS comuna_peluqueria, cq.mes, cq.max_gasto
FROM clientes_que_mas_gastaron cq
JOIN cliente c ON cq.id_cliente = c.id_cliente
JOIN comuna com ON c.id_comuna = com.id_comuna
JOIN peluqueria p ON cq.id_peluqueria = p.id_peluqueria
JOIN comuna com_p ON p.id_comuna = com_p.id_comuna;


-- 3
SELECT p.nombre AS nombre_peluqueria, pe.nombre AS nombre_peluquero, 
       EXTRACT(YEAR FROM s.fecha) AS anio, EXTRACT(MONTH FROM s.fecha) AS mes, 
       s.cantidad AS total_ganado
FROM peluqueria p 
INNER JOIN peluquero pe ON p.id_peluqueria = pe.id_peluqueria 
INNER JOIN sueldo s ON pe.id_peluquero = s.id_peluquero 
WHERE s.fecha >= DATE_TRUNC('year', CURRENT_DATE - INTERVAL '3 years')
AND (p.id_peluqueria, EXTRACT(YEAR FROM s.fecha), EXTRACT(MONTH FROM s.fecha), s.cantidad) IN 
    (SELECT pelu.id_peluqueria, EXTRACT(YEAR FROM s2.fecha), EXTRACT(MONTH FROM s2.fecha), MAX(s2.cantidad)
     FROM peluqueria pelu 
     INNER JOIN peluquero pe2 ON pelu.id_peluqueria = pe2.id_peluqueria 
     INNER JOIN sueldo s2 ON pe2.id_peluquero = s2.id_peluquero 
     WHERE s2.fecha >= DATE_TRUNC('year', CURRENT_DATE - INTERVAL '3 years')
     GROUP BY pelu.id_peluqueria, EXTRACT(YEAR FROM s2.fecha), EXTRACT(MONTH FROM s2.fecha))
ORDER BY p.nombre, anio, mes;


-- 4
SELECT DISTINCT cl.nombre
FROM cita c, cliente cl, detalle d
WHERE d.servicio = 'Pelo y Barba' AND c.id_detalle = d.id_detalle 
AND c.id_cliente = cl.id_cliente AND cl.genero = 'M';

-- 5
SELECT DISTINCT cl.nombre, co.nombre, pe.nombre, d.precio
FROM detalle d, cita c, cliente cl, comuna co, peluqueria pe
WHERE d.servicio = 'Teñido' AND d.id_detalle = c.id_detalle AND c.id_cliente = cl.id_cliente
AND cl.id_comuna = co.id_comuna AND c.id_peluqueria = pe.id_peluqueria;

-- 6
SELECT p.nombre AS peluqueria, c.anio, c.mes, c.hora, COUNT(*) AS cantidad_citas
FROM Peluqueria p 
INNER JOIN Peluquero pq ON p.id_peluqueria = pq.id_peluqueria 
INNER JOIN Cita c ON pq.id_peluquero = c.id_peluquero 
WHERE c.anio BETWEEN 2018 AND 2029 
GROUP BY p.nombre, c.anio, c.mes, c.hora 
HAVING COUNT(*) = 
	(
	    SELECT MAX(cantidad_citas) 
		FROM (
			SELECT p2.nombre, c2.anio, c2.mes, c2.hora, COUNT(*) AS cantidad_citas
			FROM Peluqueria p2 
			INNER JOIN Peluquero pq2 ON p2.id_peluqueria = pq2.id_peluqueria 
			INNER JOIN Cita c2 ON pq2.id_peluquero = c2.id_peluquero 
			WHERE c2.anio BETWEEN 2018 AND 2029 
			GROUP BY p2.nombre, c2.anio, c2.mes, c2.hora 
			) AS temp 
		WHERE temp.nombre = p.nombre AND temp.anio = c.anio AND temp.mes = c.mes 
	)
ORDER BY p.nombre, c.anio, c.mes, cantidad_citas DESC;

-- 7
SELECT c.nombre, p.nombre, ci.mes, MAX(ci.duracion_cita) AS duracion_maxima
	FROM cliente c
	JOIN cita ci ON c.id_cliente = ci.id_cliente
	JOIN peluqueria p ON ci.id_peluqueria = p.id_peluqueria
	GROUP BY c.id_cliente, p.id_peluqueria, ci.mes;

-- 8

SELECT peluqueria.nombre AS nombre_peluqueria, detalle.servicio as servicio_mas_caro, detalle.precio as valor 
FROM peluqueria 
INNER JOIN cita ON peluqueria.id_peluqueria = cita.id_peluqueria 
INNER JOIN detalle ON cita.id_detalle = detalle.id_detalle 
WHERE detalle.precio = (SELECT MAX(detalle.precio) 
                        FROM detalle 
                        INNER JOIN cita ON detalle.id_detalle = cita.id_detalle 
                        WHERE cita.id_peluqueria = peluqueria.id_peluqueria) 
GROUP BY peluqueria.nombre, detalle.servicio, detalle.precio;

-- 9

SELECT t1.nombre, t1.mes, t2.mayor_tiempo
FROM (
	SELECT p.nombre, c.mes, SUM(c.duracion_cita) AS tiempo_trabajado
	FROM Peluquero p
	JOIN Cita c ON p.id_peluquero = c.id_peluquero
	WHERE c.anio = 2021
	GROUP BY p.nombre, c.mes
) t1, (
	SELECT tiempo_por_mes.mes, MAX(tiempo_trabajado) AS mayor_tiempo
	FROM (
  		SELECT p.nombre, c.mes, SUM(c.duracion_cita) AS tiempo_trabajado
  		FROM Peluquero p
  		JOIN Cita c ON p.id_peluquero = c.id_peluquero
  		WHERE c.anio = 2021
  		GROUP BY p.nombre, c.mes
	) AS tiempo_por_mes
	GROUP BY tiempo_por_mes.mes
) t2
WHERE t1.mes = t2.mes AND t1.tiempo_trabajado = t2.mayor_tiempo;


-- 10
WITH peluquerias as (SELECT c.id_comuna, COUNT(*)as n_peluquerias
FROM comuna c, peluqueria p
WHERE c.id_comuna = p.id_comuna
GROUP BY c.id_comuna), 
clientes as 
(SELECT c.id_comuna, COUNT(*) as n_clientes
FROM comuna c, cliente cl
WHERE c.id_comuna = cl.id_comuna
GROUP BY c.id_comuna)

SELECT c.id_comuna, c.nombre, p.n_peluquerias, cl.n_clientes
FROM comuna c, peluquerias p, clientes cl
WHERE c.id_comuna = p.id_comuna AND c.id_comuna = cl.id_comuna;
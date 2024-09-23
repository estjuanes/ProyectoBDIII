-- Crear base de datos del Data Warehouse
CREATE DATABASE DW_TransporteBuses;
GO

-- Usar la base de datos
USE DW_TransporteBuses;
GO

-- Crear tabla de dimensión Tiempo
CREATE TABLE DimTiempo (
    fecha_id INT PRIMARY KEY,
    fecha DATE,
    dia INT,
    mes INT,
    año INT,
    trimestre INT,
    semana INT,
    dia_semana VARCHAR(10)
);
GO

-- Crear dimensión Viaje
CREATE TABLE DimViaje (
    viaje_id INT PRIMARY KEY,
    bus_id INT,
    conductor_id INT,
    ruta_id INT,
    fecha_salida DATETIME,
    fecha_llegada DATETIME,
    estado_viaje VARCHAR(50) CHECK (estado_viaje IN ('completado', 'cancelado', 'en curso'))
);
GO

-- Crear dimensión Ruta
CREATE TABLE DimRuta (
    ruta_id INT PRIMARY KEY,
    origen VARCHAR(100),
    destino VARCHAR(100),
    distancia_km DECIMAL(5,2)
);
GO

-- Crear dimensión Bus
CREATE TABLE DimBus (
    bus_id INT PRIMARY KEY,
    placa VARCHAR(10),
    modelo VARCHAR(50),
    capacidad INT,
    estado VARCHAR(50) CHECK (estado IN ('disponible', 'en mantenimiento', 'en ruta'))
);
GO

-- Crear dimensión Conductor
CREATE TABLE DimConductor (
    conductor_id INT PRIMARY KEY,
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    licencia VARCHAR(50),
    telefono VARCHAR(15)
);
GO

-- Crear tabla de hechos Ventas
CREATE TABLE Ventas (
    venta_id INT PRIMARY KEY,
    viaje_id INT,
    ruta_id INT,
    fecha_id INT,  -- Usamos el ID de la dimensión tiempo en lugar de DATETIME
    bus_id INT,    -- Clave foránea que se conecta con la dimensión Bus
    conductor_id INT, -- Clave forónea que se conecta con la dimensión Conductor
    monto_vendido DECIMAL(10,2),
    asientos_vendidos INT,
    FOREIGN KEY (viaje_id) REFERENCES DimViaje(viaje_id),
    FOREIGN KEY (ruta_id) REFERENCES DimRuta(ruta_id),
    FOREIGN KEY (fecha_id) REFERENCES DimTiempo(fecha_id),
    FOREIGN KEY (bus_id) REFERENCES DimBus(bus_id),         -- Conexión con la dimensión Bus
    FOREIGN KEY (conductor_id) REFERENCES DimConductor(conductor_id) -- Conexión con la dimensión Conductor
);
GO

-- Usar la base de datos
USE TransporteBuses;
GO
-- Obtener fechas inicas de la tabla Viajes
SELECT DISTINCT CAST(fecha_salida AS DATE) AS fecha FROM Viajes
UNION
SELECT DISTINCT CAST(fecha_llegada AS DATE) AS fecha FROM Viajes
UNION
-- Obtener fechas únicas de la tabla Boletos
SELECT DISTINCT CAST(fecha_compra AS DATE) AS fecha FROM Boletos
UNION
-- Obtener fechas únicas de la tabla Pagos
SELECT DISTINCT CAST(fecha_pago AS DATE) AS fecha FROM Pagos;


-- Usar la base de datos
USE DW_TransporteBuses;
GO

-- Insertar datos en la tabla DimBuses
INSERT INTO DimBus (bus_id, placa, modelo, capacidad, estado)
VALUES 
(1, 'ABC123', 'Volvo 2020', 50, 'disponible'),
(2, 'DEF456', 'Mercedes 2019', 45, 'en ruta'),
(3, 'GHI789', 'Scania 2021', 60, 'en mantenimiento'),
(4, 'JKL012', 'Volvo 2022', 55, 'disponible'),
(5, 'MNO345', 'Mercedes 2020', 40, 'disponible'),
(6, 'PQR678', 'Volvo 2019', 50, 'en mantenimiento'),
(7, 'STU901', 'Scania 2020', 65, 'en ruta'),
(8, 'VWX234', 'Mercedes 2021', 45, 'disponible'),
(9, 'YZA567', 'Volvo 2022', 55, 'disponible'),
(10, 'BCD890', 'Mercedes 2020', 40, 'disponible'),
(11, 'EFG123', 'Volvo 2020', 50, 'en mantenimiento'),
(12, 'HIJ456', 'Scania 2021', 65, 'en ruta'),
(13, 'KLM789', 'Mercedes 2019', 45, 'disponible'),
(14, 'NOP012', 'Volvo 2022', 60, 'disponible'),
(15, 'QRS345', 'Mercedes 2021', 40, 'disponible'),
(16, 'TUV678', 'Scania 2020', 50, 'en ruta'),
(17, 'WXY901', 'Volvo 2022', 55, 'en mantenimiento'),
(18, 'ZAB234', 'Mercedes 2020', 45, 'disponible'),
(19, 'CDE567', 'Scania 2019', 60, 'disponible'),
(20, 'FGH890', 'Volvo 2020', 50, 'disponible');
GO

-- Insertar datos en la tabla DimConductores
INSERT INTO DimConductor (conductor_id, nombre, apellido, licencia, telefono)
VALUES 
(1, 'Juan', 'Perez', 'ABC123', '8888-1234'),
(2, 'Pedro', 'Garcia', 'DEF456', '8888-5678'),
(3, 'Luis', 'Martinez', 'GHI789', '8888-9876'),
(4, 'Carlos', 'Gomez', 'JKL012', '8888-5432'),
(5, 'Jorge', 'Lopez', 'MNO345', '8888-8765'),
(6, 'Esteban', 'Ramirez', 'PQR678', '8888-2345'),
(7, 'Maria', 'Sanchez', 'STU901', '8888-6543'),
(8, 'Gabriel', 'Vargas', 'VWX234', '8888-7890'),
(9, 'Jose', 'Herrera', 'YZA567', '8888-3210'),
(10, 'Sofia', 'Mendoza', 'BCD890', '8888-4321'),
(11, 'Carolina', 'Rodriguez', 'EFG123', '8888-5432'),
(12, 'Fernando', 'Cruz', 'HIJ456', '8888-7654'),
(13, 'David', 'Rojas', 'KLM789', '8888-8765'),
(14, 'Laura', 'Jimenez', 'NOP012', '8888-9876'),
(15, 'Rafael', 'Alvarado', 'QRS345', '8888-0987'),
(16, 'Diego', 'Vega', 'TUV678', '8888-5678'),
(17, 'Andrea', 'Paniagua', 'WXY901', '8888-6543'),
(18, 'Ricardo', 'Acosta', 'ZAB234', '8888-3210'),
(19, 'Daniel', 'Navarro', 'CDE567', '8888-4321'),
(20, 'Paola', 'Ortiz', 'FGH890', '8888-5432');
GO

-- Insertar datos en la tabla DimRutas
INSERT INTO DimRuta (ruta_id, origen, destino, distancia_km)
VALUES 
(1, 'San Jose', 'Alajuela', 20.5),
(2, 'Alajuela', 'Puntarenas', 115.3),
(3, 'San Jose', 'Limon', 160.8),
(4, 'San Jose', 'Cartago', 25.0),
(5, 'Cartago', 'Perez Zeledon', 125.0),
(6, 'San Jose', 'Heredia', 15.2),
(7, 'Heredia', 'Liberia', 210.4),
(8, 'San Jose', 'Tamarindo', 275.8),
(9, 'Alajuela', 'Nicoya', 190.1),
(10, 'Limon', 'Puerto Viejo', 40.7),
(11, 'San Jose', 'Guapiles', 75.6),
(12, 'Heredia', 'Limon', 160.8),
(13, 'San Jose', 'Quepos', 175.3),
(14, 'San Jose', 'San Isidro', 135.4),
(15, 'San Jose', 'Monteverde', 180.5),
(16, 'Cartago', 'Turrialba', 60.7),
(17, 'Alajuela', 'San Carlos', 95.2),
(18, 'Liberia', 'Tamarindo', 60.4),
(19, 'San Jose', 'Playa Hermosa', 215.6),
(20, 'Limon', 'Cahuita', 50.9);
GO

-- Insertar datos en la tabla FactViajes
INSERT INTO DimViaje(viaje_id, bus_id, conductor_id, ruta_id, fecha_salida, fecha_llegada)
VALUES 
(1, 1, 1, 1, '2022-03-15 08:00:00', '2022-03-15 10:00:00'),
(2, 2, 2, 2, '2022-04-18 07:30:00', '2022-04-18 10:00:00'),
(3, 3, 3, 3, '2022-05-20 09:00:00', '2022-05-20 11:00:00'),
(4, 4, 4, 4, '2022-06-15 08:30:00', '2022-06-15 11:30:00'),
(5, 5, 5, 5, '2022-07-10 06:30:00', '2022-07-10 09:00:00'),
(6, 6, 6, 6, '2023-01-08 09:00:00', '2023-01-08 12:00:00'),
(7, 7, 7, 7, '2023-02-20 07:00:00', '2023-02-20 09:00:00'),
(8, 8, 8, 8, '2023-03-14 10:00:00', '2023-03-14 12:00:00'),
(9, 9, 9, 9, '2023-04-18 11:00:00', '2023-04-18 14:00:00'),
(10, 10, 10, 10, '2023-05-19 07:30:00', '2023-05-19 10:30:00'),
(11, 11, 11, 11, '2023-06-15 09:00:00', '2023-06-15 11:30:00'),
(12, 12, 12, 12, '2023-07-20 06:00:00', '2023-07-20 09:30:00'),
(13, 13, 13, 13, '2023-08-10 07:00:00', '2023-08-10 09:30:00'),
(14, 14, 14, 14, '2023-09-05 09:30:00', '2023-09-05 11:30:00'),
(15, 15, 15, 15, '2024-01-24 05:30:00', '2024-01-24 09:30:00'),
(16, 16, 16, 16, '2024-02-15 06:30:00', '2024-02-15 10:00:00'),
(17, 17, 17, 17, '2024-03-11 08:00:00', '2024-03-11 11:00:00'),
(18, 18, 18, 18, '2024-04-10 09:00:00', '2024-04-10 12:00:00'),
(19, 19, 19, 19, '2024-05-15 07:00:00', '2024-05-15 10:00:00'),
(20, 20, 20, 20, '2024-06-10 08:30:00', '2024-06-10 11:30:00');
GO

INSERT INTO DimTiempo (fecha_id, fecha, dia, mes, año, trimestre, semana, dia_semana)
VALUES 
(1, '2022-03-15', 15, 3, 2022, 1, 11, 'miércoles'),
(2, '2022-04-18', 18, 4, 2022, 2, 16, 'lunes'),
(3, '2022-05-20', 20, 5, 2022, 2, 20, 'viernes'),
(4, '2022-06-15', 15, 6, 2022, 2, 24, 'miércoles'),
(5, '2022-07-10', 10, 7, 2022, 4, 28, 'domingo'),
(6, '2023-01-08', 08, 1, 2023, 1, 1, 'domingo'),
(7, '2023-02-20', 20, 2, 2023, 1, 8, 'lunes'),
(8, '2023-03-14', 14, 3, 2023, 1, 11, 'martes'),
(9, '2023-04-18', 18, 4, 2023, 2, 16, 'martes'),
(10, '2023-05-19', 19, 5, 2023, 2, 20, 'viernes'),
(11, '2023-06-15', 15, 6, 2023, 2, 24, 'jueves'),
(12, '2023-07-20', 20, 7, 2023, 3, 30, 'jueves'),
(13, '2023-08-10', 10, 8, 2023, 3, 32, 'jueves'),
(14, '2023-09-05', 05, 9, 2023, 3, 36, 'martes'),
(15, '2024-01-24', 24, 1, 2024, 1, 4, 'miércoles'),
(16, '2024-02-15', 15, 2, 2024, 1, 7, 'jueves'),
(17, '2024-03-11', 11, 3, 2024, 1, 11, 'lunes'),
(18, '2024-04-10', 10, 4, 2024, 2, 15, 'miércoles'),
(19, '2024-05-15', 15, 5, 2024, 2, 20, 'miércoles'),
(20, '2024-06-10', 10, 6, 2024, 2, 24, 'lunes');
GO


-- Inserci�n de los datos transformados en la tabla de hechos Ventas
INSERT INTO Ventas (venta_id, viaje_id, ruta_id, fecha_id, bus_id, conductor_id, monto_vendido, asientos_vendidos)
VALUES 
(1, 1, 1, 1, 1, 1, 3000.50, 30),
(2, 2, 2, 2, 2, 2, 1200.75, 25),
(3, 3, 3, 3, 3, 3, 2000.50, 27),
(4, 4, 4, 4, 4, 4, 3500.75, 31),
(5, 5, 5, 5, 5, 5, 2500.80, 20),
(6, 6, 6, 6, 6, 6, 3900.30, 38),
(7, 7, 7, 7, 7, 7, 2000.20, 21),
(8, 8, 8, 8, 8, 8, 4000.70, 40),
(9, 9, 9, 9, 9, 9, 2400.75, 26),
(10, 10, 10, 10, 10, 10, 2000.40, 22),
(11, 11, 11, 11, 11, 11, 3200.70, 32),
(12, 12, 12, 12, 12, 12, 3000.80, 30),
(13, 13, 13, 13, 13, 13, 3900.76, 39),
(14, 14, 14, 14, 14, 14, 2600.45, 27),
(15, 15, 15, 15, 15, 15, 3000.50, 31),
(16, 16, 16, 16, 16, 16, 2400.60, 25),
(17, 17, 17, 17, 17, 17, 2000.50, 27),
(18, 18, 18, 18, 18, 18, 3900.30, 38),
(19, 19, 19, 19, 19, 19, 4000.70, 40),
(20, 20, 20, 20, 20, 20, 2500.80, 20);
GO

-- Insertar datos en la tabla DimTiempo
-- Nota: Puedes ajustar el formato del `fecha_id` si tienes un formato específico en mente.

INSERT INTO DimTiempo (fecha_id, fecha, dia, mes, año, trimestre, semana, dia_semana)
VALUES
(
GO


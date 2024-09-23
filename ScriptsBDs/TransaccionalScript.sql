-- Crear base de datos transaccional
CREATE DATABASE TransporteBuses;
GO

-- Usar la base de datos
USE TransporteBuses;
GO

-- Crear tabla Buses
CREATE TABLE Buses (
    bus_id INT PRIMARY KEY,
    placa VARCHAR(10) NOT NULL,
    modelo VARCHAR(50),
    capacidad INT NOT NULL,
    estado VARCHAR(50) CHECK (estado IN ('disponible', 'en mantenimiento', 'en ruta'))
);
GO

-- Crear tabla Conductores
CREATE TABLE Conductores (
    conductor_id INT PRIMARY KEY,
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    licencia VARCHAR(50),
    telefono VARCHAR(15)
);
GO

-- Crear tabla Rutas
CREATE TABLE Rutas (
    ruta_id INT PRIMARY KEY,
    origen VARCHAR(100),
    destino VARCHAR(100),
    distancia_km DECIMAL(5,2)
);
GO

-- Crear tabla Viajes
CREATE TABLE Viajes (
    viaje_id INT PRIMARY KEY,
    ruta_id INT FOREIGN KEY REFERENCES Rutas(ruta_id),
    bus_id INT FOREIGN KEY REFERENCES Buses(bus_id),
    conductor_id INT FOREIGN KEY REFERENCES Conductores(conductor_id),
    fecha_salida DATETIME,
    fecha_llegada DATETIME
);
GO

-- Crear tabla Boletos
CREATE TABLE Boletos (
    boleto_id INT PRIMARY KEY,
    viaje_id INT FOREIGN KEY REFERENCES Viajes(viaje_id),
    asiento VARCHAR(5),
    precio DECIMAL(10,2),
    fecha_compra DATETIME
);
GO

-- Crear tabla Pagos
CREATE TABLE Pagos (
    pago_id INT PRIMARY KEY,
    boleto_id INT FOREIGN KEY REFERENCES Boletos(boleto_id),
    monto DECIMAL(10,2),
    fecha_pago DATETIME,
    metodo_pago VARCHAR(50) CHECK (metodo_pago IN ('efectivo', 'tarjeta', 'transferencia'))
);
GO


-- Insertar datos en la tabla Buses
INSERT INTO Buses (bus_id, placa, modelo, capacidad, estado)
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

-- Insertar datos en la tabla Conductores
INSERT INTO Conductores (conductor_id, nombre, apellido, licencia, telefono)
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


-- Insertar datos en la tabla Rutas
INSERT INTO Rutas (ruta_id, origen, destino, distancia_km)
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


-- Insertar datos en la tabla Viajes con fechas variadas
INSERT INTO Viajes (viaje_id, bus_id, conductor_id, ruta_id, fecha_salida, fecha_llegada)
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
(16, 16, 16, 16, '2024-02-25 08:00:00', '2024-02-25 09:15:00'),
(17, 17, 17, 17, '2024-03-26 06:00:00', '2024-03-26 08:30:00'),
(18, 18, 18, 18, '2024-04-27 07:00:00', '2024-04-27 08:30:00'),
(19, 19, 19, 19, '2024-05-28 06:30:00', '2024-05-28 10:30:00'),
(20, 20, 20, 20, '2024-06-29 07:30:00', '2024-06-29 09:30:00');
GO


-- Insertar datos en la tabla Boletos con fechas variadas
INSERT INTO Boletos (boleto_id, viaje_id, asiento, precio, fecha_compra)
VALUES 
(1, 1, 'A1', 2500.00, '2022-03-10 09:00:00'),
(2, 2, 'A2', 2700.00, '2022-04-12 10:00:00'),
(3, 3, 'A3', 3000.00, '2022-05-15 09:00:00'),
(4, 4, 'A4', 3500.00, '2022-06-10 11:00:00'),
(5, 5, 'A5', 2000.00, '2022-07-05 10:00:00'),
(6, 6, 'A6', 2600.00, '2023-01-05 12:00:00'),
(7, 7, 'A7', 3200.00, '2023-02-15 10:00:00'),
(8, 8, 'A8', 2800.00, '2023-03-07 11:00:00'),
(9, 9, 'A9', 2900.00, '2023-04-10 12:00:00'),
(10, 10, 'A10', 2600.00, '2023-05-05 08:00:00'),
(11, 11, 'A11', 2700.00, '2023-06-10 09:00:00'),
(12, 12, 'A12', 3100.00, '2023-07-10 10:00:00'),
(13, 13, 'A13', 2400.00, '2023-08-01 11:00:00'),
(14, 14, 'A14', 2900.00, '2023-09-01 08:00:00'),
(15, 15, 'A15', 3300.00, '2024-01-10 10:00:00'),
(16, 16, 'A16', 2800.00, '2024-02-10 11:00:00'),
(17, 17, 'A17', 2500.00, '2024-03-10 09:00:00'),
(18, 18, 'A18', 3200.00, '2024-04-05 08:00:00'),
(19, 19, 'A19', 3000.00, '2024-05-01 10:00:00'),
(20, 20, 'A20', 2500.00, '2024-06-01 11:00:00');
GO


-- Insertar datos en la tabla Pagos con fechas variadas
INSERT INTO Pagos (pago_id, boleto_id, monto, fecha_pago, metodo_pago)
VALUES 
(1, 1, 2500.00, '2022-03-11 09:30:00', 'efectivo'),
(2, 2, 2700.00, '2022-04-13 10:30:00', 'tarjeta'),
(3, 3, 3000.00, '2022-05-16 09:30:00', 'transferencia'),
(4, 4, 3500.00, '2022-06-11 11:30:00', 'efectivo'),
(5, 5, 2000.00, '2022-07-06 10:30:00', 'tarjeta'),
(6, 6, 2600.00, '2023-01-06 12:30:00', 'transferencia'),
(7, 7, 3200.00, '2023-02-16 10:30:00', 'efectivo'),
(8, 8, 2800.00, '2023-03-08 11:30:00', 'tarjeta'),
(9, 9, 2900.00, '2023-04-11 12:30:00', 'transferencia'),
(10, 10, 2600.00, '2023-05-06 08:30:00', 'efectivo'),
(11, 11, 2700.00, '2023-06-11 09:30:00', 'tarjeta'),
(12, 12, 3100.00, '2023-07-11 10:30:00', 'transferencia'),
(13, 13, 2400.00, '2023-08-02 11:30:00', 'efectivo'),
(14, 14, 2900.00, '2023-09-02 08:30:00', 'tarjeta'),
(15, 15, 3300.00, '2024-01-11 10:30:00', 'transferencia'),
(16, 16, 2800.00, '2024-02-11 11:30:00', 'efectivo'),
(17, 17, 2500.00, '2024-03-11 09:30:00', 'tarjeta'),
(18, 18, 3200.00, '2024-04-06 08:30:00', 'transferencia'),
(19, 19, 3000.00, '2024-05-02 10:30:00', 'efectivo'),
(20, 20, 2500.00, '2024-06-02 11:30:00', 'tarjeta');
GO

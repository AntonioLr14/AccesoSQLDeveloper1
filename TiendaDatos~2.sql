-- Crear tabla Persona
CREATE OR REPLACE TYPE Persona  AS OBJECT (
    persona_id INT ,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    edad INT
  
);


-- Crear tabla Empleado con relación de herencia a Persona
CREATE TABLE Empleado UNDER Persona (
    empleado_id INT PRIMARY KEY,
    salario DECIMAL(10, 2),
    cargo VARCHAR(50),
    fecha_contratacion DATE
);

-- Crear tabla Cliente con relación de herencia a Persona
CREATE TABLE Cliente UNDER Persona (
    cliente_id INT PRIMARY KEY,
    numero_cliente VARCHAR(20),
    tipo_cliente VARCHAR(50),
    fecha_registro DATE
);

-- Crear tabla Producto con relación a Empleado
CREATE TABLE Producto (
    producto_id INT PRIMARY KEY,
    nombre_producto VARCHAR(100),
    precio DECIMAL(10, 2),
    empleado_id INT,
    fecha_lanzamiento DATE,
    FOREIGN KEY (empleado_id) REFERENCES Empleado(empleado_id)
);
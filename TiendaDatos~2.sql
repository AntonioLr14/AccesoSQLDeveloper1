-- Crear tabla Persona
-- Crear tipo de dato para Persona
CREATE or REPLACE TYPE Persona AS OBJECT (
    persona_id INT,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    edad INT,
    MEMBER FUNCTION getNombre RETURN VARCHAR,
    MEMBER PROCEDURE setNombre(nombre VARCHAR),
    MEMBER FUNCTION getApellido RETURN VARCHAR,
    MEMBER PROCEDURE setApellido(apellido VARCHAR),
    MEMBER FUNCTION getEdad RETURN INT,
    MEMBER PROCEDURE setEdad(edad INT)
);

-- Implementar métodos para PersonaType
CREATE TYPE BODY Persona AS
    MEMBER FUNCTION getNombre RETURN VARCHAR IS
    BEGIN
        RETURN self.nombre;
    END;

    MEMBER PROCEDURE setNombre(nombre VARCHAR) IS
    BEGIN
        self.nombre := nombre;
    END;

    MEMBER FUNCTION getApellido RETURN VARCHAR IS
    BEGIN
        RETURN self.apellido;
    END;

    MEMBER PROCEDURE setApellido(apellido VARCHAR) IS
    BEGIN
        self.apellido := apellido;
    END;

    MEMBER FUNCTION getEdad RETURN INT IS
    BEGIN
        RETURN self.edad;
    END;

    MEMBER PROCEDURE setEdad(edad INT) IS
    BEGIN
        self.edad := edad;
    END;
END;


-- Crear tabla Empleado con relación de herencia a Persona
CREATE OR REPLACE TYPE Empleado UNDER Persona (
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
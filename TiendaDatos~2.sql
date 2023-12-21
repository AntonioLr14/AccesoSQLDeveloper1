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
)NOT FINAL;

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



-- Crear tipo de dato para Empleado
CREATE TYPE Empleado UNDER Persona (
    salario DECIMAL(10, 2),
    cargo VARCHAR(50),
    MEMBER FUNCTION getSalario RETURN DECIMAL,
    MEMBER PROCEDURE setSalario(salario DECIMAL),
    MEMBER FUNCTION getCargo RETURN VARCHAR,
    MEMBER PROCEDURE setCargo(cargo VARCHAR)
);

-- Implementar métodos para EmpleadoType
CREATE TYPE BODY Empleado AS
    MEMBER FUNCTION getSalario RETURN DECIMAL IS
    BEGIN
        RETURN self.salario;
    END;

    MEMBER PROCEDURE setSalario(salario DECIMAL) IS
    BEGIN
        self.salario := salario;
    END;

    MEMBER FUNCTION getCargo RETURN VARCHAR IS
    BEGIN
        RETURN self.cargo;
    END;

    MEMBER PROCEDURE setCargo(cargo VARCHAR) IS
    BEGIN
        self.cargo := cargo;
    END;
END;
-- Crear tipo de dato para Cliente
CREATE TYPE Cliente UNDER persona (
    fechaRegistro DATE,
    MEMBER FUNCTION getFechaRegistro RETURN DATE,
    MEMBER PROCEDURE setFechaRegistro(fechaRegistro DATE)
);

-- Implementar métodos para ClienteType
CREATE TYPE BODY Cliente AS
   
    MEMBER FUNCTION getFechaRegistro RETURN DATE IS
    BEGIN
        RETURN self.fechaRegistro;
    END;

    MEMBER PROCEDURE setFechaRegistro(fechaRegistro DATE) IS
    BEGIN
        self.fechaRegistro := fecharegistro;
    END;
END;

-- Crear tipo de dato para Producto
CREATE TYPE Producto AS OBJECT (
    producto_id INT,
    nombre_producto VARCHAR(100),
    precio DECIMAL(10, 2),
    empleado_id INT,
    MEMBER FUNCTION getNombre_producto RETURN VARCHAR,
    MEMBER PROCEDURE setNombre_producto(nombre_producto VARCHAR),
    MEMBER FUNCTION getPrecio RETURN DECIMAL,
    MEMBER PROCEDURE setPrecio(precio DECIMAL),
    MEMBER FUNCTION getEmpleado_id RETURN INT,
    MEMBER PROCEDURE setEmpleado_id(empleado_id INT)
);

-- Implementar métodos para Producto
CREATE TYPE BODY Producto AS
    MEMBER FUNCTION getNombre_producto RETURN VARCHAR IS
    BEGIN
        RETURN self.nombre_producto;
    END;

    MEMBER PROCEDURE setNombre_producto(nombre_producto VARCHAR) IS
    BEGIN
        self.nombre_producto := nombre_producto;
    END;

    MEMBER FUNCTION getPrecio RETURN DECIMAL IS
    BEGIN
        RETURN self.precio;
    END;

    MEMBER PROCEDURE setPrecio(precio DECIMAL) IS
    BEGIN
        self.precio := precio;
    END;

    MEMBER FUNCTION getEmpleado_id RETURN INT IS
    BEGIN
        RETURN self.empleado_id;
    END;

    MEMBER PROCEDURE setEmpleado_id(empleado_id INT) IS
    BEGIN
        self.empleado_id := empleado_id;
    END;
END;

CREATE TABLE Persona_table of Persona(
persona_id primary key
);

CREATE TABLE Empleado_Table of Empleado(
persona_id primary key);

CREATE TABLE Cliente_Table of Cliente(
persona_id primary key
);
CREATE TABLE Producto_Table of Producto(
producto_id primary key,
 constraint fk_prod_emp foreign key (empleado_id) references Empleado_Table(persona_id)
);

INSERT INTO Persona_Table VALUES(1,'Jose','Perez',24);
INSERT INTO Persona_Table VALUES(2,'Luisa','Gonzalez',50);
INSERT INTO Persona_Table VALUES(3,'Manuel','Carrasco',20);
INSERT INTO Persona_Table VALUES(4,'Pedro','Ruiz',54);
INSERT INTO Persona_Table VALUES(5,'Javier','Garcia',33);
INSERT INTO Persona_Table VALUES(6,'Miguel','Fernandez',47);

INSERT INTO Cliente_Table VALUES(3,'Manuel','Carrasco',60,'21-12-2023');
INSERT INTO Cliente_Table VALUES(2,'Luisa','Gonzalez',50,'01-04-2021');
INSERT INTO Cliente_Table VALUES(6,'Miguel','Fernandez',47,'24-08-2012');

INSERT INTO Empleado_Table VALUES(1,'Jose','Perez',24,2300,'Administrativo');
INSERT INTO Empleado_Table VALUES(4,'Pedro','Ruiz',54,1800,'Reponedor');
INSERT INTO Empleado_Table VALUES(5,'Javier','Garcia',33,3500,'Encargado');

INSERT INTO Producto_Table VALUES(1,'Ratón Logitech',50,1);
INSERT INTO Producto_Table VALUES(2,'Pantalla Corsair',200,5);
INSERT INTO Producto_Table VALUES(3,'Teclado Keychron',100,1);


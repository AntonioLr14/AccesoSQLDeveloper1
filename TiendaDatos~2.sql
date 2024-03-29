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

-- Implementar m�todos para PersonaType
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

-- Implementar m�todos para EmpleadoType
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

-- Implementar m�todos para ClienteType
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

-- Implementar m�todos para Producto
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

INSERT INTO Producto_Table VALUES(1,'Rat�n Logitech',50,1);
INSERT INTO Producto_Table VALUES(2,'Pantalla Corsair',200,5);
INSERT INTO Producto_Table VALUES(3,'Teclado Keychron',100,1);
 
DECLARE 
CURSOR persona_cursor IS SELECT * FROM persona_table;
BEGIN
FOR p IN persona_cursor
LOOP
DBMS_output.put_line('Id: '||p.persona_id||', Nombre: '||p.nombre||', Apellido: '||p.apellido||', Edad: '||p.edad);
END LOOP;
END;

DECLARE 
CURSOR cliente_cursor IS SELECT * FROM cliente_table;
BEGIN
FOR c IN cliente_cursor
LOOP
DBMS_output.put_line('Id: '||c.persona_id||', Nombre: '||c.nombre||', Apellido: '||c.apellido||', Edad: '||c.edad||', Fecha_Registro: '||c.fecharegistro);
END LOOP;
END;

DECLARE 
CURSOR empleado_cursor IS SELECT * FROM empleado_table;
BEGIN
FOR e IN empleado_cursor
LOOP
DBMS_output.put_line('Id: '||e.persona_id||', Nombre: '||e.nombre||', Apellido: '||e.apellido||', Edad: '||e.edad||', Salario: '||e.salario||', Cargo: '||e.cargo);
END LOOP;
END;

DECLARE 
CURSOR producto_cursor IS SELECT * FROM producto_table;
BEGIN
FOR p IN producto_cursor
LOOP
DBMS_output.put_line('Id: '||p.producto_id||', Nombre_producto: '||p.nombre_producto||', Precio: '||p.precio||', Empleado: '||p.empleado_id);
END LOOP;
END;

-- Procedimiento para insertar una Persona
CREATE OR REPLACE PROCEDURE InsertarPersona(
  p persona
) AS
BEGIN
    INSERT INTO persona_table VALUES (p.persona_id,p.nombre,p.apellido,p.edad);
END InsertarPersona;

-- Procedimiento para borrar una Persona
CREATE OR REPLACE PROCEDURE BorrarPersona(
    p_id INT
) AS
BEGIN
    DELETE FROM Persona_table WHERE persona_id = p_id;
END BorrarPersona;

-- Procedimiento para actualizar una Persona
CREATE OR REPLACE PROCEDURE ActualizarPersona(
    p persona
) AS
BEGIN
    UPDATE Persona_table SET
        nombre = p.nombre,
        apellido = p.apellido,
        edad = p.edad
    WHERE persona_id = p.persona_id;
END ActualizarPersona;

 -- Procedimiento para consultar una persona por id
CREATE OR REPLACE PROCEDURE ConsultarPersonas(condicion NUMBER) AS
p persona;
id NUMBER;
nombre VARCHAR2(255);
apellido VARCHAR2(255);
edad NUMBER;
BEGIN
SELECT * into id,nombre,apellido,edad from persona_table where persona_id=condicion;
p:=new Persona(id,nombre,apellido,edad);
        DBMS_OUTPUT.PUT_LINE(
            p.persona_id || ' ' ||
            p.nombre || ' ' ||
            p.apellido || ' ' ||
            p.edad
        );

END ConsultarPersonas;

-- Procedimiento para insertar un Producto
CREATE OR REPLACE PROCEDURE InsertarProducto(
  p producto
) AS
BEGIN
    INSERT INTO producto_table VALUES (p.producto_id,p.nombre_producto,p.precio,p.empleado_id);
END InsertarProducto;

-- Procedimiento para borrar una Persona
CREATE OR REPLACE PROCEDURE BorrarProducto(
    p_id INT
) AS
BEGIN
    DELETE FROM Producto_table WHERE producto_id = p_id;
END BorrarProducto;

CREATE OR REPLACE PROCEDURE ActualizarProducto(
   p producto
) AS
BEGIN
    UPDATE Producto_table SET
        nombre_producto = p.nombre_producto,
        precio = p.precio,
        empleado_id = p.empleado_id
    WHERE producto_id = p.producto_id;
END ActualizarProducto;

 -- Procedimiento para consultar un prodcuto por id
CREATE OR REPLACE PROCEDURE ConsultarProductos(condicion NUMBER) AS
id NUMBER;
nombre VARCHAR2(255);
precio NUMBER;
empleado_id NUMBER;
p producto;
BEGIN
        SELECT * into id,nombre,precio,empleado_id FROM producto_table where producto_id=condicion;
        p:=new Producto(id,nombre,precio,empleado_id);
        DBMS_OUTPUT.PUT_LINE(
            p.producto_id || ' ' ||
            p.nombre_producto || ' ' ||
            p.precio || ' ' ||
            p.empleado_id
        );

END ConsultarProductos;
--Procedimiento para insertar un Empleado
CREATE OR REPLACE PROCEDURE InsertarEmpleado(
  e empleado
) AS
BEGIN
    INSERT INTO empleado_table VALUES (e.persona_id,e.nombre,e.apellido,e.edad,e.salario,e.cargo);
END InsertarEmpleado;

-- Procedimiento para borrar una Empleado
CREATE OR REPLACE PROCEDURE BorrarEmpleado(
    e_id INT
) AS
BEGIN
    DELETE FROM empleado_table WHERE persona_id = e_id;
END BorrarEmpleado;

-- Procedimiento para actualizar una Empleado
CREATE OR REPLACE PROCEDURE ActualizarEmpleado(
    e empleado
) AS
BEGIN
    UPDATE Empleado_table SET
        nombre = e.nombre,
        apellido = e.apellido,
        edad = e.edad,
        salario=e.salario,
        cargo=e.cargo
    WHERE persona_id = e.persona_id;
END ActualizarEmpleado;

 -- Procedimiento para consultar un empleado por id
CREATE OR REPLACE PROCEDURE ConsultarEmpleados(condicion NUMBER) AS
id NUMBER;
nombre VARCHAR2(255);
apellido VARCHAR2(255);
edad NUMBER;
salario NUMBER;
cargo VARCHAR2(255);
e empleado;
BEGIN
        SELECT * into id,nombre,apellido,edad,salario,cargo FROM empleado_table where persona_id=condicion;
        e:=new Empleado(id,nombre,apellido,edad,salario,cargo);
        DBMS_OUTPUT.PUT_LINE(
            e.persona_id || ' ' ||
            e.nombre || ' ' ||
            e.apellido || ' ' ||
            e.edad || ' ' ||
            e.salario || ' ' ||
            e.cargo
        );

END ConsultarEmpleados;

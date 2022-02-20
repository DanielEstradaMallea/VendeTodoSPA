
-- PASOS PARA CREAR USUARIO PARA LA PRUEBA

-- ALTER SESSION SET"_ORACLE_SCRIPT"=TRUE;
-- CREATE USER vendetodospa IDENTIFIED BY 1234;
-- GRANT ALL PRIVILEGES TO vendetodospa;

-- se crean las tablas sin FK

CREATE TABLE empleados (
    idempleado         NUMBER PRIMARY KEY,
    nombre             VARCHAR(50),
    apellidos          VARCHAR2(50),
    fecha_nacimiento   DATE,
    direccion          VARCHAR(50),
    region             VARCHAR2(50),
    ciudad             VARCHAR2(50),
    pais               VARCHAR2(50),
    telefono           VARCHAR2(12),
    cargo              VARCHAR2(30)
);

CREATE TABLE clientes (
    idcliente         NUMBER PRIMARY KEY,
    nombre_empresa    VARCHAR(50),
    nombre_contacto   VARCHAR2(50),
    email             VARCHAR2(50),
    direccion         VARCHAR(50),
    region            VARCHAR2(50),
    ciudad            VARCHAR2(50),
    pais              VARCHAR2(50),
    codigo_postal     VARCHAR2(10),
    telefono          VARCHAR2(12)
);

CREATE TABLE despachadores (
    iddespachador    NUMBER PRIMARY KEY,
    nombre_empresa   VARCHAR2(50),
    telefono         VARCHAR(12)
);

CREATE TABLE ordenes (
    idorden                       NUMBER PRIMARY KEY,
    fecha_orden                   DATE,
    fecha_envio                   DATE,
    destinatario                  VARCHAR2(50),
    direccion_envio               VARCHAR2(50),
    codigo_postal                 NUMBER,
    region                        VARCHAR2(50),
    ciudad                        VARCHAR2(50),
    pais                          VARCHAR2(50),
    metodo_envio                  VARCHAR2(50),
    clientes_idcliente            NUMBER,
    empleados_idempleados         NUMBER,
    despachadores_iddespachador   NUMBER
);

-- en la tabla productos interpreté descontinuado como un dato booleano, por lo que lo declare como 0(falso) y 1(verdadero)

CREATE TABLE productos (
    idproducto                NUMBER PRIMARY KEY,
    nombre_producto           VARCHAR2(50),
    precio                    NUMBER,
    stock                     NUMBER CHECK ( stock >= 0 ),
    descontinuado             NUMBER CHECK ( descontinuado IN (
        0,
        1
    ) ),
    categorias_idcategoria    NUMBER,
    proveedores_idproveedor   NUMBER
);

CREATE TABLE proveedores (
    idproveedor        NUMBER PRIMARY KEY,
    nombre_proveedor   VARCHAR2(50),
    nombre_contacto    VARCHAR2(50),
    direccion          VARCHAR2(50),
    region             VARCHAR2(50),
    ciudad             VARCHAR2(50),
    telefono           VARCHAR2(12)
);

CREATE TABLE categorias (
    idcategoria        NUMBER PRIMARY KEY,
    nombre_categoria   VARCHAR2(50)
);

CREATE TABLE ordenes_detalle (
    idordendetalle         NUMBER PRIMARY KEY,
    valor                  NUMBER,
    cantidad_producto      NUMBER CHECK ( cantidad_producto >= 0 ),
    descuento              NUMBER,
    productos_idproducto   NUMBER,
    ordenes_idorden        NUMBER
);


-- creando las llaves foraneas

ALTER TABLE ordenes
    ADD CONSTRAINT fk_cliente_ordenes FOREIGN KEY ( clientes_idcliente )
        REFERENCES clientes ( idcliente );

ALTER TABLE ordenes
    ADD CONSTRAINT fk_empleados_ordenes FOREIGN KEY ( empleados_idempleados )
        REFERENCES empleados ( idempleado );

ALTER TABLE ordenes
    ADD CONSTRAINT fk_despachadores_ordenes FOREIGN KEY ( despachadores_iddespachador )
        REFERENCES despachadores ( iddespachador );

ALTER TABLE ordenes_detalle
    ADD CONSTRAINT fk_ordenes_ordenesdetalle FOREIGN KEY ( ordenes_idorden )
        REFERENCES ordenes ( idorden );

ALTER TABLE ordenes_detalle
    ADD CONSTRAINT fk_productos_ordenesdetalle FOREIGN KEY ( productos_idproducto )
        REFERENCES productos ( idproducto );

ALTER TABLE productos
    ADD CONSTRAINT fk_categoria_productos FOREIGN KEY ( categorias_idcategoria )
        REFERENCES categorias ( idcategoria );

ALTER TABLE productos
    ADD CONSTRAINT fk_proveedores_productos FOREIGN KEY ( proveedores_idproveedor )
        REFERENCES proveedores ( idproveedor );
    
  
--crear sequences

CREATE SEQUENCE cliente_id_seq INCREMENT BY 1 START WITH 1 MINVALUE 0 NOMAXVALUE CACHE 2;

CREATE SEQUENCE empleado_id_seq INCREMENT BY 1 START WITH 1 MINVALUE 0 NOMAXVALUE CACHE 2;

CREATE SEQUENCE despachador_id_seq INCREMENT BY 1 START WITH 1 MINVALUE 0 NOMAXVALUE CACHE 2;

CREATE SEQUENCE ordenes_id_seq INCREMENT BY 1 START WITH 1 MINVALUE 0 NOMAXVALUE CACHE 2;

CREATE SEQUENCE ordenesdetalle_id_seq INCREMENT BY 1 START WITH 1 MINVALUE 0 NOMAXVALUE CACHE 2;

CREATE SEQUENCE producto_id_seq INCREMENT BY 1 START WITH 1 MINVALUE 0 NOMAXVALUE CACHE 2;

CREATE SEQUENCE categoria_id_seq INCREMENT BY 1 START WITH 1 MINVALUE 0 NOMAXVALUE CACHE 2;

CREATE SEQUENCE proveedor_id_seq INCREMENT BY 1 START WITH 1 MINVALUE 0 NOMAXVALUE CACHE 2;



-- INSERTANDO DATOS

-- insertar categorias

INSERT INTO categorias (
    idcategoria,
    nombre_categoria
) VALUES (
    cliente_id_seq.NEXTVAL,
    'Abarrotes'
);

INSERT INTO categorias (
    idcategoria,
    nombre_categoria
) VALUES (
    cliente_id_seq.NEXTVAL,
    'Panaderia'
);

INSERT INTO categorias (
    idcategoria,
    nombre_categoria
) VALUES (
    cliente_id_seq.NEXTVAL,
    'Congelados'
);

INSERT INTO categorias (
    idcategoria,
    nombre_categoria
) VALUES (
    cliente_id_seq.NEXTVAL,
    'Liquidos'
);

INSERT INTO categorias (
    idcategoria,
    nombre_categoria
) VALUES (
    cliente_id_seq.NEXTVAL,
    'Frutas'
);

-- insertar proveedores

INSERT INTO proveedores VALUES (
    proveedor_id_seq.NEXTVAL,
    'Keylogistic',
    'Julio Videla',
    'Las acacias 1315',
    'Metropolitana',
    'Santiago',
    '227650000'
);

INSERT INTO proveedores VALUES (
    proveedor_id_seq.NEXTVAL,
    'Minuto Verde',
    'Aquiles Bailo',
    'Americo vespucio 111',
    'Metropolitana',
    'Maipu',
    '227650000'
);

INSERT INTO proveedores VALUES (
    proveedor_id_seq.NEXTVAL,
    'Ideal',
    'Elsa Bado',
    'Av españa',
    'Metropolitana',
    'Santiago',
    '227650000'
);

INSERT INTO proveedores VALUES (
    proveedor_id_seq.NEXTVAL,
    'CCU',
    'Felipe Derecho',
    'Americo vespucio 561',
    'Metropolitana',
    'Maipu',
    '227650000'
);

INSERT INTO proveedores VALUES (
    proveedor_id_seq.NEXTVAL,
    'Pacifico Mar',
    'Soila Contacto',
    'Av las industrias 1313',
    'Metropolitana',
    'Quilicura',
    '227650000'
);

-- insertar productos

INSERT INTO productos VALUES (
    producto_id_seq.NEXTVAL,
    'producto 1',
    5000,
    80,
    0,
    1,
    1
);

INSERT INTO productos VALUES (
    producto_id_seq.NEXTVAL,
    'producto 2',
    9000,
    10,
    0,
    1,
    1
);

INSERT INTO productos VALUES (
    producto_id_seq.NEXTVAL,
    'producto 3',
    8000,
    60,
    0,
    4,
    4
);

INSERT INTO productos VALUES (
    producto_id_seq.NEXTVAL,
    'producto 4',
    7000,
    15,
    0,
    5,
    2
);

INSERT INTO productos VALUES (
    producto_id_seq.NEXTVAL,
    'producto 5',
    6000,
    25,
    0,
    2,
    2
);

-- insertar despachadores

INSERT INTO despachadores VALUES (
    despachador_id_seq.NEXTVAL,
    'STARKEN',
    '2222222'
);

INSERT INTO despachadores VALUES (
    despachador_id_seq.NEXTVAL,
    'CHILEXPRESS',
    '3333333'
);

INSERT INTO despachadores VALUES (
    despachador_id_seq.NEXTVAL,
    'CORRES DE CHILE',
    '4444444'
);

INSERT INTO despachadores VALUES (
    despachador_id_seq.NEXTVAL,
    'BLUEXPRESS',
    '5555555'
);

INSERT INTO despachadores VALUES (
    despachador_id_seq.NEXTVAL,
    'TURBUS',
    '6666666'
);

-- insertar clientes

INSERT INTO clientes VALUES (
    cliente_id_seq.NEXTVAL,
    'empresa 1',
    'contacto 1',
    'correo@1',
    'calle 1',
    'RM',
    'santiago',
    'chile',
    '1234',
    '22222222'
);

INSERT INTO clientes VALUES (
    cliente_id_seq.NEXTVAL,
    'empresa 2',
    'contacto 2',
    'correo@2',
    'calle 2',
    'RM',
    'santiago',
    'chile',
    '4321',
    '44444444'
);

INSERT INTO clientes VALUES (
    cliente_id_seq.NEXTVAL,
    'empresa 3',
    'contacto 3',
    'correo@3',
    'calle 3',
    'V',
    'valparaiso',
    'chile',
    '1122',
    '33333333'
);

INSERT INTO clientes VALUES (
    cliente_id_seq.NEXTVAL,
    'empresa 4',
    'contacto 4',
    'correo@4',
    'calle 4',
    'V',
    'valparaiso',
    'chile',
    '2211',
    '55555555'
);

INSERT INTO clientes VALUES (
    cliente_id_seq.NEXTVAL,
    'empresa 5',
    'contacto 5',
    'correo@5',
    'calle 5',
    'RM',
    'santiago',
    'chile',
    '1324',
    '11111111'
);

-- insertar empleados 

INSERT INTO empleados VALUES (
    empleado_id_seq.NEXTVAL,
    'nombre 1',
    'apellido 1',
    TO_DATE('1995-02-02', 'YYYY-MM-DD'),
    'direccion 1',
    'RM',
    'Santiago',
    'Chile',
    '1111',
    'puesto 1'
);

INSERT INTO empleados VALUES (
    empleado_id_seq.NEXTVAL,
    'nombre 2',
    'apellido 2',
    TO_DATE('1994-06-15', 'YYYY-MM-DD'),
    'direccion 2',
    'RM',
    'Santiago',
    'Chile',
    '2222',
    'puesto 1'
);

INSERT INTO empleados VALUES (
    empleado_id_seq.NEXTVAL,
    'nombre 3',
    'apellido 3',
    TO_DATE('1990-02-18', 'YYYY-MM-DD'),
    'direccion 3',
    'RM',
    'Maipu',
    'Chile',
    '3333',
    'puesto 2'
);

INSERT INTO empleados VALUES (
    empleado_id_seq.NEXTVAL,
    'nombre 4',
    'apellido 4',
    TO_DATE('1980-06-17', 'YYYY-MM-DD'),
    'direccion 4',
    'RM',
    'Santiago',
    'Chile',
    '4444',
    'puesto 3'
);

INSERT INTO empleados VALUES (
    empleado_id_seq.NEXTVAL,
    'nombre 5',
    'apellido 5',
    TO_DATE('1987-09-30', 'YYYY-MM-DD'),
    'direccion 5',
    'RM',
    'Pudahuel',
    'Chile',
    '5555',
    'puesto 2'
);

-- insertar ordenes

INSERT INTO ordenes VALUES (
    ordenes_id_seq.NEXTVAL,
    TO_DATE('2022-02-01', 'YYYY-MM-DD'),
    TO_DATE('2022-02-22', 'YYYY-MM-DD'),
    'destinatario 1',
    'direccion 1',
    '12345',
    'RM',
    'Providencia',
    'Chile',
    'Envio pagado',
    1,
    2,
    1
);

INSERT INTO ordenes VALUES (
    ordenes_id_seq.NEXTVAL,
    TO_DATE('2022-02-01', 'YYYY-MM-DD'),
    TO_DATE('2022-02-22', 'YYYY-MM-DD'),
    'destinatario 2',
    'direccion 2',
    '11223',
    'RM',
    'Providencia',
    'Chile',
    'Retiro',
    1,
    2,
    1
);

INSERT INTO ordenes VALUES (
    ordenes_id_seq.NEXTVAL,
    TO_DATE('2022-02-12', 'YYYY-MM-DD'),
    TO_DATE('2022-02-24', 'YYYY-MM-DD'),
    'destinatario 3',
    'direccion 3',
    '12344',
    'V',
    'Valparaiso',
    'Chile',
    'Envio Pagado',
    3,
    3,
    3
);

INSERT INTO ordenes VALUES (
    ordenes_id_seq.NEXTVAL,
    TO_DATE('2022-02-12', 'YYYY-MM-DD'),
    TO_DATE('2022-02-25', 'YYYY-MM-DD'),
    'destinatario 4',
    'direccion 4',
    '11111',
    'RM',
    'Santiago',
    'Chile',
    'Envio por pagar',
    2,
    1,
    2
);

INSERT INTO ordenes VALUES (
    ordenes_id_seq.NEXTVAL,
    TO_DATE('2022-02-13', 'YYYY-MM-DD'),
    TO_DATE('2022-02-25', 'YYYY-MM-DD'),
    'destinatario 5',
    'direccion 5',
    '54321',
    'V',
    'Reñaca',
    'Chile',
    'Envio pagado',
    1,
    5,
    4
);

-- insertar ordenes_detalle

INSERT INTO ordenes_detalle VALUES (
    ordenesdetalle_id_seq.NEXTVAL,
    1000000,
    10,
    0,
    1,
    1
);

INSERT INTO ordenes_detalle VALUES (
    ordenesdetalle_id_seq.NEXTVAL,
    500000,
    5,
    0,
    1,
    2
);

INSERT INTO ordenes_detalle VALUES (
    ordenesdetalle_id_seq.NEXTVAL,
    150000,
    4,
    0,
    2,
    3
);

INSERT INTO ordenes_detalle VALUES (
    ordenesdetalle_id_seq.NEXTVAL,
    350000,
    10,
    10,
    3,
    4
);

INSERT INTO ordenes_detalle VALUES (
    ordenesdetalle_id_seq.NEXTVAL,
    60000,
    6,
    0,
    4,
    5
);


-- CONSULTAS


--1.- Determinar cuál o cuáles son los clientes con las compras más altas y a qué
-- ciudad corresponden los mismos. Esto permitirá en un futuro que VendeTodo
-- SPA pueda buscar convenios con algunas empresas despachadoras. 

SELECT
    c.nombre_empresa,
    c.ciudad,
    d.valor
FROM
    clientes          c
    INNER JOIN ordenes           o ON c.idcliente = o.clientes_idcliente
    INNER JOIN ordenes_detalle   d ON o.idorden = d.ordenes_idorden
WHERE
    d.valor = (
        SELECT
            MAX(valor)
        FROM
            ordenes_detalle
    );
    
--1.1.- todas las compras ordenadas de forma descendente

SELECT
    c.nombre_empresa,
    c.ciudad,
    d.valor
FROM
    clientes          c
    INNER JOIN ordenes           o ON c.idcliente = o.clientes_idcliente
    INNER JOIN ordenes_detalle   d ON o.idorden = d.ordenes_idorden
ORDER BY
    d.valor DESC;

--2.- Se necesita saber los nombre de los distribuidores de los productos más
-- vendidos, esto permitirá evaluar comprar por volumen. Solo es necesario que
-- se listen los nombres de todos los registros que cumplan con la solicitud

SELECT
    p.nombre_proveedor,
    k.nombre_producto,
    d.cantidad_producto AS cantidad_vendida
FROM
    proveedores       p
    INNER JOIN productos         k ON p.idproveedor = k.proveedores_idproveedor
    INNER JOIN ordenes_detalle   d ON k.idproducto = d.productos_idproducto
WHERE
    d.cantidad_producto = (
        SELECT
            MAX(cantidad_producto)
        FROM
            ordenes_detalle
    );
    
--2.1.- todos los productos ordenados de forma descendente

SELECT
    p.nombre_proveedor,
    k.nombre_producto,
    d.cantidad_producto AS cantidad_vendida
FROM
    proveedores       p
    INNER JOIN productos         k ON p.idproveedor = k.proveedores_idproveedor
    INNER JOIN ordenes_detalle   d ON k.idproducto = d.productos_idproducto
ORDER BY
    d.cantidad_producto DESC;
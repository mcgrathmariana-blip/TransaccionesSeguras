
-- REPOSITORIO DE TRANSACCIONES SEGURAS EN SQLITE

-- Preparación de tablas
CREATE TABLE IF NOT EXISTS productos (
    id INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL,
    stock INTEGER NOT NULL CHECK (stock >= 0)
);

CREATE TABLE IF NOT EXISTS ventas_log (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    producto_id INTEGER,
    cambio_stock INTEGER,
    descripcion TEXT,
    fecha TEXT DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS almacenes (
    id INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL,
    stock INTEGER NOT NULL CHECK (stock >= 0)
);

-- CASO 1: TRANSACCIÓN EXITOSA
-- ACID: Atomicidad y Durabilidad.
-- El descuento y el registro de auditoría se confirman juntos.

-- Estado anterior: Notebook tiene 20 unidades.
BEGIN TRANSACTION;

UPDATE productos
SET stock = stock - 3
WHERE id = 1;

INSERT INTO ventas_log (producto_id, cambio_stock, descripcion)
VALUES (1, -3, 'Venta de 3 unidades de Notebook');

-- Verificación posterior al COMMIT:
COMMIT;

SELECT * FROM productos WHERE id = 1;
SELECT * FROM ventas_log;

-- CASO 2: BOTÓN DE PÁNICO
-- ACID: Atomicidad.
-- El borrado se cancela y los registros originales se conservan.

-- Verificación antes del DELETE:
SELECT * FROM productos;

BEGIN TRANSACTION;

DELETE FROM productos;

-- Estado temporal: tabla vacía dentro de la transacción.
SELECT * FROM productos;

ROLLBACK;

-- Verificación posterior al ROLLBACK:
SELECT * FROM productos;

-- CASO 3: ERROR DURANTE UNA TRANSFERENCIA
-- ACID: Atomicidad y Consistencia.
-- Si falla el segundo UPDATE, el primero también debe revertirse.

-- Estado inicial: Central 100 y Secundario 50.
SELECT * FROM almacenes;

BEGIN TRANSACTION;

-- Primer UPDATE: operación válida.
UPDATE almacenes
SET stock = stock - 10
WHERE id = 1;

-- Segundo UPDATE: genera un error por intentar asignar NULL
-- a una columna NOT NULL. Se debe ejecutar ROLLBACK.

UPDATE almacenes
SET stock = NULL
WHERE id = 2;

-- Ante el error, ejecutar ROLLBACK desde el programa
-- y comprobar que ambos stocks conservan sus valores iniciales.
-- SELECT * FROM almacenes;


# Repositorio de Transacciones Seguras en SQLite

## Objetivo
Implementar transacciones en SQLite para demostrar la integridad
de los datos y los principios ACID.

## Escenarios desarrollados

### 1. Transacción exitosa (COMMIT)
Se descuentan unidades del stock de un producto y se registra
el movimiento en la tabla ventas_log. Ambos cambios se confirman.

### 2. Botón de pánico (ROLLBACK)
Se intenta eliminar todos los productos, pero la operación se
cancela. Se verifica que los registros originales se conservan.

### 3. Error durante una transferencia
Se realiza un primer UPDATE válido y se provoca un error en el
segundo UPDATE. Se ejecuta ROLLBACK para deshacer ambos cambios.

## Principios ACID
- Atomicidad: las operaciones se confirman juntas o se deshacen.
- Consistencia: se respetan las restricciones de integridad.
- Aislamiento: las transacciones se ejecutan como unidades de trabajo.
- Durabilidad: los cambios confirmados mediante COMMIT permanecen guardados.

## Archivos
- Transacciones_Seguras_SQLite.ipynb: desarrollo y pruebas en Google Colab.
- transacciones_seguras.sql: instrucciones SQL y comentarios de los escenarios.
- practica_dml.db: base de datos SQLite utilizada en el ejercicio.

## Herramientas
- Python
- Google Colab
- SQLite

       IDENTIFICATION DIVISION.
       PROGRAM-ID. RESTAURANTE.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER. IBM-PC.
OBJECT-COMPUTER. IBM-PC.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
SELECT CLIENTES-FILE ASSIGN TO 'clientes.dat'
       ORGANIZATION IS INDEXED
ACCESS MODE IS RANDOM
RECORD KEY IS CLIENTE-ID
       FILE STATUS IS CLIENTES-FILE-STATUS.
SELECT MESAS-FILE ASSIGN TO 'mesas.dat'
       ORGANIZATION IS INDEXED
ACCESS MODE IS RANDOM
RECORD KEY IS MESA-ID
       FILE STATUS IS MESAS-FILE-STATUS.
SELECT PLATILLOS-FILE ASSIGN TO 'platillos.dat'
       ORGANIZATION IS INDEXED
ACCESS MODE IS RANDOM
RECORD KEY IS PLATILLO-ID
       FILE STATUS IS PLATILLOS-FILE-STATUS.
SELECT PEDIDOS-FILE ASSIGN TO 'pedidos.dat'
       ORGANIZATION IS INDEXED
ACCESS MODE IS RANDOM
RECORD KEY IS PEDIDO-ID
       FILE STATUS IS PEDIDOS-FILE-STATUS.
       DATA DIVISION.
       FILE SECTION.
       FD CLIENTES-FILE.
       01 CLIENTES-RECORD.
       05 CLIENTE-ID PIC X(10).
       05 CLIENTE-NOMBRE PIC X(30).
       05 CLIENTE-TELEFONO PIC X(15).
       05 CLIENTE-DIRECCION PIC X(50).
       FD MESAS-FILE.
       01 MESAS-RECORD.
       05 MESA-ID PIC X(10).
       05 MESA-CAPACIDAD PIC 9(2).
       FD PLATILLOS-FILE.
       01 PLATILLOS-RECORD.
       05 PLATILLO-ID PIC X(10).
       05 PLATILLO-NOMBRE PIC X(30).
       05 PLATILLO-DESCRIPCION PIC X(100).
       05 PLATILLO-PRECIO PIC 9(5)V99.
       05 PLATILLO-CATEGORIA PIC X(20).
       FD PEDIDOS-FILE.
       01 PEDIDOS-RECORD.
       05 PEDIDO-ID PIC X(10).
       05 PEDIDO-MESA-ID PIC X(10).
       05 PEDIDO-CLIENTE-ID PIC X(10).
       05 PEDIDO-PLATILLO-ID PIC X(10) OCCURS 10 TIMES.
       05 PEDIDO-CANTIDAD PIC 9(2) OCCURS 10 TIMES.
       05 PEDIDO-TOTAL PIC 9(6)V99.
       WORKING-STORAGE SECTION.
       01 WS-CLIENTES.
       05 WS-CLIENTE-ID PIC X(10).
       05 WS-CLIENTE-NOMBRE PIC X(30).
       05 WS-CLIENTE-TELEFONO PIC X(15).
       05 WS-CLIENTE-DIRECCION PIC X(50).
       01 WS-MESAS.
       05 WS-MESA-ID PIC X(10).
       05 WS-MESA-CAPACIDAD PIC 9(2).
       01 WS-PLATILLOS.
       05 WS-PLATILLO-ID PIC X(10).
       05 WS-PLATILLO-NOMBRE PIC X(30).
       05 WS-PLATILLO-DESCRIPCION PIC X(100).
       05 WS-PLATILLO-PRECIO PIC 9(5)V99.
       05 WS-PLATILLO-CATEGORIA PIC X(20).
       01 WS-PEDIDOS.
       05 WS-PEDIDO-ID PIC X(10).
       05 WS-PEDIDO-MESA-ID PIC X(10).
       05 WS-PEDIDO-CLIENTE-ID PIC X(10).
       05 WS-PEDIDO-PLATILLO-ID PIC X(10) OCCURS 10 TIMES.
       05 WS-PEDIDO-CANTIDAD PIC 9(2) OCCURS 10 TIMES.
       05 WS-PEDIDO-TOTAL PIC 9(6)V99.
       01 WS-RESPUESTA.
       05 WS-CODIGO-RESPUESTA PIC X(2).
       05 WS-MENSAJE-RESPUESTA PIC X(50).
       PROCEDURE DIVISION.
       INICIO.
       DISPLAY "Bienvenido al sistema de gestión de restaurante".
       PERFORM MENU-PRINCIPAL.
       MENU-PRINCIPAL.
       DISPLAY "1. Gestionar clientes".
       DISPLAY "2. Gestionar mesas".
       DISPLAY "3. Gestionar platillos".
       DISPLAY "4. Gestionar pedidos".
       DISPLAY "5. Salir".
       DISPLAY "Seleccione una opción (1-5):".
ACCEPT WS-OPCION
       EVALUATE WS-OPCION
WHEN 1 PERFORM GESTIONAR-CLIENTES
WHEN 2 PERFORM GESTIONAR-MESAS
WHEN 3 PERFORM GESTIONAR-PLATILLOS
WHEN 4 PERFORM GESTIONAR-PEDIDOS
WHEN 5 STOP RUN
       WHEN OTHER DISPLAY "Opción inválida."
       END-EVALUATE
       PERFORM MENU-PRINCIPAL.
       GESTIONAR-CLIENTES.
       DISPLAY "1. Registrar un nuevo cliente".
       DISPLAY "2. Modificar los datos de un cliente".
       DISPLAY "3. Eliminar un cliente".
       DISPLAY "4. Ver todos los clientes".
       DISPLAY "5. Regresar al menú principal".
       DISPLAY "Seleccione una opción (1-5):".
ACCEPT WS-OPCION
       EVALUATE WS-OPCION
WHEN 1 PERFORM REGISTRAR-CLIENTE
WHEN 2 PERFORM MODIFICAR-CLIENTE
WHEN 3 PERFORM ELIMINAR-CLIENTE
WHEN 4 PERFORM VER-TODOS-CLIENTES
WHEN 5 PERFORM MENU-PRINCIPAL
       WHEN OTHER DISPLAY "Opción inválida."
       END-EVALUATE
       PERFORM GESTIONAR-CLIENTES.
       GESTIONAR-MESAS.
       DISPLAY "1. Registrar una nueva mesa".
       DISPLAY "2. Modificar los datos de una mesa".
       DISPLAY "3. Eliminar una mesa".
       DISPLAY "4. Ver todas las mesas".
       DISPLAY "5. Regresar al menú principal".
       DISPLAY "Seleccione una opción (1-5):".
ACCEPT WS-OPCION
       EVALUATE WS-OPCION
WHEN 1 PERFORM REGISTRAR-MESA
WHEN 2 PERFORM MODIFICAR-MESA
WHEN 3 PERFORM ELIMINAR-MESA
WHEN 4 PERFORM VER-TODAS-MESAS
WHEN 5 PERFORM MENU-PRINCIPAL
       WHEN OTHER DISPLAY "Opción inválida."
       END-EVALUATE
       PERFORM GESTIONAR-MESAS.
       GESTIONAR-PLATILLOS.
       DISPLAY "1. Registrar un nuevo platillo".
       DISPLAY "2. Modificar los datos de un platillo".
       DISPLAY "3. Eliminar un platillo".
       DISPLAY "4. Ver todos los platillos".
       DISPLAY "5. Regresar al menú principal".
       DISPLAY "Seleccione una opción (1-5):".
ACCEPT WS-OPCION
       EVALUATE WS-OPCION
WHEN 1 PERFORM REGISTRAR-PLATILLO
WHEN 2 PERFORM MODIFICAR-PLATILLO
WHEN 3 PERFORM ELIMINAR-PLATILLO
WHEN 4 PERFORM VER-TODOS-PLATILLOS
WHEN 5 PERFORM MENU-PRINCIPAL
       WHEN OTHER DISPLAY "Opción inválida."
       END-EVALUATE
       PERFORM GESTIONAR-PLATILLOS.
       GESTIONAR-PEDIDOS.
       DISPLAY "1. Registrar un nuevo pedido".
       DISPLAY "2. Modificar los datos de un pedido".
       DISPLAY "3. Eliminar un pedido".
       DISPLAY "4. Ver todos los pedidos".
       DISPLAY "5. Regresar al menú principal".
       DISPLAY "Seleccione una opción (1-5):".
ACCEPT WS-OPCION
       EVALUATE WS-OPCION
WHEN 1 PERFORM REGISTRAR-PEDIDO
WHEN 2 PERFORM MODIFICAR-PEDIDO
WHEN 3 PERFORM ELIMINAR-PEDIDO
WHEN 4 PERFORM VER-TODOS-PEDIDOS
WHEN 5 PERFORM MENU-PRINCIPAL
       WHEN OTHER DISPLAY "Opción inválida."
END-EVALUATE
       PERFORM GESTIONAR-PEDIDOS.
       REGISTRAR-PEDIDO.
       DISPLAY "Ingrese el número de pedido:"
ACCEPT WS-PEDIDO-ID
       DISPLAY "Ingrese el número de mesa:"
ACCEPT WS-PEDIDO-MESA-ID
       DISPLAY "Ingrese el número de cliente:"
ACCEPT WS-PEDIDO-CLIENTE-ID
       PERFORM VER-TODOS-PLATILLOS
       DISPLAY "Ingrese los platillos pedidos (separados por coma):"
ACCEPT WS-PLATILLOS-SELECCIONADOS
       DISPLAY "Ingrese la cantidad de cada platillo 
       (separados por coma):"
ACCEPT WS-CANTIDADES-SELECCIONADAS
       COMPUTE WS-TOTAL-PEDIDO = 0
       PERFORM VARYING I FROM 1 BY 1 UNTIL I > 10
       IF WS-PLATILLOS-SELECCIONADOS(I) = SPACES
       EXIT PERFORM
END-IF
       READ PLATILLOS-FILE
INVALID KEY
       DISPLAY "Platillo no encontrado."
       NOT INVALID KEY
       IF PLATILLO-ID = WS-PLATILLOS-SELECCIONADOS(I)
       COMPUTE WS-TOTAL-PEDIDO = WS-TOTAL-PEDIDO + 
(PLATILLO-PRECIO * WS-CANTIDADES-SELECCIONADAS(I))
       MOVE PLATILLO-ID TO WS-PEDIDO-PLATILLO-ID(I)
       MOVE WS-CANTIDADES-SELECCIONADAS(I) TO WS-PEDIDO-CANTIDAD(I)
END-IF
       END-READ
       END-PERFORM
       MOVE WS-TOTAL-PEDIDO TO WS-PEDIDO-TOTAL
       WRITE PEDIDOS-FILE
INVALID KEY
       DISPLAY "Error al registrar el pedido."
       NOT INVALID KEY
       DISPLAY "Pedido registrado con éxito."
       END-WRITE
       PERFORM GESTIONAR-PEDIDOS.
       MODIFICAR-PEDIDO.
       DISPLAY "Ingrese el número de pedido a modificar:"
ACCEPT WS-PEDIDO-ID
       READ PEDIDOS-FILE
INVALID KEY
       DISPLAY "Pedido no encontrado."
       NOT INVALID KEY
       PERFORM VER-PEDIDO
       DISPLAY "¿Qué desea modificar?"
       DISPLAY "1. Número de mesa."
       DISPLAY "2. Número de cliente."
       DISPLAY "3. Platillos."
       DISPLAY "4. Regresar."
       DISPLAY "Seleccione una opción (1-4):"
ACCEPT WS-OPCION-MODIFICAR
       EVALUATE WS-OPCION-MODIFICAR
WHEN 1
       DISPLAY "Ingrese el nuevo número de mesa:"
ACCEPT WS-PEDIDO-MESA-ID
       MOVE WS-PEDIDO-MESA-ID TO PEDIDO-MESA-ID
       REWRITE PEDIDOS-RECORD
INVALID KEY
       DISPLAY "Error al modificar el pedido."
       NOT INVALID KEY
       DISPLAY "Pedido modificado con éxito."
WHEN 2
       DISPLAY "Ingrese el nuevo número de cliente:"
ACCEPT WS-PEDIDO-CLIENTE-ID
       MOVE WS-PEDIDO-CLIENTE-ID TO PEDIDO-CLIENTE-ID
       REWRITE PEDIDOS-RECORD
INVALID KEY
       DISPLAY "Error al modificar el pedido."
       NOT INVALID KEY
       DISPLAY "Pedido modificado con éxito."
WHEN 3
       PERFORM VER-TODOS-PLATILLOS
       DISPLAY "Ingrese los platillos pedidos (separados por coma):"
ACCEPT WS-PLATILLOS-SELECCIONADOS
       DISPLAY "Ingrese la cantidad de cada platillo 
       (separados por coma):"
ACCEPT WS-CANTIDADES-SELECCIONADAS
       COMPUTE WS-TOTAL-PEDIDO = 0
       PERFORM VARYING I FROM 1 BY 1 UNTIL I > 10
       IF WS-PLATILLOS-SELECCIONADOS(I) = SPACES
       EXIT PERFORM
END-IF
       READ PLATILLOS-FILE
INVALID KEY
       DISPLAY "Platillo no encontrado."
       NOT INVALID KEY
       IF PLATILLO-ID = WS-PLATILLOS-SELECCIONADOS(I)
       COMPUTE WS-TOTAL-PEDIDO = WS-TOTAL-PEDIDO + 
       (PLATILLO-PRECIO * WS-CANTIDADES-SELECCIONADAS(I))
       MOVE PLATILLO-ID TO WS-PEDIDO-PLATILLO-ID(I)
       MOVE WS-CANTIDADES-SELECCIONADAS(I) TO WS-PEDIDO-CANTIDAD(I)
END-IF
       END-READ
       END-PERFORM
       MOVE WS-TOTAL-PEDIDO TO WS-PEDIDO-TOTAL
       MOVE WS-PEDIDO-PLATILLO-ID TO PEDIDO-PLATILLO-ID
       MOVE WS-PEDIDO-CANTIDAD TO PEDIDO-CANTIDAD
       REWRITE PEDIDOS-RECORD
INVALID KEY
       DISPLAY "Error al modificar el pedido."
       NOT INVALID KEY
       DISPLAY "Pedido modificado con éxito."
WHEN 4
EXIT.
       WHEN OTHER
       DISPLAY "Opción inválida."
       END-EVALUATE
       END-READ
       PERFORM GESTIONAR-PEDIDOS.
       ELIMINAR-PEDIDO.
       DISPLAY "Ingrese el número de pedido a eliminar:"
ACCEPT WS-PEDIDO-ID
       DISPLAY "¿Está seguro que desea eliminar el pedido? (S/N):"
ACCEPT WS-CONFIRMAR-ELIMINACION
       IF WS-CONFIRMAR-ELIMINACION = "S" 
       OR WS-CONFIRMAR-ELIMINACION = "s"
DELETE PEDIDOS-RECORD
INVALID KEY
       DISPLAY "Error al eliminar el pedido."
NOT INVALID KEY
       DISPLAY "Pedido eliminado con éxito."
END-DELETE
END-IF
       PERFORM GESTIONAR-PEDIDOS.
       VER-TODOS-PEDIDOS.
       OPEN PEDIDOS-FILE
       READ PEDIDOS-FILE
AT END
       DISPLAY "No hay pedidos registrados."
NOT AT END
       DISPLAY "Número de pedido: " PEDIDO-ID
       DISPLAY "Número de mesa: " PEDIDO-MESA-ID
       DISPLAY "Número de cliente: " PEDIDO-CLIENTE-ID
       DISPLAY "Platillos:"
       PERFORM VARYING I FROM 1 BY 1 UNTIL I > 10
       IF PEDIDO-PLATILLO-ID(I) = SPACES
       EXIT PERFORM
END-IF
       READ PLATILLOS-FILE
       INVALID KEY
       DISPLAY "Platillo no encontrado."
       NOT INVALID KEY
       IF PLATILLO-ID = PEDIDO-PLATILLO-ID(I)
       DISPLAY " " PLATILLO-NOMBRE " x" PEDIDO-CANTIDAD(I)
END-IF
       END-READ
       END-PERFORM
       DISPLAY "Total: $" PEDIDO-TOTAL
       DISPLAY " "
       READ PEDIDOS-FILE
AT END
EXIT.
NOT AT END
       CONTINUE.
       END-READ
       END-READ
CLOSE
WHEN 4 PERFORM VER-TODOS-PEDIDOS
WHEN 5 PERFORM MENU-PRINCIPAL
       WHEN OTHER DISPLAY "Opción inválida."
       END-EVALUATE
       PERFORM GESTIONAR-PEDIDOS.
       REGISTRAR-CLIENTE.
       DISPLAY "Ingrese el ID del cliente:"
ACCEPT WS-CLIENTE-ID
       DISPLAY "Ingrese el nombre del cliente:"
ACCEPT WS-CLIENTE-NOMBRE
       DISPLAY "Ingrese el número de teléfono del cliente:"
ACCEPT WS-CLIENTE-TELEFONO
       DISPLAY "Ingrese la dirección del cliente:"
ACCEPT WS-CLIENTE-DIRECCION
       EXEC SQL
       INSERT INTO clientes (id, nombre, telefono, direccion)
VALUES (:WS-CLIENTE-ID, :WS-CLIENTE-NOMBRE, 
       :WS-CLIENTE-TELEFONO, :WS-CLIENTE-DIRECCION);
       END-EXEC
       IF SQLCODE NOT = 0
       DISPLAY "Error al registrar el cliente."
ELSE
       DISPLAY "Cliente registrado exitosamente."
END-IF
       MODIFICAR-CLIENTE.
       DISPLAY "Ingrese el ID del cliente que desea modificar:"
ACCEPT WS-CLIENTE-ID
       EXEC SQL
SELECT * FROM clientes WHERE id = 
       :WS-CLIENTE-ID
       INTO :WS-CLIENTE-ID, :WS-CLIENTE-NOMBRE, 
       :WS-CLIENTE-TELEFONO, :WS-CLIENTE-DIRECCION;
       END-EXEC
       IF SQLCODE NOT = 0
       DISPLAY "Cliente no encontrado."
ELSE
       DISPLAY "Ingrese el nuevo nombre del cliente 
(dejar en blanco para mantener el nombre actual):"
ACCEPT WS-CLIENTE-NOMBRE
       DISPLAY "Ingrese el nuevo número de teléfono del cliente 
(dejar en blanco para mantener el número actual):"
ACCEPT WS-CLIENTE-TELEFONO
       DISPLAY "Ingrese la nueva dirección del cliente 
(dejar en blanco para mantener la dirección actual):"
ACCEPT WS-CLIENTE-DIRECCION
       EXEC SQL
UPDATE clientes SET
       nombre = COALESCE(:WS-CLIENTE-NOMBRE, nombre),
       telefono = COALESCE(:WS-CLIENTE-TELEFONO, telefono),
       direccion = COALESCE(:WS-CLIENTE-DIRECCION, direccion)
       WHERE id = :WS-CLIENTE-ID;
       END-EXEC
       IF SQLCODE NOT = 0
       DISPLAY "Error al modificar el cliente."
ELSE
       DISPLAY "Cliente modificado exitosamente."
END-IF
END-IF
       ELIMINAR-CLIENTE.
       DISPLAY "Ingrese el ID del cliente que desea eliminar:"
ACCEPT WS-CLIENTE-ID
       EXEC SQL
DELETE FROM clientes WHERE id = :WS-CLIENTE-ID;
       END-EXEC
       IF SQLCODE NOT = 0
       DISPLAY "Error al eliminar el cliente."
ELSE
       DISPLAY "Cliente eliminado exitosamente."
       END-IF.
       VER-TODOS-CLIENTES.
       EXEC SQL
SELECT * FROM clientes;
       END-EXEC
       IF SQLCODE NOT = 0
       DISPLAY "Error al obtener los clientes."
ELSE
       DISPLAY "ID NOMBRE TELEFONO DIRECCION"
       DISPLAY "---------------------------
       ---------------------------------"
       PERFORM UNTIL SQLCODE NOT = 0
       DISPLAY WS-CLIENTE-ID " " WS-CLIENTE-NOMBRE(1:25) " " 
       WS-CLIENTE-TELEFONO(1:15) " " WS-CLIENTE-DIRECCION(1:50)
       EXEC SQL
       FETCH NEXT FROM clientes INTO :WS-CLIENTE-ID, 
       :WS-CLIENTE-NOMBRE, :WS-CLIENTE-TELEFONO, :WS-CLIENTE-DIRECCION;
       END-EXEC
       END-PERFORM
       END-IF.
       REGISTRAR-PEDIDO.
       DISPLAY "Ingrese el ID del cliente que realiza el pedido:"
ACCEPT WS-CLIENTE-ID
       DISPLAY "Ingrese el ID del platillo que desea ordenar:"
ACCEPT WS-PLATILLO-ID
       DISPLAY "Ingrese la cantidad de platillos que desea ordenar:"
ACCEPT WS-PEDIDO-CANTIDAD
       EXEC SQL
SELECT precio FROM platillos WHERE id = :WS-PLATILLO-ID
       INTO :WS-PLATILLO-PRECIO;
       END-EXEC
       IF SQLCODE NOT = 0
       DISPLAY "Platillo no encontrado."
ELSE
       COMPUTE WS-PEDIDO-TOTAL = WS-PLATILLO-PRECIO * WS-PEDIDO-CANTIDAD
       EXEC SQL
       INSERT INTO pedidos (cliente_id, platillo_id, cantidad, total)
VALUES (:WS-CLIENTE-ID, :WS-PLATILLO-ID, 
:WS-PEDIDO-CANTIDAD, :WS-PEDIDO-TOTAL);
       END-EXEC
       IF SQLCODE NOT = 0
       DISPLAY "Error al registrar el pedido."
ELSE
       DISPLAY "Pedido registrado exitosamente."
END-IF
       END-IF.
       MODIFICAR-PEDIDO.
       DISPLAY "Ingrese el ID del pedido que desea modificar:"
ACCEPT WS-PEDIDO-ID
       EXEC SQL
SELECT * FROM pedidos WHERE id = :WS-PEDIDO-ID
       INTO :WS-PEDIDO-ID, :WS-CLIENTE-ID, 
       :WS-PLATILLO-ID, :WS-PEDIDO-CANTIDAD, :WS-PEDIDO-TOTAL;
       END-EXEC
       IF SQLCODE NOT = 0
       DISPLAY "Pedido no encontrado."
ELSE
       DISPLAY "Ingrese la nueva cantidad de platillos que desea ordenar 
(dejar en blanco para mantener la cantidad actual):"
ACCEPT WS-PEDIDO-CANTIDAD
       IF WS-PEDIDO-CANTIDAD = 0
       DISPLAY "No se puede dejar una cantidad 
       de 0 platillos en un pedido."
ELSE
       EXEC SQL
SELECT precio FROM platillos WHERE id = :WS-PLATILLO-ID
       INTO :WS-PLATILLO-PRECIO;
       END-EXEC
       COMPUTE WS-PEDIDO-TOTAL = WS-PLATILLO-PRECIO * WS-PEDIDO-CANTIDAD
       EXEC SQL
UPDATE pedidos SET
       cantidad = :WS-PEDIDO-CANTIDAD,
       total = :WS-PEDIDO-TOTAL
       WHERE id = :WS-PEDIDO-ID;
       END-EXEC
       IF SQLCODE NOT = 0
       DISPLAY "Error al modificar el pedido."
ELSE
       DISPLAY "Pedido modificado exitosamente."
       END-IF
END-IF
       END-IF.
       ELIMINAR-PEDIDO.
       DISPLAY "Ingrese el ID del pedido que desea eliminar:"
ACCEPT WS-PEDIDO-ID
       EXEC SQL
DELETE FROM pedidos WHERE id = :WS-PEDIDO-ID;
       END-EXEC
       IF SQLCODE NOT = 0
       DISPLAY "Error al eliminar el pedido."
ELSE
       DISPLAY "Pedido eliminado exitosamente."
       END-IF.
       VER-TODOS-PEDIDOS.
       EXEC SQL
SELECT pedidos.id, clientes.nombre, platillos.nombre, pedidos.cantidad, pedidos
.total
       FROM pedidos
       JOIN clientes ON pedidos.cliente_id = clientes.id
       JOIN platillos ON pedidos.platillo_id = platillos.id;
       END-EXEC
       IF SQLCODE NOT = 0
       DISPLAY "Error al obtener los pedidos."
ELSE
       DISPLAY "ID NOMBRE DEL CLIENTE PLATILLO CANTIDAD TOTAL"
       DISPLAY "----------------------------
       -------------------------------------"
       PERFORM UNTIL SQLCODE NOT = 0
       DISPLAY WS-PEDIDO-ID " " WS-CLIENTE-NOMBRE(1:25) 
       " " WS-PLATILLO-NOMBRE(1:15) 
       " " WS-PEDIDO-CANTIDAD " " WS-PEDIDO-TOTAL
       EXEC SQL
       FETCH NEXT FROM pedidos INTO :WS-PEDIDO-ID, :WS-CLIENTE-NOMBRE, 
       :WS-PLATILLO-NOMBRE, :WS-PEDIDO-CANTIDAD, :WS-PEDIDO-TOTAL;
       END-EXEC
       END-PERFORM
       END-IF.
       MENU-PRINCIPAL.
       DISPLAY "1. Gestionar clientes"
       DISPLAY "2. Gestionar pedidos"
       DISPLAY "3. Salir"
       DISPLAY "Ingrese una opción:"
ACCEPT WS-OPCION
       EVALUATE WS-OPCION
WHEN 1 PERFORM GESTIONAR-CLIENTES
WHEN 2 PERFORM GESTIONAR-PEDIDOS
WHEN 3 STOP RUN
       WHEN OTHER DISPLAY "Opción inválida."
       END-EVALUATE
           PERFORM MENU-PRINCIPAL.

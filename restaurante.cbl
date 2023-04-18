IDENTIFICATION DIVISION.
PROGRAM-ID. Restaurante.

ENVIRONMENT DIVISION.
CONFIGURATION SECTION.
SOURCE-COMPUTER. IBM-PC.
OBJECT-COMPUTER. IBM-PC.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
SELECT cliente-db ASSIGN TO 'restaurante_db.cliente'.
SELECT mesa-db ASSIGN TO 'restaurante_db.mesa'.
SELECT pedido-db ASSIGN TO 'restaurante_db.pedido'.
SELECT platillo-db ASSIGN TO 'restaurante_db.platillo'.

DATA DIVISION.
FILE SECTION.
FD cliente-db.
       01 cliente-registro.
          05 cliente-nombre PIC X(50).
          05 cliente-telefono PIC X(15).
          05 cliente-direccion PIC X(100).

FD mesa-db.
       01 mesa-registro.
          05 mesa-numero PIC X(2).
          05 mesa-capacidad PIC X(2).

FD pedido-db.
       01 pedido-registro.
          05 pedido-numero PIC X(5).
          05 pedido-mesa PIC X(2).
          05 pedido-cliente PIC X(50).
          05 pedido-platillo PIC X(50).
          05 pedido-cantidad PIC X(2).
          05 pedido-total PIC X(6).

FD platillo-db.
       01 platillo-registro.
          05 platillo-nombre PIC X(50).
          05 platillo-descripcion PIC X(100).
          05 platillo-precio PIC X(6).
          05 platillo-categoria PIC X(15).

WORKING-STORAGE SECTION.
       01 opcion-menu PIC X.
       01 opcion-registro PIC X.
       01 opcion-consulta PIC X.
       01 codigo-platillo PIC X(5).
       01 descripcion-platillo PIC X(100).
       01 precio-platillo PIC X(6).
       01 categoria-platillo PIC X(15).
       01 nombre-cliente PIC X(50).
       01 telefono-cliente PIC X(15).
       01 direccion-cliente PIC X(100).
       01 numero-mesa PIC X(2).
       01 capacidad-mesa PIC X(2).
       01 numero-pedido PIC X(5).
       01 mesa-pedido PIC X(2).
       01 cliente-pedido PIC X(50).
       01 platillo-pedido PIC X(50).
       01 cantidad-pedido PIC X(2).
       01 total-pedido PIC X(6).
       01 nombre-mesero PIC X(50).
       01 cedula-mesero PIC X(15).
       01 fecha-ausencia PIC X(10).
       01 fecha-pedido PIC X(10).

PROCEDURE DIVISION.

       MAIN-LOOP.
          DISPLAY "RESTAURANTE".
          DISPLAY "1. Carta del restaurante".
          DISPLAY "2. Platillos por tipos".
          DISPLAY "3. Registro de Meseros".
          DISPLAY "4. Registro de Mesas numeradas".
          DISPLAY "5. Registro de Pedidos".
          DISPLAY "6. Consultas".
          DISPLAY "0. Salir".
          ACCEPT WS-OPTION.

          EVALUATE WS-OPTION
             WHEN "1"
                PERFORM MENU-1
             WHEN "2"
                PERFORM MENU-2
             WHEN "3"
                PERFORM MENU-3
             WHEN "4"
                PERFORM MENU-4
             WHEN "5"
                PERFORM MENU-5
             WHEN "6"
                PERFORM MENU-6
             WHEN "0"
                MOVE 'Y' TO WS-EXIT
             WHEN OTHER
                DISPLAY "Opción inválida."
          END-EVALUATE.

          IF WS-EXIT = 'Y'
             GO TO END-PROGRAM
          END-IF.

          GO TO MAIN-LOOP.

END-PROGRAM.
          DISPLAY "Fin del programa."
          STOP RUN
          
          CLIENTES-LOOP.
       DISPLAY "1. Agregar cliente".
       DISPLAY "2. Actualizar cliente".
       DISPLAY "3. Eliminar cliente".
       DISPLAY "0. Volver al menú principal".
       ACCEPT opcion-registro.

         EVALUATE opcion-registro
             WHEN "1"
                 PERFORM AGREGAR-CLIENTE
             WHEN "2"
                 PERFORM ACTUALIZAR-CLIENTE
             WHEN "3"
                 PERFORM ELIMINAR-CLIENTE
             WHEN "0"
                 GO TO MAIN-LOOP
             WHEN OTHER
                 DISPLAY "Opción inválida."
         END-EVALUATE.

         GO TO CLIENTES-LOOP.

       AGREGAR-CLIENTE.
       DISPLAY "Agregar cliente."
       ACCEPT nombre-cliente.
       ACCEPT telefono-cliente.
       ACCEPT direccion-cliente.

         WRITE cliente-registro.

         IF (STATUS-KEY) NOT = '00'
             DISPLAY "Error al agregar cliente."
         ELSE
             DISPLAY "Cliente agregado con éxito."
         END-IF.

       ACTUALIZAR-CLIENTE.
       DISPLAY "Actualizar cliente."
       ACCEPT cliente-nombre.
       ACCEPT telefono-cliente.
       ACCEPT direccion-cliente.

         READ cliente-registro
             INVALID KEY
                 DISPLAY "Cliente no encontrado."
         END-READ.

         IF (STATUS-KEY) NOT = '00'
             DISPLAY "Error al actualizar cliente."
         ELSE
             REWRITE cliente-registro.
             DISPLAY "Cliente actualizado con éxito."
         END-IF.

       ELIMINAR-CLIENTE.
       DISPLAY "Eliminar cliente."
       ACCEPT cliente-nombre.

         DELETE cliente-registro
             INVALID KEY
                 DISPLAY "Cliente no encontrado."
         END-DELETE.

         IF (STATUS-KEY) NOT = '00'
             DISPLAY "Error al eliminar cliente."
         ELSE
             DISPLAY "Cliente eliminado con éxito."
         END-IF.

       MESAS-LOOP.
       DISPLAY "1. Agregar mesa".
       DISPLAY "2. Actualizar mesa".
       DISPLAY "3. Eliminar mesa".
       DISPLAY "0. Volver al menú principal".
       ACCEPT opcion-registro.

         EVALUATE opcion-registro
             WHEN "1"
                 PERFORM AGREGAR-MESA
             WHEN "2"
                 PERFORM ACTUALIZAR-MESA
             WHEN "3"
                 PERFORM ELIMINAR-MESA
             WHEN "0"
                 GO TO MAIN-LOOP
             WHEN OTHER
                 DISPLAY "Opción inválida."
         END-EVALUATE.

         GO TO MESAS-LOOP.

       AGREGAR-MESA.
       DISPLAY "Agregar Mesa"

       MENU-1.
         	DISPLAY "CARTA DEL RESTAURANTE".
         	DISPLAY "1. Entradas".
         	DISPLAY "2. Platos principales".
         	DISPLAY "3. Postres".
         	DISPLAY "4. Bebidas".
         	DISPLAY "0. Regresar al menú principal".
         	ACCEPT WS-OPCION-MENU.

                	EVALUATE WS-OPCION-MENU
            	WHEN "1"
               	PERFORM MENU-1-1
            	WHEN "2"
               	PERFORM MENU-1-2
            	WHEN "3"
               	PERFORM MENU-1-3
            	WHEN "4"
               	PERFORM MENU-1-4
            	WHEN "0"
               	GO TO MAIN-LOOP
            	WHEN OTHER
               	DISPLAY "Opción inválida."
         	END-EVALUATE.

         	GO TO MENU-1.

       MENU-1-1.
         	DISPLAY "ENTRADAS".
         	DISPLAY "1. Empanadas de carne".
         	DISPLAY "2. Ceviche".
         	DISPLAY "3. Ensalada César".
         	DISPLAY "0. Regresar a la carta principal".
         	ACCEPT WS-OPCION-MENU.

         	EVALUATE WS-OPCION-MENU
            	WHEN "1"
           	PERFORM AGREGAR-PLATILLO "Empanadas de carne" 
           	"Empanadas de carne rellenas de carne molida" 10.99 "Entrada"
            	WHEN "2"
        	PERFORM AGREGAR-PLATILLO "Ceviche" 
        	"Ceviche de camarón con limón y cilantro" 12.99 "Entrada"
            	WHEN "3"
        	PERFORM AGREGAR-PLATILLO "Ensalada César" 
        	"Ensalada de lechuga, pollo y aderezo César" 8.99 "Entrada"
            	WHEN "0"
               	GO TO MENU-1
            	WHEN OTHER
               	DISPLAY "Opción inválida."
         	END-EVALUATE.

         	GO TO MENU-1-1.

       MENU-1-2.
         	DISPLAY "PLATOS PRINCIPALES".
         	DISPLAY "1. Filete de res".
         	DISPLAY "2. Pollo a la parrilla".
         	DISPLAY "3. Spaghetti a la boloñesa".
         	DISPLAY "0. Regresar a la carta principal".
         	ACCEPT WS-OPCION-MENU.

         	EVALUATE WS-OPCION-MENU
            	WHEN "1"
        	PERFORM AGREGAR-PLATILLO "Filete de res" 
        	"Filete de res a la parrilla con papas fritas" 
        	17.99 "Plato principal"
            	WHEN "2"
        	PERFORM AGREGAR-PLATILLO "Pollo a la parrilla" 
        	"Pechuga de pollo a la parrilla con arroz y ensalada" 
        	14.99 "Plato principal"
            	WHEN "3"
        	PERFORM AGREGAR-PLATILLO "Spaghetti a la boloñesa" 
        	"Spaghetti con salsa de carne y queso parmesano" 
        	11.99 "Plato principal"
            	WHEN "0"
        	GO TO MENU-1
            	WHEN OTHER
        	DISPLAY "Opción inválida."
         	END-EVALUATE.

         	GO TO MENU-1-2.

       MENU-1-3.
         	DISPLAY "POSTRES".
         	DISPLAY "1. Tiramisú".
         	DISPLAY "2. Flan de caramelo".
         	DISPLAY "3. Helado de vainilla".
         	DISPLAY "0. Regresar a la carta principal".
         	ACCEPT WS-OPCION-MENU.

         	EVALUATE WS-OPCION-MENU
            	WHEN "1"
        	PERFORM AGREGAR-PLATILLO "Tiramisú" 
        	"Postre italiano hecho con bizcocho, café y queso mascarpone" 
        	8.99 "Postre"
            	WHEN "2"
        	PERFORM AGREGAR-PLATILLO "Flan de caramelo" 
        	"Postre latinoamericano hecho con leche y caramelo" 
        	6.99 "Postre"
            	WHEN "3"
        	PERFORM AGREGAR-PLATILLO "Helado de vainilla"
        	 "Helado de vainilla con salsa de chocolate" 4.99 "Postre"
            	WHEN "0"
               	GO TO MENU-1
            	WHEN OTHER
        	DISPLAY "Opción inválida."
         	END-EVALUATE.

         	GO TO MENU-1-3.

       MENU-1-4.
         	DISPLAY "BEBIDAS".
         	DISPLAY "1. Refresco".
         	DISPLAY "2. Agua mineral".
         	DISPLAY "3. Cerveza".
         	DISPLAY "0. Regresar a la carta principal".
         	ACCEPT WS-OPCION-MENU.

         	EVALUATE WS-OPCION-MENU
            	WHEN "1"
        	PERFORM AGREGAR-PLATILLO 
        	"Refresco" "Refresco de cola, limón o naranja" 2.99 "Bebida"
            	WHEN "2"
        	PERFORM AGREGAR-PLATILLO 
        	"Agua mineral" "Agua mineral con o sin gas" 1.99 "Bebida"
            	WHEN "3"
        	PERFORM AGREGAR-PLATILLO 
        	"Cerveza" "Cerveza nacional o importada" 5.99 "Bebida"
            	WHEN "0"
        	GO TO MENU-1
            	WHEN OTHER
        	DISPLAY "Opción inválida."
         	END-EVALUATE.

         	GO TO MENU-1-4.

       AGREGAR-PLATILLO USING NOMBRE, DESCRIPCION, PRECIO, CATEGORIA.
         	DISPLAY "¿Desea agregar el siguiente platillo a la orden?"
         	DISPLAY "Nombre: " NOMBRE
         	DISPLAY "Descripción: " DESCRIPCION
         	DISPLAY "Precio: " PRECIO
         	DISPLAY "Categoría: " CATEGORIA
         	DISPLAY "1. Sí"
         	DISPLAY "2. No"
         	ACCEPT WS-OPCION.

         	EVALUATE WS-OPCION
            	WHEN "1"
        	ADD 1 TO CANTIDAD-PRODUCTOS
        	MOVE NOMBRE TO PRODUCTOS (CANTIDAD-PRODUCTOS)
        	MOVE PRECIO TO PRECIOS (CANTIDAD-PRODUCTOS)
        	MOVE CATEGORIA TO CATEGORIAS (CANTIDAD-PRODUCTOS)
        	DISPLAY "Se ha agregado el platillo a la orden."
            	WHEN "2"
        	DISPLAY "No se ha agregado el platillo a la orden."
            	WHEN OTHER
        	DISPLAY "Opción inválida."
         	END-EVALUATE.

         	DISPLAY "Presione una tecla para continuar."
         	ACCEPT WS-PAUSA.

         	GO TO MENU-1.

       IMPRIMIR-ORDEN.
         	DISPLAY "ORDEN"
         	DISPLAY "--------------------------"
         	DISPLAY "Cant. | Producto | Precio"
         	MOVE 1 TO WS-INDICE
         	PERFORM UNTIL WS-INDICE > CANTIDAD-PRODUCTOS
            	DISPLAY CANTIDADES 
            	(WS-INDICE) " 
            	| " PRODUCTOS (WS-INDICE) " | " PRECIOS (WS-INDICE)
            	ADD PRECIOS (WS-INDICE) TO TOTAL-ORDEN
            	ADD 1 TO WS-INDICE
         	END-PERFORM.
         	DISPLAY "--------------------------"
         	DISPLAY "Total: " TOTAL-ORDEN
         	DISPLAY "Presione una tecla para continuar."
         	ACCEPT WS-PAUSA.

         	MOVE 0 TO CANTIDAD-PRODUCTOS
         	MOVE 0 TO TOTAL-ORDEN.

         	GO TO MAIN-LOOP.

       SALIR.
         	DISPLAY "Gracias por visitarnos."
         	STOP RUN.
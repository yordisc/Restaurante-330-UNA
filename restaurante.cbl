       IDENTIFICATION DIVISION.
       PROGRAM-ID. Restaurante.
       AUTHOR. github.com/yordisc;

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
       DATA DIVISION.
       
          FILE SECTION.
          FD CLIENTES.
          01 CLIENTES-REGISTRO.
             05 CLIENTE-ID        PIC X(10).
             05 CLIENTE-NOMBRE    PIC X(50).
             05 CLIENTE-TELEFONO  PIC X(20).
             05 CLIENTE-DIRECCION PIC X(50).

          FD MESAS.
          01 MESAS-REGISTRO.
             05 MESA-ID          PIC X(10).
             05 MESA-NUMERO      PIC X(10).
             05 MESA-CAPACIDAD   PIC 9(2).

          FD PLATILLOS.
          01 PLATILLOS-REGISTRO.
             05 PLATILLO-ID      PIC X(10).
             05 PLATILLO-NOMBRE  PIC X(50).
             05 PLATILLO-DESCRIP PIC X(200).
             05 PLATILLO-PRECIO  PIC 9(5)V99.
             05 PLATILLO-CATEG   PIC X(50).

          FD PEDIDOS.
          01 PEDIDOS-REGISTRO.
             05 PEDIDO-ID        PIC X(10).
             05 PEDIDO-NUMERO    PIC X(10).
             05 PEDIDO-MESA-ID   PIC X(10).
             05 PEDIDO-CLIENTE-ID PIC X(10).
             05 PEDIDO-TOTAL     PIC 9(5)V99.

          FD PLATILLOS-PEDIDOS.
          01 PLATILLOS-PEDIDOS-REGISTRO.
             05 PLATILLO-PEDIDO-ID  PIC X(10).
             05 PLATILLO-ID         PIC X(10).
             05 PEDIDO-ID           PIC X(10).
             05 CANTIDAD            PIC 9(2).

       WORKING-STORAGE SECTION.
       01 OPCIONES-MENU.
          05 OPCION1 PIC X(30) VALUE 'Carta del restaurante'.
          05 OPCION2 PIC X(30) VALUE 'Platillos por tipos'.
          05 OPCION3 PIC X(30) VALUE 'Registro de Meseros'.
          05 OPCION4 PIC X(30) VALUE 'Registro de Mesas numeradas'.
          05 OPCION5 PIC X(30) VALUE 'Registro de Pedidos'.
       01 OPCION-SELECCIONADA PIC 99.
       01 CLIENTE-REGISTRO-TEMP.
          05 CLIENTE-NOMBRE-TEMP PIC X(50).
          05 CLIENTE-TELEFONO-TEMP PIC X(15).
          05 CLIENTE-DIRECCION-TEMP PIC X(100).
       01 MESA-REGISTRO-TEMP.
          05 MESA-NUMERO-TEMP PIC X(2).
          05 MESA-CAPACIDAD-TEMP PIC X(2).
       01 PEDIDO-REGISTRO-TEMP.
          05 PEDIDO-NUMERO-TEMP PIC X(5).
          05 PEDIDO-MESA-TEMP PIC X(2).
          05 PEDIDO-CLIENTE-TEMP PIC X(50).
          05 PEDIDO-TOTAL-TEMP PIC X(6).
       01 PLATILLO-REGISTRO-TEMP.
          05 PLATILLO-NOMBRE-TEMP PIC X(50).
          05 PLATILLO-DESCRIPCION-TEMP PIC X(100).
          05 PLATILLO-PRECIO-TEMP PIC X(6).
          05 PLATILLO-CATEGORIA-TEMP PIC X(15).
       01 CLIENTE-DB-REGISTRO.
          05 CLIENTE-NOMBRE PIC X(50).
          05 CLIENTE-TELEFONO PIC X(15).
          05 CLIENTE-DIRECCION PIC X(100).
       01 MESA-DB-REGISTRO.
          05 MESA-NUMERO PIC X(2).
          05 MESA-CAPACIDAD PIC X(2).
          05 MESA-MESERO-ASIGNADO PIC X(15).
       01 PEDIDO-DB-REGISTRO.
          05 PEDIDO-NUMERO PIC X(5).
          05 PEDIDO-MESA PIC X(2).
          05 PEDIDO-CLIENTE PIC X(50).
          05 PEDIDO-TOTAL PIC X(6).
          05 PEDIDO-ESTADO PIC X(10) VALUE 'PENDIENTE'.
       01 PLATILLO-DB-REGISTRO.
          05 PLATILLO-NOMBRE PIC X(50).
          05 PLATILLO-DESCRIPCION PIC X(100).
          05 PLATILLO-PRECIO PIC X(6).
          05 PLATILLO-CATEGORIA PIC X(15).
       01 FECHA-SELECCIONADA.
          05 ANIO PIC X(4).
          05 MES PIC X(2).

       PROCEDURE DIVISION.
      *Menú principal del programa
           INICIO.
           DISPLAY '*** BIENVENIDO AL SISTEMA***'.
           DISPLAY '*** DE PEDIDOS DEL RESTAURANTE ***'.
           DISPLAY 'Seleccione una opción del menú:'.
           DISPLAY '1. Carta del restaurante'.
           DISPLAY '2. Platillos por tipos'.
           DISPLAY '3. Registro de Meseros'.
           DISPLAY '4. Registro de Mesas numeradas'.
           DISPLAY '5. Registro de Pedidos'.
           DISPLAY '6. Salir'.
           ACCEPT OPCION-SELECCIONADA.
           PERFORM OPCIONES-MENU.
           GO TO INICIO.
           Opción 1: Carta del restaurante
           OPCION1.
           DISPLAY '*** CARTA DEL RESTAURANTE ***'.
           DISPLAY 'Seleccione una opción:'.
           DISPLAY '1. Agregar tipo de platillo'.
           DISPLAY '2. Modificar tipo de platillo'.
           DISPLAY '3. Eliminar tipo de platillo'.
           DISPLAY '4. Regresar al menú principal'.
           ACCEPT OPCION-SELECCIONADA.
           PERFORM OPCIONES-CARTA.
           GO TO OPCION1.
           Opción 2: Platillos por tipos
           OPCION2.
           DISPLAY '*** PLATILLOS POR TIPOS ***'.
           DISPLAY 'Seleccione una opción:'.
           DISPLAY '1. Agregar platillo'.
           DISPLAY '2. Modificar platillo'.
           DISPLAY '3. Eliminar platillo'.
           DISPLAY '4. Regresar al menú principal'.
           ACCEPT OPCION-SELECCIONADA.
           PERFORM OPCIONES-PLATILLOS.
           GO TO OPCION2.
           Opción 3: Registro de Meseros
           OPCION3.
           DISPLAY '*** REGISTRO DE MESEROS ***'.
           DISPLAY 'Seleccione una opción:'.
           DISPLAY '1. Agregar mesero'.
           DISPLAY '2. Modificar mesero'.
           DISPLAY '3. Eliminar mesero'.
           DISPLAY '4. Regresar al menú principal'.
           ACCEPT OPCION-SELECCIONADA.
           PERFORM OPCIONES-MESEROS.
           GO TO OPCION3.
           Opción 4: Registro de Mesas numeradas
           OPCION4.
           DISPLAY '*** REGISTRO DE MESAS NUMERADAS ***'.
           DISPLAY 'Seleccione una opción:'.
           DISPLAY '1. Agregar mesa'.
           DISPLAY '2. Modificar mesa'.
           DISPLAY '3. Eliminar mesa'.
           DISPLAY '4. Regresar al menú principal'.
           ACCEPT OPCION-SELECCIONADA.
           PERFORM OPCIONES-MESAS.
           GO TO OPCION4.
           Opción 5: Registro de Pedidos
           OPCION5.
           DISPLAY '*** REGISTRO DE PEDIDOS ***'.
           DISPLAY 'Seleccione una opción:'.
           DISPLAY '1. Agregar pedido'.
           DISPLAY '2. Modificar pedido'.
           DISPLAY '3. Eliminar pedido'.
           DISPLAY '4. Regresar al menú principal'.
           ACCEPT OPCION-SELECCIONADA.
           PERFORM OPCIONES-PEDIDOS.
           GO TO OPCION5.
           Opción 6: Salir
           OPCION6.
           DISPLAY '*** GRACIAS POR UTILIZAR EL '
       CONTINUE 'SISTEMA DE PEDIDOS DEL RESTAURANTE ***'.
           STOP RUN.
      *Subrutina para manejar las opciones del menú de la Carta del restaurante
           OPCIONES-CARTA.
           IF OPCION-SELECCIONADA = 1 THEN
           PERFORM AGREGAR-TIPO-PLATILLO
           ELSE IF OPCION-SELECCIONADA = 2 THEN
           PERFORM MODIFICAR-TIPO-PLATILLO
           ELSE IF OPCION-SELECCIONADA = 3 THEN
           PERFORM ELIMINAR-TIPO-PLATILLO
           ELSE IF OPCION-SELECCIONADA = 4 THEN
           EXIT.
           ELSE DISPLAY 'Opción inválida. Seleccione una opción válida.'.
           GO TO OPCIONES-CARTA.
           END-IF.
      *Subrutina para manejar las opciones del menú de Platillos por tipos
           OPCIONES-PLATILLOS.
           IF OPCION-SELECCIONADA = 1 THEN
           PERFORM AGREGAR-PLATILLO
           ELSE IF OPCION-SELECCIONADA = 2 THEN
           PERFORM MODIFICAR-PLATILLO
           ELSE IF OPCION-SELECCIONADA = 3 THEN
           PERFORM ELIMINAR-PLATILLO
           ELSE IF OPCION-SELECCIONADA = 4 THEN
           EXIT.
           ELSE DISPLAY 'Opción inválida. Seleccione una opción válida.'.
           GO TO OPCIONES-PLATILLOS.
           END-IF.
      *Subrutina para manejar las opciones del menú de Registro de Meseros
           OPCIONES-MESEROS.
           IF OPCION-SELECCIONADA = 1 THEN
           PERFORM AGREGAR-MESERO
           ELSE IF OPCION-SELECCIONADA = 2 THEN
           PERFORM MODIFICAR-MESERO
           ELSE IF OPCION-SELECCIONADA = 3 THEN
           PERFORM ELIMINAR-MESERO
           ELSE IF OPCION-SELECCIONADA = 4 THEN
           EXIT.
           ELSE DISPLAY 'Opción inválida. Seleccione una opción válida.'.
           GO TO OPCIONES-MESEROS.
           END-IF.
      *Subrutina para manejar las opciones del menú de Registro de Mesas numeradas
           OPCIONES-MESAS.
           IF OPCION-SELECCIONADA = 1 THEN
           PERFORM AGREGAR-MESA
           ELSE IF OPCION-SELECCIONADA = 2 THEN
           PERFORM MODIFICAR-MESA
           ELSE IF OPCION-SELECCIONADA = 3 THEN
           PERFORM ELIMINAR-MESA
           ELSE IF OPCION-SELECCIONADA = 4 THEN
           EXIT.
           ELSE DISPLAY 'Opción inválida. Seleccione una opción válida.'.
           GO TO OPCIONES-MESAS.
           END-IF.
      *Subrutina para manejar las opciones del menú de Registro de Pedidos
           OPCIONES-PEDIDOS.
           IF OPCION-SELECCIONADA = 1 THEN
           PERFORM AGREGAR-PEDIDO
           ELSE IF OPCION-SELECCIONADA = 2 THEN
           PERFORM MODIFICAR-PEDIDO
           ELSE IF OPCION-SELECCIONADA = 3 THEN
           PERFORM ELIMINAR-PEDIDO
           ELSE IF OPCION-SELECCIONADA = 4 THEN
           EXIT.
           ELSE DISPLAY 'Opción inválida. Seleccione una opción válida.'.
           GO TO OPCIONES-PEDIDOS.
           END-IF.
      *Subrutina para agregar un tipo de platillo
           AGREGAR-TIPO-PLATILLO.
           DISPLAY 'Ingrese el nombre del tipo de platillo:'.
           ACCEPT NOMBRE-TIPO-PLATILLO.
           IF NOMBRE-TIPO-PLATILLO NOT = '' THEN
           ADD 1 TO NUMERO-TIPOS-PLATILLOS.
           SET TIPOS-PLATILLOS(NUMERO-TIPOS-PLATILLOS) 
       CONTINUE TO NOMBRE-TIPO-PLATILLO.
           DISPLAY 'Tipo de platillo agregado correctamente.'.
           ELSE DISPLAY 'El nombre del tipo de platillo'
       CONTINUE ' no puede estar vacío.'.
      *Subrutina para modificar un tipo de platillo
           MODIFICAR-TIPO-PLATILLO.
           DISPLAY 'Ingrese el número del tipo de platillo a modificar:'.
           ACCEPT NUMERO-TIPO-PLATILLO.
           IF NUMERO-TIPO-PLATILLO NOT NUMERIC OR NUMERO-TIPO-PLATILLO 
       CONTINUE < 1 OR NUMERO-TIPO-PLATILLO > NUMERO-TIPOS-PLATILLOS THEN
       DISPLAY 'Número de tipo de platillo inválido.'
       CONTINUE ' Ingrese un número válido.'.
           ELSE DISPLAY 'Ingrese el nuevo nombre del tipo de platillo:'.
           ACCEPT NOMBRE-TIPO-PLATILLO.
           IF NOMBRE-TIPO-PLATILLO NOT = '' THEN
           SET TIPOS-PLATILLOS(NUMERO-TIPO-PLATILLO) 
       CONTINUE TO NOMBRE-TIPO-PLATILLO.
           DISPLAY 'Tipo de platillo modificado correctamente.'.
           ELSE DISPLAY 'El nombre del tipo de platillo '
           - 'no puede estar vacío.'.
      *Subrutina para eliminar un tipo de platillo
           ELIMINAR-TIPO-PLATILLO.
           DISPLAY 'Ingrese el número del tipo de platillo a eliminar:'.
           ACCEPT NUMERO-TIPO-PLATILLO.
           IF NUMERO-TIPO-PLATILLO NOT NUMERIC OR NUMERO-TIPO-PLATILLO 
       CONTINUE < 1 OR NUMERO-TIPO-PLATILLO > NUMERO-TIPOS-PLATILLOS THEN
           DISPLAY 'Número de tipo de platillo inválido.'
           - ' Ingrese un número válido.'.
       ELSE
       SET TIPOS-PLATILLOS(NUMERO-TIPO-PLATILLO) TO SPACES.
       MOVE TIPOS-PLATILLOS(NUMERO-TIPO-PLATILLO + 1: )
       CONTINUE TO TIPOS-PLATILLOS(NUMERO-TIPO-PLATILLO: ).
       SUBTRACT 1 FROM NUMERO-TIPOS-PLATILLOS.
       DISPLAY 'Tipo de platillo eliminado correctamente.'.
      *Subrutina para agregar un platillo
           AGREGAR-PLATILLO.
           DISPLAY 'Ingrese el número del tipo de platillo '
       CONTINUE 'al que pertenece el platillo:'.
           DISPLAY 'Las opciones son:'.
           PERFORM MOSTRAR-TIPOS-PLATILLOS.
           ACCEPT NUMERO-TIPO-PLATILLO.
           IF NUMERO-TIPO-PLATILLO NOT NUMERIC OR NUMERO-TIPO-PLATILLO 
       CONTINUE < 1 OR NUMERO-TIPO-PLATILLO > NUMERO-TIPOS-PLATILLOS THEN
           DISPLAY 'Número de tipo de platillo inválido.'
       CONTINUE ' Ingrese un número válido.'.
           ELSE
           DISPLAY 'Ingrese el nombre del platillo:'.
           ACCEPT NOMBRE-PLATILLO.
           DISPLAY 'Ingrese el precio del platillo:'.
           ACCEPT PRECIO-PLATILLO.
           IF PRECIO-PLATILLO NOT NUMERIC OR PRECIO-PLATILLO < 0 THEN
           DISPLAY 'Precio inválido. Ingrese un precio válido.'.
           ELSE
           ADD 1 TO NUMERO-PLATILLOS.
           SET PLATILLOS(NUMERO-PLATILLOS) TO NUMERO-TIPO-PLATILLO 
       CONTINUE '-' NOMBRE-PLATILLO '-' PRECIO-PLATILLO.
           DISPLAY 'Platillo agregado correctamente.'.
      *Subrutina para modificar un platillo
           MODIFICAR-PLATILLO.
           DISPLAY 'Ingrese el número del platillo a modificar:'.
           ACCEPT NUMERO-PLATILLO.
           IF NUMERO-PLATILLO NOT NUMERIC OR NUMERO-PLATILLO 
       CONTINUE < 1 OR NUMERO-PLATILLO > NUMERO-PLATILLOS THEN
           DISPLAY 'Número de platillo inválido.'
       CONTINUE ' Ingrese un número válido.'.
           ELSE
           SET TIPO-PLATILLO TO FUNCTION SUBSTRING(PLATILLOS
       CONTINUE (NUMERO-PLATILLO: ), 1, 
       CONTINUE INDEX(PLATILLOS(NUMERO-PLATILLO: ), '-') - 1).
           DISPLAY 'Tipo de platillo: ' TIPOS-PLATILLOS(TIPO-PLATILLO).
           DISPLAY 'Ingrese el nuevo nombre del platillo:'.
           ACCEPT NOMBRE-PLATILLO.
           DISPLAY 'Ingrese el nuevo precio del platillo:'.
           ACCEPT PRECIO-PLATILLO.
           IF PRECIO-PLATILLO NOT NUMERIC OR PRECIO-PLATILLO < 0 THEN
           DISPLAY 'Precio inválido. Ingrese un precio válido.'.
           ELSE
           SET PLATILLOS(NUMERO-PLATILLO) TO TIPO-PLATILLO 
       CONTINUE '-' NOMBRE-PLATILLO '-' PRECIO-PLATILLO.
           DISPLAY 'Platillo modificado correctamente.'.
      *Subrutina para eliminar un platillo
           ELIMINAR-PLATILLO.
           DISPLAY 'Ingrese el número del platillo a eliminar:'.
           ACCEPT NUMERO-PLATILLO.
           IF NUMERO-PLATILLO NOT NUMERIC OR NUMERO-PLATILLO 
       CONTINUE < 1 OR NUMERO-PLATILLO > NUMERO-PLATILLOS THEN
           DISPLAY 'Número de platillo inválido.'
           - ' Ingrese un número válido.'.
           ELSE
           SET PLATILLOS(NUMERO-PLATILLO) TO SPACES.
           MOVE PLATILLOS(NUMERO-PLATILLO + 1: ) 
       CONTINUE TO PLATILLOS(NUMERO-PLATILLO: ).
           SUBTRACT 1 FROM NUMERO-PLATILLOS.
           DISPLAY 'Platillo eliminado correctamente.'.
      *Subrutina para mostrar los platillos
           MOSTRAR-PLATILLOS.
           IF NUMERO-PLATILLOS = 0 THEN
           DISPLAY 'No hay platillos registrados.'.
           ELSE
           DISPLAY 'Los platillos registrados son:'.
           PERFORM VARYING I FROM 1 BY 1 UNTIL I > NUMERO-PLATILLOS
           DISPLAY I ': ' TIPOS-PLATILLOS(FUNCTION SUBSTRING(PLATILLOS
       CONTINUE (I: ), 1, INDEX(PLATILLOS(I: ), '-') - 
       CONTINUE 1)) ' - ' FUNCTION SUBSTRING(PLATILLOS(I: ), 
       CONTINUE INDEX(PLATILLOS(I: ), '-') + 
       CONTINUE 1) ' - ' FUNCTION SUBSTRING(PLATILLOS(I: ), 
       CONTINUE INDEX(PLATILLOS(I: ), '-', 2) + 1)
           END-PERFORM
           END-IF.
      *Subrutina para mostrar las opciones del menú
           MOSTRAR-OPCIONES.
           DISPLAY 'Las opciones son:'.
           DISPLAY '1. Agregar tipo de platillo'.
           DISPLAY '2. Modificar tipo de platillo'.
           DISPLAY '3. Eliminar tipo de platillo'.
           DISPLAY '4. Agregar platillo'.
           DISPLAY '5. Modificar platillo'.
           DISPLAY '6. Eliminar platillo'.
           DISPLAY '7. Mostrar tipos de platillos'.
           DISPLAY '8. Mostrar platillos'.
           DISPLAY '9. Salir'.
       Programa principal
       MAIN.
       INITIALIZE TIPOS-PLATILLOS PLATILLOS.
       PERFORM MOSTRAR-OPCIONES.
       ACCEPT OPCION.
       PERFORM UNTIL OPCION = 9
       EVALUATE OPCION
       WHEN 1
       PERFORM AGREGAR-TIPO-PLATILLO
       WHEN 2
       PERFORM MODIFICAR-TIPO-PLATILLO
       WHEN 3
       PERFORM ELIMINAR-TIPO-PLATILLO
       WHEN 4
       PERFORM AGREGAR-PLATILLO
       WHEN 5
       PERFORM MODIFICAR-PLATILLO
       WHEN 6
       PERFORM ELIMINAR-PLATILLO
       WHEN 7
       PERFORM MOSTRAR-TIPOS-PLATILLOS
       WHEN 8
       PERFORM MOSTRAR-PLATILLOS
       WHEN OTHER
       DISPLAY 'Opción inválida. Ingrese una opción válida.'
       END-EVALUATE
       PERFORM MOSTRAR-OPCIONES
       ACCEPT OPCION
       END-PERFORM
       DISPLAY 'Gracias por utilizar nuestro programa.'.
       STOP RUN.

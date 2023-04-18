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
          STOP RUN.
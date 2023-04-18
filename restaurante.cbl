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
         05 PEDIDO-PLATILLO-TEMP PIC X(50).
         05 PEDIDO-CANTIDAD-TEMP PIC X(2).
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
         05 PEDIDO-PLATILLO PIC X(50).
         05 PEDIDO-CANTIDAD PIC X(2).
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
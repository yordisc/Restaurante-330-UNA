       IDENTIFICATION DIVISION.
       PROGRAM-ID. Restaurante.
       AUTHOR. github.com/yordisc.
       DATE-WRITTEN. 2023.
       DATE-COMPILED.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER. PC.
       OBJECT-COMPUTER. PC.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

       SELECT clientes-file ASSIGN TO "clientes.csv".
           ORGANIZATION IS LINE SEQUENTIAL.
       SELECT carta-file ASSIGN TO "carta.csv".
           ORGANIZATION IS LINE SEQUENTIAL.
       SELECT platillos-file ASSIGN TO "platillos.csv".
           ORGANIZATION IS LINE SEQUENTIAL.
       SELECT platillo-pedido-file ASSIGN TO "platillo_pedido.csv".
           ORGANIZATION IS LINE SEQUENTIAL.
       SELECT pedidos-file ASSIGN TO "pedidos.csv".
           ORGANIZATION IS LINE SEQUENTIAL.
       SELECT pagos-file ASSIGN TO "pago.csv".
           ORGANIZATION IS LINE SEQUENTIAL.
       SELECT mesas-file ASSIGN TO "mesas.csv".
           ORGANIZATION IS LINE SEQUENTIAL.
       SELECT meseros-file ASSIGN TO "meseros.csv".
           ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.

       FD platillo-pedido-file.
          LABEL RECORDS ARE STANDARD
          VALUE OF FILE-ID IS "platillo_pedido.csv"
          DATA RECORD IS platillo-pedido-record.
       01 platillo-pedido-record.
          05 id-platillo-pedido     PIC 9(5).
          05 id-platillo            PIC 9(5).
          05 cantidad               PIC 9(5).

       FD pedidos-file.
          LABEL RECORDS ARE STANDARD
          VALUE OF FILE-ID IS "pedidos.csv"
          DATA RECORD IS pedidos-record.
       01 pedidos-record.
          05 id-pedido              PIC 9(5).
          05 id-cliente             PIC 9(5).
          05 id-mesa                PIC 9(5).
          05 id-mesero              PIC 9(5).
          05 id-platillo-pedido     PIC 9(5).
          05 id-pago                PIC 9(5).
          05 propina                PIC 9(5)V99.
          05 importe                PIC 9(5)V99.
          05 enviado                PIC X.
          05 fecha                  PIC X(10).
          05 hora                   PIC X(8).

       FD pagos-file.
          LABEL RECORDS ARE STANDARD
          VALUE OF FILE-ID IS "pago.csv"
          DATA RECORD IS pagos-record.
       01 pagos-record.
          05 id-pago                PIC 9(5).
          05 tipo-de-pago           PIC X(10).

       FD clientes-file.
          LABEL RECORDS ARE STANDARD
          VALUE OF FILE-ID IS "clientes.csv"
          DATA RECORD IS clientes-record.
       01 clientes-record.
          05 id-cliente             PIC 9(5).
          05 nombre                 PIC X(30).
          05 telefono               PIC X(14).
          05 direccion-cliente      PIC X(30).

       FD carta-file.
          LABEL RECORDS ARE STANDARD
          VALUE OF FILE-ID IS "carta.csv"
          DATA RECORD IS carta-record.
       01 carta-record.
         05 ID-CARTA-TIPO         PIC 9(5).
         05 FILLER             PIC X(01) VALUE ";".
         05 TIPO-DE-PLATILLO      PIC X(20).

       FD platillos-file.
          LABEL RECORDS ARE STANDARD
          VALUE OF FILE-ID IS "platillos.csv"
          DATA RECORD IS platillos-record.
       01 platillos-record.
          05 id-platillo            PIC 9(5).
          05 nombre                 PIC X(20).
          05 descripcion            PIC X(30).
          05 id-carta               PIC 9(5).
          05 precio-unitario        PIC 9(5)V99.

       FD mesas-file.
          LABEL RECORDS ARE STANDARD
          VALUE OF FILE-ID IS "mesas.csv"
          DATA RECORD IS mesas-record.
       01 mesas-record.
          05 id-mesa                PIC 9(5).
          05 id-mesero              PIC 9(5).
          05 cantidad               PIC 9(5).

       FD meseros-file.
          LABEL RECORDS ARE STANDARD
          VALUE OF FILE-ID IS "meseros.csv"
          DATA RECORD IS meseros-record.
       01 meseros-record.
          05 id-mesero              PIC 9(5).
          05 cedula                 PIC X(8).
          05 nombre                 PIC X(20).
          05 apellido               PIC X(20).

       WORKING-STORAGE SECTION.

       01 EOF PIC S9(4) VALUE -1.
       01 EOFCARTA               PIC X(1) VALUE 'N'.
       01 RES PIC X(1).
       01 I PIC 9(2) VALUE 1.
       01 WS-FECHA                      PIC X(10).
       01 WS-OPCION                     PIC 99.
       01 ID-CARTA-TIPO      PIC 9(5) VALUE 0.
       01 TIPO-DE-PLATILLO  PIC X(20).
       01 WS-PLATILLOS.
             05 WS-PLATILLO OCCURS 6 TIMES.
               10 ID-PLATILLO PIC 9(5).
               10 NOMBRE PIC X(20).
               10 DESCRIPCION PIC X(30).
               10 ID-CARTA PIC 9(5).
               10 PRECIO-UNITARIO PIC 9(5)V99.
       01 TIPO-DE-PLATILLO OCCURS 100 TIMES.
             05 TIPO-PLATILLO              PIC X(50).
       01 WS-OPCION-MESEROS             PIC 9(2) VALUE 0.
       01 WS-MESEROS.
             05 WS-MESERO OCCURS 6 TIMES.
                10 ID-MESERO               PIC 9(5).
                10 CEDULA                  PIC X(8).
                10 NOMBRE                  PIC X(20).
                10 APELLIDO                PIC X(20).
       01 WS-MESAS.
             05 WS-MESA OCCURS 6 TIMES.
                10 ID-MESA                 PIC 9(5).
                10 ID-MESERO               PIC 9(5).
                10 CANTIDAD                PIC 9(5).
       01 WS-PEDIDOS.
             05 WS-PEDIDO OCCURS 6 TIMES.
                10 ID-PEDIDO               PIC 9(5).
                10 ID-CLIENTE              PIC 9(5).
                10 ID-MESA                 PIC 9(5).
                10 ID-MESERO               PIC 9(5).
                10 ID-PLATILLO-PEDIDO      PIC 9(5).
                10 ID-PAGO                 PIC 9(5).
                10 PROPINA                 PIC 9(5)V99.
                10 IMPORTE                 PIC 9(5)V99.
                10 ENVIADO                 PIC X.
                10 FECHA                   PIC X(10).
                10 HORA                    PIC X(8).
        01 WS-PAGOS.
             05 WS-PAGO OCCURS 3 TIMES.
                10 ID-PAGO                 PIC 9(5).
                10 TIPO-DE-PAGO            PIC X(20).
                10 MONTO                   PIC 9(5)V99. 

        PROCEDURE DIVISION.
          MAIN-PROGRAM.
              PERFORM MENU-PRINCIPAL UNTIL WS-OPCION = 0.
              STOP RUN.

      *Inicio del Menu Principal(Rutina -0)
          MENU-PRINCIPAL.
              DISPLAY "==============================="
              DISPLAY "RESTAURANTE - MENU PRINCIPAL"
              DISPLAY "==============================="
              DISPLAY "1. Carta del restaurante"
              DISPLAY "2. Platillos por tipos"
              DISPLAY "3. Registro de Meseros"
              DISPLAY "4. Registro de Mesas enumeradas"
              DISPLAY "5. Registro de Pedidos"
              DISPLAY "6. Consultas"
              DISPLAY "0. Salir"
              DISPLAY "==============================="
              DISPLAY "github.com/yordisc  -  UNA-CLA "
              DISPLAY "==============================="
              ACCEPT WS-OPCION.
              EVALUATE WS-OPCION
                  WHEN 1
                      PERFORM MENU-CARTA
                  WHEN 2
                      PERFORM MENU-PLATILLOS
                  WHEN 3
                      PERFORM MENU-MESEROS
                  WHEN 4
                      PERFORM MENU-MESAS
                  WHEN 5
                      PERFORM MENU-PEDIDOS
                  WHEN 6
                      PERFORM MENU-CONSULTAS
                  WHEN 0
                      CONTINUE
                  WHEN OTHER
                      DISPLAY "Opción inválida. Intente de nuevo."
              END-EVALUATE.
      *Final del Menu Principal(Rutina -0)

      ***************MENUS*********************
      *Menu Carta (Rutina 1)
        MENU-CARTA.
            PERFORM LIMPIAR-PANTALLA.
            DISPLAY "==============================="
            DISPLAY "     CARTA DEL RESTAURANTE"
            DISPLAY "==============================="
            DISPLAY "1. Ver tipos de platillos"
            DISPLAY "2. Agregar tipo de platillo"
            DISPLAY "3. Modificar tipo de platillo"
            DISPLAY "4. Eliminar tipo de platillo"
            DISPLAY "0. Volver al menú principal"
            ACCEPT WS-OPCION.
            EVALUATE WS-OPCION
                WHEN 1
                    PERFORM VER-TIPOS-PLATILLOS
                WHEN 2
                    PERFORM AGREGAR-TIPO-PLATILLO
                WHEN 3
                    PERFORM MODIFICAR-TIPO-PLATILLO
                WHEN 4
                    PERFORM ELIMINAR-TIPO-PLATILLO
                WHEN 0
                    PERFORM RETURN-TO-MAIN-MENU
                WHEN OTHER
                    DISPLAY "Opción inválida. Intente de nuevo."
            END-EVALUATE.
      *Fin de Menu Carta (Rutina 1)

      *Menu Platillos (Rutina 2)
            MENU-PLATILLOS.
          DISPLAY "====================================="
          DISPLAY "  RESTAURANTE - PLATILLOS POR TIPOS"
          DISPLAY "====================================="
          DISPLAY "1. Agregar un platillo"
          DISPLAY "2. Modificar un platillo"
          DISPLAY "3. Eliminar un platillo"
          DISPLAY "4. Listar todos los platillos"
          DISPLAY "5. Listar platillos por tipo"
          DISPLAY "0. Regresar al menú principal"
          ACCEPT WS-OPCION
          EVALUATE WS-OPCION
              WHEN 1
                  PERFORM AGREGAR-PLATILLO
              WHEN 2
                  PERFORM MODIFICAR-PLATILLO
              WHEN 3
                  PERFORM ELIMINAR-PLATILLO
              WHEN 4
                  PERFORM LISTAR-PLATILLOS
              WHEN 5
                  PERFORM LISTAR-PLATILLOS-POR-TIPO
              WHEN 0
                  CONTINUE
              WHEN OTHER
                  DISPLAY "Opción inválida. Intente de nuevo."
                  PERFORM MENU-PLATILLOS
          END-EVALUATE.
      *Fin Menu Platillos (Rutina 2)

      *Menu Meseros (Rutina 3)
       MENU-MESEROS.
              PERFORM UNTIL WS-OPCION-MESEROS = 0
                  DISPLAY "==============================="
                  DISPLAY "      REGISTRO DE MESEROS"
                  DISPLAY "==============================="
                  DISPLAY "1. Agregar mesero"
                  DISPLAY "2. Modificar datos de mesero"
                  DISPLAY "0. Volver al menú principal"
                  ACCEPT WS-OPCION-MESEROS
                  EVALUATE WS-OPCION-MESEROS
                      WHEN 1
                          PERFORM AGREGAR-MESERO
                      WHEN 2
                          PERFORM MODIFICAR-MESERO
                      WHEN 0
                    CONTINUE
                      WHEN OTHER
                          DISPLAY "Opción inválida. Intente de nuevo."
                  END-EVALUATE
              END-PERFORM.
      *Fin Menu Meseros (Rutina 3)

      *Menu Mesas (Rutina 4)
       MENU-MESAS.
         DISPLAY "==============================="
         DISPLAY " REGISTRO DE MESAS ENUMERADAS"
         DISPLAY "==============================="
         DISPLAY "1. Ingresar nueva mesa"
         DISPLAY "2. Modificar mesa existente"
         DISPLAY "0. Volver al Menú Principal"
         ACCEPT WS-OPCION
         EVALUATE WS-OPCION
            WHEN 1
               PERFORM INGRESAR-MESA
            WHEN 2
               PERFORM MODIFICAR-MESA
            WHEN 0
               CONTINUE
            WHEN OTHER
               DISPLAY "Opción inválida. Intente de nuevo."
               PERFORM MENU-MESAS
         END-EVALUATE.
      *Fin Menu Mesas (Rutina 4)
      
      *Registro Pedidos (Rutina 5)
       MENU-PEDIDOS.
             PERFORM UNTIL WS-OPCION = 0
                 DISPLAY "==============================="
                 DISPLAY "REGISTRO DE PEDIDOS"
                 DISPLAY "==============================="
                 DISPLAY "1. Ingresar un nuevo pedido"
                 DISPLAY "2. Modificar un pedido existente"
                 DISPLAY "3. Eliminar un pedido"
                 DISPLAY "0. Volver al Menú Principal"
                 ACCEPT WS-OPCION
                 EVALUATE WS-OPCION
                     WHEN 1
                         PERFORM INGRESAR-PEDIDO
                     WHEN 2
                         PERFORM MODIFICAR-PEDIDO
                     WHEN 3
                         PERFORM ELIMINAR-PEDIDO
                     WHEN 0
                         CONTINUE
                     WHEN OTHER
                         DISPLAY "Opción inválida. Intente de nuevo."
                 END-EVALUATE
             END-PERFORM
             DISPLAY "Saliendo del menú de pedidos."
             DISPLAY "Volviendo al Menú Principal."
             GO TO MENU-PRINCIPAL.
      *Fin Registro Pedidos (Rutina 5)
      
      *Consultas (Rutina 6)
       MENU-CONSULTAS.
          DISPLAY "==================================="
          DISPLAY "RESTAURANTE - MENÚ DE CONSULTAS"
          DISPLAY "==================================="
          DISPLAY "1. Platillos por tipos"
          DISPLAY "2. Meseros ausentes o retirados por fecha"
          DISPLAY "3. Mesas atendidas por un mesero ",
          "en una fecha y hora específicas"
          DISPLAY "0. Volver al menú principal"
          ACCEPT WS-OPCION.
          EVALUATE WS-OPCION
              WHEN 1
            PERFORM CONSULTA-PLATILLOS
              WHEN 2
                  PERFORM CONSULTA-MESEROS
              WHEN 3
                  PERFORM CONSULTA-MESAS
              WHEN 0
                  CONTINUE
              WHEN OTHER
                  DISPLAY "Opción inválida. Intente de nuevo."
          END-EVALUATE.
          PERFORM MENU-CONSULTAS.
      *Fin Consultas (Rutina 6)
      ***********************************************
      *********************MENUS*********************
      ***********************************************

       LIMPIAR-PANTALLA.
          DISPLAY FUNCTION CHAR(27) ,
       "[2J" *> secuencia de escape ANSI para borrar la pantalla
          CONTINUE.

      ***********************************************
      *****************SUB-RUTINAS*******************
      ***********************************************

       STOP RUN.

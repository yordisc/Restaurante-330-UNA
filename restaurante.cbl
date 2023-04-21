       IDENTIFICATION DIVISION.
       PROGRAM-ID. Restaurante.
       AUTHOR. github.com/yordisc.
       DATE-WRITTEN. 20/04/2023.
       DATE-COMPILED.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER. PC.
       OBJECT-COMPUTER. PC.

       INPUT-OUTPUT SECTION.

       FILE-CONTROL.
       SELECT clientes-file ASSIGN TO "clientes.csv".
       SELECT carta-file ASSIGN TO "carta.csv".
       SELECT platillos-file ASSIGN TO "platillos.csv".
       SELECT platillo-pedido-file ASSIGN TO "platillo_pedido.csv".
       SELECT pedidos-file ASSIGN TO "pedidos.csv".
       SELECT pagos-file ASSIGN TO "pagos.csv".
       SELECT mesas-file ASSIGN TO "mesas.csv".
       SELECT meseros-file ASSIGN TO "meseros.csv".

       DATA DIVISION.
       FILE SECTION.

       FD platillo-pedido-file.
       01 platillo-pedido-record.
          05 id-platillo-pedido     PIC 9(5).
          05 id-platillo            PIC 9(5).
          05 cantidad               PIC 9(5).

       FD pedidos-file.
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
       01 pagos-record.
          05 id-pago                PIC 9(5).
          05 tipo-de-pago           PIC X(10).

       FD clientes-file.
       01 clientes-record.
          05 id-cliente             PIC 9(5).
          05 nombre                 PIC X(30).
          05 telefono               PIC X(14).
          05 direccion-cliente      PIC X(30).

       FD carta-file.
       01 carta-record.
          05 id-carta               PIC 9(5).
          05 tipo                   PIC X(20).

       FD platillos-file.
       01 platillos-record.
          05 id-platillo            PIC 9(5).
          05 nombre                 PIC X(20).
          05 descripcion            PIC X(30).
          05 id-carta               PIC 9(5).
          05 precio-unitario        PIC 9(5)V99.

       FD mesas-file.
       01 mesas-record.
          05 id-mesa                PIC 9(5).
          05 id-mesero              PIC 9(5).
          05 cantidad               PIC 9(5).

       FD meseros-file.
       01 meseros-record.
          05 id-mesero              PIC 9(5).
          05 cedula                 PIC X(8).
          05 nombre                 PIC X(20).
          05 apellido               PIC X(20).

       WORKING-STORAGE SECTION.

       01 EOF PIC S9(4) VALUE -1.

          01 WS-FECHA           PIC X(10).
          01 WS-OPCION          PIC 99.
          01 WS-CARTA-TIPOS.
             05 WS-CARTA-TIPO OCCURS 7 TIMES.
                10 ID-CARTA-TIPO           PIC 9(5).
                10 TIPO-DE-PLATILLO        PIC X(20).
          01 WS-PLATILLOS.
             05 WS-PLATILLO OCCURS 6 TIMES.
                10 ID-PLATILLO             PIC 9(5).
                10 NOMBRE                  PIC X(20).
                10 DESCRIPCION             PIC X(30).
                10 ID-CARTA                PIC 9(5).
                10 PRECIO-UNITARIO         PIC 9(5)V99.
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
             05 WS-PEDIDO OCCURS 1 TO 100 TIMES.
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

      *Inicio del Menu Principal
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
      *Final del Menu Principal

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

       VER-TIPOS-PLATILLOS.
          DISPLAY "==============================="
          DISPLAY "       TIPOS DE PLATILLOS"
          DISPLAY "==============================="
          PERFORM LEER-TIPOS-PLATILLOS
          IF EOF = 0
              DISPLAY "ID       TIPO DE PLATILLO"
              DISPLAY "==============================="
              PERFORM HASTA-LEER-TODOS-TIPOS-PLATILLOS
          ELSE
              DISPLAY "No hay tipos de platillos registrados."
          END-IF
          DISPLAY "===============================".

       LEER-TIPOS-PLATILLOS.
          OPEN INPUT carta-file
          READ carta-file
          AT END
              SET EOF TO 1
          END-READ.

       HASTA-LEER-TODOS-TIPOS-PLATILLOS.
          DISPLAY ID-CARTA-TIPO "    " TIPO-DE-PLATILLO
          READ carta-file
          AT END
              SET EOF TO 1
          END-READ.
          IF EOF = 0
              PERFORM HASTA-LEER-TODOS-TIPOS-PLATILLOS
          END-IF.
          CLOSE carta-file.

       AGREGAR-TIPO-PLATILLO.
          DISPLAY "==============================="
          DISPLAY "AGREGAR NUEVO TIPO DE PLATILLO"
          DISPLAY "==============================="
          DISPLAY "Ingrese el nuevo tipo de platillo:"
          ACCEPT TIPO-DE-PLATILLO
          COMPUTE ID-CARTA-TIPO = FUNCTION MAX(ID-CARTA-TIPO) + 1
          WRITE carta-file
              FROM ID-CARTA-TIPO, TIPO-DE-PLATILLO
          DISPLAY "Tipo de platillo agregado exitosamente."
          DISPLAY "===============================".

       MODIFICAR-TIPO-PLATILLO.
          DISPLAY "==============================="
          DISPLAY "   MODIFICAR TIPO DE PLATILLO"
          DISPLAY "==============================="
          DISPLAY "Ingrese el ID del tipo de platillo a modificar:"
          ACCEPT ID-CARTA-TIPO
          PERFORM BUSCAR-TIPO-PLATILLO
          IF EOF = 0
              DISPLAY "Ingrese el nuevo tipo de platillo:"
              ACCEPT TIPO-DE-PLATILLO
              REWRITE carta.csv
                  FROM ID-CARTA-TIPO, TIPO-DE-PLATILLO
              DISPLAY "Tipo de platillo modificado exitosamente."
          ELSE
        DISPLAY "No se encontró el tipo de platillo con el ID ingresado."
          END-IF.
          DISPLAY "===============================".

       ELIMINAR-TIPO-PLATILLO.
          DISPLAY "==============================="
          DISPLAY "   ELIMINAR TIPO DE PLATILLO"
          DISPLAY "==============================="
          DISPLAY "Ingrese el ID del tipo de platillo a eliminar:"
          ACCEPT ID-CARTA-TIPO
          PERFORM BUSCAR-TIPO-PLATILLO
          IF EOF = 0
              DELETE carta.csv
              DISPLAY "Tipo de platillo eliminado exitosamente."
          ELSE
        DISPLAY "No se encontró el tipo de platillo con el ID ingresado."
          END-IF.
          DISPLAY "===============================".
      *Fin de Menu Carta

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

       AGREGAR-PLATILLO.
          DISPLAY "====================================="
          DISPLAY "    RESTAURANTE - AGREGAR PLATILLO"
          DISPLAY "====================================="
          DISPLAY "Ingrese los siguientes datos:"
          ACCEPT WS-PLATILLO-AGREGAR-ID
          DISPLAY "Nombre:"
          ACCEPT WS-PLATILLO-AGREGAR-NOMBRE
          DISPLAY "Descripción:"
          ACCEPT WS-PLATILLO-AGREGAR-DESCRIPCION
          DISPLAY "Tipo de platillo:"
          ACCEPT WS-PLATILLO-AGREGAR-TIPO
          DISPLAY "Precio unitario:"
          ACCEPT WS-PLATILLO-AGREGAR-PRECIO
          PERFORM AGREGAR-PLATILLO-CSV
          DISPLAY "Platillo agregado exitosamente."
          PERFORM MENU-PLATILLOS.

       MODIFICAR-PLATILLO.
          DISPLAY "====================================="
          DISPLAY "  RESTAURANTE - MODIFICAR PLATILLO"
          DISPLAY "====================================="
          DISPLAY "Ingrese el ID del platillo a modificar:"
          ACCEPT WS-PLATILLO-MODIFICAR-ID
          PERFORM BUSCAR-PLATILLO-ID
          IF WS-PLATILLO-ENCONTRADO = "SI"
              DISPLAY "Ingrese los nuevos datos del platillo:"
              DISPLAY "Nombre:"
              ACCEPT WS-PLATILLO-AGREGAR-NOMBRE
              DISPLAY "Descripción:"
              ACCEPT WS-PLATILLO-AGREGAR-DESCRIPCION
              DISPLAY "Tipo de platillo:"
              ACCEPT WS-PLATILLO-AGREGAR-TIPO
              DISPLAY "Precio unitario:"
              ACCEPT WS-PLATILLO-AGREGAR-PRECIO
              PERFORM MODIFICAR-PLATILLO-CSV
              DISPLAY "Platillo modificado exitosamente."
          ELSE
              DISPLAY "No se encontró ningún platillo con ese ID. ",
       - "Intente de nuevo."
          END-IF
       PERFORM MENU-PLATILLOS.

       ELIMINAR-PLATILLO.
          DISPLAY "Ingrese el ID del platillo que desea eliminar:"
          ACCEPT ID-PLATILLO
          PERFORM BUSCAR-PLATILLO
          IF FOUND-PLATILLO
              DISPLAY "Esta seguro que desea eliminar el platillo (S/N)?"
              ACCEPT CONFIRMACION
              IF CONFIRMACION = "S" OR CONFIRMACION = "s",
                  PERFORM ELIMINAR-PLATILLO-ARCHIVO,
                  DISPLAY "Platillo eliminado exitosamente."
              END-IF
          ELSE
              DISPLAY "No se encontro el platillo con el ID ingresado."
          END-IF.

       LISTAR-PLATILLOS.
          PERFORM LEER-ARCHIVO-PLATILLOS
          DISPLAY "ID      ",
          "NOMBRE                ",
          "DESCRIPCION           ",
          "TIPO DE PLATILLO      ",
          "PRECIO".
          DISPLAY "----------------------------------",
       -"----------------------------------------------".
          PERFORM VARYING I FROM 1 BY 1 UNTIL I > EOF
              DISPLAY ID-PLATILLO(I),
              "   ",
              NOMBRE(I),
              " ",
              DESCRIPCION(I),
              " ",
              TIPO-DE-PLATILLO(I)
              " ",
              PRECIO-UNITARIO(I).
          END-PERFORM.

       LISTAR-PLATILLOS-POR-TIPO.
          DISPLAY "Ingrese el tipo de platillo que desea buscar:"
          ACCEPT TIPO-BUSQUEDA
          PERFORM LEER-ARCHIVO-PLATILLOS
          DISPLAY "ID      ",
          "NOMBRE                ",
          "DESCRIPCION           ",
          "TIPO DE PLATILLO      ",
          "PRECIO".
          DISPLAY "----------------------------------",
          "----------------------------------------------".
          PERFORM VARYING I FROM 1 BY 1 UNTIL I > EOF
        IF TIPO-DE-PLATILLO(I) = TIPO-BUSQUEDA
              DISPLAY ID-PLATILLO(I),
              "   ",
              NOMBRE(I),
              " ",
              DESCRIPCION(I),
              " ",
              TIPO-DE-PLATILLO(I)
              " ",
              PRECIO-UNITARIO(I).
              END-IF
          END-PERFORM.

       VOLVER-MENU-PLATILLOS.
          DISPLAY "Presione cualquier tecla ",
          "para volver al menu de platillos."
          ACCEPT TECLA
          PERFORM MENU-PLATILLOS.

       BUSCAR-PLATILLO.
          SET FOUND-PLATILLO TO FALSE
          PERFORM LEER-ARCHIVO-PL
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

          AGREGAR-MESERO.
              DISPLAY "==============================="
              DISPLAY "          AGREGAR MESERO"
              DISPLAY "==============================="
              ACCEPT WS-CEDULA-MESERO
              IF VALIDAR-CEDULA-MESERO(WS-CEDULA-MESERO) = TRUE
            DISPLAY "La cédula ingresada ya está registrada.",
            " Intente de nuevo.".
                  GO TO AGREGAR-MESERO
              END-IF
              ACCEPT WS-NOMBRE-MESERO
              ACCEPT WS-APELLIDO-MESERO
              SET WS-ID-MESERO TO WS-ID-MESERO + 1
        MOVE WS-CEDULA-MESERO TO WS-MESEROS(WS-ID-MESERO).CEDULA
        MOVE WS-NOMBRE-MESERO TO WS-MESEROS(WS-ID-MESERO).NOMBRE
        MOVE WS-APELLIDO-MESERO TO WS-MESEROS(WS-ID-MESERO).APELLIDO
              DISPLAY "Mesero agregado exitosamente."
              PERFORM CONFIRMAR-VOLVER

       MODIFICAR-MESERO.
          DISPLAY "Ingrese la cédula del mesero que desea modificar: "
          ACCEPT ID-MESERO-MOD
          PERFORM BUSCAR-MESERO
          IF WS-ENCONTRADO = "S"
              DISPLAY "==============================="
              DISPLAY "       DATOS DEL MESERO"
              DISPLAY "==============================="
              DISPLAY "Cédula: " ID-MESERO
              DISPLAY "Nombre: " NOMBRE-MESERO
              DISPLAY "Apellido: " APELLIDO-MESERO
              DISPLAY "Teléfono: " TELEFONO-MESERO
              DISPLAY "¿Desea modificar el nombre? (S/N)"
              ACCEPT RESPUESTA
              IF RESPUESTA = "S"
                  DISPLAY "Ingrese el nuevo nombre: "
                  ACCEPT NOMBRE-MESERO
              END-IF
              DISPLAY "¿Desea modificar el apellido? (S/N)"
              ACCEPT RESPUESTA
              IF RESPUESTA = "S"
                  DISPLAY "Ingrese el nuevo apellido: "
                  ACCEPT APELLIDO-MESERO
              END-IF
              DISPLAY "¿Desea modificar el teléfono? (S/N)"
              ACCEPT RESPUESTA
              IF RESPUESTA = "S"
                  DISPLAY "Ingrese el nuevo teléfono: "
                  ACCEPT TELEFONO-MESERO
              END-IF
              PERFORM ACTUALIZAR-MESERO
          ELSE
              DISPLAY "El mesero no se encuentra registrado."
          END-IF. 
      *Fin Menu Meseros (Rutina 3)

      *Menu Meseros (Rutina 4)
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

       INGRESAR-MESA.
         DISPLAY "==============================="
         DISPLAY "     INGRESO DE NUEVA MESA"
         DISPLAY "==============================="
         ACCEPT WS-MESA-ID
         IF WS-MESA-ID = 0
            PERFORM MENU-MESAS
         END-IF
         ACCEPT WS-MESERO-ID
         ACCEPT WS-MESA-CANTIDAD
         PERFORM GUARDAR-MESA
         DISPLAY "Mesa ingresada exitosamente."
         PERFORM MENU-MESAS.

       MODIFICAR-MESA.
         DISPLAY "==============================="
         DISPLAY "MODIFICACIÓN DE MESA EXISTENTE"
         DISPLAY "==============================="
         DISPLAY "Ingrese el ID de la mesa a modificar:"
         ACCEPT WS-MESA-ID
         IF WS-MESA-ID = 0
            PERFORM MENU-MESAS
         END-IF
         PERFORM BUSCAR-MESA
         IF WS-ENCONTRADO = "S"
            DISPLAY "Ingrese los nuevos datos de la mesa:"
            ACCEPT WS-MESERO-ID
            ACCEPT WS-MESA-CANTIDAD
            PERFORM ACTUALIZAR-MESA
            DISPLAY "Mesa modificada exitosamente."
         ELSE
            DISPLAY "No se encontró la mesa con el ID ingresado."
         END-IF
         PERFORM MENU-MESAS.

       BUSCAR-MESA.
         SET WS-ENCONTRADO TO "N"
         PERFORM VACIAR-WS-MESA
         PERFORM LEER-MESAS
            IF WS-MESA-ID = WS-BUSQUEDA-ID
               SET WS-ENCONTRADO TO "S"
               MOVE WS-MESA-ID TO WS-MESA-ID-ANTERIOR
               MOVE WS-MESERO-ID TO WS-MESA-MESERO-ID
               MOVE WS-MESA-CANTIDAD TO WS-MESA-CANTIDAD-ANTERIOR
            END-IF
         END-PERFORM.

       ACTUALIZAR-MESA.
         PERFORM VACIAR-WS-MESA-TEMP
         PERFORM LEER-MESAS
            IF WS-MESA-ID = WS-BUSQUEDA-ID
               MOVE WS-MESA-ID TO WS-MESA-ID-ANTERIOR
               MOVE WS-MESERO-ID TO WS-MESA-MESERO-ID
               MOVE WS-MESA-CANTIDAD TO WS-MESA-CANTIDAD-ANTERIOR
               PERFORM GUARDAR-MESA-TEMP
            ELSE
               PERFORM GUARDAR-MESA-TEMP
            END-IF
         END-PERFORM.

       VACIAR-WS-MESA.
         MOVE 0 TO WS-MESA-ID
         MOVE 0 TO WS-MESERO-ID
         MOVE 0 TO WS-MESA-CANTIDAD
      *Fin Menu Meseros (Rutina 4)
      
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

       INGRESAR-PEDIDO.
          DISPLAY "==============================="
          DISPLAY "RESTAURANTE - INGRESO DE PEDIDO"
          DISPLAY "==============================="
          ACCEPT WS-PEDIDO(ID-PEDIDO)
          IF WS-PEDIDO(ID-PEDIDO) = 0
              CONTINUE
          END-IF
          DISPLAY "ID del cliente: "
          ACCEPT WS-PEDIDO(ID-PEDIDO, ID-CLIENTE)
          DISPLAY "ID de la mesa: "
          ACCEPT WS-PEDIDO(ID-PEDIDO, ID-MESA)
          DISPLAY "ID del mesero: "
          ACCEPT WS-PEDIDO(ID-PEDIDO, ID-MESERO)
          DISPLAY "ID del platillo: "
          ACCEPT WS-PEDIDO(ID-PEDIDO, ID-PLATILLO-PEDIDO)
          DISPLAY "ID del pago: "
          ACCEPT WS-PEDIDO(ID-PEDIDO, ID-PAGO)
          DISPLAY "Propina: "
          ACCEPT WS-PEDIDO(ID-PEDIDO, PROPINA)
          DISPLAY "Importe: "
          ACCEPT WS-PEDIDO(ID-PEDIDO, IMPORTE)
          DISPLAY "Enviado (s/n): "
          ACCEPT WS-PEDIDO(ID-PEDIDO, ENVIADO)
          DISPLAY "Fecha (YYYY-MM-DD): "
          ACCEPT WS-PEDIDO(ID-PEDIDO, FECHA)
          DISPLAY "Hora (HH:MM:SS): "
          ACCEPT WS-PEDIDO(ID-PEDIDO, HORA)
          DISPLAY "Pedido ingresado correctamente."
          GOBACK.
          
       MODIFICAR-PEDIDO.
          PERFORM UNTIL WS-OPCION = 0
              DISPLAY "==============================="
              DISPLAY "MODIFICAR PEDIDO"
              DISPLAY "==============================="
              DISPLAY "Ingrese el ID del pedido que ",
              -"desea modificar (0 para salir):"
        ACCEPT WS-ID-PEDIDO
        IF WS-ID-PEDIDO = 0
            EXIT PERFORM
        END-IF
        COMPUTE WS-INDICE-PEDIDO = 
        FUNCTION MOD(WS-ID-PEDIDO - 1, 100) + 1
        IF WS-PEDIDO(WS-INDICE-PEDIDO:ID-PEDIDO) = 0
            DISPLAY "El ID del pedido no existe. Intente de nuevo."
        ELSE
            DISPLAY "Pedido actual:"
            DISPLAY "ID Pedido: " WS-PEDIDO(WS-INDICE-PEDIDO:ID-PEDIDO)
            DISPLAY "ID Cliente: " WS-PEDIDO(WS-INDICE-PEDIDO:ID-CLIENTE)
            DISPLAY "ID Mesa: " WS-PEDIDO(WS-INDICE-PEDIDO:ID-MESA)
            DISPLAY "ID Mesero: " WS-PEDIDO(WS-INDICE-PEDIDO:ID-MESERO)
            DISPLAY "ID Platillo Pedido: ",
            WS-PEDIDO(WS-INDICE-PEDIDO:ID-PLATILLO-PEDIDO)
            DISPLAY "ID Pago: " WS-PEDIDO(WS-INDICE-PEDIDO:ID-PAGO)
            DISPLAY "Propina: " WS-PEDIDO(WS-INDICE-PEDIDO:PROPINA)
            DISPLAY "Importe: " WS-PEDIDO(WS-INDICE-PEDIDO:IMPORTE)
            DISPLAY "Enviado: " WS-PEDIDO(WS-INDICE-PEDIDO:ENVIADO)
            DISPLAY "Fecha: " WS-PEDIDO(WS-INDICE-PEDIDO:FECHA)
            DISPLAY "Hora: " WS-PEDIDO(WS-INDICE-PEDIDO:HORA)
            DISPLAY "==============================="
            DISPLAY "Ingrese el nuevo valor para cada campo ",
            -"(dejar vacío para no modificar):"
            DISPLAY "ID Cliente: " WS-PEDIDO(WS-INDICE-PEDIDO:ID-CLIENTE)
            ACCEPT WS-NUEVO-ID-CLIENTE
            IF WS-NUEVO-ID-CLIENTE NOT = ""
                MOVE WS-NUEVO-ID-CLIENTE TO 
                WS-PEDIDO(WS-INDICE-PEDIDO:ID-CLIENTE)
            END-IF
            DISPLAY "ID Mesa: " WS-PEDIDO(WS-INDICE-PEDIDO:ID-MESA)
            ACCEPT WS-NUEVO-ID-MESA
            IF WS-NUEVO-ID-MESA NOT = ""
                MOVE WS-NUEVO-ID-MESA TO 
                WS-PEDIDO(WS-INDICE-PEDIDO:ID-MESA)
            END-IF
            DISPLAY "ID Mesero: " WS-PEDIDO(WS-INDICE-PEDIDO:ID-MESERO)
            ACCEPT WS-NUEVO-ID-MESERO
            IF WS-NUEVO-ID-MESERO NOT = ""
         MOVE WS-NUEVO-ID-MESERO TO WS-PEDIDO(WS-INDICE-PEDIDO:ID-MESERO)
            END-IF
            DISPLAY "ID Platillo Pedido: " 
            WS-PEDIDO(WS-INDICE-PEDIDO:ID-PLATILLO-PEDIDO)
            ACCEPT

       ELIMINAR-PEDIDO.
         DISPLAY "==============================="
         DISPLAY "ELIMINAR PEDIDO"
         DISPLAY "==============================="
         DISPLAY "Ingrese el ID del pedido a eliminar ",
         "(0 para volver al menú principal):".
         ACCEPT WS-ID-PEDIDO-ELIMINAR
         IF WS-ID-PEDIDO-ELIMINAR = 0
             EXIT
         END-IF
         PERFORM BUSCAR-PEDIDO-ELIMINAR
         IF WS-ENCONTRADO
             DISPLAY "Pedido eliminado exitosamente."
         ELSE
       DISPLAY "No se encontró el pedido con ID " WS-ID-PEDIDO-ELIMINAR
         END-IF
       GO TO MENU-PRINCIPAL.
      *Fin Registro Pedidos (Rutina 5)

      *Registro Pedidos (Rutina 5)
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

       CONSULTA-PLATILLOS.
          DISPLAY "==============================="
          DISPLAY "RESTAURANTE - CONSULTA DE PLATILLOS"
          DISPLAY "==============================="
          DISPLAY "Tipos de platillos disponibles:"
    
          PERFORM VARYING WS-CARTA-TIPO-INDEX FROM 1 BY 1
              UNTIL WS-CARTA-TIPO(WS-CARTA-TIPO-INDEX) = ''
              DISPLAY WS-CARTA-TIPO-INDEX, ". ",
              WS-CARTA-TIPO(WS-CARTA-TIPO-INDEX)
          END-PERFORM
    
          ACCEPT WS-OPCION
          IF WS-OPCION = 0
              GO TO MENU-PRINCIPAL
          END-IF
    
          PERFORM VARYING WS-PLATILLO-INDEX FROM 1 BY 1
              UNTIL WS-PLATILLOS(WS-PLATILLO-INDEX).ID-PLATILLO = 0
              IF WS-PLATILLOS(WS-PLATILLO-INDEX).ID-CARTA = 
              WS-CARTA-TIPO(WS-OPCION)
                  DISPLAY WS-PLATILLOS(WS-PLATILLO-INDEX).ID-PLATILLO,
                  ". ", WS-PLATILLOS(WS-PLATILLO-INDEX).NOMBRE,
                          " - $",
                          WS-PLATILLOS(WS-PLATILLO-INDEX).PRECIO-UNITARIO
              END-IF
          END-PERFORM
    
          PERFORM CONSULTA-PLATILLOS UNTIL WS-OPCION = 0
          GOBACK.
          
       CONSULTA-MESEROS.
          DISPLAY "==================================="
          DISPLAY "CONSULTA DE MESEROS"
          DISPLAY "==================================="
          PERFORM VACIAR-DATOS
          READ MESEROS.CSV
              AT END SET EOF TO 0
              NOT AT END
                  MOVE ID-MESERO TO WS-MESERO(I)
                  MOVE CEDULA TO WS-CEDULA(I)
                  MOVE NOMBRE TO WS-NOMBRE(I)
                  MOVE APELLIDO TO WS-APELLIDO(I)
                  ADD 1 TO I
              END-READ
          END-READ
          PERFORM MOSTRAR-MESEROS
          DISPLAY "Presione cualquier tecla ",
          "para volver al Menú Principal"
          ACCEPT WS-OPCION
          PERFORM VACIAR-DATOS
          DISPLAY "==================================="

       VACIAR-DATOS.
          PERFORM VARYING I FROM 1 BY 1 UNTIL I > 6
              MOVE SPACES TO WS-CEDULA(I)
              MOVE SPACES TO WS-NOMBRE(I)
              MOVE SPACES TO WS-APELLIDO(I)
          END-PERFORM
          MOVE 1 TO I
          MOVE -1 TO EOF.

       MOSTRAR-MESEROS.
          DISPLAY "ID     Cédula       Nombre          Apellido"
          DISPLAY "==========================================="
          PERFORM VARYING I FROM 1 BY 1 UNTIL I > 6
              IF WS-CEDULA(I) = SPACES
                  EXIT PERFORM
              END-IF
              DISPLAY ID-MESERO(I),
              WS-CEDULA(I),
              WS-NOMBRE(I),
              WS-APELLIDO(I)
          END-PERFORM.
    
       CONSULTA-MESAS.
          DISPLAY "==================================="
          DISPLAY "CONSULTA DE MESAS"
          DISPLAY "==================================="
          DISPLAY "Ingresa el ID de la mesa que deseas consultar:"
          ACCEPT WS-ID-MESA
          PERFORM VALIDAR-EXISTENCIA-MESA
          IF WS-MESA-ENCONTRADA
              DISPLAY "La mesa con ID ",
              WS-ID-MESA,
              " está ocupada por el mesero con ID ", WS-ID-MESERO.
          ELSE
        DISPLAY "La mesa con ID ",
        WS-ID-MESA,
        " está libre."
          END-IF
          DISPLAY "Presiona enter para volver al menú principal."
          ACCEPT WS-ENTER
          DISPLAY " "
          DISPLAY " "
          EXIT.

       VALIDAR-EXISTENCIA-MESA.
          SET WS-MESA-ENCONTRADA TO FALSE
          PERFORM VINCULAR-MESAS-MESEROS
          PERFORM BUSCAR-MESA
          IF WS-MESA-ENCONTRADA
              PERFORM BUSCAR-MESERO
          END-IF.

       VINCULAR-MESAS-MESEROS.
          PERFORM LEER-ARCHIVO "mesas.csv"
          PERFORM LEER-ARCHIVO "meseros.csv"
          PERFORM VINCULAR-MESA-MESERO UNTIL EOF = 0.

       VINCULAR-MESA-MESERO.
          IF WS-ID-MESA = WS-MESA(ID-MESA)
          AND WS-MESA(ID-MESERO) = WS-MESERO(ID-MESERO)
              SET WS-MESA-ENCONTRADA TO TRUE
              SET WS-ID-MESERO TO WS-MESERO(ID-MESERO)
          END-IF
          IF EOF = 0
              SET WS-MESA-ENCONTRADA TO FALSE
          END-IF
          PERFORM LEER-SIGUIENTE-REGISTRO.

       BUSCAR-MESA.
          PERFORM LEER-ARCHIVO "pedidos.csv"
          PERFORM BUSCAR-MESA-EN-PEDIDOS UNTIL EOF = 0.

       BUSCAR-MESA-EN-PEDIDOS.
          IF WS-ID-MESA = WS-PEDIDO(ID-MESA) AND WS-PEDIDO(ENVIADO) = "n"
              SET WS-MESA-ENCONTRADA TO TRUE
              EXIT PERFORM
          END-IF
          IF EOF = 0
              SET WS-MESA-ENCONTRADA TO FALSE
          END-IF
          PERFORM LEER-SIGUIENTE-REGISTRO.

       BUSCAR-MESERO.
          PERFORM LEER-ARCHIVO "meseros.csv"
          PERFORM BUSCAR-MESERO-POR-ID UNTIL EOF = 0.

       BUSCAR-MESERO-POR-ID.
          IF WS-ID-MESERO = WS-MESERO(ID-MESERO)
              EXIT PERFORM
           END-IF
          IF EOF = 0
              DISPLAY "No se encontró al mesero asignado a la mesa."
          END-IF
          PERFORM LEER-SIGUIENTE-REGISTRO.
      *Fin Registro Pedidos (Rutina 5)
       STOP RUN.

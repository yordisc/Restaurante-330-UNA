       *>  *************************************************************
       *>  UNIVERSIDAD NACIONAL ABIERTA                                *
       *>  TRABAJO PRÁCTICO                                            *
       *>  ASIGNATURA: PROCESAMIENTO DE DATOS                         *
       *>  CÓDIGO: 330                                                 *
       *>  COMPILADO CON GnuCOBOL VERSIÓN (3.1.2.0)  GNU/LINUX         *
       *>  EDITOR DE CÓDIGO: VISUAL STUDIO CODE                        *
       *> **************************************************************
       *>  PARA COMPILAR DEBE INSTALAR gnucobol                        *
       *>  y ejecutar: cobc -O restaurante.cbl -x -o main
       *>  -------------------------------------------------------------
       IDENTIFICATION DIVISION.
       PROGRAM-ID. RESTAURANTE.
       AUTHOR. GITHUB.COM/YORDISC/Restaurante-330-UNA.
       DATE-WRITTEN. [22-04-2023].
       DATE-COMPILED. [22-04-2023].
       *>  -------------------------------------------------------------
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
       *>  ASIGNACIÓN DE LOS ARCHIVOS LÓGICOS AL ARCHIVO FÍSICO:
       *>  ARCHIVO PARA LA CARTA DEL RESTAURANTE
           SELECT F-ARCHIVO-CARTA
               ASSIGN TO 'CARTA.TXT'
               ORGANIZATION IS INDEXED
               RECORD KEY IS RC-CODIGO
               ACCESS MODE IS DYNAMIC
               FILE STATUS IS FS-STATUS-CARTA.
       *>  ARCHIVO PARA LOS PLATILLOS
           SELECT F-ARCHIVO-PLATILLOS
               ASSIGN TO 'PLATILLOS.TXT'
               ORGANIZATION IS INDEXED
               RECORD KEY IS RP-CODIGO
               ACCESS MODE IS DYNAMIC
               FILE STATUS IS FS-STATUS-PLATILLOS.
       *>  ARCHIVO PARA EL LISTADO DE MESEROS
           SELECT F-ARCHIVO-MESEROS 
               ASSIGN TO 'MESEROS.TXT'
               ORGANIZATION IS INDEXED
               RECORD KEY IS RM-CEDULA
               ACCESS MODE IS DYNAMIC
               FILE STATUS IS FS-STATUS-MESEROS.
       *>  ARCHIVO PARA LAS MESAS
           SELECT F-ARCHIVO-MESAS
               ASSIGN TO 'MESAS.TXT'
               ORGANIZATION IS INDEXED
               RECORD KEY IS RME-NUMERO
               ACCESS MODE IS DYNAMIC
               FILE STATUS IS FS-STATUS-MESAS.
       *>  ARCHIVO PARA LAS MESAS
           SELECT F-ARCHIVO-PEDIDOS
               ASSIGN TO 'PEDIDOS.TXT'
               ORGANIZATION IS INDEXED
               RECORD KEY IS RPE-NUMERO
               ACCESS MODE IS DYNAMIC
               FILE STATUS IS FS-STATUS-PEDIDOS.
       *>  -------------------------------------------------------------
       DATA DIVISION.
       FILE SECTION.
       *>  REGISTRO PARA ARCHIVO CARTA
       FD  F-ARCHIVO-CARTA.
       01  REG-CARTA.
           02 RC-CODIGO         PIC X(15).
           02 RC-DESAYUNOS      PIC X(250).
           02 RC-ENTRADAS       PIC X(250).
           02 RC-ENSALADAS      PIC X(250).
           02 RC-CONTORNOS      PIC X(250).
           02 RC-CARNES         PIC X(250).
           02 RC-PESCADOS-MARISCOS PIC X(250).
           02 RC-BEBIDAS        PIC X(250).
       *>  REGISTRO PARA EL ARCHIVO PLATILLOS
       FD  F-ARCHIVO-PLATILLOS.
       01  REG-PLATILLOS.
           02 RP-CODIGO              PIC X(15).
           02 RP-DESCRIPCION         PIC X(100).
           02 RP-TIPO                PIC X(30).
       *>  REGISTRO PARA ARCHIVO MESEROS
       FD  F-ARCHIVO-MESEROS.
       01  REG-MESEROS.
           02 RM-NOMBRE-APELLIDO      PIC X(50).
           02 RM-CEDULA               PIC X(15).
       *>  REGISTRO PARA EL ARCHIVO MESAS
       FD  F-ARCHIVO-MESAS.
       01  REG-MESAS.
           02 RME-NUMERO            PIC X(4).
           02 RME-MESERO            PIC X(15).
       *>  REGISTRO PARA EL ARCHIVO PEDIDOS
       FD  F-ARCHIVO-PEDIDOS.
       01  REG-PEDIDOS.
           02 RPE-NUMERO              PIC 9(15).
           02 RPE-MESA                PIC X(4).
           02 RPE-MESERO              PIC X(15).
           02 RPE-DESCRIPCION         PIC X(100).
           02 RPE-CANTIDAD            PIC 9(5).
           02 RPE-PRECIO-UNITARIO     PIC 9(6)V99.
           02 RPE-TIPO-PAGO           PIC X(20).
           02 RPE-IMPORTE             PIC 9(6)V99.
           02 RPE-PROPINA             PIC 9(6)V99.
           02 RPE-ENVIADO             PIC X(1).
           02 RPE-FECHA.
                03 RPE-DIA           PIC 9(02).
                03 RPE-MES           PIC 9(02).
                03 RPE-ANNO          PIC 9(04).
       *>  -------------------------------------------------------------
       WORKING-STORAGE SECTION.
       *>  ESTRUCTURA PARA EL REGISTRO DE LA CARTA DEL RESTAURANTE
       01  WS-ENT-CARTA.
           02 WS-CARTA-CODIGO         PIC X(15).
           02 WS-CARTA-DESAYUNOS      PIC X(250).
           02 WS-CARTA-ENTRADAS       PIC X(250).
           02 WS-CARTA-ENSALADAS      PIC X(250).
           02 WS-CARTA-CONTORNOS      PIC X(250).
           02 WS-CARTA-CARNES         PIC X(250).
           02 WS-CARTA-PESCADOS-MARISCOS PIC X(250).
           02 WS-CARTA-BEBIDAS        PIC X(250).
       *>  ESTRUCTURA PARA EL REGISTRO DE LOS PLATILLOS
       01  WS-ENT-PLATILLOS.
           02 WS-PLATILLOS-CODIGO         PIC X(15).
           02 WS-PLATILLOS-DESCRIPCION    PIC X(100).
           02 WS-PLATILLOS-TIPO           PIC X(30).
       *>  ESTRUCTURA PARA EL REGISTRO DE MESEROS
       01  WS-ENT-MESEROS.
           02 WS-MESEROS-NOMBRE-APELLIDO    PIC X(50).
           02 WS-MESEROS-CEDULA             PIC X(15).
       *>  ESTRUCTURA PARA EL REGISTRO DE LAS MESAS
       01  WS-ENT-MESAS.
           02 WS-MESAS-NUMERO            PIC X(4).
           02 WS-MESAS-MESERO            PIC X(15).
       *>  ESTRUCTURA PARA EL REGISTRO DE LOS PEDIDOS    
       01  WS-ENT-PEDIDOS.
           02 WS-PEDIDOS-NUMERO              PIC 9(15).
           02 WS-PEDIDOS-MESA                PIC X(4).
           02 WS-PEDIDOS-MESERO              PIC X(15).
           02 WS-PEDIDOS-DESCRIPCION         PIC X(100).
           02 WS-PEDIDOS-CANTIDAD            PIC 9(5).
           02 WS-PEDIDOS-PRECIO-UNITARIO     PIC 9(6)V99.
           02 WS-PEDIDOS-TIPO-PAGO           PIC X(20).
           02 WS-PEDIDOS-IMPORTE             PIC 9(6)V99.
           02 WS-PEDIDOS-PROPINA             PIC 9(6)V99.
           02 WS-PEDIDOS-ENVIADO             PIC X(1).
           02 WS-PEDIDOS-FECHA.
                03 WS-PEDIDOS-DIA           PIC 9(02).
                03 WS-PEDIDOS-MES           PIC 9(02).
                03 WS-PEDIDOS-ANNO          PIC 9(04).
       *>  -------------------------------------------------------------
       *>  VARIABLES PARA MANEJO DE LOS ESTADOS EN I-O DE LOS ARCHIVOS
       77  FS-STATUS-CARTA            PIC X(2).
       77  FS-STATUS-PLATILLOS        PIC X(2).
       77  FS-STATUS-MESEROS          PIC X(2).
       77  FS-STATUS-MESAS            PIC X(2).
       77  FS-STATUS-PEDIDOS          PIC X(2).
       *>  -------------------------------------------------------------    
       *>  VARIABLES DE USO GENERAL
       77  WS-FIN                      PIC 9(01) VALUE ZERO.
       77  WS-OPCION                   PIC 9(01).
       77  WS-FIN-SUBMENU              PIC 9(01) VALUE ZERO.
       77  WS-OPCION-SUBMENU           PIC 9(01).
       77  WS-CONSULTA                 PIC 9(01) VALUE ZERO.
       77  WS-FIN-ARCHIVO              PIC 9(01) VALUE ZERO.
       77  WS-ENCONTRADO               PIC 9(01) VALUE ZERO.
       77  WS-CONTADOR                 PIC 9(15) VALUE 1.
       77  WS-TIPO-PEDIDO              PIC 9(01) VALUE ZERO.
       77  WS-TOTAL-PAGO               PIC 9(9)V99 VALUE 0.00.
       77  EOF-IN                      PIC X(1) VALUE 'N'.
       77  WS-PEDIDOS-CREADO           PIC 9(01) VALUE ZERO.
       *>  -------------------------------------------------------------
       *> MANEJO DE FECHA
       77 WS-FECHA-SISTEMA            PIC 9(06).
       01 WS-FECHA-FORMATO.
                02 WS-FECHA-ANNO           PIC 9(02).
                02 WS-FECHA-MES            PIC 9(02).
                02 WS-FECHA-DIA            PIC 9(02).
       77 WS-ANNO-EXTENDIDO           PIC 9(04).
       *>  -------------------------------------------------------------
       PROCEDURE DIVISION.
       *>  -------------------------------------------------------------
       *>  FUNCIÓN PRINCIPAL DEL SISTEMA
       *>  -------------------------------------------------------------
       MAIN-PROGRAM.
           MOVE 0 TO WS-FIN

           PERFORM 000-MENU-PRINCIPAL UNTIL WS-FIN = 1.

           DISPLAY "CERRANDO: SISTEMA RESTAURANTE..."
           STOP RUN.
       *>  -------------------------------------------------------------
       *>  FUNCIÓN PARA IMPRIMIR EL MENÚ PRINCIPAL DEL SISTEMA
       *>  -------------------------------------------------------------
       000-MENU-PRINCIPAL.
           DISPLAY "+++++++++++++++++++++++++++++++++++++++++".
           DISPLAY "SISTEMA PARA EL CONTROL DEL RESTAURANTE +".
           DISPLAY "+++++++++++++++++++++++++++++++++++++++++".

           MOVE 0 TO WS-FIN-SUBMENU

           ACCEPT WS-FECHA-SISTEMA FROM DATE.
           MOVE WS-FECHA-SISTEMA TO WS-FECHA-FORMATO.

           COMPUTE WS-ANNO-EXTENDIDO = WS-FECHA-ANNO + 2000.

           DISPLAY "BIENVENIDO | FECHA: "
                    WS-FECHA-DIA "/" WS-FECHA-MES
                     "/" WS-ANNO-EXTENDIDO.
           
           DISPLAY " ".
           DISPLAY "MENÚ PRINCIPAL DEL SISTEMA RESTAURANTE  ".
           DISPLAY "--------------------------------------".
           DISPLAY "1 - CARTA DEL RESTAURANTE.".
           DISPLAY "2 - PLATILLOS.".
           DISPLAY "3 - MESEROS.".
           DISPLAY "4 - MESAS.".
           DISPLAY "5 - PEDIDOS.".
           DISPLAY "6 - CONSULTAS.".
           DISPLAY "--------------------------------------".
           DISPLAY "9 - SALIR DEL SISTEMA.".
           DISPLAY " ".
           DISPLAY "OPCIÓN: " WITH NO ADVANCING.

           ACCEPT WS-OPCION.

           EVALUATE WS-OPCION
               WHEN 1     PERFORM 001-CARTA
               WHEN 2     PERFORM 001-PLATILLOS
               WHEN 3     PERFORM 001-MESEROS
               WHEN 4     PERFORM 001-MESAS
               WHEN 5     PERFORM 001-PEDIDOS
               WHEN 6     PERFORM 002-SUBMENU-CONSULTAS 
                            UNTIL WS-FIN-SUBMENU = 1
               WHEN 9     MOVE 1 TO WS-FIN
               WHEN OTHER
                   DISPLAY " "
                   DISPLAY "OPCION INVÁLIDA, VERIFICA"
           END-EVALUATE.
       *>  -------------------------------------------------------------
       *>  REGISTRO Y/O ACTUALIZACIÓN DE LOS DATOS DE LA CARTA
       *>  -------------------------------------------------------------
       001-CARTA.
           DISPLAY " ".
           DISPLAY "REGISTRO Y/0 ACTUALIZACIÓN DE LA CARTA.".
           DISPLAY "---------------------------------------".
           DISPLAY " ".

           DISPLAY "CÓDIGO CARTA: " WITH NO ADVANCING.
           ACCEPT WS-CARTA-CODIGO.

           PERFORM 000-INICIA-CARTA.
               MOVE WS-CARTA-CODIGO TO RC-CODIGO.
      
               READ F-ARCHIVO-CARTA RECORD
                   KEY RC-CODIGO
                   INVALID KEY MOVE 0 TO WS-CONSULTA
                   NOT INVALID KEY MOVE 1 TO WS-CONSULTA.
           PERFORM 000-CIERRE-CARTA

           IF WS-CONSULTA = 1
                DISPLAY " "
                DISPLAY "+++ADVERTENCIA: REGISTRO DE "
                            "CARTA YA EXISTE, "
                            "LOS DATOS QUE INTRODUZCA A CONTINUACIÓN "
                            "ACTUALIZARAN LOS YA EXISTENTE+++"
                DISPLAY " "
                MOVE ZERO TO WS-CONSULTA
           END-IF.
       *>  ENTRADA DE DATOS
           DISPLAY "DESAYUNOS (USE COMA PARA SEPARAR): "
               WITH NO ADVANCING.
           ACCEPT WS-CARTA-DESAYUNOS.
           DISPLAY "ENTRADAS (USE COMA PARA SEPARAR): "
               WITH NO ADVANCING.
           ACCEPT WS-CARTA-ENTRADAS.
           DISPLAY "ENSALADAS (USE COMA PARA SEPARAR): "
               WITH NO ADVANCING.
           ACCEPT WS-CARTA-ENSALADAS.
           DISPLAY "CONTORNOS (USE COMA PARA SEPARAR): "
               WITH NO ADVANCING.
           ACCEPT WS-CARTA-CONTORNOS.
           DISPLAY "CARNES (USE COMA PARA SEPARAR): "
               WITH NO ADVANCING.
           ACCEPT WS-CARTA-CARNES.
           DISPLAY "PESCADOS-MARISCOS (USE COMA PARA SEPARAR): "
               WITH NO ADVANCING.
           ACCEPT WS-CARTA-PESCADOS-MARISCOS.
           DISPLAY "BEBIDAS (USE COMA PARA SEPARAR): "
               WITH NO ADVANCING.
           ACCEPT WS-CARTA-BEBIDAS.
       *>  REGISTRO DE LOS DATOS EN EL ARCHIVO
           PERFORM 000-INICIA-CARTA
           WRITE REG-CARTA FROM WS-ENT-CARTA
                INVALID KEY
                    REWRITE REG-CARTA FROM WS-ENT-CARTA
                    END-REWRITE
           END-WRITE.
           PERFORM 000-CIERRE-CARTA
           DISPLAY "CARTA REGISTRADA EXITOSAMENTE... " 
               WITH NO ADVANCING.
           STOP "ENTER PARA CONTINUAR".
       *>  -------------------------------------------------------------
       *>  REGISTRO Y/O ACTUALIZACIÓN DE LOS DATOS DEL PLATILLO
       *>  -------------------------------------------------------------
       001-PLATILLOS.
           DISPLAY " ".
           DISPLAY "REGISTRO Y/0 ACTUALIZACIÓN DE PLATILLOS.".
           DISPLAY "--------------------------------------".
           DISPLAY " ".

           DISPLAY "CÓDIGO DEL PLATILLO: " WITH NO ADVANCING.
           ACCEPT WS-PLATILLOS-CODIGO.

           PERFORM 000-INICIA-PLATILLOS.
               MOVE WS-PLATILLOS-CODIGO TO RP-CODIGO.
      
               READ F-ARCHIVO-PLATILLOS RECORD
                   KEY RP-CODIGO
                   INVALID KEY MOVE 0 TO WS-CONSULTA
                   NOT INVALID KEY MOVE 1 TO WS-CONSULTA.
           PERFORM 000-CIERRE-PLATILLOS

           IF WS-CONSULTA = 1
                DISPLAY " "
                DISPLAY "+++ADVERTENCIA: REGISTRO DE "
                            "MESERO YA EXISTE, "
                            "LOS DATOS QUE INTRODUZCA A CONTINUACIÓN "
                            "ACTUALIZARAN LOS YA EXISTENTE+++"
                DISPLAY " "
                MOVE ZERO TO WS-CONSULTA
           END-IF.
       *>  ENTRADA DE DATOS
           DISPLAY "NOMBRE Y DESCRIPCIÓN DEL PLATILLO: "
               WITH NO ADVANCING.
           ACCEPT WS-PLATILLOS-DESCRIPCION.
           DISPLAY "TIPO DE PLATILLO: "
               WITH NO ADVANCING.
           ACCEPT WS-PLATILLOS-TIPO.
       *>  REGISTRO DE LOS DATOS EN EL ARCHIVO
           PERFORM 000-INICIA-PLATILLOS
           WRITE REG-PLATILLOS FROM WS-ENT-PLATILLOS
                INVALID KEY
                    REWRITE REG-PLATILLOS FROM WS-ENT-PLATILLOS
                    END-REWRITE
           END-WRITE.
           PERFORM 000-CIERRE-PLATILLOS
           DISPLAY "PLATILLO REGISTRADO EXITOSAMENTE... " 
               WITH NO ADVANCING.
           STOP "ENTER PARA CONTINUAR".
       *>  -------------------------------------------------------------
       *>  REGISTRO Y/O ACTUALIZACIÓN DE LOS DATOS DEL MESONERO
       *>  -------------------------------------------------------------
       001-MESEROS.
           DISPLAY " ".
           DISPLAY "REGISTRO Y/0 ACTUALIZACIÓN DE MESEROS.".
           DISPLAY "--------------------------------------".
           DISPLAY " ".

           DISPLAY "CÉDULA DE IDENTIDAD: " WITH NO ADVANCING.
           ACCEPT WS-MESEROS-CEDULA.

           PERFORM 000-INICIA-MESEROS.
               MOVE WS-MESEROS-CEDULA TO RM-CEDULA.
      
               READ F-ARCHIVO-MESEROS RECORD
                   KEY RM-CEDULA
                   INVALID KEY MOVE 0 TO WS-CONSULTA
                   NOT INVALID KEY MOVE 1 TO WS-CONSULTA.
           PERFORM 000-CIERRE-MESEROS

           IF WS-CONSULTA = 1
                DISPLAY " "
                DISPLAY "+++ADVERTENCIA: REGISTRO DE "
                            "MESERO YA EXISTE, "
                            "LOS DATOS QUE INTRODUZCA A CONTINUACIÓN "
                            "ACTUALIZARAN LOS YA EXISTENTE+++"
                DISPLAY " "
                MOVE ZERO TO WS-CONSULTA
           END-IF.
       *>  ENTRADA DE DATOS
           DISPLAY "NOMBRE Y APELLIDO: " WITH NO ADVANCING.
           ACCEPT WS-MESEROS-NOMBRE-APELLIDO.
       *>  REGISTRO DE LOS DATOS EN EL ARCHIVO
           PERFORM 000-INICIA-MESEROS
           WRITE REG-MESEROS FROM WS-ENT-MESEROS
                INVALID KEY
                    REWRITE REG-MESEROS FROM WS-ENT-MESEROS
                    END-REWRITE
           END-WRITE.
           PERFORM 000-CIERRE-MESEROS
           DISPLAY "MESERO REGISTRADO EXITOSAMENTE... " 
               WITH NO ADVANCING.
           STOP "ENTER PARA CONTINUAR".
       *>  -------------------------------------------------------------
       *>  REGISTRO Y/O ACTUALIZACIÓN DE LOS DATOS DE MESAS ENUMERADAS
       *>  -------------------------------------------------------------
       001-MESAS.
           DISPLAY " ".
           DISPLAY "REGISTRO Y/0 ACTUALIZACIÓN DE MESAS.".
           DISPLAY "--------------------------------------".
           DISPLAY " ".

           DISPLAY "NÚMERO DE LA MESA: " WITH NO ADVANCING.
           ACCEPT WS-MESAS-NUMERO.

           PERFORM 000-INICIA-MESAS.
               MOVE WS-MESAS-NUMERO TO RME-NUMERO.
      
               READ F-ARCHIVO-MESAS RECORD
                   KEY RME-NUMERO
                   INVALID KEY MOVE 0 TO WS-CONSULTA
                   NOT INVALID KEY MOVE 1 TO WS-CONSULTA.
           PERFORM 000-CIERRE-MESAS

           IF WS-CONSULTA = 1
                DISPLAY " "
                DISPLAY "+++ADVERTENCIA: REGISTRO DE "
                            "MESA YA EXISTE, "
                            "LOS DATOS QUE INTRODUZCA A CONTINUACIÓN "
                            "ACTUALIZARAN LOS YA EXISTENTE+++"
                DISPLAY " "
                MOVE ZERO TO WS-CONSULTA
           END-IF.
       *>  ENTRADA DE DATOS
           PERFORM 000-INICIA-MESEROS.
               PERFORM 003-MOSTRAR-MESEROS.

               DISPLAY "INTRODUZCA LA CEDULA DEL MESERO: "
                   WITH NO ADVANCING.
               ACCEPT WS-MESAS-MESERO.
               MOVE WS-MESAS-MESERO TO RM-CEDULA.

               READ F-ARCHIVO-MESEROS RECORD
                   KEY RM-CEDULA
                   INVALID KEY MOVE 1 TO WS-CONSULTA
                   NOT INVALID KEY MOVE 0 TO WS-CONSULTA
               END-READ.
           PERFORM 000-CIERRE-MESEROS

           IF WS-CONSULTA = 0 THEN
       *>  REGISTRO DE LOS DATOS EN EL ARCHIVO
               PERFORM 000-INICIA-MESAS
               WRITE REG-MESAS FROM WS-ENT-MESAS
                    INVALID KEY
                        REWRITE REG-MESAS FROM WS-ENT-MESAS
                        END-REWRITE
               END-WRITE
               PERFORM 000-CIERRE-MESAS
               DISPLAY "MESA REGISTRADA EXITOSAMENTE... " 
                   WITH NO ADVANCING
               STOP "ENTER PARA CONTINUAR"
           ELSE
               DISPLAY "MESERO NO EXISTE, INTENTE DE NUEVO "
                   "Y ASEGURESE DE VER LAS CÉDULAS EN LA LISTA"
               MOVE ZERO TO WS-CONSULTA
               PERFORM 001-MESAS
           END-IF.
       *>  -------------------------------------------------------------
       *>  REGISTRO Y/O ACTUALIZACIÓN DE LOS PEDIDOS
       *>  -------------------------------------------------------------
       001-PEDIDOS.
           DISPLAY " ".
           DISPLAY "REGISTRO Y/O ACTUIALIZACIÓN DE PEDIDOS.".
           DISPLAY "--------------------------------------".
           DISPLAY " ".

           MOVE 1 TO WS-CONTADOR.

           DISPLAY "INTRODUZCA EL NÚMERO DE PEDIDO, "
               "SI ESCRIBE SÓLO EL CERO, EL SISTEMA LE ASIGNARÁ UNO, "
               "SEGÚN EL ORDEN EN QUE SE VAN REGISTRANDO.".
           DISPLAY "NÚMERO DEL PEDIDO: " WITH NO ADVANCING.
           ACCEPT WS-PEDIDOS-NUMERO.
           MOVE 'N' TO EOF-IN

           IF WS-PEDIDOS-NUMERO = 0 THEN
               PERFORM 000-INICIA-PEDIDOS
               IF WS-PEDIDOS-CREADO = ZERO THEN
                   PERFORM UNTIL EOF-IN = 'Y'
                       READ F-ARCHIVO-PEDIDOS
                           AT END
                               MOVE 'Y' TO EOF-IN
                           NOT AT END
                               ADD 1 TO WS-CONTADOR
                       END-READ
                   END-PERFORM
                END-IF
                PERFORM 000-CIERRE-PEDIDOS
           ELSE
               PERFORM 000-INICIA-PEDIDOS
               MOVE WS-PEDIDOS-NUMERO TO RPE-NUMERO
               READ F-ARCHIVO-PEDIDOS RECORD
                   KEY RPE-NUMERO
                   INVALID KEY MOVE 0 TO WS-CONSULTA
                   NOT INVALID KEY MOVE 1 TO WS-CONSULTA
               PERFORM 000-CIERRE-PEDIDOS
           END-IF.
           MOVE WS-CONTADOR TO WS-PEDIDOS-NUMERO
           DISPLAY " ".
           DISPLAY "NRO. DE PEDIDO ASIGNADO.: " WS-PEDIDOS-NUMERO.
           DISPLAY " ".
           IF WS-CONSULTA = 1
               DISPLAY " "
               DISPLAY "+++ADVERTENCIA: REGISTRO DEL "
                   "PEDIDO YA EXISTE, "
                   "LOS DATOS QUE INTRODUZCA A CONTINUACIÓN "
                   "ACTUALIZARAN LOS YA EXISTENTE+++"
               DISPLAY " "
               MOVE ZERO TO WS-CONSULTA
           END-IF.
           
       *>  ENTRADA DE DATOS
           PERFORM 000-INICIA-MESAS.
               PERFORM 003-MOSTRAR-MESAS.

               DISPLAY "INTRODUZCA NÚMERO DE MESA SEGÚN LA LISTA: "
                   WITH NO ADVANCING.
               ACCEPT WS-PEDIDOS-MESA.
               MOVE WS-PEDIDOS-MESA TO RME-NUMERO.

               READ F-ARCHIVO-MESAS RECORD
                   KEY RME-NUMERO
                   INVALID KEY MOVE 1 TO WS-CONSULTA
                   NOT INVALID KEY MOVE 0 TO WS-CONSULTA
               END-READ.
           PERFORM 000-CIERRE-MESAS
           IF WS-CONSULTA = 0 THEN
               PERFORM 003-MESERO-POR-MESA
               IF WS-CONSULTA = 0 THEN
                   DISPLAY "DESCRIPCIÓN DEL PEDIDO: "
                       WITH NO ADVANCING
                   ACCEPT WS-PEDIDOS-DESCRIPCION
                   DISPLAY "CANTIDAD DEL PEDIDO: "
                       WITH NO ADVANCING
                   ACCEPT WS-PEDIDOS-CANTIDAD
                   DISPLAY "PRECIO UNITARIO (EJ. 22.33): "
                       WITH NO ADVANCING
                   ACCEPT WS-PEDIDOS-PRECIO-UNITARIO
                   DISPLAY "TIPO DE PAGO "
                       "(EJ. PAGO MOVIL, TARJETA,...): "
                       WITH NO ADVANCING
                   ACCEPT WS-PEDIDOS-TIPO-PAGO
                   DISPLAY "IMPORTE (EJ. 1.35): "
                       WITH NO ADVANCING
                   ACCEPT WS-PEDIDOS-IMPORTE
                   DISPLAY "PROPINA (EJ. 1.35): "
                       WITH NO ADVANCING
                   ACCEPT WS-PEDIDOS-PROPINA
                   DISPLAY "ENVIADO (EJ. S = SI o N = NO): "
                       WITH NO ADVANCING
                   ACCEPT WS-PEDIDOS-ENVIADO
                   DISPLAY "FECHA DEL PEDIDO: "
                   DISPLAY "DIA (EJ. 13): "
                       WITH NO ADVANCING
                   ACCEPT WS-PEDIDOS-DIA
                    DISPLAY "MES (EJ. 02): "
                       WITH NO ADVANCING
                   ACCEPT WS-PEDIDOS-MES
                    DISPLAY "AÑO (EJ. 2023): "
                       WITH NO ADVANCING
                   ACCEPT WS-PEDIDOS-ANNO
       *>  REGISTRO DE LOS DATOS EN EL ARCHIVO
                   PERFORM 000-INICIA-PEDIDOS
                   WRITE REG-PEDIDOS FROM WS-ENT-PEDIDOS
                        INVALID KEY
                            REWRITE REG-PEDIDOS FROM WS-ENT-PEDIDOS
                            END-REWRITE
                   END-WRITE
                   PERFORM 000-CIERRE-PEDIDOS
                   DISPLAY "PEDIDO REGISTRADO EXITOSAMENTE... " 
                       WITH NO ADVANCING
                   STOP "ENTER PARA CONTINUAR"
               ELSE
                   DISPLAY "NO HAY MESEROS ASIGNADOS A ESTA MESA,"
                   "O LA MESA NO EXISTE, POR FAVOR INTENTE DE NUEVO"
                   MOVE ZERO TO WS-CONSULTA
                   PERFORM 001-PEDIDOS
               END-IF
           ELSE
               DISPLAY "MESA NO EXISTE, INTENTE DE NUEVO "
                   "Y ASEGURESE DE VER LAS MESAS EN LA LISTA"
               MOVE ZERO TO WS-CONSULTA
               PERFORM 001-PEDIDOS
           END-IF.
       *>  -------------------------------------------------------------
       *>  SUBMENU CONSULTAS
       *>  -------------------------------------------------------------
       002-SUBMENU-CONSULTAS.
       *>  -------------------------------------------------------------
           DISPLAY " ".
           DISPLAY "SUBMENÚ CONSULTAS  ".
           DISPLAY "--------------------------------------".
           DISPLAY "1 - PLATILLOS DISPONIBLES POR TIPO.".
           DISPLAY "2 - MESAS ATENDIDAS POR MESERO Y FECHA.".
           DISPLAY "3 - PEDIDOS ENVIADOS Y/O ANULADOS.".
           DISPLAY "4 - PEDIDOS REALIZADOS POR FECHA.".
           DISPLAY "5 - IMPORTE POR PEDIDOS Y TOTAL.".
           DISPLAY "--------------------------------------".
           DISPLAY "9 - SALIR DEL SUBMENU.".
           DISPLAY " ".
           DISPLAY "OPCIÓN: " WITH NO ADVANCING.

           ACCEPT WS-OPCION-SUBMENU.

           EVALUATE WS-OPCION-SUBMENU
               WHEN 1
                   PERFORM 000-INICIA-PLATILLOS
                   PERFORM 003-MOSTRAR-PLATILLOS-POR-TIPO
                   PERFORM 000-CIERRE-PLATILLOS
               WHEN 2
                   PERFORM 000-INICIA-PEDIDOS
                   PERFORM 003-MOSTRAR-MESAS-POR-FECHA-MESERO
                   PERFORM 000-CIERRE-PEDIDOS
               WHEN 3
                   PERFORM 000-INICIA-PEDIDOS
                   PERFORM 003-MOSTRAR-PEDIDOS-ENVIADOS
                   PERFORM 000-CIERRE-PEDIDOS
               WHEN 4     
                   PERFORM 000-INICIA-PEDIDOS
                   PERFORM 003-MOSTRAR-PEDIDOS-POR-FECHA
                   PERFORM 000-CIERRE-PEDIDOS
               WHEN 5
                   PERFORM 003-MOSTRAR-IMPORTE-POR-PEDIDOS
               WHEN 9 MOVE 1 TO WS-FIN-SUBMENU
               WHEN OTHER
                   DISPLAY " "
                   DISPLAY "OPCION INVÁLIDA"
           END-EVALUATE.
       *>  -------------------------------------------------------------
       
       *>  -------------------------------------------------------------
       *>  APERTURA O CREACIÓN DE NO EXISTIR DEL ARCHIVO CARTA
       *>  -------------------------------------------------------------
       000-INICIA-CARTA.
           MOVE ZERO TO FS-STATUS-CARTA.

           OPEN I-O F-ARCHIVO-CARTA.
           IF FS-STATUS-CARTA = '10' OR FS-STATUS-CARTA = '00'
               THEN
               EXIT
           ELSE
               IF FS-STATUS-CARTA = '35' THEN
                   OPEN OUTPUT F-ARCHIVO-CARTA
                   IF FS-STATUS-CARTA = '10' OR 
                   FS-STATUS-CARTA = '00' THEN
                       EXIT
                   ELSE
                       DISPLAY "ERROR AL CREAR EL ARCHIVO, ERROR: "
                       FS-STATUS-CARTA
                   END-IF
               ELSE
                   DISPLAY 'ERROR AL ABRIR O CREAR EL ARCHIVO, ERROR: '
                       FS-STATUS-CARTA
                   MOVE 1 TO WS-FIN
               END-IF
           END-IF.
       *>  -------------------------------------------------------------
       *>  CIERRE DEL ARCHIVO CARTA
       *>  -------------------------------------------------------------
       000-CIERRE-CARTA.
           CLOSE F-ARCHIVO-CARTA.
       *>  -------------------------------------------------------------
       *>  APERTURA O CREACIÓN DE NO EXISTIR DEL ARCHIVO PLATILLOS
       *>  -------------------------------------------------------------
       000-INICIA-PLATILLOS.
           MOVE ZERO TO FS-STATUS-PLATILLOS.

           OPEN I-O F-ARCHIVO-PLATILLOS.
           IF FS-STATUS-PLATILLOS = '10' OR FS-STATUS-PLATILLOS = '00'
               THEN
               EXIT
           ELSE
               IF FS-STATUS-PLATILLOS = '35' THEN
                   OPEN OUTPUT F-ARCHIVO-PLATILLOS
                   IF FS-STATUS-PLATILLOS = '10' OR 
                   FS-STATUS-PLATILLOS = '00' THEN
                       EXIT
                   ELSE
                       DISPLAY "ERROR AL CREAR EL ARCHIVO, ERROR: "
                       FS-STATUS-PLATILLOS
                   END-IF
               ELSE
                   DISPLAY 'ERROR AL ABRIR O CREAR EL ARCHIVO, ERROR: '
                       FS-STATUS-PLATILLOS
                   MOVE 1 TO WS-FIN
               END-IF
           END-IF.
       *>  -------------------------------------------------------------
       *>  CIERRE DEL ARCHIVO PLATILLOS
       *>  -------------------------------------------------------------
       000-CIERRE-PLATILLOS.
           CLOSE F-ARCHIVO-PLATILLOS.
       *>  -------------------------------------------------------------
       *>  APERTURA O CREACIÓN DE NO EXISTIR DEL ARCHIVO MESEROS
       *>  -------------------------------------------------------------
       000-INICIA-MESEROS.
           MOVE ZERO TO FS-STATUS-MESEROS.

           OPEN I-O F-ARCHIVO-MESEROS.
           IF FS-STATUS-MESEROS = '10' OR FS-STATUS-MESEROS = '00'
               THEN
               EXIT
           ELSE
               IF FS-STATUS-MESEROS = '35' THEN
                   OPEN OUTPUT F-ARCHIVO-MESEROS
                   IF FS-STATUS-MESEROS = '10' OR 
                   FS-STATUS-MESEROS = '00' THEN
                       EXIT
                   ELSE
                       DISPLAY "ERROR AL CREAR EL ARCHIVO: "
                       FS-STATUS-MESEROS
                   END-IF
               ELSE
                   DISPLAY 'ERROR AL ABRIR O CREAR EL ARCHIVO: '
                       FS-STATUS-MESEROS
                   MOVE 1 TO WS-FIN
               END-IF
           END-IF.
       *>  -------------------------------------------------------------
       *>  CIERRE DEL ARCHIVO MESEROS
       *>  -------------------------------------------------------------
       000-CIERRE-MESEROS.
           CLOSE F-ARCHIVO-MESEROS.
       *>  -------------------------------------------------------------
       *>  APERTURA O CREACIÓN DE NO EXISTIR DEL ARCHIVO MESAS
       *>  -------------------------------------------------------------
       000-INICIA-MESAS.
           MOVE ZERO TO FS-STATUS-MESAS.

           OPEN I-O F-ARCHIVO-MESAS.
           IF FS-STATUS-MESAS = '10' OR FS-STATUS-MESAS = '00'
               THEN
               EXIT
           ELSE
               IF FS-STATUS-MESAS = '35' THEN
                   OPEN OUTPUT F-ARCHIVO-MESAS
                   IF FS-STATUS-MESAS = '10' OR 
                   FS-STATUS-MESAS = '00' THEN
                       EXIT
                   ELSE
                       DISPLAY "ERROR AL CREAR EL ARCHIVO: "
                       FS-STATUS-MESAS
                   END-IF
               ELSE
                   DISPLAY 'ERROR AL ABRIR O CREAR EL ARCHIVO: '
                       FS-STATUS-MESAS
                   MOVE 1 TO WS-FIN
               END-IF
           END-IF.
       *>  -------------------------------------------------------------
       *>  CIERRE DEL ARCHIVO MESAS
       *>  -------------------------------------------------------------
       000-CIERRE-MESAS.
           CLOSE F-ARCHIVO-MESAS.
       *>  -------------------------------------------------------------
       *>  APERTURA O CREACIÓN DE NO EXISTIR DEL ARCHIVO PEDIDOS
       *>  -------------------------------------------------------------
       000-INICIA-PEDIDOS.
           MOVE ZERO TO FS-STATUS-PEDIDOS.
           MOVE ZERO TO WS-PEDIDOS-CREADO

           OPEN I-O F-ARCHIVO-PEDIDOS.
           IF FS-STATUS-PEDIDOS = '10' OR FS-STATUS-PEDIDOS = '00'
               THEN
               MOVE ZERO TO WS-PEDIDOS-CREADO
           ELSE
               IF FS-STATUS-PEDIDOS = '35' THEN
                   OPEN OUTPUT F-ARCHIVO-PEDIDOS
                   IF FS-STATUS-PEDIDOS = '10' OR 
                   FS-STATUS-PEDIDOS = '00' THEN
                       MOVE 1 TO WS-PEDIDOS-CREADO
                   ELSE
                       DISPLAY "ERROR AL CREAR EL ARCHIVO: "
                       FS-STATUS-PEDIDOS
                   END-IF
               ELSE
                   DISPLAY 'ERROR AL ABRIR O CREAR EL ARCHIVO: '
                       FS-STATUS-PEDIDOS
                   MOVE 1 TO WS-FIN
               END-IF
           END-IF.
       *>  -------------------------------------------------------------
       *>  CIERRE DEL ARCHIVO PEDIDOS
       *>  -------------------------------------------------------------
       000-CIERRE-PEDIDOS.
           CLOSE F-ARCHIVO-PEDIDOS.
       *>  -------------------------------------------------------------
       *>  CONSULTAS AUXILIARES
       *>  -------------------------------------------------------------
       *>  -------------------------------------------------------------
       *>  MOSTRAR MESEROS
       *>  -------------------------------------------------------------
       003-MOSTRAR-MESEROS.
           MOVE 0 TO WS-FIN-ARCHIVO.
           PERFORM 004-LEE-SIG-MESERO.

           DISPLAY "LISTA DE MESEROS REGISTRADOS: "
           PERFORM 004-IMPRIME-MESERO UNTIL WS-FIN-ARCHIVO = 1.

       004-LEE-SIG-MESERO.
            READ F-ARCHIVO-MESEROS NEXT RECORD
                AT END
            MOVE 1 TO WS-FIN-ARCHIVO.

       004-IMPRIME-MESERO.
           DISPLAY " - " RM-CEDULA " " RM-NOMBRE-APELLIDO.
           PERFORM 004-LEE-SIG-MESERO.
       *>  -------------------------------------------------------------
       *>  MOSTRAR Y SELECCIONAR MESERO POR MESA
       *>  -------------------------------------------------------------
       003-MESERO-POR-MESA.
           MOVE 0 TO WS-FIN-ARCHIVO.
           move 1 to WS-CONSULTA.

           PERFORM 000-INICIA-MESAS.
           PERFORM 004-LEE-SIG-MESA.

           DISPLAY "LA CÉDULA DEL MESERO ASIGNADO A ESTA MESA ES: " 
               WITH NO ADVANCING.
           PERFORM 004-IMPRIME-MESERO-POR-MESA UNTIL WS-FIN-ARCHIVO = 1.
           PERFORM 000-CIERRE-MESAS.

       004-IMPRIME-MESERO-POR-MESA.
           IF WS-PEDIDOS-MESA = RME-NUMERO THEN
               DISPLAY RME-MESERO
               MOVE RME-MESERO TO WS-PEDIDOS-MESERO
               MOVE ZERO TO WS-CONSULTA
           END-IF.
           PERFORM 004-LEE-SIG-MESA.
       *>  -------------------------------------------------------------
       *>  MOSTRAR MESAS
       *>  -------------------------------------------------------------
       003-MOSTRAR-MESAS.
           MOVE 0 TO WS-FIN-ARCHIVO.
           PERFORM 004-LEE-SIG-MESA.

           DISPLAY "LISTA DE MESAS REGISTRADAS: ".
           PERFORM 004-IMPRIME-MESA UNTIL WS-FIN-ARCHIVO = 1.

       004-LEE-SIG-MESA.
            READ F-ARCHIVO-MESAS NEXT RECORD
                AT END MOVE 1 TO WS-FIN-ARCHIVO.

       004-IMPRIME-MESA.
           DISPLAY " -> " RME-NUMERO.
           PERFORM 004-LEE-SIG-MESA.
       *>  -------------------------------------------------------------
       *>  MOSTRAR PEDIDOS
       *>  -------------------------------------------------------------
       003-MOSTRAR-PEDIDOS.
           MOVE 0 TO WS-FIN-ARCHIVO.
           PERFORM 004-LEE-SIG-PEDIDO.

           DISPLAY "LISTA PEDIDOS: ".
           PERFORM 004-IMPRIME-PEDIDO UNTIL WS-FIN-ARCHIVO = 1.
       
       004-LEE-SIG-PEDIDO.
           READ F-ARCHIVO-PEDIDOS NEXT RECORD
               AT END MOVE 1 TO WS-FIN-ARCHIVO.

       004-IMPRIME-PEDIDO.
           DISPLAY "NRO. DE PEDIDO: " RPE-NUMERO.
           PERFORM 004-LEE-SIG-PEDIDO.
       *>  -------------------------------------------------------------
       *>  CONSULTAS SOLICITADAS POR LAS EXIGENCIAS DEL SISTEMA
       *>  -------------------------------------------------------------
       *>  -------------------------------------------------------------
       *>  MOSTRAR PLATILLOS POR TIPO
       *>  -------------------------------------------------------------
       003-MOSTRAR-PLATILLOS-POR-TIPO.
           DISPLAY " ".
           DISPLAY "********************************".
           DISPLAY "LISTA DE PLATILLOS POR TIPO: ".
           DISPLAY "********************************".
           DISPLAY "INTRODUZCA EL TIPO: " WITH NO ADVANCING.
           ACCEPT WS-PLATILLOS-TIPO.

           MOVE 0 TO WS-FIN-ARCHIVO.
           PERFORM 004-LEE-SIG-PLATILLO.

           MOVE 0 TO WS-ENCONTRADO
           DISPLAY " "
           DISPLAY "PLATILLOS PARA EL TIPO: " WS-PLATILLOS-TIPO

           PERFORM 004-IMPRIME-PLATILLO-POR-TIPO
               UNTIL WS-FIN-ARCHIVO = 1.
        
           IF WS-ENCONTRADO = 0 THEN
               DISPLAY " "
               DISPLAY "*** NO HAY PLATILLOS PARA ESTE TIPO ***"
               DISPLAY " "
               STOP "ENTER PARA CONTINUAR"
           ELSE
               DISPLAY " "
               STOP "ENTER PARA CONTINUAR"
           END-IF.

       004-LEE-SIG-PLATILLO.
           READ F-ARCHIVO-PLATILLOS NEXT RECORD
               AT END MOVE 1 TO WS-FIN-ARCHIVO.

       004-IMPRIME-PLATILLO-POR-TIPO.
           IF  WS-PLATILLOS-TIPO = RP-TIPO THEN  
               DISPLAY "------------------------------------------"
               DISPLAY " -> CODIGO DE PLATILLO: " RP-CODIGO
               DISPLAY "  - DESCRIPCIÓN: " RP-DESCRIPCION
               MOVE 1 TO WS-ENCONTRADO
           END-IF.

           PERFORM 004-LEE-SIG-PLATILLO.
       *>  -------------------------------------------------------------
       *>  MOSTRAR PEDIDOS POR FECHA
       *>  -------------------------------------------------------------
       003-MOSTRAR-PEDIDOS-POR-FECHA.
           DISPLAY " "
           DISPLAY "********************************"
           DISPLAY "LISTA DE PEDIDOS POR FECHA: "
           DISPLAY "********************************"
           DISPLAY "INTRODUZCA LA FECHA"
           DISPLAY "DÍA: " WITH NO ADVANCING.
           ACCEPT WS-PEDIDOS-DIA.
           DISPLAY "MES: " WITH NO ADVANCING.
           ACCEPT WS-PEDIDOS-MES.
           DISPLAY "AÑO: " WITH NO ADVANCING.
           ACCEPT WS-PEDIDOS-ANNO.

           MOVE 0 TO WS-FIN-ARCHIVO.
           PERFORM 004-LEE-SIG-PEDIDO.

           MOVE 0 TO WS-ENCONTRADO
           DISPLAY " "
           DISPLAY "PEDIDOS PARA LA FECHA: " WS-PEDIDOS-DIA "/"
               WS-PEDIDOS-MES "/" WS-PEDIDOS-ANNO

           PERFORM 004-IMPRIME-PEDIDO-POR-FECHA UNTIL WS-FIN-ARCHIVO = 1.

           IF WS-ENCONTRADO = 0 THEN
               DISPLAY " "
               DISPLAY "*** NO HAY PEDIDOS PARA LA "
               "FECHA INTRODUCIDA ***"
               DISPLAY " "
               STOP "ENTER PARA CONTINUAR"
           END-IF.

           DISPLAY " ".
           STOP "ENTER PARA CONTINUAR".

       004-IMPRIME-PEDIDO-POR-FECHA.
           IF  WS-PEDIDOS-DIA = RPE-DIA AND
               WS-PEDIDOS-MES = RPE-MES AND
               WS-PEDIDOS-ANNO = RPE-ANNO
               THEN
                   DISPLAY "------------------------------------------"
                   DISPLAY "-> PEDIDO NRO. " RPE-NUMERO
                   DISPLAY " - MESA: " RPE-MESA
                   DISPLAY " - CÉDULA DEL MESERO: " RPE-MESERO
                   DISPLAY " - DESCRIPCIÓN: " RPE-DESCRIPCION
                   DISPLAY " - CANTIDAD: " RPE-CANTIDAD
                   DISPLAY " - PRECIO UNITARIO: " RPE-PRECIO-UNITARIO
                   DISPLAY " - TIPO DE PAGO: " RPE-TIPO-PAGO
                   DISPLAY " - IMPORTE: " RPE-IMPORTE
                   DISPLAY " - PROPINA: " RPE-PROPINA
                   DISPLAY " - ENVIADO: " RPE-ENVIADO
                   DISPLAY " - FECHA: " RPE-DIA 
                       "/" RPE-MES "/" RPE-ANNO
                   MOVE 1 TO WS-ENCONTRADO
           END-IF

           PERFORM 004-LEE-SIG-PEDIDO.
       *>  -------------------------------------------------------------
       *>  MOSTRAR MESAS POR FECHA Y MESERO
       *>  -------------------------------------------------------------
       003-MOSTRAR-MESAS-POR-FECHA-MESERO.
           DISPLAY " ".
           DISPLAY "***********************************".
           DISPLAY "MESAS ATENDIDAS POR FECHA Y MESERO: ".
           DISPLAY "***********************************".
           DISPLAY "INTRODUZCA LA FECHA".
           DISPLAY "DÍA: " WITH NO ADVANCING.
           ACCEPT WS-PEDIDOS-DIA.
           DISPLAY "MES: " WITH NO ADVANCING.
           ACCEPT WS-PEDIDOS-MES.
           DISPLAY "AÑO: " WITH NO ADVANCING.
           ACCEPT WS-PEDIDOS-ANNO.

           PERFORM 000-INICIA-MESEROS.
           PERFORM 003-MOSTRAR-MESEROS.
           PERFORM 000-CIERRE-MESEROS.

           DISPLAY "INTRODUZCA LA CEDULA DEL MESERO: "
               WITH NO ADVANCING.
           ACCEPT WS-PEDIDOS-MESERO.

           MOVE 0 TO WS-FIN-ARCHIVO.
           PERFORM 004-LEE-SIG-PEDIDO.

           MOVE 0 TO WS-ENCONTRADO
           DISPLAY " "
           DISPLAY "MESAS ATENDIDAS POR EL MESERO: " WS-PEDIDOS-MESERO
           DISPLAY "PARA LA FECHA: " WS-PEDIDOS-DIA "/"
               WS-PEDIDOS-MES "/" WS-PEDIDOS-ANNO

           PERFORM 004-IMPRIME-MESAS-POR-FECHA-MESERO
               UNTIL WS-FIN-ARCHIVO = 1.

           IF WS-ENCONTRADO = 0 THEN
               DISPLAY " "
               DISPLAY "*** NO HAY MESAS PARA EL MESERO Y LA "
               "FECHA INTRODUCIDA ***"
               DISPLAY " "
               STOP "ENTER PARA CONTINUAR"
           ELSE 
               DISPLAY " "
               STOP "ENTER PARA CONTINUAR"
           END-IF.

       004-IMPRIME-MESAS-POR-FECHA-MESERO.
           IF  WS-PEDIDOS-DIA = RPE-DIA AND
               WS-PEDIDOS-MES = RPE-MES AND
               WS-PEDIDOS-ANNO = RPE-ANNO AND
               WS-PEDIDOS-MESERO = RPE-MESERO
               THEN
                   DISPLAY "------------------------------------------"
                   DISPLAY " - NRO. DE MESA: " RPE-MESA
                   MOVE 1 TO WS-ENCONTRADO
           END-IF

           PERFORM 004-LEE-SIG-PEDIDO.
       *>  -------------------------------------------------------------
       *>  MOSTRAR PEDIDOS ENVIADO Y/O ANULADOS
       *>  -------------------------------------------------------------
       003-MOSTRAR-PEDIDOS-ENVIADOS.
           DISPLAY " ".
           DISPLAY "**************************************".
           DISPLAY "MOSTRAR PEDIDOS ENVIADOS O ANULADOS: ".
           DISPLAY "**************************************".

           DISPLAY "1. PEDIDOS ENVIADOS.".
           DISPLAY "2. PEDIDOS ANULADOS.".
           DISPLAY "----------------------"
           DISPLAY "INTRODUZCA CUALQUIER NÚMERO PARA CANCELAR".
           DISPLAY " ".

           DISPLAY "QUE TIPO DE PEDIDOS DESEA MOSTRAR (1 o 2)?: "
               WITH NO ADVANCING.
           ACCEPT WS-TIPO-PEDIDO.

           MOVE 0 TO WS-FIN-ARCHIVO.
           PERFORM 004-LEE-SIG-PEDIDO.

           MOVE 0 TO WS-ENCONTRADO
           DISPLAY " "
           IF WS-TIPO-PEDIDO = 1 THEN
               DISPLAY "LISTA DE PEDIDOS ENVIADOS: "
           ELSE
               IF WS-TIPO-PEDIDO = 2 THEN
                   DISPLAY "LISTA DE PEDIDOS CANCELADOS: "
               ELSE
                   EXIT
               END-IF
           END-IF.

           PERFORM 004-IMPRIME-PEDIDOS-ENVIADOS
               UNTIL WS-FIN-ARCHIVO = 1.

           IF WS-ENCONTRADO = 0 THEN
               DISPLAY " "
               DISPLAY "*** NO HAY NINGÚN PEDIDO ***"
               DISPLAY " "
               STOP "ENTER PARA CONTINUAR"
           ELSE 
               DISPLAY " "
               STOP "ENTER PARA CONTINUAR"
           END-IF.

       004-IMPRIME-PEDIDOS-ENVIADOS.
           IF  RPE-ENVIADO = 'S' AND WS-TIPO-PEDIDO = 1
               THEN
                   DISPLAY "------------------------------------------"
                   DISPLAY "-> PEDIDO NRO. " RPE-NUMERO
                   DISPLAY " - MESA: " RPE-MESA
                   DISPLAY " - CÉDULA DEL MESERO: " RPE-MESERO
                   DISPLAY " - DESCRIPCIÓN: " RPE-DESCRIPCION
                   DISPLAY " - CANTIDAD: " RPE-CANTIDAD
                   DISPLAY " - PRECIO UNITARIO: " RPE-PRECIO-UNITARIO
                   DISPLAY " - TIPO DE PAGO: " RPE-TIPO-PAGO
                   DISPLAY " - IMPORTE: " RPE-IMPORTE
                   DISPLAY " - PROPINA: " RPE-PROPINA
                   DISPLAY " - ENVIADO: " RPE-ENVIADO
                   DISPLAY " - FECHA: " RPE-DIA 
                       "/" RPE-MES "/" RPE-ANNO
                   MOVE 1 TO WS-ENCONTRADO
                   MOVE 1 TO WS-ENCONTRADO
           ELSE 
               IF RPE-ENVIADO = 'N' AND WS-TIPO-PEDIDO = 2 THEN
                   DISPLAY "------------------------------------------"
                   DISPLAY "-> PEDIDO NRO. " RPE-NUMERO
                   DISPLAY " - MESA: " RPE-MESA
                   DISPLAY " - CÉDULA DEL MESERO: " RPE-MESERO
                   DISPLAY " - DESCRIPCIÓN: " RPE-DESCRIPCION
                   DISPLAY " - CANTIDAD: " RPE-CANTIDAD
                   DISPLAY " - PRECIO UNITARIO: " RPE-PRECIO-UNITARIO
                   DISPLAY " - TIPO DE PAGO: " RPE-TIPO-PAGO
                   DISPLAY " - IMPORTE: " RPE-IMPORTE
                   DISPLAY " - PROPINA: " RPE-PROPINA
                   DISPLAY " - ENVIADO: " RPE-ENVIADO
                   DISPLAY " - FECHA: " RPE-DIA 
                       "/" RPE-MES "/" RPE-ANNO
                   MOVE 1 TO WS-ENCONTRADO
                   MOVE 1 TO WS-ENCONTRADO
                ELSE
                    EXIT
                END-IF
           END-IF

           PERFORM 004-LEE-SIG-PEDIDO.
       *>  -------------------------------------------------------------
       *>  MOSTRAR IMPORTE POR PEDIDOS
       *>  -------------------------------------------------------------
       003-MOSTRAR-IMPORTE-POR-PEDIDOS.
           DISPLAY " ".
           DISPLAY "********************************".
           DISPLAY "MOSTRAR IMPORTE POR PEDIDOS: ".
           DISPLAY "********************************".

           PERFORM 000-INICIA-PEDIDOS.
           PERFORM 003-MOSTRAR-PEDIDOS.
           PERFORM 000-CIERRE-PEDIDOS.

           MOVE 0 TO WS-FIN-ARCHIVO.

           PERFORM 000-INICIA-PEDIDOS.
           PERFORM 004-LEE-SIG-PEDIDO.

           MOVE 0 TO WS-ENCONTRADO.

           DISPLAY "INTRODUZCA EL NÚMERO DE PEDIDO: "
               WITH NO ADVANCING.
           ACCEPT WS-PEDIDOS-NUMERO.
           

           PERFORM 004-IMPRIME-IMPORTE-POR-PEDIDO
               UNTIL WS-FIN-ARCHIVO = 1.

           IF WS-ENCONTRADO = 0 THEN
               DISPLAY " "
               DISPLAY "*** NADA QUE MOSTRAR ***"
               DISPLAY " "
               STOP "ENTER PARA CONTINUAR"
           END-IF.

           PERFORM 000-CIERRE-PEDIDOS.
           DISPLAY " ".
           STOP "ENTER PARA CONTINUAR".

       004-IMPRIME-IMPORTE-POR-PEDIDO.
           IF WS-PEDIDOS-NUMERO = RPE-NUMERO THEN
               DISPLAY " "
               DISPLAY "IMPORTE, DETALLE Y TOTAL A PAGAR:"
               DISPLAY "------------------------------------------"
               DISPLAY " + NUMERO DE PEDIDO: " RPE-NUMERO
               DISPLAY " + PRECIO UNITARIO: " RPE-PRECIO-UNITARIO
               DISPLAY " + CANTIDAD: " RPE-CANTIDAD
               DISPLAY " + IMPORTE: " RPE-IMPORTE
               DISPLAY " + PROPINA: " RPE-PROPINA
               COMPUTE WS-TOTAL-PAGO = RPE-PRECIO-UNITARIO 
               * RPE-CANTIDAD + RPE-IMPORTE + RPE-PROPINA
               DISPLAY ">> TOTAL A PAGAR: " WS-TOTAL-PAGO
               MOVE 1 TO WS-ENCONTRADO
           END-IF

           PERFORM 004-LEE-SIG-PEDIDO.
       *>  -------------------------------------------------------------
       END PROGRAM RESTAURANTE.
       *>  -------------------------------------------------------------

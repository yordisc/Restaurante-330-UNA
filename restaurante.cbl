       IDENTIFICATION DIVISION.
       PROGRAM-ID. Restaurante.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       
       FILE-CONTROL.
       SELECT Carta-File ASSIGN TO "carta.csv"
       ORGANIZATION IS LINE SEQUENTIAL.
       SELECT Platillos-File ASSIGN TO "platillos.csv"
       ORGANIZATION IS LINE SEQUENTIAL.
       SELECT Meseros-File ASSIGN TO "meseros.csv"
       ORGANIZATION IS LINE SEQUENTIAL.
       SELECT Mesas-File ASSIGN TO "mesas.csv"
       ORGANIZATION IS LINE SEQUENTIAL.
       SELECT Pedidos-File ASSIGN TO "pedidos.csv"
       ORGANIZATION IS LINE SEQUENTIAL.
       
       DATA DIVISION.
       FILE SECTION.
       FD Carta-File.
       01 Carta-Record.
         05 Carta-Codigo PIC X(6).
         05 Carta-Desayunos PIC X(20).
         05 Carta-Entradas PIC X(20).
         05 Carta-Ensaladas PIC X(20).
         05 Carta-Contornos PIC X(20).
         05 Carta-Carnes PIC X(20).
         05 Carta-Pescados PIC X(20).
         05 Carta-Bebidas PIC X(20).
       FD Platillos-File.
       01 Platillos-Record.
         05 Platillos-Codigo PIC X(6).
         05 Platillos-Descripcion PIC X(30).
         05 Platillos-Tipo PIC X(10).
       FD Meseros-File.
       01 Meseros-Record.
         05 Meseros-Cedula PIC X(9).
         05 Meseros-Nombre PIC X(20).
         05 Meseros-Apellido PIC X(20).
       FD Mesas-File.
       01 Mesas-Record.
         05 Mesas-Numero PIC 9(2).
         05 Mesas-Mesero PIC X(9).
         05 Mesas-Cantidad PIC 9(2).
       FD Pedidos-File.
       01 Pedidos-Record.
         05 Pedidos-Numero PIC X(6).
         05 Pedidos-Mesa PIC 9(2).
         05 Pedidos-Cedula PIC X(9).
         05 Pedidos-Descripcion PIC X(30).
         05 Pedidos-Cantidad PIC 9(2).
         05 Pedidos-Precio PIC 9(5)V99.
         05 Pedidos-Tipo PIC X(10).
         05 Pedidos-Importe PIC 9(5)V99.
         05 Pedidos-Propina PIC 9(3)V99.
         05 Pedidos-Enviado PIC X(1).
       
       WORKING-STORAGE SECTION.
       01 Menu-Option PIC X.
       01 Valid-Option PIC X VALUE 'Y'.
       01 Valid-Date PIC X VALUE 'Y'.
       01 Valid-Mesero PIC X VALUE 'Y'.
       01 Valid-Mesa PIC X VALUE 'Y'.
       01 Valid-Pedido PIC X VALUE 'Y'.
       01 Valid-Plato PIC X VALUE 'Y'.
       01 Valid-Codigo PIC X VALUE 'Y'.
       01 Valid-Cedula PIC X VALUE 'Y'.
       01 Valid-Number PIC X VALUE 'Y'.
       01 Valid-Price PIC X VALUE 'Y'.
       01 Valid-Qty PIC X VALUE 'Y'.
       01 Platillo-Tipo PIC X(10).
       01 Mesero-Cedula PIC X(9).
       01 Mesa-Number PIC 9(2).
       01 Pedido-Number PIC X(6).
       01 Pedido-Mesa PIC 9(2).
       01 Pedido-Cedula PIC X(9).
       01 Pedido-Plato PIC X(30).
       01 Pedido-Qty PIC 9(2).
       01 Pedido-Price PIC 9(5)V99.
       01 Pedido-Type PIC X(10).
       01 Pedido-Amount PIC 9(5)V99.
       01 Pedido-Tip PIC 9(3)V99.
       01 Pedido-Sent PIC X(1).
       01 WS-Date PIC 9(8).
       01 WS-Day PIC 9(2).
       01 WS-Month PIC 9(2).
       01 WS-Year PIC 9(4).
       01 WS-Current PIC X(10) VALUE "CURRENT".
       01 WS-Blank-Line PIC X(80) VALUE SPACES.
       01 WS-Menu-Header.
         05 WS-Header-1 PIC X(36) VALUE "RESTAURANTE MENU PRINCIPAL".
       01 WS-Menu-Options.
         05 WS-Option-1 PIC X(30) VALUE "1 - CARTA DEL RESTAURANTE".
         05 WS-Option-2 PIC X(30) VALUE "2 - PLATILLOS POR TIPOS".
         05 WS-Option-3 PIC X(30) VALUE "3 - REGISTRO DE MESEROS".
         05 WS-Option-4 PIC X(30) 
       CONTINUE VALUE "4 - REGISTRO DE MESAS ENUMERADAS".
         05 WS-Option-5 PIC X(30) VALUE "5 - REGISTRO DE PEDIDOS".
         05 WS-Option-6 PIC X(30) VALUE "6 - PLATILLOS DISPONIBLES".
         05 WS-Option-7 PIC X(30) 
       CONTINUE VALUE "7 - PEDIDOS REALIZADOS POR FECHA".
         05 WS-Option-8 PIC X(30) 
       CONTINUE VALUE "8 - MESEROS CON PEDIDOS POR Nº DE PEDIDO".
         05 WS-Option-9 PIC X(30) VALUE "9 - MESEROS AUSENTES".
         05 WS-Option-10 PIC X(30) VALUE "10 - SALIR".
       01 WS-Menu-Selection PIC 9.
       01 WS-Menu-Error PIC X.
       01 WS-Platillo-Codigo PIC X(6).
       01 WS-Pedido-Importe PIC 9(5)V99.
       01 WS-Pedido-Total PIC 9(5)V99.
       01 WS-Platillo-Found PIC X VALUE 'N'.
       01 WS-Pedido-Found PIC X VALUE 'N'.
       01 WS-Mesero-Found PIC X VALUE 'N'.
       01 WS-Mesa-Found PIC X VALUE 'N'.
       01 WS-Plato-Found PIC X VALUE 'N'.
       
       PROCEDURE DIVISION.
       MAIN-PARAGRAPH.
       PERFORM DISPLAY-MENU UNTIL WS-Menu-Selection = 10.
       STOP RUN.
       DISPLAY-MENU.
       DISPLAY WS-Blank-Line.
       DISPLAY WS-Menu-Header.
       DISPLAY WS-Blank-Line.
       DISPLAY WS-Menu-Options.
       DISPLAY WS-Blank-Line.
       DISPLAY "SELECCIONE UNA OPCION: " WITH NO ADVANCING.
       ACCEPT WS-Menu-Selection.
       EVALUATE WS-Menu-Selection
       WHEN 1
       PERFORM DISPLAY-CARTA
       WHEN 2
       PERFORM DISPLAY-PLATILLOS
       WHEN 3
       PERFORM REGISTER-MESERO
       WHEN 4
       PERFORM REGISTER-MESA
       WHEN 5
       PERFORM REGISTER-PEDIDO
       WHEN 6
       PERFORM DISPLAY-PLATILLOS-DISPONIBLES
       WHEN 7
       PERFORM DISPLAY-PEDIDOS-POR-FECHA
       WHEN 8
       PERFORM DISPLAY-MESEROS-CON-PEDIDOS
       WHEN 9
       PERFORM DISPLAY-MESEROS-AUSENTES
       WHEN 10
       CONTINUE
       WHEN OTHER
       DISPLAY "OPCION INVALIDA. INGRESE UNA OPCION VALIDA.".
       END-EVALUATE.
       DISPLAY-CARTA.
       OPEN INPUT Carta-File.
       DISPLAY "CODIGO DESAYUNOS ENTRADAS ENSALADAS "
       CONTINUE "CONTORNOS CARNES PESCADOS Y MARISCOS BEBIDAS".
       DISPLAY WS-Blank-Line.
       READ Carta-File INTO Carta-Record
       AT END
       DISPLAY "NO HAY DATOS EN EL ARCHIVO."
       END-READ.
       PERFORM UNTIL EOF
       DISPLAY Carta-Codigo " " Carta-Desayunos " " Carta-Entradas
       CONTINUE " " Carta-Ensaladas " " Carta-Contornos " " Carta-Carnes
       CONTINUE " " Carta-Pescados " " Carta-Bebidas
       READ Carta-File INTO Carta-Record
       AT END
       SET EOF TO TRUE
       END-READ.
       END-PERFORM.
       CLOSE Carta-File.
       DISPLAY-PLATILLOS.
       DISPLAY "INGRESE EL TIPO DE PLATILLO"
       DISPLAY " (DESAYUNOS, ENTRADAS, ENSALADAS, CONTORNOS,"
       CONTINUE "CARNES, PESCADOS O BEBIDAS): " WITH NO ADVANCING.
       ACCEPT Platillo-Tipo.
       OPEN INPUT Platillos-File.
       DISPLAY "CODIGO DESCRIPCION TIPO".
       DISPLAY WS-Blank-Line.
       READ Platillos-File INTO Platillos-Record
       AT END
       DISPLAY "NO HAY DATOS EN EL ARCHIVO."
       END-READ.
       PERFORM UNTIL EOF
       IF Platillos-Tipo = Platillos-Tipo
       DISPLAY Platillos-Codigo " Platillos-Descripcion " "
       CONTINUE Platillos-Tipo
       SET WS-Platillo-Found TO 'Y'
       END-IF
       READ Platillos-File INTO Platillos-Record
       AT END
       SET EOF TO TRUE
       END-READ.
       END-PERFORM.
       IF WS-Platillo-Found = 'N'
       DISPLAY "NO HAY PLATILLOS DISPONIBLES "
       CONTINUE "PARA EL TIPO DE PLATILLO INGRESADO."
       END-IF
       CLOSE Platillos-File.
       REGISTER-MESERO.
       DISPLAY "INGRESE LA CEDULA DEL MESERO: " WITH NO ADVANCING.
       ACCEPT Mesero-Cedula.
       DISPLAY "INGRESE EL NOMBRE DEL MESERO: " WITH NO ADVANCING.
       ACCEPT Meseros-Nombre.
       DISPLAY "INGRESE EL APELLIDO DEL MESERO: " WITH NO ADVANCING.
       ACCEPT Meseros-Apellido.
       OPEN OUTPUT Meseros-File.
       WRITE Meseros-Record.
       CLOSE Meseros-File.
       DISPLAY "MESERO REGISTRADO CON EXITO.".
       REGISTER-MESA.
       DISPLAY "INGRESE EL NUMERO DE LA MESA: " WITH NO ADVANCING.
       ACCEPT Mesa-Number.
       DISPLAY "INGRESE LA CEDULA DEL MESERO "
       CONTINUE "ASIGNADO A LA MESA: " WITH NO ADVANCING.
       ACCEPT Mesas-Mesero.
       DISPLAY "INGRESE EL NUMERO DE PERSONAS "
       CONTINUE "EN LA MESA: " WITH NO ADVANCING.
       ACCEPT Mesas-Cantidad.
       OPEN OUTPUT Mesas-File.
       WRITE Mesas-Record.
       CLOSE Mesas-File.
       DISPLAY "MESA REGISTRADA CON EXITO.".
       REGISTER-PEDIDO.
       DISPLAY "INGRESE EL NUMERO DEL PEDIDO: " WITH NO ADVANCING.
       ACCEPT Pedido-Number.
       DISPLAY "INGRESE EL NUMERO DE LA MESA: " WITH NO ADVANCING.
       ACCEPT Pedido-Mesa.
       DISPLAY "INGRESE LA CEDULA DEL CLIENTE: " WITH NO ADVANCING.
       ACCEPT Pedido-Cedula.
       DISPLAY "INGRESE LA DESCRIPCION DEL PLATO: " WITH NO ADVANCING.
       ACCEPT Pedido-Plato.
       DISPLAY "INGRESE LA CANTIDAD DEL PLATO: " WITH NO ADVANCING.
       ACCEPT Pedido-Qty.
       DISPLAY "INGRESE EL PRECIO DEL PLATO: " WITH NO ADVANCING.
       ACCEPT Pedido-Price.
       DISPLAY "INGRESE EL TIPO DE PEDIDO "
       DISPLAY "(PARA LLEVAR O EN EL RESTAURANTE): " WITH NO ADVANCING.
       ACCEPT Pedido-Type.
       COMPUTE Pedido-Amount = Pedido-Qty * Pedido-Price.
       DISPLAY "EL IMPORTE DEL PEDIDO ES: ", Pedido-Amount.
       OPEN OUTPUT Pedidos-File.
       WRITE Pedidos-Record.
       CLOSE Pedidos-File.
       DISPLAY "PEDIDO REGISTRADO CON EXITO.".
       END PROGRAM.

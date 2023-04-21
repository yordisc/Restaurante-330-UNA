<p align="center">
 
[//]: <> (site para ícones: https://shields.io/ )
 
<img alt="Maintained" src="https://img.shields.io/badge/Maintained%3F-Yes-green">
<img alt="GitHub last commit" src="https://img.shields.io/github/last-commit/yordisc/Restaurante-330-UNA">
<img alt="GitHub repo size" src="https://img.shields.io/github/repo-size/yordisc/Restaurante-330-UNA">
<img alt="GitHub commit activity (branch)" src="https://img.shields.io/github/commit-activity/y/yordisc/Restaurante-330-UNA">

<hr>

# Situación:
Un nuevo restaurante está a punto de ser inaugurado. En este momento se le está dando los últimos toques para su apertura. El gerente a cargo del proyecto, se ha planteado la necesidad de un sistema automatizado, para llevar el servicio de pedido del cliente dentro del local.

Para satisfacer los requerimientos propuestos por el gerente, el software debe contar con las siguientes especificaciones:

<details>
<summary><b>Especificaciones</b></summary>

### Carta del restaurante: 
Datos correspondientes a los diferentes tipos de platillos:
- Código
- Desayunos
- Entradas
- Ensaladas
- Contornos
- Carnes
- Pescados y Mariscos
- Bebidas

### Platillos por tipos: 
Datos sobre cada plato por tipo
- Código del platillo
- Descripción del platillo

### Meseros: Datos sobre los meseros que atienden.
- Nombre y Apellido
- Cédula

### Mesas numeradas: Datos sobre las mesas
- No. Mesa
- Mesero Asignado
- Cantidad de Mesas

### Pedidos: Datos de los pedidos realizados durante el día.
- Nº de pedido pre impreso en talonario
- Nº de mesa
- Nº de cédula del mesero
- Descripción del pedido
- Cantidad
- Precio Unitario
- Tipo de pago
- Importe
- Propina
- Enviado (s/n)

### El programa debe permitir realizar lo siguiente:
Registro y modificación de datos de:
- Meseros
- Pedidos
- Platillos
- Mesas

### Las siguientes consultas:
- Platillos disponibles
- Pedidos realizados por fecha
- Meseros con pedidos por Nº de Pedido
- Meseros ausentes

## ESPECIFICACIONES GENERALES PARA LA IMPLEMENTACIÓN:
El programa a realizar debe presentar un Menú con las opciones, descritas a continuación.

### 1) Carta del restaurante: 
Esta opción permite ingresar o modificar los datos de los tipos de platillos que se encuentran en la carta. La clave es el código asignado por tipo.

### 2) Platillos por tipos:
Esta opción permite ingresar o modificar los datos de los diferentes platillos que conforman los tipos. La clave de acceso de cada platillo es el código asignado.

### 3) Registro de Meseros:
Esta opción permite ingresar o modificar los datos de los meseros. La clave de acceso será la cédula de cada mesero.

### 4) Registro de Mesas numeradas:
Esta opción permite ingresar o modificar los datos de las mesas que conforman el comedor. Su clave será el Nº de mesa.

### 5) Registro de Pedidos:
Esta opción permite ingresar, modificar o eliminar un pedido. Su clave será el No. de pedido.

### Consultas: El programa permitirá realizar las siguientes consultas:
- Platillos por tipos.
- Meseros ausentes o retirados por fecha
- Mesas atendidas por mesero y fecha
- Pedidos enviados y/o anulados por fecha
- Importe por pedidos y total por fecha

## Para la implementación se deberán diseñar los archivos para almacenar los datos de:
- CARTA DEL RESTAURANTE
- PLATILLOS POR TIPOS
- MESEROS
- MESAS
- PEDIDOS
</details>

<details>
<summary><b>Requisitos</b></summary>

El programa deberá controlar la integridad de los datos, realizando validaciones como:

- No permitirá registrar el mismo pedido por dos meseros
diferentes.
- No permitirá que una mesa sea atendida por un mesero diferente al asignado. Sin embargo, en caso de su ausencia deberá la gerencia tener la opción de reasignar la mesa. (Validación especial).

De acuerdo a las especificaciones dadas, aplique los conocimientos sobre la organización de archivos y elabore un programa en COBOL que satisfaga los requerimientos planteados y a su vez entregue un informe que contenga lo siguiente:

* Algoritmo del programa en pseudolenguaje Listado documentado del programa (FUENTE): en el encabezado de cada procedimiento, función o sección debe incluir un breve comentario del proceso que se realiza.
* Definición de las estructuras de datos utilizadas.
* Listado de los reportes (código fuente y salida de cada reporte).
</details>

## Descarga el proyecto
```bash
git clone https://github.com/yordisc/Restaurante-330-UNA.git
cd Restaurante-330-UNA
ls
```

## :100: Resources used / Credits 
* [Foro de Cobol](cobolforo.es/)
* [Repositorio aprendiendo COBOL](https://github.com/HiroNakamura/aprendiendo-cobol/tree/master/temario)
* [Documentacion](https://devdocs.io/gnu_cobol/)
<summary><b>Profesora Clemencia Caldera</b></summary>
* [Correo](mailto:clemenciacaldera@gmail.com)
* [Web - Clemencia Caldera](https://asesoria-unidad-de-computacion.blogspot.com/)
![clc](https://raw.githubusercontent.com/yordisc/Restaurante-330-UNA.git/master/clc.png)
</details>

## :venezuela: Social Media 
* [Stackoverflow](https://stackoverflow.com/users/19875787/yordisc)
* [Reddit](https://www.reddit.com/user/yordiscujar)
* [Linkedin](https://www.linkedin.com/in/yordiscujar/)

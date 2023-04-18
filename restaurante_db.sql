CREATE DATABASE restaurante_db;

USE restaurante_db;

-- Tabla para clientes
CREATE TABLE clientes (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(255) NOT NULL,
  telefono VARCHAR(20) NOT NULL,
  direccion VARCHAR(255) NOT NULL
);

-- Tabla para mesas
CREATE TABLE mesas (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  numero_mesa INT NOT NULL,
  capacidad INT NOT NULL
);

-- Tabla para platillos
CREATE TABLE platillos (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(255) NOT NULL,
  descripcion TEXT NOT NULL,
  precio DECIMAL(10, 2) NOT NULL,
  categoria VARCHAR(20) NOT NULL
);

-- Tabla para pedidos
CREATE TABLE pedidos (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  numero_pedido INT NOT NULL,
  mesa_id INT NOT NULL,
  cliente_id INT NOT NULL,
  total DECIMAL(10, 2) NOT NULL,
  FOREIGN KEY (mesa_id) REFERENCES mesas(id),
  FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

-- Tabla para platillos pedidos en un pedido
CREATE TABLE platillos_pedidos (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  platillo_id INT NOT NULL,
  pedido_id INT NOT NULL,
  cantidad INT NOT NULL,
  FOREIGN KEY (platillo_id) REFERENCES platillos(id),
  FOREIGN KEY (pedido_id) REFERENCES pedidos(id)
);
CREATE DATABASE restaurante;

USE restaurante;

CREATE TABLE platos (
  plato_id INT PRIMARY KEY,
  nombre VARCHAR(255),
  precio DECIMAL(10,2)
);

CREATE TABLE mesas (
  mesa_id INT PRIMARY KEY,
  num_asientos INT,
  ocupada TINYINT
);

CREATE TABLE ordenes (
  orden_id INT PRIMARY KEY,
  mesa_id INT,
  plato_id INT,
  cantidad INT,
  FOREIGN KEY (mesa_id) REFERENCES mesas(mesa_id),
  FOREIGN KEY (plato_id) REFERENCES platos(plato_id)
);
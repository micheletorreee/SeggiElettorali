CREATE DATABASE elezioni;

USE elezioni;

-- Creazione della tabella ComponenteSeggio
CREATE TABLE ComponenteSeggio (
  ID INT PRIMARY KEY,
  Ruolo NVARCHAR(255)
);

-- Creazione della tabella Edificio
CREATE TABLE Edificio (
  ID INT PRIMARY KEY,
  NomeEdificio NVARCHAR(255),
  ViaEdificio NVARCHAR(255)
);

-- Creazione della tabella Seggio
CREATE TABLE Seggio (
  NumSeggio INT PRIMARY KEY,
  IDedificio INT,
  FOREIGN KEY (IDedificio) REFERENCES Edificio(ID)
);

-- Creazione della tabella Elettore
CREATE TABLE Elettore (
  ID INT PRIMARY KEY,
  Cognome NVARCHAR(255) NOT NULL,
  Nome NVARCHAR(255) NOT NULL,
  DataNascita DATE,
  Sesso CHAR(1),
  Via NVARCHAR(255),
  NumSeggio INT,
  IdComponente INT,
  FOREIGN KEY (NumSeggio) REFERENCES Seggio(NumSeggio),
  FOREIGN KEY (IdComponente) REFERENCES ComponenteSeggio(ID)
);

-- Inserimento dati nella tabella ComponenteSeggio
INSERT INTO ComponenteSeggio (ID, Ruolo)
VALUES
(1, 'Presidente'),
(2, 'Segretario'),
(3, 'Scrutatore'),
(4, 'Supplente'),
(5, 'Responsabile tecnico');

-- Inserimento dati nella tabella Edificio
INSERT INTO Edificio (ID, NomeEdificio, ViaEdificio)
VALUES
(1, 'Scuola Primaria Giovanni XXIII', 'Via Roma, 1'),
(2, 'Palazzina Comunale', 'Via Garibaldi, 10'),
(3, 'Centro Civico', 'Piazza Libertà, 5'),
(4, 'Scuola Media Leonardo da Vinci', 'Via Venezia, 20'),
(5, 'Municipio', 'Piazza Municipio, 3');

-- Inserimento dati nella tabella Seggio
INSERT INTO Seggio (NumSeggio, IDedificio)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

-- Inserimento dati nella tabella Elettore
INSERT INTO Elettore (ID, Cognome, Nome, DataNascita, Sesso, Via, NumSeggio, IdComponente)
VALUES
(1, 'Rossi', 'Mario', '1990-05-15', 'M', 'Via Garibaldi, 2', 1, 1),
(2, 'Bianchi', 'Anna', '1985-08-20', 'F', 'Via Roma, 5', 2, 2),
(3, 'Verdi', 'Luigi', '1978-11-10', 'M', 'Piazza Libertà, 8', 3, 3),
(4, 'Russo', 'Giulia', '2000-02-25', 'F', 'Via Venezia, 15', 4, 4),
(5, 'Ferrari', 'Paolo', '1995-04-30', 'M', 'Piazza Municipio, 6', 5, 5);


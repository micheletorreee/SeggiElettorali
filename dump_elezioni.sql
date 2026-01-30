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

--1. Gli elenchi degli elettori (con cognome, nome e data di nascita), assegnati ad un seggio
-- (di cui viene fornito il numero), distinti per sesso

SELECT e.Nome, e.Cognome, e.DataNascita, e.sesso
FROM Elettore e, Seggio s
WHERE e.NumSeggio = s.NumSeggio
AND s.NumSeggio = :seggio
ORDER BY e.Sesso;

--tutti gli elettori nel seggio 1
UPDATE Elettore
SET NumSeggio = 1;

-- 2. L’elenco di tutti i seggi con numero, edificio dove è collocato e nome del presidente di
-- seggio

SELECT  s.NumSeggio, ed.NomeEdificio, c.Ruolo
FROM Seggio s, Edificio ed, ComponenteSeggio c, Elettore e
WHERE s.IdEdificio = ed.ID 
AND e.NumSeggio = s.NumSeggio
AND c.ID = e.IDComponente
AND c.Ruolo LIKE 'Presidente';

-- 3. Dato il numero di un seggio, l’elenco con i nomi dei componenti del seggio, presidente e
-- scrutatori
-- 4. L’elenco delle vie con il numero di seggio assegnato a ciascuna
-- 5. Il numero dei seggi assegnato a ciascuna via
-- 6. L’elenco degli edifici
-- 7. L’elenco dei custodi assegnati ai vari edifici
-- 8. L’elenco degli elettori che si presentano per la prima volta a votare (>= 18 anni di età
-- rispetto alla data odierna)
-- 9. L’elenco degli edifici che hanno un numero di seggi uguale ad un valore prefissato
-- 10. L’edificio che ha il maggior numero di seggi
-- 11. Il numero di seggio con relativo edificio e via, che ha il maggior numero di elettori
-- 12. Conteggio totale degli elettori per ogni seggio
-- 13. Distribuzione elettori per sesso e ruolo nel seggio
-- 14. Conteggio degli elettori nati in un determinato mese
-- 15. Seggi con meno di 2 elettori o senza componenti assegnati
-- Active: 1769584376247@@127.0.0.1@3306@elezioni
CREATE DATABASE IF NOT EXISTS elezioni;

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

--Insert di Chat tappabuchi
/* ===========================
   DATI EXTRA (run AFTER i tuoi INSERT)
   =========================== */

/* 1) Aggiungo ruoli utili (es. custode) */
INSERT INTO ComponenteSeggio (ID, Ruolo) VALUES
(6, 'Custode'),
(7, 'Vicepresidente');

/* 2) Aggiungo un edificio senza seggi (utile per test elenco edifici) */
INSERT INTO Edificio (ID, NomeEdificio, ViaEdificio) VALUES
(6, 'Palestra Comunale', 'Via dello Sport, 12');

/* 3) Aggiungo nuovi seggi, creando edifici con PIÙ seggi
      - Edificio 1 avrà seggi 1,6,7
      - Edificio 3 avrà seggi 3,8
*/
INSERT INTO Seggio (NumSeggio, IDedificio) VALUES
(6, 1),
(7, 1),
(8, 3);

/* 4) Aggiungo elettori e componenti per coprire query 1..15
      - Presidenti per seggi 2,3,4,5,6,7,8 (oltre al seggio 1 già coperto)
      - Scrutatori per vari seggi
      - Custodi collegati a edifici tramite seggio
      - Seggio con 1 elettore (seggio 7)
      - Seggio con 0 elettori (seggio 8) -> utile per "senza elettori"
      - Alcuni elettori senza seggio (NumSeggio NULL)
      - Date di nascita varie (anche per mese e per età ~18)
*/
INSERT INTO Elettore (ID, Cognome, Nome, DataNascita, Sesso, Via, NumSeggio, IdComponente) VALUES
-- Presidenti mancanti (uno per seggio)
(6,  'Neri',     'Carla',   '1975-03-12', 'F', 'Via Roma, 12', 2, 1),
(7,  'Gallo',    'Enrico',  '1968-07-22', 'M', 'Via Garibaldi, 18',     3, 1),
(8,  'Fontana',  'Sara',    '1982-10-05', 'F', 'Via Venezia, 3',        4, 1),
(9, 'Marino',   'Davide',  '1979-01-30', 'M', 'Piazza Municipio, 10', 5, 1),
(10, 'Costa',    'Luca',    '1988-11-14', 'M', 'Via Roma, 20',          6, 1),
(11, 'Greco',    'Marta',   '1991-06-09', 'F', 'Via Roma, 22',          7, 1),
(12, 'Ferri',    'Irene',   '1980-09-01', 'F', 'Piazza Libertà, 2',     8, 1),
-- Scrutatori (per query 3)
(13, 'Sala',     'Giorgio', '1994-02-10', 'M', 'Via Garibaldi, 7',      2, 3),
(14, 'Riva',     'Elena',   '1992-02-21', 'F', 'Via Roma, 9',           2, 3),
(15, 'Testa',    'Marco',   '1998-05-19', 'M', 'Piazza Libertà, 11',    3, 3),
(16, 'Fiore',    'Noemi',   '1999-12-03', 'F', 'Via Venezia, 44',       4, 3),
(17, 'Pellegrini','Ivan',   '1986-04-25', 'M', 'Piazza Municipio, 1',   5, 3),
(18, 'Sanna',    'Giada',   '1997-08-08', 'F', 'Via Roma, 25',          6, 3),
-- Custodi (per query 7 “custodi ai vari edifici” via Seggio->Edificio)
(19, 'Colombo',  'Rita',    '1983-03-03', 'F', 'Via Roma, 2',           1, 6),
(20, 'Moretti',  'Paolo',   '1970-07-07', 'M', 'Piazza Libertà, 30',    3, 6),
-- Segretari / supplenti extra (varietà ruoli)
(21, 'Serra',    'Nadia',   '1990-09-17', 'F', 'Via Venezia, 9',        4, 2),
(22, 'De Luca',  'Stefano', '1989-10-28', 'M', 'Via Garibaldi, 21',     6, 4),
-- Elettori “normali” (IdComponente NULL) per conteggi e distribuzioni
(23, 'Ricci',    'Alessio', '2008-01-15', 'M', 'Via Roma, 55',          1, NULL), -- ~18 (dipende dalla data odierna)
(24, 'Lombardi', 'Chiara',  '2007-12-01', 'F', 'Via Roma, 55',          1, NULL), -- ~18+
(25, 'Barbieri', 'Tommaso', '2010-06-20', 'M', 'Via Garibaldi, 2',      2, NULL), -- <18 (test filtro)
(26, 'Giordano', 'Silvia',  '1996-06-11', 'F', 'Via Garibaldi, 2',      2, NULL),
(27, 'Mancini',  'Fabio',   '1985-03-27', 'M', 'Piazza Libertà, 8',     3, NULL),
(28, 'Longo',    'Arianna', '1993-04-02', 'F', 'Via Venezia, 15',       4, NULL),
(29, 'Piras',    'Emanuele','1977-11-23', 'M', 'Piazza Municipio, 6',   5, NULL),
(30, 'Ruggeri',  'Sofia',   '1999-02-14', 'F', 'Via Roma, 20',          6, NULL),
-- Seggio 7 volutamente con POCHI elettori (qui 1 solo “normale” + presidente già inserito sopra)
(31, 'Caruso',   'Mirko',   '1990-05-05', 'M', 'Via Roma, 22',          7, NULL),
-- Elettori SENZA seggio (NumSeggio NULL) per test LEFT JOIN / “buchi”
(32, 'Bellini',  'Lucia',   '1984-01-09', 'F', 'Via Senza Seggio, 1',   NULL, NULL),
(33, 'Conti',    'Andrea',  '1972-09-19', 'M', 'Via Senza Seggio, 2',   NULL, NULL);

INSERT INTO Elettore (ID, Cognome, Nome, DataNascita, Sesso, Via, NumSeggio, IdComponente) VALUES
(34, 'Conti',    'Andrea',  '2008-02-06', 'M', 'Via Senza Seggio, 2',   NULL, NULL);

--1. Gli elenchi degli elettori (con cognome, nome e data di nascita), assegnati ad un seggio
-- (di cui viene fornito il numero), distinti per sesso

SELECT e.Nome, e.Cognome, e.DataNascita, e.sesso
FROM Elettore e, Seggio s
WHERE e.NumSeggio = s.NumSeggio
AND s.NumSeggio = :seggio
ORDER BY e.Sesso;

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

SELECT  e.Nome, e.Cognome, c.Ruolo
FROM Seggio s, ComponenteSeggio c, Elettore e
WHERE e.NumSeggio = s.NumSeggio
AND s.NumSeggio = :Nseggio
AND c.ID = e.IdComponente
AND c.Ruolo IN ("Presidente","Scrutatore");

-- 4. L’elenco delle vie con il numero di seggio assegnato a ciascuna

SELECT ed.ViaEdificio, s.NumSeggio 
FROM Seggio s, Edificio ed
WHERE ed.ID = s.IDedificio;

-- 5. Il numero dei seggi assegnato a ciascuna via

SELECT ed.ViaEdificio, COUNT(*) as "NumeriSeggi"
FROM Seggio s, Edificio ed
WHERE ed.ID = s.IDedificio
GROUP BY ed.ViaEdificio;

-- 6. L’elenco degli edifici

SELECT ed.NomeEdificio, ed.ViaEdificio
FROM edificio ed;

-- 7. L’elenco dei custodi assegnati ai vari edifici

SELECT  e.Nome, e.Cognome, c.Ruolo
FROM Seggio s, ComponenteSeggio c, Elettore e
WHERE e.NumSeggio = s.NumSeggio
AND c.ID = e.IdComponente
AND c.Ruolo IN ("Custode");

-- 8. L’elenco degli elettori che si presentano per la prima volta a votare (>= 18 anni di età
-- rispetto alla data odierna)

SELECT e.Nome, e.Cognome, e.DataNascita, e.sesso
FROM Elettore e
WHERE TIMESTAMPDIFF(YEAR,e.DataNascita,CURDATE())=18
ORDER BY e.DataNascita;


-- 9. L’elenco degli edifici che hanno un numero di seggi uguale ad un valore prefissato

SELECT ed.NomeEdificio,COUNT(*) as "TotaleSeggi"
FROM Seggio s, Edificio ed
WHERE ed.ID = s.IdEdificio
GROUP BY ed.ID
HAVING TotaleSeggi = :NumSeggio9;

-- 10. L’edificio che ha il maggior numero di seggi

SELECT ed.NomeEdificio,COUNT(*) as "TotaleSeggi"
FROM Seggio s, Edificio ed
WHERE ed.ID = s.IdEdificio
GROUP BY ed.ID
ORDER BY TotaleSeggi DESC
LIMIT 1;

-- 10b. L’edificio che ha il maggior numero di seggi

SELECT q.NomeEdificio,MAX(q.TotaleSeggi) as "MassimoSeggi"
FROM (SELECT ed.NomeEdificio,COUNT(*) as "TotaleSeggi"
      FROM Seggio s, Edificio ed
      WHERE ed.ID = s.IdEdificio
      GROUP BY ed.ID) q;

-- 11. Il numero di seggio con relativo edificio e via, che ha il maggior numero di elettori
SELECT q.*
FROM (SELECT s.NumSeggio,COUNT(*) AS "TotaleElettori",ed.ViaEdificio
FROM Elettore e, Seggio s, edificio ed
WHERE e.NumSeggio = s.NumSeggio
AND ed.ID = s.IDEdificio
GROUP BY s.NumSeggio) q
WHERE TotaleElettori = (SELECT MAX(TotaleElettori) AS "MAXTotaleElettori"
FROM Elettore e, Seggio s, edificio ed
WHERE e.NumSeggio = s.NumSeggio
AND ed.ID = s.IDEdificio
GROUP BY s.NumSeggio) x;


-- 12. Conteggio totale degli elettori per ogni seggio
-- 13. Distribuzione elettori per sesso e ruolo nel seggio
-- 14. Conteggio degli elettori nati in un determinato mese
-- 15. Seggi con meno di 2 elettori o senza componenti assegnati
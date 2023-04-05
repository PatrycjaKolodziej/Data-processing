DROP DATABASE car_rental;
CREATE  DATABASE car_rental;

USE car_rental;


CREATE TABLE cars
(
 car_id INTEGER PRIMARY KEY,
 producer VARCHAR(30),
 model VARCHAR(30),
 year INTEGER,
 horse_power INTEGER,
 price_per_day INTEGER
);
CREATE TABLE clients
(
 client_id INTEGER PRIMARY KEY,
 name VARCHAR(30),
 surname VARCHAR(30),
 address TEXT,
 city VARCHAR(30)
);
CREATE TABLE bookings
(
 booking_id INTEGER PRIMARY KEY,
 client_id INTEGER,
 car_id INTEGER,
 start_date DATE,
 end_date DATE,
 total_amount INTEGER
);

ALTER TABLE clients MODIFY COLUMN client_id INTEGER
AUTO_INCREMENT;
ALTER TABLE cars MODIFY COLUMN car_id INTEGER
AUTO_INCREMENT;
ALTER TABLE bookings MODIFY COLUMN booking_id INTEGER
AUTO_INCREMENT;

ALTER TABLE bookings
ADD CONSTRAINT client_id_fk FOREIGN KEY (client_id)
REFERENCES clients (client_id),
ADD CONSTRAINT car_id_fk FOREIGN KEY (car_id)
REFERENCES cars (car_id);

INSERT INTO clients (name, surname, address, city)
VALUES
('Jan', 'Kowalski', 'ul. Florianska 12', 'Krakow'),
('Andrzej', 'Nowak', 'ul. Saska 43', 'Wroclaw' );


INSERT INTO cars (producer, model, year, horse_power,
price_per_day)
VALUES
('Seat', 'Leon', 2016, 80, 200),
('Toyota', 'Avensis', 2014, 72, 100);


INSERT INTO bookings (client_id, car_id, start_date, end_date,
total_amount)
VALUES
(1, 2, '2020-07-05', '2020-07-06', 100),
(2, 2, '2020-07-10', '2020-07-12', 200);

INSERT INTO clients (name, surname, address, city)
VALUES
 ('Michal', 'Taki', 'os. Srodkowe 12', 'Poznan'),
 ('Pawel', 'Ktory', 'ul. Stara 11', 'Gdynia'),
 ('Anna', 'Inna', 'os. Srednie 1', 'Gniezno'),
 ('Alicja', 'Panna', 'os. Duze 33', 'Torun'),
 ('Damian', 'Papa', 'ul. Skosna 66', 'Warszawa'),
 ('Marek', 'Troska', 'os. Male 90', 'Radom'),
 ('Jakub', 'Klos', 'os. Polskie 19', 'Wadowice'),
 ('Lukasz', 'Lis', 'os. Podlaskie 90', 'Bialystok');

INSERT INTO cars (producer, model, year, horse_power,
price_per_day) VALUES
 ('Mercedes', 'CLK', 2018, 190, 400),
 ('Hyundai', 'Coupe', 2014, 165, 300),
 ('Dacia', 'Logan', 2015, 103, 150),
 ('Saab', '95', 2012, 140, 140),
 ('BMW', 'E36', 2007, 110, 80),
 ('Fiat', 'Panda', 2016, 77, 190),
 ('Honda', 'Civic', 2019, 130, 360),
 ('Volvo', 'XC70', 2013, 180, 280);

INSERT INTO bookings (client_id, car_id, start_date,
end_date, total_amount) VALUES
 (3, 3, '2020-07-06', '2020-07-08', 400),
 (6, 10, '2020-07-10', '2020-07-16', 1680),
 (4, 5, '2020-07-11', '2020-07-14', 450),
 (5, 4, '2020-07-11', '2020-07-13', 600),
 (7, 3, '2020-07-12', '2020-07-14', 800),
 (5, 7, '2020-07-14', '2020-07-17', 240),
 (3, 8, '2020-07-14', '2020-07-16', 380),
 (5, 9, '2020-07-15', '2020-07-18', 1080),
 (6, 10, '2020-07-16', '2020-07-20', 1120),
 (8, 1, '2020-07-16', '2020-07-19', 600),
 (9, 2, '2020-07-16', '2020-07-21', 500),
 (10, 6, '2020-07-17', '2020-07-19', 280),
 (1, 9, '2020-07-17', '2020-07-19', 720),
 (3, 7, '2020-07-18', '2020-07-21', 240),
 (5, 4, '2020-07-18', '2020-07-22', 1200);

-- Zadanie 10
-- 1. Wypisz wszystkie samochody, których rok produkcji jest większy niż 2015.
-- 2. *Wypisz wszystkie rezerwacje, których koszt całkowity znajduje się w
-- przedziale 1000-2555.
-- 3. *Wypisz id wszystkich klientów, których nazwisko zaczyna się na literę 'N'
-- oraz imię kończy się na litery 'ej'.

#1)
SELECT *
FROM cars
WHERE year > 2015;
#2)
SELECT *
FROM bookings
WHERE total_amount
BETWEEN 1000 AND 2555;
#3)
SELECT client_id
FROM clients
WHERE surname
LIKE "N%" AND name LIKE "%ej";







#1)
SELECT c.name, b.total_amount
FROM bookings b
JOIN clients c ON c.client_id = b.client_id
WHERE b.total_amount > 1000;
#2)
SELECT c.city, b.total_amount
FROM clients c
JOIN bookings b ON c.client_id = b.client_id
JOIN cars r ON b.car_id = r.car_id
WHERE b.start_date >= '2020-07-12'
AND b.end_date <= '2020-07-20'
AND r.horse_power <= 120
ORDER BY b.total_amount DESC;
#3)
SELECT COUNT(b.car_id)
FROM bookings b
JOIN cars r ON b.car_id = r.car_id
WHERE r.price_per_day >= 300
GROUP BY r.horse_power
ORDER BY r.horse_power;
#4)
SELECT SUM(total_amount)
FROM bookings
WHERE start_date >= '2020-07-14'
AND end_date <= '2020-07-18';
#5)
SELECT AVG(b.total_amount) AS
Srednia_wartosc_rezerwacji,
COUNT(b.car_id) AS
Liczba_wypozyczonych_samochodow,
c.name AS Imie, c.surname AS Nazwisko
FROM bookings b
JOIN clients c ON c.client_id = b.client_id
GROUP BY b.client_id
HAVING Liczba_wypozyczonych_samochodow >= 2
ORDER BY Liczba_wypozyczonych_samochodow DESC;





SELECT c.city, b.total_amount
FROM clients c
JOIN bookings b ON c.client_id = b.client_id
JOIN cars r ON b.car_id = r.car_id
WHERE b.start_date >= '2020-07-12'

AND r.horse_power <= 300
ORDER BY c.city DESC;


SELECT c.city, b.total_amount
FROM clients c
JOIN bookings b ON c.client_id = b.client_id
JOIN cars r ON b.car_id = r.car_id
WHERE b.start_date >= '2020-07-12'

AND r.horse_power <= 300
ORDER BY c.city DESC





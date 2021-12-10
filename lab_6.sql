CREATE DATABASE lab6;
CREATE SCHEMA lab_six;
create table dealer (
    id integer primary key ,
    name varchar(255),
    location varchar(255),
    charge float
);

INSERT INTO dealer (id, name, location, charge) VALUES (101, 'Ерлан', 'Алматы', 0.15);
INSERT INTO dealer (id, name, location, charge) VALUES (102, 'Жасмин', 'Караганда', 0.13);
INSERT INTO dealer (id, name, location, charge) VALUES (105, 'Азамат', 'Нур-Султан', 0.11);
INSERT INTO dealer (id, name, location, charge) VALUES (106, 'Канат', 'Караганда', 0.14);
INSERT INTO dealer (id, name, location, charge) VALUES (107, 'Евгений', 'Атырау', 0.13);
INSERT INTO dealer (id, name, location, charge) VALUES (103, 'Жулдыз', 'Актобе', 0.12);

create table client (
    id integer primary key ,
    name varchar(255),
    city varchar(255),
    priority integer,
    dealer_id integer references dealer(id)
);

INSERT INTO client (id, name, city, priority, dealer_id) VALUES (802, 'Айша', 'Алматы', 100, 101);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (807, 'Даулет', 'Алматы', 200, 101);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (805, 'Али', 'Кокшетау', 200, 102);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (808, 'Ильяс', 'Нур-Султан', 300, 102);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (804, 'Алия', 'Караганда', 300, 106);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (809, 'Саша', 'Шымкент', 100, 103);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (803, 'Маша', 'Семей', 200, 107);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (801, 'Максат', 'Нур-Султан', null, 105);

create table sell (
    id integer primary key,
    amount float,
    date timestamp,
    client_id integer references client(id),
    dealer_id integer references dealer(id)
);

INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (201, 150.5, '2012-10-05 00:00:00.000000', 805, 102);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (209, 270.65, '2012-09-10 00:00:00.000000', 801, 105);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (202, 65.26, '2012-10-05 00:00:00.000000', 802, 101);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (204, 110.5, '2012-08-17 00:00:00.000000', 809, 103);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (207, 948.5, '2012-09-10 00:00:00.000000', 805, 102);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (205, 2400.6, '2012-07-27 00:00:00.000000', 807, 101);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (208, 5760, '2012-09-10 00:00:00.000000', 802, 101);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (210, 1983.43, '2012-10-10 00:00:00.000000', 804, 106);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (203, 2480.4, '2012-10-10 00:00:00.000000', 809, 103);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (212, 250.45, '2012-06-27 00:00:00.000000', 808, 102);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (211, 75.29, '2012-08-17 00:00:00.000000', 803, 107);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (213, 3045.6, '2012-04-25 00:00:00.000000', 802, 101);

-- drop table client;
-- drop table dealer;
-- drop table sell;

-- 1a
SELECT * FROM dealer JOIN client ON dealer.id = client.dealer_id;

-- 1b
SELECT dealer, client.name, client.city, client.priority, sell.id, sell.date, sell.amount
FROM dealer JOIN client ON dealer.id = client.dealer_id
JOIN sell ON dealer.id = sell.dealer_id AND client.id = sell.client_id;

-- 1c
SELECT * FROM dealer JOIN client ON dealer.id = client.dealer_id WHERE dealer.location=client.city;

-- 1d
SELECT sell.id, sell.amount, client.name, client.city
FROM client JOIN sell ON client.id = sell.client_id WHERE sell.amount BETWEEN 100 AND 500;

-- 1e
SELECT * FROM dealer FULL OUTER JOIN client ON dealer.id = client.dealer_id;

-- 1f
SELECT client.name, client.city, dealer.name,dealer.charge
FROM dealer JOIN client ON dealer.id = client.dealer_id;

-- 1g
SELECT client.name, client.city, dealer, dealer.charge
FROM client JOIN dealer ON dealer.id = client.dealer_id
WHERE dealer.charge > 0.12;

-- 1h
SELECT client.name, client.city, sell.id, sell.date, sell.amount, dealer.name, dealer.charge
FROM dealer JOIN client ON dealer.id = client.dealer_id
JOIN sell ON client.id = sell.client_id;

-- 1i
SELECT client.name, client.priority, dealer.name, sell.id, sell.amount
FROM dealer JOIN client ON dealer.id = client.dealer_id
JOIN sell ON client.id = sell.client_id
WHERE priority IS NOT NULL AND sell.amount > 2000;

-- 2a
CREATE VIEW v1 AS
    SELECT date, COUNT(distinct client_id) as "number", AVG(amount) as "average", SUM(amount) as "total"
    FROM sell group by date;

-- 2b
CREATE VIEW v2 AS
    SELECT date, amount FROM sell ORDER BY amount DESC LIMIT 5;

-- 2c
CREATE VIEW v3 AS
    SELECT dealer, COUNT(amount) as "number", AVG(amount) as "average",SUM(amount) as "total"
    FROM sell JOIN dealer ON sell.dealer_id = dealer.id GROUP BY dealer;

-- 2d
CREATE VIEW v4 AS
    SELECT dealer, SUM(amount * dealer.charge) AS "earned"
    FROM sell JOIN dealer ON sell.dealer_id = dealer.id GROUP BY dealer;

-- 2e
CREATE VIEW v5 AS
    SELECT location, COUNT(amount) as "number", AVG(amount) as "avarage", SUM(amount) as "total"
    FROM dealer JOIN sell ON dealer.id = sell.dealer_id GROUP BY location;

-- 2f
CREATE VIEW v6 AS
    SELECT city , COUNT(amount) as "number", AVG(amount * (dealer.charge + 1)) as "average", SUM(amount * (dealer.charge +1)) as "total"
    FROM client JOIN dealer ON client.dealer_id = dealer.id
    JOIN sell ON client.id = sell.client_id GROUP BY city;

-- 2g
CREATE VIEW v7 AS
    SELECT client.city, SUM(sell.amount * (dealer.charge + 1)) AS cities, SUM(amount) AS locations
    FROM client JOIN sell ON client.id = sell.client_id
    JOIN dealer ON sell.dealer_id = dealer.id and client.city = dealer.location GROUP BY city;
CREATE DATABASE lab8;
CREATE SCHEMA last_lab;
-- 1
-- a
CREATE FUNCTION inc(val integer) RETURNS integer
LANGUAGE plpgsql
AS
    $$
    BEGIN
        RETURN val + 1;
    END;
    $$;
SELECT inc(89);

-- b
CREATE FUNCTION sum(val1 integer, val2 integer) RETURNS integer
LANGUAGE plpgsql
AS
    $$
    BEGIN
        RETURN val1 + val2;
    END;
    $$;

SELECT sum(45, 60);

-- c
CREATE FUNCTION div(num numeric) RETURNS BOOLEAN
LANGUAGE plpgsql
AS
    $$
    BEGIN
        IF(num % 2 = 0) THEN
            RETURN TRUE;
        ELSE
            RETURN FALSE;
        END IF;
    END;
    $$;

SELECT div(89);
SELECT div(48);

-- d
CREATE FUNCTION check_pass(pass text) RETURNS BOOLEAN
language plpgsql
AS
    $$
    BEGIN
        IF(length(pass) >= 8) THEN
            RETURN TRUE;
        ELSE
            RETURN FALSE;
        END IF;
    END;
    $$;

SELECT check_pass('hjudjsk');
SELECT check_pass('hyfj89dl');

-- e
CREATE or REPLACE function f(days integer, out year integer, out month integer, out day integer)
LANGUAGE plpgsql
AS
    $$
    BEGIN
        year := days / 365;
        month := days % 365 / 30;
        day := days % 365 % 30;
    END;
    $$;

SELECT f(366);

-- 2
-- a
CREATE TABLE playlist(
    id serial primary key ,
    name varchar(50) not null,
    changed timestamp
);

INSERT INTO playlist(name) VALUES ('Dynamite');
INSERT INTO playlist(name) VALUES ('Peaches');
INSERT INTO playlist(name) VALUES ('STAY');
INSERT INTO playlist(name) VALUES ('Levitating');

CREATE or REPLACE function changed() RETURNS TRIGGER
LANGUAGE plpgsql
AS
    $$
    BEGIN
        new.changed = now();
        RETURN new;
    END;
    $$;

CREATE TRIGGER playlist_changed BEFORE INSERT or UPDATE
    ON playlist FOR each row execute procedure changed();

SELECT * FROM playlist;

INSERT INTO playlist(name) VALUES ('MONTERO');

UPDATE playlist
SET name = 'Beggin' WHERE id = 5;

SELECT * FROM playlist;

-- b
CREATE TABLE person(
    id serial primary key ,
    name varchar(50),
    age integer,
    year_of_birth integer not null
);

CREATE or REPLACE function calc() RETURNS TRIGGER
LANGUAGE plpgsql
AS
    $$
    BEGIN
        new.age = extract(year from current_date) - new.year_of_birth;
        return new;
    END;
    $$;

CREATE TRIGGER age1 BEFORE INSERT or UPDATE
    ON person FOR each row execute procedure calc();

insert into person (name, year_of_birth) values ('Ruth', 1996);
insert into person (name, year_of_birth) values ('Jammal', 2011);
insert into person (name, year_of_birth) values ('Dolorita', 2007);
insert into person (name, year_of_birth) values ('Juanita', 2004);
insert into person (name, year_of_birth) values ('Iolanthe', 2003);

SELECT * FROM person;

-- c
CREATE TABLE item(
    id serial primary key ,
    name varchar(50),
    price integer not null
);

CREATE or REPLACE function total() RETURNS TRIGGER
LANGUAGE plpgsql
AS
    $$
    BEGIN
        UPDATE item
        SET price = price * 1.12 WHERE id = new.id;
        RETURN new;
    END;
    $$;

CREATE TRIGGER cost AFTER INSERT
    ON item FOR each row execute procedure total();

insert into item (name, price) values ('Puree - Mocha', 29);
insert into item (name, price) values ('Rosemary - Dry', 13);
insert into item (name, price) values ('Beets - Golden', 28);
insert into item (name, price) values ('Longos - Cheese Tortellini', 60);

SELECT * FROM item;

-- d
CREATE or REPLACE function reset() RETURNS TRIGGER
LANGUAGE plpgsql
AS
    $$
    BEGIN
        INSERT INTO item(id, name, price) values(old.id, old.name, old.price);
        RETURN old;
    END;
    $$;

CREATE TRIGGER back
    AFTER DELETE ON item FOR each row execute procedure reset();

DELETE FROM item where id = 4;

SELECT * FROM item;

---------------------------------------------3----------------------------------------------------------------------
--------------------------------------the differents---------------------------------------------------------------
-- The function must return a value but in Stored Procedure it is optional. Even a procedure can return zero or n values.
-- Functions can have only input parameters for it whereas Procedures can have input or output parameters.
-- Functions can be called from Procedure whereas Procedures cannot be called from a Function.

-----4
CREATE TABLE employee(
    id integer,
    name varchar(100),
    date_of_birth date,
    age integer,
    salary integer,
    workexperience integer,
    discount integer,
    primary key (id)
);

insert into employee (id, name, date_of_birth, age, salary, workexperience, discount) values (1, 'Marissa', '2021-08-03', 50, 169377, 28, 40757);
insert into employee (id, name, date_of_birth, age, salary, workexperience, discount) values (2, 'Goldy', '2021-09-23', 39, 206318, 4, 4238);
insert into employee (id, name, date_of_birth, age, salary, workexperience, discount) values (3, 'Letitia', '2021-01-11', 60, 210904, 18, 10059);
insert into employee (id, name, date_of_birth, age, salary, workexperience, discount) values (4, 'Lon', '2021-09-19', 24, 260915, 24, 46279);
insert into employee (id, name, date_of_birth, age, salary, workexperience, discount) values (5, 'Adelheid', '2021-11-14', 35, 131388, 10, 3887);

-----------------------------------------------------------a-----------------------------------------------------------
CREATE or REPLACE procedure salary()
LANGUAGE plpgsql
AS
    $$
    BEGIN
        UPDATE employee SET salary = salary * 1.1 WHERE workexperience >= 2;
        UPDATE employee SET discount = discount * 1.1 WHERE workexperience >= 2;
        UPDATE employee SET discount = discount * 1.01 WHERE workexperience >= 5;
    COMMIT;
    END;
    $$;

SELECT * FROM employee;

----------------------------------------------------------------b--------------------------------------------------------
CREATE or REPLACE procedure salary()
LANGUAGE plpgsql
AS
    $$
    BEGIN
        UPDATE employee SET salary = salary * 1.15 WHERE age >= 40;
        UPDATE employee SET salary = salary * 1.15 WHERE workexperience >= 8;
        UPDATE employee SET discount = discount * 1.2 WHERE workexperience >= 8;
    COMMIT;
    END;
    $$;

SELECT * FROM employee;

-- 5
CREATE TABLE members(
    memid integer,
    surname varchar(200),
    firstname varchar(200),
    address varchar(300),
    zipcode integer,
    telephone varchar(20),
    recommendedby integer,
    joindate timestamp,
    primary key (memid)
);

CREATE TABLE facilities(
    facid integer,
    name varchar(100),
    membercost numeric,
    guestcost numeric,
    initialoutlay numeric,
    monthlymaintenance numeric,
    primary key (facid)
);

CREATE TABLE bookings(
    facid integer,
    memid integer,
    starttime timestamp,
    slots integer,
    foreign key (facid) references facilities,
    foreign key (memid) references members
);

WITH RECURSIVE recomm(recommender, member)
AS (
        SELECT recommendedby, memid FROM members
        UNION ALL
        SELECT members.recommendedby, recomm.member FROM recomm
            INNER JOIN members ON members.memid = recomm.recommender
    )
SELECT recomm.member member, recomm.recommender, members.firstname, members.surname FROM recomm
    INNER JOIN members ON recomm.recommender = members.memid
WHERE recomm.member = 22 or recomm.member = 12
ORDER BY recomm.member asc, recomm.recommender desc;

-- insert to members------------------------------------------------------------------------------------------------

insert into members (memid, surname, firstname, address, zipcode, telephone, recommendedby, joindate) values (12, 'Fivey', 'Bette-ann', '8 2nd Junction', 93, '658-596-2625', 84, '2021-04-02');
insert into members (memid, surname, firstname, address, zipcode, telephone, recommendedby, joindate) values (22, 'MacAnellye', 'Kimberly', '3 Novick Avenue', 89, '196-232-9987', 78, '2021-01-20');
insert into members (memid, surname, firstname, address, zipcode, telephone, recommendedby, joindate) values (77, 'Limpricht', 'Merrill', '4751 Basil Hill', 14, '433-124-2675', 34, '2021-01-31');
insert into members (memid, surname, firstname, address, zipcode, telephone, recommendedby, joindate) values (94, 'Lavalle', 'Irwin', '5814 Hovde Court', 47, '455-185-6482', 17, '2021-03-14');
insert into members (memid, surname, firstname, address, zipcode, telephone, recommendedby, joindate) values (37, 'Bagg', 'Byram', '0 Artisan Junction', 69, '417-445-3391', 4, '2021-04-05');
insert into members (memid, surname, firstname, address, zipcode, telephone, recommendedby, joindate) values (67, 'Townsend', 'Hilton', '5 Mcbride Road', 1, '816-833-4660', 65, '2021-02-09');
insert into members (memid, surname, firstname, address, zipcode, telephone, recommendedby, joindate) values (3, 'Malim', 'Charla', '20209 Pennsylvania Hill', 69, '185-782-4348', 35, '2021-02-26');
insert into members (memid, surname, firstname, address, zipcode, telephone, recommendedby, joindate) values (73, 'Gresty', 'Corinna', '46 Amoth Junction', 96, '822-647-1862', 44, '2021-03-18');
insert into members (memid, surname, firstname, address, zipcode, telephone, recommendedby, joindate) values (29, 'Angliss', 'Rozamond', '57 Mosinee Drive', 9, '741-279-4939', 36, '2021-02-10');
insert into members (memid, surname, firstname, address, zipcode, telephone, recommendedby, joindate) values (95, 'Iannelli', 'Ezekiel', '4557 Drewry Place', 76, '920-424-5364', 30, '2021-01-27');
insert into members (memid, surname, firstname, address, zipcode, telephone, recommendedby, joindate) values (81, 'Hallet', 'Martin', '8 Lotheville Street', 96, '382-782-6817', 58, '2021-03-08');
insert into members (memid, surname, firstname, address, zipcode, telephone, recommendedby, joindate) values (47, 'Giovannilli', 'Yetta', '6046 Pepper Wood Hill', 16, '587-662-3199', 62, '2020-12-09');
insert into members (memid, surname, firstname, address, zipcode, telephone, recommendedby, joindate) values (82, 'Parade', 'Ranique', '33161 Moulton Parkway', 74, '481-905-8011', 84, '2021-11-20');
insert into members (memid, surname, firstname, address, zipcode, telephone, recommendedby, joindate) values (83, 'Rosina', 'Emanuele', '392 Valley Edge Street', 82, '470-119-7637', 18, '2021-04-10');
insert into members (memid, surname, firstname, address, zipcode, telephone, recommendedby, joindate) values (48, 'Wolfe', 'Christi', '04 Truax Lane', 87, '680-436-4836', 41, '2021-03-24');
insert into members (memid, surname, firstname, address, zipcode, telephone, recommendedby, joindate) values (16, 'Cotterel', 'Brianne', '62 Macpherson Trail', 62, '688-157-1518', 93, '2021-12-01');
insert into members (memid, surname, firstname, address, zipcode, telephone, recommendedby, joindate) values (33, 'Baison', 'Wiatt', '24708 Superior Trail', 87, '616-645-8562', 71, '2020-12-24');
insert into members (memid, surname, firstname, address, zipcode, telephone, recommendedby, joindate) values (79, 'Robshaw', 'Flo', '731 Blue Bill Park Pass', 5, '898-666-9610', 76, '2021-10-23');
insert into members (memid, surname, firstname, address, zipcode, telephone, recommendedby, joindate) values (15, 'Wescott', 'Orsola', '4382 Columbus Plaza', 87, '395-180-3374', 95, '2020-12-28');
insert into members (memid, surname, firstname, address, zipcode, telephone, recommendedby, joindate) values (84, 'Olivie', 'Jamesy', '0 Sachtjen Point', 42, '427-154-5768', 46, '2021-06-08');
insert into members (memid, surname, firstname, address, zipcode, telephone, recommendedby, joindate) values (78, 'Hizir', 'Isadora', '755 Portage Avenue', 6, '561-400-2786', 95, '2021-06-07');
insert into members (memid, surname, firstname, address, zipcode, telephone, recommendedby, joindate) values (60, 'McGurk', 'Erskine', '6 Southridge Road', 46, '538-990-2176', 92, '2021-08-18');
insert into members (memid, surname, firstname, address, zipcode, telephone, recommendedby, joindate) values (74, 'Tayler', 'Ilsa', '58 Lien Lane', 12, '542-876-6926', 17, '2021-08-15');
insert into members (memid, surname, firstname, address, zipcode, telephone, recommendedby, joindate) values (7, 'Cushion', 'Jessi', '05 Delaware Pass', 58, '240-764-2809', 36, '2021-06-14');
insert into members (memid, surname, firstname, address, zipcode, telephone, recommendedby, joindate) values (23, 'Winchurch', 'Yoko', '2707 Vidon Hill', 26, '829-286-4872', 16, '2021-02-02');

-- inserts to fascilities----------------------------------------------------------------------

insert into facilities (facid, name, membercost, guestcost, initialoutlay, monthlymaintenance) values (79, 'Matias', 28, 84, 37, 55);
insert into facilities (facid, name, membercost, guestcost, initialoutlay, monthlymaintenance) values (96, 'Roman', 95, 38, 40, 40);
insert into facilities (facid, name, membercost, guestcost, initialoutlay, monthlymaintenance) values (41, 'Glen', 57, 62, 84, 38);
insert into facilities (facid, name, membercost, guestcost, initialoutlay, monthlymaintenance) values (24, 'Waring', 85, 79, 95, 5);
insert into facilities (facid, name, membercost, guestcost, initialoutlay, monthlymaintenance) values (56, 'Byram', 30, 29, 73, 47);
insert into facilities (facid, name, membercost, guestcost, initialoutlay, monthlymaintenance) values (99, 'Berkly', 97, 33, 10, 4);
insert into facilities (facid, name, membercost, guestcost, initialoutlay, monthlymaintenance) values (88, 'Dniren', 66, 57, 14, 6);
insert into facilities (facid, name, membercost, guestcost, initialoutlay, monthlymaintenance) values (69, 'Ellery', 100, 100, 75, 61);
insert into facilities (facid, name, membercost, guestcost, initialoutlay, monthlymaintenance) values (49, 'Ichabod', 30, 92, 94, 65);
insert into facilities (facid, name, membercost, guestcost, initialoutlay, monthlymaintenance) values (9, 'Forester', 72, 33, 5, 5);
insert into facilities (facid, name, membercost, guestcost, initialoutlay, monthlymaintenance) values (74, 'Poppy', 72, 63, 31, 42);
insert into facilities (facid, name, membercost, guestcost, initialoutlay, monthlymaintenance) values (5, 'Rowen', 76, 71, 70, 99);
insert into facilities (facid, name, membercost, guestcost, initialoutlay, monthlymaintenance) values (39, 'Dewain', 82, 74, 2, 63);
insert into facilities (facid, name, membercost, guestcost, initialoutlay, monthlymaintenance) values (15, 'Veda', 9, 72, 15, 98);
insert into facilities (facid, name, membercost, guestcost, initialoutlay, monthlymaintenance) values (97, 'Ursulina', 21, 56, 86, 81);
insert into facilities (facid, name, membercost, guestcost, initialoutlay, monthlymaintenance) values (17, 'Elizabet', 50, 99, 87, 30);
insert into facilities (facid, name, membercost, guestcost, initialoutlay, monthlymaintenance) values (63, 'Warner', 33, 4, 83, 69);
insert into facilities (facid, name, membercost, guestcost, initialoutlay, monthlymaintenance) values (87, 'Eliza', 30, 9, 26, 88);
insert into facilities (facid, name, membercost, guestcost, initialoutlay, monthlymaintenance) values (93, 'Rhetta', 78, 67, 22, 5);
insert into facilities (facid, name, membercost, guestcost, initialoutlay, monthlymaintenance) values (8, 'Elberta', 48, 18, 31, 65);
insert into facilities (facid, name, membercost, guestcost, initialoutlay, monthlymaintenance) values (84, 'Gracia', 64, 96, 58, 11);
insert into facilities (facid, name, membercost, guestcost, initialoutlay, monthlymaintenance) values (13, 'Maggy', 57, 32, 5, 92);
insert into facilities (facid, name, membercost, guestcost, initialoutlay, monthlymaintenance) values (40, 'Ursa', 36, 63, 24, 27);
insert into facilities (facid, name, membercost, guestcost, initialoutlay, monthlymaintenance) values (4, 'Becka', 13, 96, 96, 98);
insert into facilities (facid, name, membercost, guestcost, initialoutlay, monthlymaintenance) values (31, 'Kaylyn', 84, 92, 59, 7);

-- bookings
insert into bookings (starttime, slots) values ('2021-06-06', 66);
insert into bookings (starttime, slots) values ('2021-07-13', 6);
insert into bookings (starttime, slots) values ('2021-09-03', 71);
insert into bookings (starttime, slots) values ('2021-03-02', 40);
insert into bookings (starttime, slots) values ('2020-12-21', 97);
insert into bookings (starttime, slots) values ('2021-03-29', 36);
insert into bookings (starttime, slots) values ('2021-05-06', 40);
insert into bookings (starttime, slots) values ('2021-02-03', 62);
insert into bookings (starttime, slots) values ('2021-10-29', 21);
insert into bookings (starttime, slots) values ('2021-07-29', 16);
insert into bookings (starttime, slots) values ('2021-10-10', 50);
insert into bookings (starttime, slots) values ('2021-11-13', 40);
insert into bookings (starttime, slots) values ('2020-12-07', 9);
insert into bookings (starttime, slots) values ('2021-07-29', 72);
insert into bookings (starttime, slots) values ('2021-03-08', 83);
insert into bookings (starttime, slots) values ('2021-09-20', 83);
insert into bookings (starttime, slots) values ('2021-10-28', 53);
insert into bookings (starttime, slots) values ('2021-07-13', 11);
insert into bookings (starttime, slots) values ('2021-02-05', 93);
insert into bookings (starttime, slots) values ('2021-03-19', 12);
insert into bookings (starttime, slots) values ('2021-10-04', 23);
insert into bookings (starttime, slots) values ('2021-07-22', 69);
insert into bookings (starttime, slots) values ('2021-09-24', 33);
insert into bookings (starttime, slots) values ('2021-09-20', 62);
insert into bookings (starttime, slots) values ('2021-05-01', 98);
CREATE DATABASE AUTOMOBILE_COMPANY;
CREATE SCHEMA ATO;
CREATE TABLE vehicle(
    vin BIGSERIAL NOT NULL PRIMARY KEY ,
    model_name VARCHAR(50) NOT NULL
);
ALTER TABLE vehicle ADD manufacturer_id BIGINT REFERENCES manufacturer(id);
ALTER TABLE vehicle ADD customer_id BIGINT REFERENCES customer(id);
ALTER TABLE vehicle ADD option_id BIGINT REFERENCES option(id);
ALTER TABLE vehicle ADD model_id BIGINT REFERENCES model(id);
INSERT INTO vehicle(vin,model_name,manufacturer_id,customer_id,option_id,model_id)
VALUES(1,'Ford Mustang',1,1,1,1);
INSERT INTO vehicle(vin,model_name,manufacturer_id,customer_id,option_id,model_id)
VALUES(2,'Audi R8',2,2,2,2);
INSERT INTO vehicle(vin,model_name,manufacturer_id,customer_id,option_id,model_id)
VALUES(3,'BMW M5',3,3,3,3);
INSERT INTO vehicle(vin,model_name,manufacturer_id,customer_id,option_id,model_id)
VALUES(4,'Mercedes S500',4,4,4,4);
INSERT INTO vehicle(vin,model_name,manufacturer_id,customer_id,option_id,model_id)
VALUES(5,'Wolswagen Polo',5,5,5,5);
INSERT INTO vehicle(vin,model_name,manufacturer_id,customer_id,option_id,model_id)
VALUES(6,'Kia Rio',6,6,6,6);
INSERT INTO vehicle(vin,model_name,manufacturer_id,customer_id,option_id,model_id)
VALUES(7,'BMW M3',7,7,7,7);
INSERT INTO vehicle(vin,model_name,manufacturer_id,customer_id,option_id,model_id)
VALUES(8,'Mercedes S700',8,8,8,8);
;
------------------------------------------------------------------------------------------------------------------

CREATE TABLE option(
    id BIGSERIAL NOT NULL PRIMARY KEY ,
    color VARCHAR(50) NOT NULL,
    engine VARCHAR(50) NOT NULL
);
ALTER TABLE option ADD model_id BIGINT REFERENCES model(id);
INSERT INTO option(id,color,engine,model_id)
VALUES(1,'black','2 cylinders',1);
INSERT INTO option(id,color,engine,model_id)
VALUES(2,'black','3 cylinders',2);
INSERT INTO option(id,color,engine,model_id)
VALUES(3,'black','2 cylinders',3);
INSERT INTO option(id,color,engine,model_id)
VALUES(4,'black','3 cylinders',4);
INSERT INTO option(id,color,engine,model_id)
VALUES(5,'black','4 cylinders',5);
INSERT INTO option(id,color,engine,model_id)
VALUES(6,'white','3 cylinders',6);
INSERT INTO option(id,color,engine,model_id)
VALUES(7,'white','2 cylinders',7);
INSERT INTO option(id,color,engine,model_id)
VALUES(8,'black','3 cylinders',8);
------------------------------------------------------------------------------------------------------------------

CREATE TABLE company(
    id BIGSERIAL NOT NULL PRIMARY KEY,
    company_num_of_empl BIGINT NOT NULL,
    company_name VARCHAR(50) NOT NULL,
    ceo_name VARCHAR(50) NOT NULL
);
INSERT INTO company(id,company_num_of_empl,company_name,ceo_name)
VALUES(1,255,'MS','Jimmy Neitron');
INSERT INTO company(id,company_num_of_empl,company_name,ceo_name)
VALUES(2,255,'MS','Jimmy Neitron');
INSERT INTO company(id,company_num_of_empl,company_name,ceo_name)
VALUES(3,255,'MS','Jimmy Neitron');
INSERT INTO company(id,company_num_of_empl,company_name,ceo_name)
VALUES(4,255,'MS','Jimmy Neitron');

INSERT INTO company(id,company_num_of_empl,company_name,ceo_name)
VALUES(5,255,'NS','Jimmy Neitron');
INSERT INTO company(id,company_num_of_empl,company_name,ceo_name)
VALUES(6,255,'NS','Jimmy Neitron');
INSERT INTO company(id,company_num_of_empl,company_name,ceo_name)
VALUES(7,255,'NS','Jimmy Neitron');
INSERT INTO company(id,company_num_of_empl,company_name,ceo_name)
VALUES(8,255,'NS','Jimmy Neitron');

------------------------------------------------------------------------------------------------------------------
CREATE TABLE brand(
    id BIGSERIAL NOT NULL PRIMARY KEY,
    brand_num_of_empl BIGINT NOT NULL,
    brand_name VARCHAR(50) NOT NULL
);
ALTER TABLE brand ADD company_id BIGINT REFERENCES company(id);
INSERT INTO brand(id,brand_num_of_empl,brand_name,company_id)
VALUES(1,300,'Ford',1);
INSERT INTO brand(id,brand_num_of_empl,brand_name,company_id)
VALUES(2,311,'Audi',2);
INSERT INTO brand(id,brand_num_of_empl,brand_name,company_id)
VALUES(3,300,'BMW',3);
INSERT INTO brand(id,brand_num_of_empl,brand_name,company_id)
VALUES(4,311,'Mercedes',4);

INSERT INTO brand(id,brand_num_of_empl,brand_name,company_id)
VALUES(5,300,'Wolswagen',5);
INSERT INTO brand(id,brand_num_of_empl,brand_name,company_id)
VALUES(6,311,'Kia',6);

------------------------------------------------------------------------------------------------------------------
CREATE TABLE model(
    id BIGSERIAL NOT NULL PRIMARY KEY ,
    model_name VARCHAR(50) NOT NULL,
    model_year TIMESTAMP NOT NULL,
    model_style VARCHAR(50)
);
ALTER TABLE model ADD brand_id BIGINT REFERENCES brand(id);
INSERT INTO model(id,model_name,model_year,model_style,brand_id)
VALUES(1,'Ford Mustang','2020-06-17 08:40:37','road',1);
INSERT INTO model(id,model_name,model_year,model_style,brand_id)
VALUES(2,'Audi R8','2020-06-17 08:40:37','road',2);
INSERT INTO model(id,model_name,model_year,model_style,brand_id)
VALUES(3,'BMW M5','2020-06-17 08:40:37','road',3);
INSERT INTO model(id,model_name,model_year,model_style,brand_id)
VALUES(4,'Mercedes S500','2020-06-17 08:40:37','road',4);
ALTER TABLE model
ALTER COLUMN model_year TYPE VARCHAR(50);
UPDATE model
SET model_year = '2019-06-17 08:40:37'
WHERE id = 1;
UPDATE model
SET model_year = '2018-06-18 09:43:37'
WHERE id = 2;
UPDATE model
SET model_year = '2018-06-19 10:44:37'
WHERE id = 3;
UPDATE model
SET model_year = '2017-06-20 13:40:37'
WHERE id = 4;

INSERT INTO model(id,model_name,model_year,model_style,brand_id)
VALUES(5,'Wolswagen Polo','2020-06-17 08:40:37','road',5);
INSERT INTO model(id,model_name,model_year,model_style,brand_id)
VALUES(6,'Kia Rio','2020-06-17 08:40:37','road',6);
INSERT INTO model(id,model_name,model_year,model_style,brand_id)
VALUES(7,'BMW M3','2020-06-17 08:40:37','road',3);
INSERT INTO model(id,model_name,model_year,model_style,brand_id)
VALUES(8,'Mercedes S700','2020-06-17 08:40:37','offroad',4);
-------------------------------------------------------------------------------------------------------------------

CREATE TABLE manufacturer(
    id BIGSERIAL NOT NULL PRIMARY KEY,
    manufacturer_name VARCHAR(50) NOT NULL,
    manufacturer_locate VARCHAR(50) NOT NULL
);
ALTER TABLE manufacturer ADD vehicle_vin BIGINT REFERENCES vehicle(vin);
INSERT INTO manufacturer(id,manufacturer_name,manufacturer_locate)
VALUES(1,'Benz','Beijing');
INSERT INTO manufacturer(id,manufacturer_name,manufacturer_locate)
VALUES(2,'ZNEB','Pakistan');
INSERT INTO manufacturer(id,manufacturer_name,manufacturer_locate)
VALUES(3,'Bnez','Beijing');
INSERT INTO manufacturer(id,manufacturer_name,manufacturer_locate)
VALUES(4,'Zebn','Pakistan');
INSERT INTO manufacturer(id,manufacturer_name,manufacturer_locate)
VALUES(5,'ZZZ','Beijing');
INSERT INTO manufacturer(id,manufacturer_name,manufacturer_locate)
VALUES(6,'WWW','Pakistan');
INSERT INTO manufacturer(id,manufacturer_name,manufacturer_locate)
VALUES(7,'RRR','Beijing');
INSERT INTO manufacturer(id,manufacturer_name,manufacturer_locate)
VALUES(8,'BBB','Pakistan');
-------------------------------------------------------------------------------------------------------------------
CREATE TABLE sales(
    date_of_sale TIMESTAMP NOT NULL,
    price NUMERIC(19,2) NOT NULL
);
ALTER TABLE sales ADD vehicle_vin BIGINT REFERENCES vehicle(vin);
ALTER TABLE sales ADD customer_id BIGINT REFERENCES customer(id);
ALTER TABLE sales ADD dealer_id BIGINT REFERENCES dealer(id);
INSERT INTO sales(date_of_sale, price,vehicle_vin,customer_id,dealer_id)
VALUES('2020-06-17 08:40:37',40000,1,1,1);
INSERT INTO sales(date_of_sale, price,vehicle_vin,customer_id,dealer_id)
VALUES('2020-06-18 09:37:45' ,45000,2,2,2);
INSERT INTO sales(date_of_sale, price,vehicle_vin,customer_id,dealer_id)
VALUES('2020-06-19 08:40:37',39000,3,3,3);
INSERT INTO sales(date_of_sale, price,vehicle_vin,customer_id,dealer_id)
VALUES('2020-06-20 09:37:45' ,42000,4,4,4);
INSERT INTO sales(date_of_sale, price,vehicle_vin,customer_id,dealer_id)
VALUES('2020-06-20 08:45:37',70000,5,5,5);
INSERT INTO sales(date_of_sale, price,vehicle_vin,customer_id,dealer_id)
VALUES('2020-06-21 09:37:45' ,58000,6,6,6);
INSERT INTO sales(date_of_sale, price,vehicle_vin,customer_id,dealer_id)
VALUES('2020-06-22 08:45:37',37000,7,7,7);
INSERT INTO sales(date_of_sale, price,vehicle_vin,customer_id,dealer_id)
VALUES('2020-06-23 09:39:45' ,45000,8,8,8);
-------------------------------------------------------------------------------------------------------------------
CREATE TABLE customer(
    id BIGSERIAL NOT NULL PRIMARY KEY,
    customer_gender VARCHAR(50),
    phone VARCHAR(50) NOT NULL
);
ALTER TABLE customer ADD dealer_id BIGINT REFERENCES dealer(id);
INSERT INTO customer(id,customer_gender,phone,dealer_id)
VALUES(1,'Male','87051791103',1);
INSERT INTO customer(id,customer_gender,phone,dealer_id)
VALUES(2,'Male','87051741101',2);
INSERT INTO customer(id,customer_gender,phone,dealer_id)
VALUES(3,'Female','87151797103',3);
INSERT INTO customer(id,customer_gender,phone,dealer_id)
VALUES(4,'Female','87251751101',4);
INSERT INTO customer(id,customer_gender,phone,dealer_id)
VALUES(5,'Male','87151751201',5);
INSERT INTO customer(id,customer_gender,phone,dealer_id)
VALUES(6,'Female','87251731201',6);
INSERT INTO customer(id,customer_gender,phone,dealer_id)
VALUES(7,'Female','875451797103',7);
INSERT INTO customer(id,customer_gender,phone,dealer_id)
VALUES(8,'Female','87551651147',8);


--------------------------------------------------------------------------------------------------------------------
CREATE TABLE dealer(
    id BIGSERIAL NOT NULL PRIMARY KEY
);
INSERT INTO dealer(id)
VALUES(1);
INSERT INTO dealer(id)
VALUES(2);
INSERT INTO dealer(id)
VALUES(3);
INSERT INTO dealer(id)
VALUES(4);
INSERT INTO dealer(id)
VALUES(5);
INSERT INTO dealer(id)
VALUES(6);
INSERT INTO dealer(id)
VALUES(7);
INSERT INTO dealer(id)
VALUES(8);
--------------------------------------------------------------------------------------------------------------------
CREATE TABLE person(
    person_name VARCHAR(50) NOT NULL,
    person_address VARCHAR(50) NOT NULL
);
--------------------------------------------------------------------------------------------------------------------
CREATE TABLE supplier(
    id BIGSERIAL NOT NULL PRIMARY KEY,
    supplier_name VARCHAR(50) NOT NULL,
    detail_type VARCHAR(50) NOT NULL
);
--------------------------------------------------------------------------------------------------------------------
CREATE TABLE supplies(
    detail_id BIGSERIAL NOT NULL,
    supply_date DATE NOT NULL,
    detail_type VARCHAR(50) NOT NULL
);
--------------------------------------------------------------------------------------------------------------------
--------------------------------QUERIE1----------------------------------------------------------------------------

SELECT MAX(price) FROM sales;
SELECT MAX(price) FROM sales
WHERE price NOT IN(SELECT MAX(price) FROM sales);

SELECT vehicle_vin FROM sales
WHERE price >= 58000;

SELECT brand_id FROM model
WHERE (id = 5 OR id = 6);

SELECT brand_name FROM brand
WHERE (id = 5 OR id = 6);
----------------------------------------QUERY2----------------------------------------------------------
ALTER TABLE sales ADD COLUMN brand_vision VARCHAR(20);
UPDATE sales SET brand_vision = 'Ford'
WHERE vehicle_vin = 1;
UPDATE sales SET brand_vision = 'Audi'
WHERE vehicle_vin = 2;
UPDATE sales SET brand_vision = 'BMW'
WHERE vehicle_vin = 3;
UPDATE sales SET brand_vision = 'Mercedes'
WHERE vehicle_vin = 4;
UPDATE sales SET brand_vision = 'Wolswagen'
WHERE vehicle_vin = 5;
UPDATE sales SET brand_vision = 'Kia'
WHERE vehicle_vin = 6;
UPDATE sales SET brand_vision = 'BMW'
WHERE vehicle_vin = 7;
UPDATE sales SET brand_vision = 'Mercedes'
WHERE vehicle_vin = 8;

SELECT brand_vision,
       COUNT(brand_vision) AS value_occurrence
FROM sales
GROUP BY brand_vision
ORDER BY value_occurrence DESC
LIMIT 2;
---------------------------------------------QUERY3--------------------------------------------------------------------
ALTER TABLE dealer ADD COLUMN time_keep BIGINT;
UPDATE dealer SET time_keep = 10
WHERE id = 1;
UPDATE dealer SET time_keep = 15
WHERE id = 2;
UPDATE dealer SET time_keep = 13
WHERE id = 3;
UPDATE dealer SET time_keep = 9
WHERE id = 4;
UPDATE dealer SET time_keep = 11
WHERE id = 5;
UPDATE dealer SET time_keep = 10
WHERE id = 6;
UPDATE dealer SET time_keep = 21
WHERE id = 7;
UPDATE dealer SET time_keep = 5
WHERE id = 8;

SELECT MAX(time_keep) FROM dealer;
SELECT MAX(time_keep) FROM dealer
WHERE time_keep NOT IN(SELECT MAX(time_keep) FROM dealer);
SELECT id FROM dealer
WHERE (time_keep = 21 OR time_keep = 15);
---------------------------------------------QUERY4---------------------------------------------------
ALTER TABLE supplies ADD COLUMN vehiclevin BIGINT;
INSERT INTO supplies(detail_id,supply_date,detail_type,vehiclevin)
VALUES(1,'2019-01-04','transmission',1);
INSERT INTO supplies(detail_id,supply_date,detail_type,vehiclevin)
VALUES(2,'2019-01-05','transmission',2);
INSERT INTO supplies(detail_id,supply_date,detail_type,vehiclevin)
VALUES(3,'2019-02-04','transmission',3);
INSERT INTO supplies(detail_id,supply_date,detail_type,vehiclevin)
VALUES(4,'2019-01-07','transmission',4);
INSERT INTO supplies(detail_id,supply_date,detail_type,vehiclevin)
VALUES(5,'2019-01-06','transmission',5);
INSERT INTO supplies(detail_id,supply_date,detail_type,vehiclevin)
VALUES(6,'2019-01-05','transmission',6);
INSERT INTO supplies(detail_id,supply_date,detail_type,vehiclevin)
VALUES(7,'2019-02-04','transmission',7);
INSERT INTO supplies(detail_id,supply_date,detail_type,vehiclevin)
VALUES(8,'2019-01-02','transmission',8);

SELECT vehiclevin FROM supplies
WHERE(supply_date = '2019-01-04' OR supply_date = '2019-01-05');

SELECT customer_id FROM vehicle
WHERE(vin = 1 OR vin = 2 OR vin = 6);
-------------------------------------QUERY5------------------------------------------------------------------------
SELECT date_of_sale FROM sales
WHERE brand_vision = 'BMW';
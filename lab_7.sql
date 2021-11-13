create table customers (
    id integer primary key,
    name varchar(255),
    birth_date date
);

create table accounts(
    account_id varchar(40) primary key ,
    customer_id integer references customers(id),
    currency varchar(3),
    balance float,
    "limit" float
);

create table transactions (
    id serial primary key ,
    date timestamp,
    src_account varchar(40) references accounts(account_id),
    dst_account varchar(40) references accounts(account_id),
    amount float,
    status varchar(20)
);

INSERT INTO customers VALUES (201, 'John', '2021-11-05');
INSERT INTO customers VALUES (202, 'Anny', '2021-11-02');
INSERT INTO customers VALUES (203, 'Rick', '2021-11-24');

INSERT INTO accounts VALUES ('NT10204', 201, 'KZT', 1000, null);
INSERT INTO accounts VALUES ('AB10203', 202, 'USD', 100, 0);
INSERT INTO accounts VALUES ('DK12000', 203, 'EUR', 500, 200);
INSERT INTO accounts VALUES ('NK90123', 201, 'USD', 400, 0);
INSERT INTO accounts VALUES ('RS88012', 203, 'KZT', 5000, -100);

INSERT INTO transactions VALUES (1, '2021-11-05 18:00:34.000000', 'NT10204', 'RS88012', 1000, 'commited');
INSERT INTO transactions VALUES (2, '2021-11-05 18:01:19.000000', 'NK90123', 'AB10203', 500, 'rollback');
INSERT INTO transactions VALUES (3, '2021-06-05 18:02:45.000000', 'RS88012', 'NT10204', 400, 'init');
----------------------------------------------1--------------------------------------------------------------------
/*(Binary Large Object) is a large object data type in the database system.
  BLOB could store a large chunk of data, document types and even media files like audio or video files. BLOB fields allocate space only whenever the content in the field is utilized. BLOB allocates spaces in Giga Bytes.
 */
/*A Character Large OBject (or CLOB) is a collection of character data in a database management system, usually stored in a separate location that is referenced in the table itself. Oracle and IBM DB2 provide a construct explicitly named CLOB,[1][2] and the majority of other database systems support some form of the concept, often labeled as text, memo or long character fields.

CLOBs usually have very high size-limits, of the order of gigabytes. The tradeoff for the capacity is usually limited access methods. In particular, some database systems[which?] limit certain SQL clauses and/or functions, such as LIKE or SUBSTRING from being used on CLOBs.
  Those that permit such operations may perform them very slowly.
 */

----------------------------------------------2---------------------------------------------------------------------
CREATE ROLE support;
CREATE ROLE administrator;
CREATE ROLE accountant;
GRANT SELECT ON transactions TO accountant;
GRANT SELECT, UPDATE (balance) ON accounts TO accountant;
GRANT ALL PRIVILEGES ON SCHEMA labseven TO administrator;
GRANT SELECT ON accounts ,customers ,transactions TO support;
select * FROM pg_roles;
CREATE USER Boss;
GRANT accountant TO Boss;
CREATE USER Moss;
GRANT administrator TO Moss;
CREATE USER Loss;
GRANT support TO Loss;
CREATE ROLE role_manager CREATEROLE;
GRANT role_manager to Moss;
REVOKE UPDATE ON accounts FROM accountant;
------------------------------------------------------3-------------------------------------------------------
SELECT * FROM transactions;
ALTER TABLE transactions
----------------------------Constraint------------------------------------------------------------------------
ALTER COLUMN date SET NOT NULL;
ALTER TABLE transactions
ALTER COLUMN src_account SET NOT NULL;
ALTER TABLE transactions
ALTER COLUMN dst_account SET NOT NULL;
ALTER TABLE transactions
ALTER COLUMN amount SET NOT NULL;
ALTER TABLE transactions
ALTER COLUMN status SET NOT NULL;

------------------------------------------------------------4------------------------------------------------------
CREATE TYPE Valuta as (sql char(3));
ALTER TABLE accounts
ALTER COLUMN currency TYPE Valuta USING currency :: valuta;
------------------------------------------------------------5------------------------------------------------------
CREATE UNIQUE INDEX idx_acc ON accounts(customer_id, currency);
CREATE INDEX search_t ON accounts(currency, balance);
------------------------------------------------------------6-------------------------------------------------------
DO
$$
    DECLARE
        balancee INT;
        limitee INT;
    BEGIN
        UPDATE transactions SET status = 'init'
        WHERE id = 2;
        UPDATE accounts
        SET balance = 400 + balance
        WHERE account_id = 'AB10203';
        UPDATE accounts
        SET balance = balance - 400
        WHERE account_id = 'NK90123';
        SELECT balance INTO balancee FROM accounts
        WHERE account_id = 'NK90123';
        SELECT accounts.limit INTO limitee FROM accounts
        WHERE account_id = 'NK90123';
        IF (balancee <= limitee - 1) THEN
            UPDATE transactions SET status = 'rollback'
            WHERE id = 2;
        ELSE
            COMMIT;
            UPDATE transactions SET status = 'commited'
            WHERE id = 2;
        END IF;
    END
$$
--1.
-- DMl used to manipulate the data itself(Update,Insert,Delete,Select)
--DDl used to define data structures(Create,Drop,Alter)

--2.
create database shop;
create table customers(
    id int not null unique,
    full_name varchar(30) not null,
    timestamp timestamp not null,
    delivery_address text not null,
    primary key (id)
);

create table orders(
    code int not null unique,
    customer_id int,
    total_sum double precision not null,
    is_paid boolean not null,
    primary key (code),
    foreign key (customer_id) references customers(id),
    check (total_sum > 0)
);

create table products(
    id varchar not null unique,
    name varchar not null unique,
    description text,
    price double precision not null,
    primary key (id),
    check(price > 0)
);

create table order_items(
    order_code int not null unique,
    product_id varchar not null unique,
    quantity int not null,
    primary key (order_code, product_id),
    foreign key (order_code) references orders(code),
    foreign key (product_id) references products(id),
    check(quantity > 0)
);

--3.
create table students(
    id int not null unique ,
    full_name varchar(30) not null,
    age int not null,
    birth_date date not null,
    gender varchar(10) not null,
    avg_grade double precision not null,
    s_info text not null,
    dorm bool not null,
    add_info text,
    primary key (id),
    check(gender = 'female' or gender = 'male')
);

create table instructors(
    id int not null unique ,
    full_name varchar(30) not null,
    languages text not null,
    work_exp text not null,
    remote_lessons bool not null,
    primary key (id)
);

create table lesson_participants(
    title varchar(35),
    instructor_id int not null unique,
    student_id int not null unique,
    room_numb int not null,
    primary key (title),
    foreign key (instructor_id) references instructors(id),
    foreign key (student_id) references students(id)
);

--4.
insert into customers values (1310, 'Sultanbek K.A', '2021-09-23 15:57:27', 'Almaty');

update customers
    set full_name = 'Kenzhakhimov.S.A' where id = 1310;

delete from customers where full_name = 'Kenzhakhimov.S.A';
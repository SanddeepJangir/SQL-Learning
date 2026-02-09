-- view 

use regex1;

/*
VIEW =>
this is a virtual table
       
these are not store the data physically but will access the existing table
        advantages
make complex query easy
            helps in security
           
types

*/

use regex1;
create table newactor as
select actor_id, first_name from sakila.actor where actor_id between 1 and 3;

select * from newactor;

create view actor_v as -- create view here for the query
select *, substr(first_name,2) from newactor;

select * from actor_v;

select * from newactor; -- 3 rows 2 columns
insert into newactor values(4,'Riya'); -- 4 rows
select * from newactor;

select * from actor_v;

-- data control language 
-- permission which user can accessbility 
-- authentatication and authorization

-- user => create => permission 

-- ddl statement
 
 create user regex identified by 'regex';
 
 select * from mysql.user;
 
 create database sandeepdb;
 
 create table sandeepdb.actor1 as select actor_id, first_name from sakila.actor
where actor_id between 1 and 5;

create table sandeepdb.actor2 as select actor_id, first_name from sakila.actor
where actor_id between 3 and 7;


show grants for regex;
 
 -- grant permission on database to username
grant select on sandeepdb.actor2 to regex; 

select * from sandeepdb.actor1;

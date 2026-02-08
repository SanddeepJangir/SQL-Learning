-- tcl (transaction control language)
-- Transaction => set of logical statement (temporary operation)
-- update 

use regex1;
drop table actor_cp;
create table actor_cp as select actor_id, first_name from sakila.actor
where actor_id between 1 and 5;

select * from actor_cp;

insert into actor_cp values (6,'tushar'); 

-- automcommit => enable
select @@autocommit = 0; -- disable
select @@autocommit; -- enable

insert into actor_cp values (7,'testoo');
select * from actor_cp;

-- in case if you run any DML operation or you write down start transaction when write start transaction keyword

-- when my transaction is off automatically 
-- when i use any command/rollback on tcl my transaction are off automatically
-- or in case if i run any DDL,DCL operation like create, update, drop , truncate
-- my transaction are automatically are off


start transaction;
insert into actor_cp values (12,'flipkart');

select * from actor_cp;

insert into actor_cp values (18,'asdfasf');

insert into actor_cp values (19,'asdfasdg');
savepoint db_actor_cp_svp1;

delete from actor_cp where actor_id in (3);
rollback to db_actor_cp_svp1;
select * from actor_cp;

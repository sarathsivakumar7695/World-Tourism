create database tourism;
use tourism;


-- display data--

select * from tourism_dataset;
select distinct country from tourism_dataset;
select distinct category from tourism_dataset;
select distinct rating from tourism_dataset
order by rating;

-- add column--

alter table tourism_dataset
add column review varchar(20);


-- trying to create review column data--

select case
when rating between 4.5 and 5.0 then 'Excellent'
when rating between 4.0 and 4.5 then 'Very good'
when rating between 3.5 and 4.0 then 'Good'
when rating between 3.0 and 3.5 then 'Average'
when rating between 2.5 and 3.0 then 'fair'
else 'poor' end as review,rating
from tourism_dataset;

-- insert review associate with rating--

update tourism_dataset set review=case
when rating between 4.5 and 5.0 then 'Excellent'
when rating between 4.0 and 4.5 then 'Very good'
when rating between 3.5 and 4.0 then 'Good'
when rating between 3.0 and 3.5 then 'Average'
when rating between 2.5 and 3.0 then 'fair'
else 'poor' end;
select * from tourism_dataset;

-- alter table--

alter table tourism_dataset
rename tourism;
select * from tourism;
alter table tourism
drop location;

-- like----

select* from tourism
 where country like 'a%';
 
 select * from tourism 
 where country like '__d%';
 
 -- where clause--
 
 select * from tourism
 where country='india' and rating>4;
 
 select * from tourism
 where category='urban' and rating<3;
 
 -- IN and NOT IN--
 
 select *from tourism
 where country in ('india','USA');
 
 select country,rating from  tourism
 where rating in (3,4);
 
  
 select *from tourism
 where country not in ('india','USA');
 
  select * from  tourism
 where country not like'i%' ;
 
 select * from  tourism
 where country not like'a%' and country not like'i%' ;
 
 select * from tourism;
 
 -- function--
 
 select country,sum(visitors) from tourism
 group by country;
 
 
  select country,avg(revenue) from tourism 
  group by country;
  
   select country,sum(visitors) as 'sum of visitors' from tourism
 group by country
 having country ='india';
 
 select sum(revenue) from tourism
 where country='india';
 
 select avg(rating) from tourism
 where country='india';
 
 select country, min(visitors) from tourism
 where category='nature'
 group by country;
 
 select country, max(visitors) from tourism
 where category='urban'
 group by country;
 
select country, max(visitors) from tourism
 where category='urban'
 group by  country
 order by max(visitors);
 
-- why we use as(alias)--

select case
when rating between 4.5 and 5.0 then 'Excellent'
when rating between 4.0 and 4.5 then 'Very good'
when rating between 3.5 and 4.0 then 'Good'
when rating between 3.0 and 3.5 then 'Average'
when rating between 2.5 and 3.0 then 'fair'
else 'poor' end ,rating
from tourism;  

 select distinct upper(country) from tourism;

-- limit clause-

select distinct country from tourism
limit 3 ;

select * from tourism
order by rating desc
limit 3 ;

select distinct country from tourism
limit 3 offset 2;


select distinct country from tourism
limit 2,3;

-- order by--

select*from tourism
order by rating desc,visitors desc;

--- group by--

select country, count(country) from tourism
group by country;		

select country, avg(revenue) from tourism
group by country;		

-- having--

select country ,count(country) from tourism
where revenue<50000	
group by country
having count(country)>40;						 		

-- index--

alter table tourism
modify country varchar(20) primary key ;


create index category on tourism(category);


select* from tourism;

-- separete into two tables--

create table tourism1(c_id int primary key auto_increment, 
country varchar(20),category varchar(20) , visitors int,revenue int);

insert into tourism1(country,category,visitors,revenue)
select distinct country,category,visitors,revenue from tourism;

select* from tourism; 
select* from tourism1;


create table tourism2(country varchar(30),rating float(3,2),
Accommodation_Available varchar(30),review varchar(15));

insert into tourism2 select country,rating,
Accommodation_Available,review from tourism;

select * from tourism2;


-- JOIN --                    -- inner join =join , cross , self , right , left , outer

select tourism1.country,category,Accommodation_Available,
review from tourism1 inner join tourism2 on 
tourism1.country=tourism2.country;


-- SUBQUERIES , Exists , Any , All --

select country from tourism
where revenue=(select min(revenue) from tourism);

select * from tourism
where country=(select country from tourism
where revenue=(select min(revenue) from tourism));

--- view ---

create view country_review as select tourism1.country,
tourism2.review from tourism1 inner join tourism2 on 
tourism1.country=tourism2.country;


select* from country_review;

-- rename--

alter table tourism
rename column Accommodation_Available to acc;

select* from tourism;


-- store procedure---

delimiter $
create procedure world() 
begin
 select tourism1.country,category,Accommodation_Available,review
 from tourism1 inner join tourism2 on 
tourism1.country=tourism2.country;
end $
 delimiter ;
 call world();
 
 
 

CREATE TABLE  trips_details4 (tripid integer,loc_from integer,searches integer,searches_got_estimate integer,searches_for_quotes	integer,searches_got_quotes	integer,customer_not_cancelled integer,driver_not_cancelled integer,otp_entered	integer,end_ride integer);

insert into trips_details4 
select * from trips_details1
union
select * from trips_details2
union
select * from trips_details3;

select * from trips_details4;

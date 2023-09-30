-- Total trips
select count(distinct tripid) from trips;
select count(distinct tripid) from trips_details4
where end_ride = 1;

-- Check for duplicate data present or not 
select tripid,count(tripid) as cnt from trips_details1 group by tripid having count(tripid) > 1 ;
select * from trips_details1;

-- Total driver 
select count(distinct driverid) as total_drivers from trips;

-- Total earnings
select  sum(fare) as fares from trips ;

-- Total completed trips
select count(distinct tripid) from trips;

-- Total Searching
select sum(searches) from trips_details4;

-- Total searches which got estimate 
select sum(searches) from trips_details4 where searches=1;

-- Total driver cancelled
select count(driver_not_cancelled)  from trips_details4 where  driver_not_cancelled = 0 ;

-- Total entered otp
select sum(otp_entered) from trips_details4;

-- Total successful ride
select sum(end_ride) from trips_details4 ;

-- Average distance per trip
select round(avg(distance),0) from trips;

-- Total distance travel 
select sum(distance) from trips;

-- which is the most used payment method 
select a.method from payment a inner join 
(select faremethod, count(distinct tripid) from trips group by faremethod order by count(distinct tripid) desc limit 1) b 
on a.id = b.faremethod;

-- the highest paymnet from which instrument
select a.method from payment a inner join
(select *  from trips  order by fare desc limit 1) b
on a.id = b.faremethod;

-- which two locations had most trips 
select * from
(select * ,dense_rank() over(order by trip desc) rnk from 
(select loc_from , loc_to ,count(distinct tripid) trip from trips group by loc_from , loc_to) a) b
where rnk=1;

-- Top 5 earing driver 
select driverid,sum(fare) from trips group by driverid order by sum(fare) desc limit 5;

-- which duration had more trips
select duration ,count(distinct tripid) as cnt from trips group by duration  limit 1;

-- which driver ,customer pair had more orders 
with cte as(
select *,rank() over(order by cnt desc) as rnk from 
(select driverid , custid ,count( distinct tripid) as cnt from trips group by driverid ,custid) c)
select * from cte where rnk = 1;

-- search  to estimate rate
select sum(searches_got_estimate)*100.0/sum(searches) from trips_details4;

-- which area got highest trips in which duration
with cte as(
select *,rank() over (partition by loc_from order by cnt desc) rnk from
 (select duration,loc_from,count(distinct tripid) cnt from trips group by duration,loc_from ) c)
 select * from cte where rnk = 1;
 
 -- which area got the highest fares,cancellationn trips
 select loc_from , sum(fare) as fares from trips group by loc_from order by sum(fare) desc limit 1 ;
 
-- which duration got the highest trips 
with cte as(
select *,rank() over ( order by cnt desc) rnk from
 (select duration,sum(fare) as cnt from trips group by duration ) c)
 select * from cte where rnk = 1;



create database hotel_bookings;
use hotel_bookings;

select * from hotel_bookings;
alter table hotel_bookings rename hotel_booking;

select * from hotel_booking;
select count(*) from hotel_booking;
describe hotel_booking;

#hotel: The type of hotel (Categorical)
#is_canceled: Indicates whether the booking was canceled (Binary)
#lead_time: The number of days between the booking date and the arrival date (Numerical)
#arrival_date_year: The year of the arrival date (Numerical)
#arrival_date_month: The month of the arrival date (Categorical)
#arrival_date_week_number: The week number of the arrival date (Numerical)
#arrival_date_day_of_month: The day of the month of the arrival date (Numerical)
#stays_in_weekend_nights: The number of weekend nights (Saturday and Sunday) the guest stayed or booked to stay at the hotel (Numerical)
#stays_in_week_nights: The number of weeknights (Monday to Friday) the guest stayed or booked to stay at the hotel (Numerical)
#adults: The number of adults included in the booking (Numerical)
#children: The number of children included in the booking (Numerical)
#babies: The number of babies included in the booking (Numerical)
#meal: The type of meal booked (Categorical)
#country: The country of origin for each guest who made a reservation (Categorical)
#market_segment: The market segment that individuals belong to when making reservations (Categorical)
#distribution_channel: The channel through which bookings were made (Categorical)
#is_repeated_guest: Indicates whether the guest is a repeated visitor (Binary)
#previous_cancellations: The number of times guests previously canceled their bookings (Numerical)
#previous_bookings_not_canceled: The count of previous bookings made by guests that were not canceled (Numerical)
#reserved_room_type: The type of room initially reserved (Categorical)
#assigned_room_type: The type of room that was assigned to guests. (Categorical)
#booking_changes: The number of changes made to the booking. (Numerical)
#deposit_type: The type of deposit made for the booking. (Categorical)
#agent: The ID of the travel agency that made the booking. (Categorical)
#company: The ID of the company that made the booking. (Categorical)
#days_in_waiting_list: The number of days the booking was on the waiting list before being confirmed. (Numerical)
#customer_type: The type of customer (e.g., transient, contract, group, or other). (Categorical)
#adr: The average daily rate (price per room) for the booking. (Numerical)
#required_car_parking_spaces: The number of car parking spaces required by the guest. (Numerical)
#total_of_special_requests: The total number of special requests made by the guest (e.g., extra bed, room amenities). (Numerical)
#reservation_status: The status of the reservation (e.g., canceled, checked-in, no-show). (Categorical)
#reservation_status_date: The date on which the reservation status was last updated. (Date)

create table hotel ( 
hotel_id int primary key auto_increment,
hotel_name varchar(50) unique);

insert into hotel (hotel_name)
select distinct hotel from hotel_booking;

select * from hotel;

create table agent_companies (
agent_id int,
company_id int,
primary key (agent_id,company_id));

INSERT INTO agent_companies (agent_id, company_id)
SELECT DISTINCT agent, company
FROM hotel_booking
WHERE agent IS NOT NULL
  AND agent <> ''
  AND company IS NOT NULL
  AND company <> '';


select * from agent_companies;

create table customers (
customer_id int primary key auto_increment,
country varchar(10),
customer_type varchar(50),
market_segment varchar(50),
distribution_channel varchar(50),
is_repeated_guest int);


insert into customers (country,customer_type,market_segment,distribution_channel,is_repeated_guest)
select distinct country,customer_type,market_segment,distribution_channel,is_repeated_guest
from hotel_booking;

select * from  customers;


CREATE TABLE bookings (
booking_id INT PRIMARY KEY, -- You can use the 'index' column from your CSV
hotel_id INT,
customer_id INT,
agent_id INT,
company_id INT,
is_canceled INT,
lead_time INT,
arrival_date_year INT,
arrival_date_month VARCHAR(20),
arrival_date_day_of_month INT,
stays_in_weekend_nights INT,
stays_in_week_nights INT,
adults INT,
children DECIMAL(3,1),
babies INT,
meal VARCHAR(10),
reserved_room_type VARCHAR(5),
assigned_room_type VARCHAR(5),
booking_changes INT,
deposit_type VARCHAR(20),
days_in_waiting_list INT,
adr DECIMAL(10,2),
required_car_parking_spaces INT,
total_of_special_requests INT,
reservation_status VARCHAR(20),
reservation_status_date DATE,
FOREIGN KEY (hotel_id) REFERENCES hotel(hotel_id),
FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO bookings (
booking_id, hotel_id, customer_id, agent_id, company_id,
is_canceled, lead_time, arrival_date_year, arrival_date_month,
arrival_date_day_of_month, stays_in_weekend_nights, stays_in_week_nights,
adults, children, babies, meal, reserved_room_type, assigned_room_type,
booking_changes, deposit_type, days_in_waiting_list, adr,
required_car_parking_spaces, total_of_special_requests,
reservation_status, reservation_status_date
)
SELECT
hb.index,
h.hotel_id,
c.customer_id,
cast(round(COALESCE(hb.agent, 0)) as signed), 
cast(round(COALESCE(hb.company,0)) as signed),
hb.is_canceled,
hb.lead_time,
hb.arrival_date_year,
hb.arrival_date_month,
hb.arrival_date_day_of_month,
hb.stays_in_weekend_nights,
hb.stays_in_week_nights,
hb.adults,
COALESCE(hb.children, 0), 
hb.babies,
hb.meal,
hb.reserved_room_type,
hb.assigned_room_type,
hb.booking_changes,
hb.deposit_type,
hb.days_in_waiting_list,
hb.adr,
hb.required_car_parking_spaces,
hb.total_of_special_requests,
hb.reservation_status,
STR_TO_DATE(hb.reservation_status_date, '%d-%m-%y') -- Convert string date to proper SQL date
FROM hotel_booking hb
JOIN hotel h ON hb.hotel = h.hotel_name
JOIN customers c ON hb.country <=> c.country
AND hb.customer_type = c.customer_type
AND hb.market_segment = c.market_segment
AND hb.distribution_channel = c.distribution_channel
AND hb.is_repeated_guest = c.is_repeated_guest;
select * from bookings;


#Objective: Find the top 10 most expensive bookings(by ADR) that had a lead time of over 100 days.

select b.booking_id,h.hotel_name,b.lead_time,b.adr,b.arrival_date_year
from bookings b
join hotel h on b.hotel_id=h.hotel_id
where b.lead_time > 100
order by b.adr desc
limit 10;


#Question 1: See which hotel type generates the highest average daily rate and how many total bookings they each recieved.

select h.hotel_name,count(b.booking_id) as total_bookings,
round(avg(b.adr),2) as avg_adr
from bookings b
join hotel h on b.hotel_id=h.hotel_id
group by h.hotel_name
order by avg_adr desc;

## INSIGHTS >> City Hotel type with 79326 bookings and highest ADR as 105.31

#Question 2: Find customer countries that have a total count of bookings greater than 500 , ordered from highest to lowest bookings

select c.country,count(b.booking_id) as total_bookings
from bookings b
join customers c on b.customer_id=c.customer_id
group by c.country
having count(b.booking_id)>500
order by total_bookings desc;

## INSIGHTS >> There are total 20 countries which have bookings greater than 500


#Question 3: Analyze market segments that have more than 1,000 bookings and find their 
#average special requests, keeping only segments where the average special requests exceed 0.5.

SELECT c.market_segment,
COUNT(b.booking_id) AS total_bookings,
ROUND(AVG(b.total_of_special_requests), 2) AS avg_special_requests
FROM bookings b
JOIN customers c ON b.customer_id = c.customer_id
GROUP BY c.market_segment
HAVING COUNT(b.booking_id) > 1000 AND AVG(b.total_of_special_requests) > 0.5
ORDER BY avg_special_requests DESC;

## INSIGHTS >> Market segment with more than 1000 bookings was Online TA with 56476 bookings in total 

#Question 4: How can bookings be categorized into low,medium and high ADR(Average Daily Rate) categories,
#how many bookings fall into each category


select 
case
when adr between -10 and 2000 then "Low adr"
when adr between 2000 and 4000 then "Medium adr"
else "High adr"
end as adr_category,
count(booking_id) as total_bookings,
round(avg(adr),2) as avg_adr
from bookings 
group by adr_category
order by avg_adr asc;

## INSIGHTS >> Total bookings of LOW ADR were 119385 and HIGH ADR was 1.


#Question 5: Which booking have an ADR higher than the overall average ADR of all bookings?

#overall avg adr is calculated as 101

select 
b.booking_id,
h.hotel_name,
b.adr,
b.arrival_date_month
from bookings b 
join hotel h on b.hotel_id=h.hotel_id
where b.adr > (select avg(adr) from bookings)
order by b.adr desc;

## INSIGHTS >> The booking ID 48515 of the City Hotel type  had the ADR highest than the overal average

# Question 6: Which month had the highest number of bookings, and what was the total number of bookings in each month ?

with monthly_bookings as 
(select arrival_date_month,count(booking_id) as no_of_bookings
from bookings 
group by arrival_date_month)
select arrival_date_month,no_of_bookings
from monthly_bookings
order by no_of_bookings desc;

##INSIGHTS >> highest number of bookings was in the month of August.

#Question 7 : Rank the hotel types based on their total number of bookings, from highest to lowest

select h.hotel_name,
count(b.booking_id) as total_bookings,
rank() over (order by count(b.booking_id) desc) as boooking_rank
from bookings b
join hotel h on b.hotel_id=h.hotel_id
group by h.hotel_name
order by total_bookings desc;

##INSIGHTS >> City Hotel type is at the first rank with 79326 bookings
# and Resort Hotel type is at the second rank with 40060 bookings.




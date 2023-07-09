
--Column name & Data type & Data explaination

hotel	nvarchar(255)
is_canceled	float
lead_time	float
arrival_date_year	float
arrival_date_month	nvarchar(255)
arrival_date_week_number	float
arrival_date_day_of_month	float
stays_in_weekend_nights	float
stays_in_week_nights	float
adults	float
children	float
babies	float
meal	nvarchar(255)
country	nvarchar(255)
market_segment	nvarchar(255)
distribution_channel	nvarchar(255)
is_repeated_guest	float
previous_cancellations	float
previous_bookings_not_canceled	float
reserved_room_type	nvarchar(255)
assigned_room_type	nvarchar(255)
booking_changes	float
deposit_type	nvarchar(255)
agent	float
company	nvarchar(255)
days_in_waiting_list	float
customer_type	nvarchar(255)
adr	float                            --adr = average daily revenue
required_car_parking_spaces	float
total_of_special_requests	float
reservation_status	nvarchar(255)
reservation_status_date	datetime
	
	

--Data Combining

WITH hotels AS (
  SELECT * FROM dbo.['2018$']
  UNION 
  SELECT * FROM dbo.['2019$']
  UNION 
  SELECT * FROM dbo.['2020$'])
SELECT * FROM hotels
LEFT JOIN market_segment$
ON hotels.market_segment = market_segment$.market_segment
LEFT JOIN meal_cost$
ON hotels.meal = meal_cost$.meal
-->there are 100,756 rows

--Calculate revenue by hotel by years

SELECT 
	arrival_date_year,
	hotel,
	ROUND(SUM((stays_in_week_nights+stays_in_weekend_nights)*adr),2) AS revenue
FROM hotels
GROUP BY 
	arrival_date_year,
	hotel
--



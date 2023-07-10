
--Column name & Data type & Data explaination

hotel				nvarchar(255)				
is_canceled			float
lead_time			float
arrival_date_year		float
arrival_date_month		nvarchar(255)
arrival_date_week_number	float
arrival_date_day_of_month	float
stays_in_weekend_nights		float
stays_in_week_nights		float
adults				float
children			float
babies				float
meal				nvarchar(255)
country				nvarchar(255)
market_segment			nvarchar(255)
distribution_channel		nvarchar(255)			--distribution channel = platforms that are available to sell your services
is_repeated_guest		float
previous_cancellations		float
previous_bookings_not_canceled	float
reserved_room_type		nvarchar(255)
assigned_room_type		nvarchar(255)
booking_changes			float
deposit_type			nvarchar(255)
agent				float				--agent from distribution channel
company				nvarchar(255)			--company from distribution channel
days_in_waiting_list		float
customer_type			nvarchar(255)
adr				float                           --adr = average daily revenue
required_car_parking_spaces	float
total_of_special_requests	float
reservation_status		nvarchar(255)
reservation_status_date		datetime
	
	

--Data Combining - create a new table that combine data of 2018, 2019, and 2020

CREATE TABLE hotels AS (
  SELECT * FROM dbo.['2018$']
  UNION 
  SELECT * FROM dbo.['2019$']
  UNION 
  SELECT * FROM dbo.['2020$'])
SELECT * FROM hotels
--> There are 100,756 rows


--Clean Data
	---convert month into number format
UPDATE hotels
SET arrival_date_month = CASE
	WHEN arrival_date_month = 'January' THEN 1
	WHEN arrival_date_month = 'February' THEN 2
	WHEN arrival_date_month = 'March' THEN 3
	WHEN arrival_date_month = 'April' THEN 4
	WHEN arrival_date_month = 'May' THEN 5
	WHEN arrival_date_month = 'June' THEN 6
	WHEN arrival_date_month = 'July' THEN 7
	WHEN arrival_date_month = 'August' THEN 8
	WHEN arrival_date_month = 'September' THEN 9
	WHEN arrival_date_month = 'October' THEN 10
	WHEN arrival_date_month = 'November' THEN 11
	WHEN arrival_date_month = 'December' THEN 12
	ELSE arrival_date_month
END
	---after updating the value, the datatype of column arrival_date_month is still nvarchar(255)
	---convert datatype into integer
ALTER TABLE hotels
ALTER COLUMN arrival_date_month int
	

--Join Data - join data with 2 tables to add market segments and meal cost
	
SELECT * 
FROM hotels
LEFT JOIN market_segment$
ON hotels.market_segment = market_segment$.market_segment
LEFT JOIN meal_cost$
ON hotels.meal = meal_cost$.meal

--Calculate revenue by hotel by years
	
SELECT 
	arrival_date_year,
	hotel,
	ROUND(SUM((stays_in_week_nights+stays_in_weekend_nights)*adr),2) AS revenue
FROM hotels
GROUP BY 
	arrival_date_year,
	hotel

--Calculate reservation status
select reservation_status, arrival_date_year,count(*) from hotels 
group by reservation_status, arrival_date_year
Order by arrival_date_year, count(*)



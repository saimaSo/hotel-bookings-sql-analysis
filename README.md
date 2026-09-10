Hotel Booking Analysis using SQL

Project Overview:

This project analyzes hotel booking data using SQL to explore booking patterns, hotel performance, customer markets, pricing, and other booking-related factors.
The original hotel booking dataset was imported into MySQL and organized into multiple relational tables. SQL queries were then used to answer business-oriented questions and practice data analysis techniques.
The main objective of this project was to apply SQL concepts to a real-world dataset and generate meaningful insights from the data.


Dataset:

The dataset used in this project is a publicly available Hotel Booking dataset from Kaggle.
It contains information about hotel reservations, including:
- Hotel type
- Booking and arrival details
- Lead time
- Customer information
- Country of origin
- Market segment
- Room types
- Booking changes
- Deposit type
- Average Daily Rate (ADR)
- Special requests
- Reservation status
- Cancellation information
Source: Kaggle – Hotel Booking dataset
The dataset was used for educational and portfolio purposes, with attribution to the original source

Database Structure:

The original dataset was imported into MySQL as the hotel_booking table.
To practice relational database design, the data was organized into four additional tables:
1. hotel
Stores unique hotel types.
Key columns:
hotel_id
hotel_name
2. customers
Stores customer-related information.
Key columns:
customer_id
country
customer_type
market_segment
distribution_channel
is_repeated_guest
3. agent_companies
Stores the relationship between travel agents and companies.
Key columns:
agent_id
company_id
4. bookings
Stores booking-level information such as hotel, customer, arrival details, ADR, reservation status, and other booking attributes.
Key columns include:
booking_id
hotel_id
customer_id
agent_id
company_id
is_canceled
lead_time
arrival_date_year
arrival_date_month
adr
reservation_status
The tables are connected using primary and foreign key relationships where applicable.

Business Questions:

The analysis answers the following questions:
1. Hotel Performance
Which hotel type generates the highest average daily rate (ADR), and how many total bookings did each hotel type receive?
2. Customer Countries
Which customer countries have more than 500 total bookings, ordered from highest to lowest?
3. Market Segment Analysis
Which market segments have more than 1,000 bookings and an average number of special requests greater than 0.5?
4. ADR Categorization
How can bookings be categorized into Low, Medium, and High ADR categories, and how many bookings fall into each category?
5. Above-Average Bookings
Which bookings have an ADR higher than the overall average ADR of all bookings?
6. Monthly Booking Trends
Which month had the highest number of bookings, and what was the total number of bookings in each month?
7. Hotel Booking Ranking
How can hotel types be ranked based on their total number of bookings?

SQL Concepts Used:

- The project applies the following SQL concepts:
- SELECT
- WHERE
- GROUP BY
- HAVING
- ORDER BY
- Aggregate functions such as COUNT() and AVG()
- JOIN
- CASE statements
 -Subqueries
- Common Table Expressions (CTEs)
- Window functions
- RANK()
- Primary keys and foreign keys
- Relational database design
- Data transformation and cleaning

Key Findings:

- Some of the key findings from the analysis include:
- City Hotel had the highest average ADR among the hotel types, with an average ADR of 105.31 and 79,326 bookings.
- 20 customer countries had more than 500 bookings.
- Online TA was the market segment with the highest booking volume among the segments meeting the specified criteria, with 56,476 bookings.
- The Low ADR category contained 119,385 bookings, while only 1 booking fell into the High ADR category based on the defined ADR ranges.
- The overall average ADR was approximately 101, and the analysis identified bookings priced above this average.
- August had the highest number of bookings among the arrival months.
- City Hotel ranked first by total bookings with 79,326 bookings, followed by Resort Hotel with 40,060 bookings.
- The analysis also identified the top 10 highest-ADR bookings with lead times exceeding 100 days.

Tools Used: 

- MySQL
- MySQL Workbench
- GitHub
- Kaggle dataset



Project Objective:

The purpose of this project was to strengthen practical SQL skills by working with a
real-world dataset, designing relational tables, writing analytical queries, and extracting
business insights from hotel booking data.

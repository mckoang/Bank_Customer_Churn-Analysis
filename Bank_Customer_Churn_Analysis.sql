select * from customer_churn

select distinct customerage from customer_churn
select min(customerage) from customer_churn
--Finding the number of male and female customers
CREATE VIEW number_of_male_and_female_customers AS
select gender, count (*) AS gender_count
from customer_churn
group by gender;

--Finding the average age of customers and average estimated salary
CREATE VIEW average_age_of_customers_and_salary AS
select ROUND(avg(customerage),2) AS average_age,
       ROUND(avg(estimatedsalary),2) AS average_salary
from customer_churn

--what is the exit rate as compared to satisfaction score?
CREATE VIEW exit_rate_vs_satisfaction_score AS
SELECT 
  SatisfactionScore,
  COUNT(*) AS total_customers,
  SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) AS customers_exited,
  ROUND(
    (SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END)::decimal / COUNT(*)) * 100, 2
  ) AS exit_rate_percentage
FROM 
  customer_churn
GROUP BY 
  SatisfactionScore
ORDER BY 
  SatisfactionScore;

--Finding total churn rate
CREATE VIEW total_churn_rate AS
SELECT exited,
  COUNT(*) AS total_customers,
  SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) AS total_exited,
  ROUND(
    (SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END)::decimal / COUNT(*)) * 100, 
    2
  ) AS churn_rate_percentage
FROM 
  customer_churn
  GROUP BY exited;


--Finding churn rate by gender
CREATE VIEW churn_rate_by_gender AS 
Select gender,
count(*) as total_customers,
SUM(CASE WHEN exited=1 THEN 1 ELSE 0 END) AS total_exited,
ROUND(
(SUM(CASE WHEN exited=1 THEN 1 ELSE 0 END)::decimal/count(*)) * 100,2
) AS exited_rate
from customer_churn
group by gender;

--Finding churn rate by geography
CREATE VIEW churn_rate_by_geography AS 
select geography,
count(*) as total_customers,
SUM(CASE WHEN exited=1 THEN 1 ELSE 0 END) AS total_exited,
ROUND(
(SUM(CASE WHEN exited=1 THEN 1 ELSE 0 END)::decimal/count(*)) * 100,2
) AS exited_rate
from customer_churn
group by geography;

--Finding churn rate by age group
CREATE VIEW churn_rate_by_age_group AS
Select customerage,
count(*) as total_customers,
case
when customerage between 18 and 25 then '18-25'
when customerage between 26 and 35 then '26-35'
when customerage between 36 and 45 then '36-45'
when customerage between 46 and 55 then '46-55'
when customerage between 56 and 65 then '56-65'
else '66+'
end as age_group,
sum(case when exited=1 then 1 else 0 end) as total_exit,
ROUND(
(SUM(CASE WHEN exited=1 then 1 else 0 end)::decimal/count(*)) * 100,2
) as total_exit_rate
from customer_churn
group by customerage;

--Finding Churn by Card Type 
CREATE VIEW churn_by_card_type AS
SELECT 
  CardType,
  COUNT(*) AS total_customers,
  SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END) AS churned_customers,
  ROUND(
    (SUM(CASE WHEN Exited = 1 THEN 1 ELSE 0 END)::DECIMAL / COUNT(*)) * 100, 2
  ) AS churn_rate_percentage
FROM customer_churn
GROUP BY CardType
ORDER BY churn_rate_percentage DESC;

--Average Salary by Gender
CREATE VIEW avg_salary_by_gender AS
select gender, ROUND(avg(estimatedsalary),2) AS estimated_salary
from customer_churn
group by gender;

--Active vs inactive customers churn rate
CREATE VIEW inactive_customers_churn_rate AS 
select isactivemember,
count(*) as total_customers,
sum(case when exited =1 then 1 else 0 end) as total_exit,
ROUND(
(sum(case when exited = 1 then 1 else 0 end)::decimal/count(*)) *100,2)
as exit_rate
from customer_churn
group by isactivemember;

--Complaints vs churn
CREATE VIEW complaint_churn AS
select complain,
count(*) as total_customers,
sum(case when exited =1 then 1 else 0 end) as total_exit,
ROUND(
(sum(case when exited = 1 then 1 else 0 end)::decimal/count(*)) *100,2)
as exit_rate
from customer_churn
group by complain;

--Number of Products Vs churn
CREATE VIEW products_churn AS 
select numofproducts,
count(*) as total_customers,
sum(case when exited =1 then 1 else 0 end) as total_exit,
ROUND(
(sum(case when exited = 1 then 1 else 0 end)::decimal/count(*)) *100,2)
as exit_rate
from customer_churn
group by numofproducts;

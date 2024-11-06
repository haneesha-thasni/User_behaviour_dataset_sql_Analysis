create database mobile;
use mobile;
show tables;
select * from user_behavior;
alter table user_behavior_dataset rename to user_behavior;

-- Mobile Device Usage and User Behavior Dataset

/* 
About Dataset

This dataset provides a comprehensive analysis of mobile device usage patterns and user behavior classification. 
It contains 700 samples of user data, including metrics such as app usage time, screen-on time, battery drain, and data consumption. 
Each entry is categorized into one of five user behavior classes, ranging from light to extreme usage, allowing for insightful analysis and modeling.

Key Features:

* User ID: Unique identifier for each user.
* Device Model: Model of the user's smartphone.
* Operating System: The OS of the device (iOS or Android).
* App Usage Time: Daily time spent on mobile applications, measured in minutes.
* Screen On Time: Average hours per day the screen is active.
* Battery Drain: Daily battery consumption in mAh.
* Number of Apps Installed: Total apps available on the device.
* Data Usage: Daily mobile data consumption in megabytes.
* Age: Age of the user.
* Gender: Gender of the user (Male or Female).
* User Behavior Class: Classification of user behavior based on usage patterns (1 to 5).

This dataset is ideal for researchers, data scientists, and analysts interested in understanding mobile user behavior and developing 
predictive models in the realm of mobile technology and applications. 
This Dataset was primarily designed to implement machine learning algorithms and is not a reliable source for a paper or article.
*/

-- 1. How many records (rows) are there in the user_behavior table?
select count(*) from user_behavior;

-- 2. How many users fall into each behavior class?
select User_Behavior_Class,count(User_ID) as user_counts from user_behavior GROUP BY User_Behavior_Class order by User_Behavior_Class;
 
-- 3. What is the average screen-on time recorded in the user_behavior table?
select avg(Screen_On_Time)as average_screen_time from user_behavior;

-- 4. What are the average values for app usage time, battery drain, data usage, number of apps installed, and age of users in the user_behavior table?
SELECT AVG(App_Usage_Time) AS avg_app_usage_time,
    AVG(Battery_Drain) AS avg_battery_drain,
    AVG(Data_Usage) AS avg_data_usage,
    AVG(Number_of_Apps_Installed) AS avg_apps_installed,
    AVG(Age) AS avg_age
FROM user_behavior;

-- 5. How many users are associated with each device model in the user_behavior table?
select Device_Model,count(User_ID) from user_behavior GROUP BY Device_Model;

-- 6. Which are the top 5 device models with the highest average app usage time, and what is the average app usage time for each of these models?
select Device_Model,avg(App_Usage_Time) as average_usage_time from user_behavior GROUP BY Device_Model ORDER BY average_usage_time desc limit 5;

SELECT MAX(age) from user_behavior;
select min(age) from user_behavior;

-- 7. How do average mobile usage patterns vary across different age groups?
SELECT 
CASE
WHEN Age < 18 THEN 'UNDER 18'
WHEN Age BETWEEN 18 AND 35 THEN 'YOUNG'
WHEN Age BETWEEN 36 AND 50 THEN 'MIDDLE'
ELSE 'OLD'
END AS AGE_GROUP,
	AVG(App_Usage_Time) AS avg_app_usage_time,
    AVG(Screen_On_Time) AS avg_screen_on_time,
    AVG(Battery_Drain) AS avg_battery_drain,
    AVG(Data_Usage) AS avg_data_usage,
    AVG(Number_of_Apps_Installed) AS avg_apps_installed   
FROM user_behavior
GROUP BY AGE_GROUP;

-- 8. How does the average app usage time and data usage vary by gender among users?
SELECT gender,AVG(app_usage_time) AS avg_app_usage_time,AVG(data_usage) AS avg_data_usage
FROM user_behavior
GROUP BY gender;
    
-- 9.How does the average data usage vary by user behavior class across different operating systems?
SELECT Operating_System,User_Behavior_Class,AVG(Data_Usage) AS avg_data_usage
FROM user_behavior
GROUP BY Operating_System, User_Behavior_Class;

-- 10. What is the percentage distribution of male and female users across user behavior classes?
SELECT Gender,User_Behavior_Class,
COUNT(User_ID) * 100 / (SELECT COUNT(*) FROM user_behavior) AS percentage
FROM user_behavior
GROUP BY Gender, User_Behavior_Class;

-- 11. Which device model has the highest average screen-on time?
SELECT Device_Model,AVG(Screen_On_Time) AS avg_screen_on_time
FROM user_behavior
GROUP BY Device_Model
ORDER BY avg_screen_on_time DESC
LIMIT 1;

-- 12. How does the average app usage time vary among different user behavior classes?
SELECT User_Behavior_Class,AVG(App_Usage_Time) AS avg_app_usage_time
FROM user_behavior
GROUP BY User_Behavior_Class;

-- 13. What are the top 3 device models in terms of the highest number of installed apps?
SELECT Device_Model,count(Number_of_Apps_Installed) AS total_apps_installed
FROM user_behavior
GROUP BY Device_Model
ORDER BY total_apps_installed DESC
LIMIT 3;

-- 14. How does the average battery drain differ across different age groups?
SELECT 
CASE
WHEN Age < 18 THEN 'UNDER 18'
WHEN Age BETWEEN 18 AND 35 THEN 'YOUNG'
WHEN Age BETWEEN 36 AND 50 THEN 'MIDDLE'
ELSE 'OLD'     
END AS age_group, AVG(Battery_Drain) AS avg_battery_drain
FROM user_behavior
GROUP BY age_group;

-- 15. What is the distribution of users based on the operating system and user behavior class?
SELECT Operating_System,User_Behavior_Class,COUNT(User_ID) AS user_count
FROM user_behavior
GROUP BY Operating_System, User_Behavior_Class;

-- 16. Which age group has the highest number of installed apps on average?
SELECT 
CASE
WHEN Age < 18 THEN 'UNDER 18'
WHEN Age BETWEEN 18 AND 35 THEN 'YOUNG'
WHEN Age BETWEEN 36 AND 50 THEN 'MIDDLE'
ELSE 'OLD'     
END AS age_group,
AVG(Number_of_Apps_Installed) AS avg_apps_installed
FROM user_behavior
GROUP BY age_group
ORDER BY avg_apps_installed DESC
LIMIT 1;

-- 17. What is the average app usage time and screen-on time for male vs. female users?
SELECT Gender,AVG(App_Usage_Time) AS avg_app_usage_time,AVG(Screen_On_Time) AS avg_screen_on_time
FROM user_behavior
GROUP BY Gender;

-- 18. What are the top 3 operating systems in terms of average battery drain?
SELECT Operating_System,AVG(Battery_Drain) AS avg_battery_drain
FROM user_behavior
GROUP BY Operating_System
ORDER BY avg_battery_drain DESC
LIMIT 3;
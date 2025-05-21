create DATABASE Olympics;
USE Olympics;

select * from Olympics;

#check number of empty rows
SELECT * FROM Olympics
WHERE City IS NULL 
   OR Year IS NULL
   OR Sport IS NULL
   OR Discipline IS NULL
   OR Event IS NULL
   OR Athlete IS NULL
   OR Gender IS NULL
   OR Country_Code IS NULL
   OR Country IS NULL
   OR Event_gender IS NULL
   OR Medal IS NULL;

#count number of empty rows
SELECT COUNT(*) AS empty_row_count FROM Olympics
WHERE City IS NULL 
   OR Year IS NULL
   OR Sport IS NULL
   OR Discipline IS NULL
   OR Event IS NULL
   OR Athlete IS NULL
   OR Gender IS NULL
   OR Country_Code IS NULL
   OR Country IS NULL
   OR Event_gender IS NULL
   OR Medal IS NULL;
   
#1.	Which country has won the most Gold medals overall?
select Country, count(*) as total_number_of_Gold_medals from Olympics
where Medal = 'Gold'
group by Country
order by total_number_of_Gold_medals desc; 
   
#2.	Who are the top 10 athletes with the highest number of total medals?
SELECT Athlete, COUNT(*) AS number_of_medals from Olympics
group by Athlete
order by number_of_medals desc limit 10; 

#3. How many medals were won by male vs female athletes?
select Gender, COUNT(*) AS number_of_medals, ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Olympics), 2) AS percentage from olympics
group by Gender;

#4. Which sport has awarded the most medals?
select Sport, count(*) as number_of_medals , ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Olympics), 2) AS percentage from olympics                   
group by Sport
order by number_of_medals desc;

#5.	How many unique athletes have won more than one medal?
SELECT COUNT(*) AS unique_athletes_with_multiple_medals
FROM (SELECT Athlete FROM Olympics
    GROUP BY Athlete HAVING COUNT(Medal) > 1) AS sub;
    
#6. Which country has participated in the most Olympic events?
select country, count(*) as  participated_in_the_most_Olympic_events from olympics
group by country
order by participated_in_the_most_Olympic_events desc;
 
# 7. Which country performed best in Aquatics overall?
SELECT Country, COUNT(Medal) AS total_medals_in_aquatics FROM Olympics
WHERE Sport = 'Aquatics'
GROUP BY Country
ORDER BY total_medals_in_aquatics DESC;

#8. Trend of medals won by United States from year to year.
SELECT Year, COUNT(Medal) AS no_of_medals FROM Olympics 
WHERE Country = 'United States'
GROUP BY Year
ORDER BY Year ASC;

#9. Which year had the highest number of medals awarded?
select year, COUNT(Medal) AS no_of_medals FROM Olympics 
GROUP BY Year
ORDER BY no_of_medals desc;

#10. Has the number of medals per Olympics increased over time?
SELECT Year, COUNT(*) AS total_medals FROM Olympics
GROUP BY Year 
ORDER BY Year ASC;
 
#11. What are the most consistent sports (present in every Olympic year)?
SELECT Sport FROM Olympics
GROUP BY Sport
HAVING COUNT(DISTINCT Year) = (SELECT COUNT(DISTINCT Year) FROM Olympics);
 
#12. How did medal distribution by gender change over the year?
select Year,Gender, count(Medal) as medal_distribution from Olympics
group by Year,Gender
order by Year ASC, Gender;
 
#13. Which country won multiple medals in same Sport in the same year?
SELECT Country, Sport, Year, COUNT(*) AS medal_count
FROM Olympics
GROUP BY Country, Sport, Year
HAVING COUNT(*) > 1
ORDER BY medal_count DESC;
 
#14. Are there any sports where only one gender has ever won medals?
SELECT Sport, MIN(Gender) AS Gender,  COUNT(DISTINCT Gender) AS gender_count FROM Olympics
GROUP BY Sport
HAVING COUNT(DISTINCT Gender) = 1;

#15. Identify one-time winners vs repeat winners by athlete and country.
SELECT Athlete, Country, COUNT(*) AS total_medals,
    CASE 
        WHEN COUNT(*) = 1 THEN 'One-time Winner'
        ELSE 'Repeat Winner'
    END AS winner_type
FROM Olympics
GROUP BY Athlete, Country
ORDER BY total_medals DESC;

#16. What are the most medal-winning sports by year?
select year,Sport,count(Medal) as number_of_medal from Olympics
group by year,Sport
order by number_of_medal desc ;

#17. How has female participation and medal-winning changed over time?
select year, count(Medal) as number_of_medal from Olympics
WHERE gender = 'Women'
group by year
ORDER BY  year asc;

#18. Which countries dominate in specific sports ?
SELECT Country, Discipline, number_of_medal
FROM (
    SELECT Country, Discipline, COUNT(*) AS number_of_medal,
           RANK() OVER (PARTITION BY Discipline ORDER BY COUNT(*) DESC) AS rank_per_sport
    FROM Olympics
    GROUP BY Country, Discipline
) ranked
WHERE rank_per_sport = 1
order by Country desc, number_of_medal desc;






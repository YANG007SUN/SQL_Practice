
--https://www.hackerrank.com/challenges/weather-observation-station-18/problem

SELECT ROUND(SQRT(POWER(num.a-num.c,2))+ SQRT(POWER(num.d-num.b,2)),4)
FROM (SELECT MIN(LAT_N) AS a, 
       MIN(LONG_W) AS b,       
       MAX(LAT_N) AS c,
       MAX(LONG_W) AS d
       FROM STATION) AS num
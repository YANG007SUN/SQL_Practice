-- https://www.hackerrank.com/challenges/weather-observation-station-20/problem

SELECT ROUND(r.LAT_N,4)
FROM (SELECT ROW_NUMBER() OVER (ORDER BY LAT_N)AS row_num, 
             LAT_N
      FROM STATION
      ORDER BY LAT_N) AS r
WHERE r.row_num = (
     SELECT CASE WHEN MAX(r.row_num) %2 =0 THEN MAX(r.row_num)/2
                 ELSE (MAX(r.row_num)+1)/2 END AS t
     FROM (SELECT ROW_NUMBER() OVER (ORDER BY LAT_N) AS row_num, 
             LAT_N
           FROM STATION) AS r
)

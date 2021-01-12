
-- https://www.hackerrank.com/challenges/occupations/problem

SELECT 
MAX(CASE WHEN Occupation = 'Doctor' THEN Name ELSE NULL END) AS Doctor,
MAX(CASE WHEN Occupation = 'Professor' THEN Name ELSE NULL END) AS Professor,
MAX(CASE WHEN Occupation = 'Singer' THEN Name ELSE NULL END) AS Singer,
MAX(CASE WHEN Occupation = 'Actor' THEN Name ELSE NULL END) AS Actor
FROM (
  SELECT a.Occupation,
         a.Name,
         (SELECT COUNT(*) 
            FROM Occupations AS b
            WHERE a.Occupation = b.Occupation AND a.Name > b.Name) AS rk
  FROM Occupations AS a
  ORDER by rk
) AS c
GROUP BY c.rk;



-- Alternative Solution, use Windown function to find out the rank of each person by occupation

SELECT 
       MAX(CASE WHEN a.Occupation ='Doctor' THEN Name ELSE NULL END),
       MAX(CASE WHEN a.Occupation ='Professor' THEN Name ELSE NULL END),
       MAX(CASE WHEN a.Occupation ='Singer' THEN Name ELSE NULL END),
       MAX(CASE WHEN a.Occupation ='Actor' THEN Name ELSE NULL END)
       
FROM  (SELECT Occupation, 
           Name, 
           ROW_NUMBER() OVER (PARTITION BY OCCUPATION ORDER BY NAME) AS row_num
       FROM OCCUPATIONS
       ORDER BY row_num) AS a

GROUP BY a.row_num
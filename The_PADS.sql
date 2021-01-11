-- https://www.hackerrank.com/challenges/the-pads/problem

SELECT CONCAT(Name, '(', LEFT(Occupation,1),')')
FROM OCCUPATIONS
ORDER BY Name;

SELECT CONCAT('There are a total of ',c,' ',LOWER(Occupation),'s','.')
FROM  (SELECT Occupation, COUNT(Name) AS c
       FROM OCCUPATIONS
       GROUP BY Occupation
       ORDER BY c, Occupation) AS res
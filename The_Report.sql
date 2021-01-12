-- https://www.hackerrank.com/challenges/the-report/problem

SELECT CASE WHEN temp.grade<8 THEN NULL ELSE temp.name END,
       temp.grade,
       temp.marks
FROM (SELECT s.name AS name,
             s.marks AS marks,
           (SELECT grade
            FROM Grades AS g
            WHERE s.marks<=g.max_mark AND s.marks>=g.min_mark) AS grade
      FROM Students AS s
      ORDER BY grade DESC, s.name) AS temp
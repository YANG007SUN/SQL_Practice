--https://www.hackerrank.com/challenges/full-score/problem

-- Solution with join
SELECT s.hacker_id, 
       h.name
FROM Submissions AS s
LEFT JOIN Challenges AS c
ON s.challenge_id = c.challenge_id
LEFT JOIN Difficulty AS d
ON c.difficulty_level = d.difficulty_level
LEFT JOIN hackers AS h
ON s.hacker_id = h.hacker_id
WHERE s.score = d.score
GROUP BY s.hacker_id, h.name
HAVING COUNT(*)>1
ORDER BY COUNT(*) DESC, s.hacker_id


-- Solution with subquery
SELECT temp.hacker_id, 
       temp.name
FROM (SELECT s.hacker_id AS hacker_id, s.score AS score,
         (SELECT c.difficulty_level
          FROM Challenges AS c
          WHERE c.challenge_id = s.challenge_id) AS dl, 
         (SELECT d.score
          FROM Difficulty AS d
          WHERE d.difficulty_level = dl) AS full_score,
         (SELECT h.name
          FROM hackers AS h
          WHERE h.hacker_id = s.hacker_id) AS name
      FROM Submissions AS s) AS temp
WHERE temp.full_score = temp.score
GROUP BY temp.hacker_id, temp.name
HAVING COUNT(*)>1
ORDER BY COUNT(*) DESC, temp.hacker_id
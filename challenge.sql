-- https://www.hackerrank.com/challenges/challenges/problem

SELECT h.hacker_id, h.name, temp.num
FROM Hackers AS h
LEFT JOIN (SELECT hacker_id, COUNT(challenge_id) AS num
            FROM Challenges
            GROUP BY hacker_id) AS temp
ON temp.hacker_id=h.hacker_id
WHERE temp.num NOT IN (
    SELECT tt.n
    FROM (
        SELECT t.num AS n, COUNT(t.num) AS freq
        FROM (SELECT hacker_id, COUNT(challenge_id) AS num
              FROM Challenges
              GROUP BY hacker_id) AS t
        GROUP BY t.num
        HAVING freq>1 AND n<50) AS tt
)
ORDER BY temp.num DESC, hacker_id
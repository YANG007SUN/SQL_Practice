-- https://www.hackerrank.com/challenges/contest-leaderboard/problem?h_r=next-challenge&h_v=zen&isFullScreen=true

SELECT h.hacker_id, h.name, temp.total_score
FROM Hackers AS h
LEFT JOIN (SELECT t1.hacker_id AS hacker_id, sum(t1.total_score) AS total_score
            FROM (
                SELECT hacker_id, challenge_id, MAX(score) AS total_score
                FROM Submissions
                GROUP BY hacker_id, challenge_id) AS t1
            GROUP BY t1.hacker_id) AS temp
ON temp.hacker_id = h.hacker_id
WHERE temp.total_score> 0
ORDER BY temp.total_score DESC, h.hacker_id
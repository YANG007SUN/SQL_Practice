--https://www.hackerrank.com/challenges/harry-potter-and-wands/problem



-- only runs in MS SQL, but not in MYSQL
SELECT temp.id, temp.age, temp.coins_needed, temp.power
FROM (SELECT w.id AS id, wp.age AS age, w.coins_needed AS coins_needed, w.power AS power, 
              ROW_NUMBER() OVER (PARTITION BY wp.age, w.power ORDER BY w.coins_needed) AS r
        FROM Wands AS w
        INNER JOIN Wands_Property AS wp
        ON wp.code = w.code
        WHERE wp.is_evil = 0) temp
WHERE temp.r = 1
ORDER BY temp.power DESC, temp.age DESC 
SELECT 'Tykvenko Olga Vasilevna' -- FIO
SELECT * FROM ratings_8 LIMIT 10; -- TASK 1.1
SELECT * FROM links_3 WHERE links_3.imbld LIKE '%42' AND movieid BETWEEN '100' AND '1000'; -- TASK 1.2
SELECT * FROM links_3 INNER JOIN ratings_8 ON links_3.movieid = ratings_8.movieid WHERE ratings_8.rating = 5; -- TASK 2.1
SELECT COUNT (movieid) as count FROM ratings_8 WHERE ratings_8.rating IS NULL; -- TASK 3.1
SELECT userId, AVG(rating) as avg_rating FROM ratings_8 GROUP BY userId HAVING AVG(rating) > 3.5 ORDER BY avg_rating DESC LIMIT 10; -- TASK 3.2
SELECT DISTINCT imbld FROM links_3 WHERE (SELECT AVG(rating) FROM public.ratings_8) > 3.5 LIMIT 10; -- TASK 4.1
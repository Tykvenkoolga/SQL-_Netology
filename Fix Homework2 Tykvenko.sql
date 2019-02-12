SELECT COUNT(links_3.movieid) as count FROM links_3 LEFT JOIN ratings_8 ON links_3.movieid = ratings_8.movieid WHERE ratings_8.movieid IS NULL; --Task 3.1

SELECT imbld FROM links_3 LEFT JOIN ratings_8 ON links_3.movieid = ratings_8.movieid WHERE (SELECT AVG(rating) FROM ratings_8) > 3.5 LIMIT 10; -- Task 4.1

WITH avg_srednee AS (SELECT userid, COUNT(rating) as activity FROM ratings_8 GROUP BY userid HAVING COUNT (rating) > 10) SELECT AVG (activity) as srednee FROM avg_srednee; -- Task 4.2
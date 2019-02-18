SELECT imbld FROM links_3 WHERE movieid IN (SELECT movieid FROM ratings_8 GROUP BY movieid HAVING AVG(rating) > 3.5) LIMIT 10; -- Task 4.1

WITH avg_srednee AS (SELECT userid, AVG(rating) as activity FROM ratings_8 GROUP BY userid HAVING COUNT (rating) > 10) SELECT AVG (activity) as srednee FROM avg_srednee; -- Task 4.2
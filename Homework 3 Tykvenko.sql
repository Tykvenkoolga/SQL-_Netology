SELECT userId, movieId,
		(rating - MIN(rating) OVER (PARTITION BY userId))/(MAX(rating) OVER (PARTITION BY userId)) - (MIN(rating) OVER (PARTITION BY userId)) as normed_rating,
		AVG(rating) OVER (PARTITION BY userId) FROM 
		(SELECT DISTINCT userId, movieId, rating FROM ratings_8) as norma 
		ORDER BY userId, rating DESC LIMIT 30; --Task 1


		CREATE TABLE IF NOT EXISTS keywords (Id bigint, tags text);
		\copy keywords FROM '/vagrant/keywords.csv' DELIMITER ',' CSV HEADER;



		SELECT movieid, AVG(rating) :: numeric (10,2) as avg_rating FROM ratings_8 GROUP BY movieid HAVING COUNT(userid) > 50 ORDER BY avg_rating DESC, movieid ASC LIMIT 150; -- zapros 1

		WITH top_rated as (SELECT movieid, AVG(rating) :: numeric (10,2) as avg_rating FROM ratings_8 
		GROUP BY movieid HAVING COUNT(userid) > 50 ORDER BY avg_rating DESC, movieid ASC LIMIT 150) 
		SELECT tags FROM keywords JOIN top_rated ON top_rated.movieid = keywords.id LIMIT 150; -- zapros 2



		\copy (SELECT * FROM top_rated_tags LIMIT 150) TO 'top_rated_tags.csv' WITH CSV HEADER DELIMITER as ','; -- vygruzka

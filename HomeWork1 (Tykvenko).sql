CREATE TABLE favorite_films (id_films INT NOT NULL, tittle VARCHAR (255) NOT NULL, country VARCHAR (255) NOT NULL, box_office INT NOT NULL, release_year TIMESTAMP, PRIMARY KEY (id_films));
INSERT INTO favorite_films VALUES (111,'Saw','USA', 103096345, '2004-01-19' :: timestamp), (222, 'Insidious','USA', 97009150, '2010-09-14' :: timestamp), (333,'Silent Hill','Canada', 97607453, '2006-04-21' :: timestamp), (444,'Harry Potter','Great Britain', 974755371, '2001-11-04' :: timestamp), (555,'A Dog Purpose','USA', 204052467, '2017-01-19' :: timestamp);
CREATE TABLE persons (id_persons INT NOT NULL, fio VARCHAR (255), PRIMARY KEY (id_persons)); 
INSERT INTO persons VALUES (1111, 'James Wan'), (2222, 'Patrick Wilson'), (3333, 'Akira Yamaoka'), (4444, 'J.K.Rowling'), (5555, 'Holly Bario');
CREATE TABLE persons2content (id_persons INT NOT NULL, id_films INT NOT NULL, person_type VARCHAR (255), FOREIGN KEY (id_persons) REFERENCES persons (id_persons), FOREIGN KEY (id_films) REFERENCES favorite_films (id_films);
INSERT INTO persons2content (persons_type) VALUES ('producer'), ('actor'), ('composer'), ('screenwriter'), ('co-produser');

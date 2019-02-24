CREATE TABLE Shop (shop_id INTEGER, adres VARCHAR (255), PRIMARY KEY (shop_id));

INSERT INTO Shop VALUES (1, 'Vikulova'), 
						(2, 'Lunacharskogo'),
						(3, 'Dekabristov'),
						(4, 'Gagarina'),
						(5, 'Amundsena'),
						(6, 'Surikova');


CREATE TABLE Emploees (id INTEGER, shop_id INTEGER, seller_id INTEGER, name VARCHAR (255), PRIMARY KEY (seller_id), FOREIGN KEY (shop_id) REFERENCES Shop (shop_id));

INSERT INTO Emploees VALUES (1, 1, 11, 'Anna'),
							(2, 1, 12, 'Elena'),
							(3, 2, 21, 'Marina'),
							(4, 2, 22, 'Irina'),
							(5, 3, 31, 'Katerina'),
							(6, 3, 32, 'Nina'),
							(7, 4, 41, 'Sergey'),
							(8, 4, 42, 'Petr'),
							(9, 5, 51, 'Oksana'),
							(10, 5, 52, 'Alesandr'),
							(11, 6, 61, 'Anton'),
							(12, 6, 62, 'Victor');


CREATE TABLE Revenue (id INTEGER, shop_id INTEGER, adres VARCHAR (255), proceeds INTEGER, FOREIGN KEY (shop_id) REFERENCES Shop (shop_id));

INSERT INTO Revenue VALUES  (1, 1, 'Vikulova', 1110020),
							(2, 2, 'Lunacharskogo', 1378092),
							(3, 3, 'Dekabristov', 1229763),
							(4, 4, 'Gagarina', 978195),
							(5, 5, 'Amundsena', 371196),
							(6, 6, 'Surikova', 1174264);


CREATE TABLE Sales 	(id INTEGER, shop_id INTEGER, seller_id INTEGER, name VARCHAR (255), num_sales INTEGER, sum_sales INTEGER,  FOREIGN KEY (seller_id) REFERENCES Emploees (seller_id));

INSERT INTO Sales VALUES (1, 1, 11, 'Anna', 411, 625463), 
						 (2, 1, 12, 'Elena', 398, 484557),
						 (3, 2, 21, 'Marina', 576, 643198),
						 (4, 2, 22, 'Irina', 541, 734894),
						 (5, 3., 31, 'Katerina', 466, 681192),
						 (6, 3, 32, 'Nina', 423, 548571),
						 (7, 4, 41, 'Sergey', 221, 424175),
						 (8, 4, 42, 'Petr', 273, 554020),
						 (9, 5, 51, 'Oksana', 124,175296),
						 (10, 5, 52, 'Alesandr', 98, 195900),
						 (11, 6, 61, 'Anton', 355, 587572),
						 (12, 6, 62, 'Victor', 369, 586692);

SELECT * FROM Emploees LIMIT 10; -- zapros 1 (Выбрать 5 любых записей из таблицы Emploees)

SELECT COUNT (*) FROM Sales WHERE num_sales < 400 AND sum_sales BETWEEN '500000' AND '600000'; -- zapros 2 (В таблице Sales посчитать количество записей, в которых количество продаж больше 400, а выручка сотрудника находится между 500 000 и 600 000)

SELECT seller_id, name FROM Emploees JOIN Revenue ON Emploees.shop_id = Revenue.shop_id WHERE proceeds > 1000000; -- zapros 3 (Вывести имена сотрудников, чьи магазины делают выручку больше 1 000 000 в месяц)

SELECT name, (sum_sales/num_sales) as sr_chek FROM Sales WHERE sum_sales/num_sales > 1500 ORDER BY sr_chek DESC; -- zapros 4 (Выбрать из таблицы Sales имена тех продавцов, чей средний чек больше 1500 (средний чек = выручка сотрудника/количество продаж))

SELECT Shop.shop_id, Shop.adres, sum (num_sales) as quantity FROM Shop JOIN Sales ON Shop.shop_id = Sales.shop_id GROUP BY Shop.shop_id, Shop.adres ORDER BY quantity DESC; -- zapros 5 (Вывести список адресов магазинов и количество продаж в каждом магазине)

WITH shop_num as (SELECT shop.shop_id, adres, SUM (Sales.num_sales) as summa_prodaz 
				 FROM Shop JOIN Sales ON shop.shop_id = Sales.shop_id GROUP BY shop.shop_id, adres 
				 ORDER BY summa_prodaz DESC)
SELECT * FROM shop_num WHERE summa_prodaz = (SELECT summa_prodaz FROM shop_num LIMIT 1); -- zapros 6 (Вывести список адресов с максимальным количеством продаж)

SELECT shop.shop_id, Shop.adres, AVG (Sales.num_sales) as srednee FROM Shop JOIN Sales ON shop.shop_id = Sales.shop_id 
JOIN Revenue ON shop.shop_id = Revenue.shop_id WHERE proceeds < 1000000
GROUP BY shop.shop_id, Shop.adres; -- zapros 7 (Вывести список адресов и среднее количество продаж у тех магазинов, у которых выручка за месяц меньше 1 000 000)

SELECT * FROM (SELECT seller_id, name, sum_sales, ROW_NUMBER () OVER (ORDER BY sum_sales DESC) as premia 
FROM Sales ORDER BY premia ASC)  TOP_5 WHERE premia <=5; -- zapros 8 (Вывести топ-5 сотрудников с наибольшими суммами продаж)

SELECT seller_id, name, sum_sales, AVG (sum_sales) OVER (PARTITION BY adres) 
FROM Sales JOIN Shop ON Sales.shop_id = Shop.shop_id ORDER BY seller_id; -- zapros 9 (Вывести сумму продаж каждого сотрудника и среднюю сумму продаж его магазина)

SELECT id, shop_id, adres, proceeds, ROW_NUMBER () OVER w as rating, LAG (proceeds) OVER w - proceeds as proceeds_lag 
FROM Revenue WINDOW w as (ORDER BY proceeds DESC) ORDER BY proceeds DESC; -- zapros 10 (Найти, на какую сумму выручка магазина отстает от предыдущей в рейтинге)					 
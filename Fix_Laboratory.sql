CREATE TABLE Department (id INTEGER, name VARCHAR (255), PRIMARY KEY (id));
INSERT INTO Department VALUES ('1', 'Therapy'),
('2', 'Neurology'),
('3', 'Cardiology'),
('4', 'Gastroenterology'),
('5', 'Hematology'),
('6', 'Oncology');

CREATE TABLE Employee (id INTEGER, department_id INTEGER, chief_doc_id INTEGER, name VARCHAR (255), num_public INTEGER, PRIMARY KEY (id), FOREIGN KEY (department_id) REFERENCES Department (id));
                       
INSERT INTO Employee VALUES
('1', '1', '1', 'Kate', 4),
('2', '1', '1', 'Lidia', 2),
('3', '1', '1', 'Alexey', 1),
('4', '1', '2', 'Pier', 7),
('5', '1', '2', 'Aurel', 6),
('6', '1', '2', 'Klaudia', 1),
('7', '2', '3', 'Klaus', 12),
('8', '2', '3', 'Maria', 11),
('9', '2', '4', 'Kate', 10),
('10', '3', '5', 'Peter', 8),
('11', '3', '5', 'Sergey', 9),
('12', '3', '6', 'Olga', 12),
('13', '3', '6', 'Maria', 14),
('14', '4', '7', 'Irina', 2),
('15', '4', '7', 'Grit', 10),
('16', '4', '7', 'Vanessa', 16),
('17', '5', '8', 'Sascha', 21),
('18', '5', '8', 'Ben', 22),
('19', '6', '9', 'Jessy', 19),
('20', '6', '9', 'Ann', 18);

SELECT Department.name, COUNT (distinct chief_doc_id) as summa FROM Department
LEFT JOIN Employee ON Department.id=Employee.department_id GROUP BY Department.name, Department.id; -- запрос a), добавлено distinct

SELECT Department.id, Department.name,  COUNT (chief_doc_id) as summa FROM Department 
LEFT JOIN Employee ON Department.id=Employee.department_id GROUP BY Department.name, Department.id -- запрос b) - без изменений, т.к. решен правильно
HAVING COUNT (chief_doc_id) >= 3;

WITH dep_public AS ( -- запрос c), добавлена часть запроса
  SELECT d.id,
         d.name,
         SUM(e.num_public) AS total_public
  FROM Department d
         JOIN Employee e ON d.id = e.department_id
  GROUP BY d.id, d.name
  ORDER BY total_public DESC
)
SELECT *
FROM dep_public
WHERE total_public = (
  SELECT total_public
  FROM dep_public
  LIMIT 1
);

WITH mp AS ( --  запрос d) с добавленными данными в подсказку
  SELECT MIN(Employee.num_public) AS num_public,
         Employee.department_id
  FROM Employee
  GROUP BY Employee.department_id
)
SELECT Department.id, Department.name, Employee.name, Employee.num_public
FROM mp
       FULL OUTER JOIN Employee ON Employee.num_public = mp.num_public
       JOIN Department ON Department.id = Employee.department_id
WHERE Department.id = mp.department_id
  AND Employee.num_public = mp.num_public
ORDER BY Department.id;

SELECT -- запрос e) с доработкой
	Department.id,
	Department.name,
	AVG(Employee.num_public) AS avg
FROM Department
JOIN Employee ON Department.id = Employee.department_id
GROUP BY Department.id, Department.name
HAVING COUNT(DISTINCT(Employee.chief_doc_id)) > 1;

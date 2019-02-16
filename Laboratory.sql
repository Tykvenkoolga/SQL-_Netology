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
                      
SELECT Department.name, COUNT (chief_doc_id) as summa FROM Department 
LEFT JOIN Employee ON Department.id=Employee.department_id GROUP BY Department.name, Department.id;

SELECT Department.id, Department.name,  COUNT (chief_doc_id) as summa FROM Department 
LEFT JOIN Employee ON Department.id=Employee.department_id GROUP BY Department.name, Department.id
HAVING COUNT (chief_doc_id) >= 3;





WITH dep_public as (SELECT Department.id, Department.name,  SUM (num_public) as max_kolvo FROM Department 
LEFT JOIN Employee ON Department.id=Employee.department_id GROUP BY Department.name, Department.id
ORDER BY max_kolvo DESC) SELECT * FROM dep_public WHERE SUM (num_public) = (MAX(num_public) LIMIT 1);
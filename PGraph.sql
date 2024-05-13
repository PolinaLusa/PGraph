USE MASTER
GO
DROP DATABASE IF EXISTS PGraph
GO
CREATE DATABASE PGraph
GO
USE PGraph
GO

-- Создание таблицы Сотрудник
CREATE TABLE Employee (
    ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Position VARCHAR(100),
    Department VARCHAR(100),
    Email VARCHAR(100)
) AS NODE;

-- Создание таблицы Проект
CREATE TABLE Project (
    ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Description TEXT,
    StartDate DATE,
    EndDate DATE,
    Status VARCHAR(50)
) AS NODE;

-- Создание таблицы Задача
CREATE TABLE Task (
    ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Description TEXT,
    Priority INT,
) AS NODE;

CREATE TABLE Includes AS EDGE
CREATE TABLE Works AS EDGE
CREATE TABLE Collaborates AS EDGE

-- Заполнение таблицы Сотрудник данными
INSERT INTO Employee (ID, Name, Position, Department, Email)
VALUES
    (1, 'John Smith', 'Software Engineer', 'Development', 'john@example.com'),
    (2, 'Jane Doe', 'Project Manager', 'Management', 'jane@example.com'),
    (3, 'Michael Johnson', 'QA Engineer', 'Quality Assurance', 'michael@example.com'),
    (4, 'Emily Brown', 'UI/UX Designer', 'Design', 'emily@example.com'),
    (5, 'Chris Wilson', 'Database Administrator', 'IT', 'chris@example.com'),
    (6, 'Sarah Lee', 'Business Analyst', 'Analysis', 'sarah@example.com'),
    (7, 'Alex Clark', 'System Administrator', 'IT', 'alex@example.com'),
    (8, 'Emma Taylor', 'Marketing Specialist', 'Marketing', 'emma@example.com'),
    (9, 'Daniel Martinez', 'Data Scientist', 'Data Science', 'daniel@example.com'),
    (10, 'Olivia Garcia', 'HR Manager', 'Human Resources', 'olivia@example.com');

-- Заполнение таблицы Проект данными
INSERT INTO Project (ID, Name, Description, StartDate, EndDate, Status)
VALUES
    (1, 'Project A', 'Developing a new mobile application', '2024-01-01', '2024-06-30', 'In Progress'),
    (2, 'Project B', 'Implementing a CRM system', '2024-02-01', '2024-08-31', 'Planned'),
    (3, 'Project C', 'Website redesign', '2024-03-01', '2024-07-31', 'Completed'),
    (4, 'Project D', 'Big data analytics platform', '2024-04-01', '2024-09-30', 'In Progress'),
    (5, 'Project E', 'E-commerce website development', '2024-05-01', '2024-10-31', 'Planned'),
    (6, 'Project F', 'Cybersecurity audit', '2024-06-01', '2024-11-30', 'Completed'),
    (7, 'Project G', 'Machine learning research', '2024-07-01', '2024-12-31', 'In Progress'),
    (8, 'Project H', 'Product launch campaign', '2024-08-01', '2025-01-31', 'Planned'),
    (9, 'Project I', 'IT infrastructure upgrade', '2024-09-01', '2025-02-28', 'Completed'),
    (10, 'Project J', 'Social media marketing', '2024-10-01', '2025-03-31', 'In Progress');

-- Заполнение таблицы Задача данными
INSERT INTO Task (ID, Name, Description, Priority)
VALUES
    (1, 'Requirement gathering', 'Gather requirements for the new project', 1),
    (2, 'UI/UX design', 'Design user interface and experience', 2),
    (3, 'Database setup', 'Set up database for the project', 3),
    (4, 'Frontend development', 'Develop frontend of the application', 1),
    (5, 'Backend development', 'Develop backend logic and APIs', 1),
    (6, 'Testing', 'Perform unit and integration testing', 2),
    (7, 'Deployment', 'Deploy the application to production servers', 3),
    (8, 'Data analysis', 'Analyze data for insights', 2),
    (9, 'Report generation', 'Generate reports based on data analysis', 3),
    (10, 'Training', 'Provide training to end users', 1);


INSERT INTO Collaborates ($from_id, $to_id)
VALUES ((SELECT $node_id FROM Employee WHERE id = 1),
 (SELECT $node_id FROM Employee WHERE id = 2)),
 ((SELECT $node_id FROM Employee WHERE id = 10),
 (SELECT $node_id FROM Employee WHERE id = 5)),
 ((SELECT $node_id FROM Employee WHERE id = 2),
 (SELECT $node_id FROM Employee WHERE id = 9)),
 ((SELECT $node_id FROM Employee WHERE id = 3),
 (SELECT $node_id FROM Employee WHERE id = 1)),
 ((SELECT $node_id FROM Employee WHERE id = 3),
 (SELECT $node_id FROM Employee WHERE id = 6)),
 ((SELECT $node_id FROM Employee WHERE id = 4),
 (SELECT $node_id FROM Employee WHERE id = 2)),
 ((SELECT $node_id FROM Employee WHERE id = 5),
 (SELECT $node_id FROM Employee WHERE id = 4)),
 ((SELECT $node_id FROM Employee WHERE id = 6),
 (SELECT $node_id FROM Employee WHERE id = 7)),
 ((SELECT $node_id FROM Employee WHERE id = 6),
 (SELECT $node_id FROM Employee WHERE id = 8)),
 ((SELECT $node_id FROM Employee WHERE id = 8),
 (SELECT $node_id FROM Employee WHERE id = 3));

INSERT INTO Works ($from_id, $to_id)
VALUES ((SELECT $node_id FROM Employee WHERE ID = 1),
 (SELECT $node_id FROM Project WHERE ID = 1)),
 ((SELECT $node_id FROM Employee WHERE ID = 5),
 (SELECT $node_id FROM Project WHERE ID = 1)),
 ((SELECT $node_id FROM Employee WHERE ID = 8),
 (SELECT $node_id FROM Project WHERE ID = 1)),
 ((SELECT $node_id FROM Employee WHERE ID = 2),
 (SELECT $node_id FROM Project WHERE ID = 2)),
 ((SELECT $node_id FROM Employee WHERE ID = 3),
 (SELECT $node_id FROM Project WHERE ID = 3)),
 ((SELECT $node_id FROM Employee WHERE ID = 4),
 (SELECT $node_id FROM Project WHERE ID = 3)),
 ((SELECT $node_id FROM Employee WHERE ID = 6),
 (SELECT $node_id FROM Project WHERE ID = 4)),
 ((SELECT $node_id FROM Employee WHERE ID = 7),
 (SELECT $node_id FROM Project WHERE ID = 4)),
 ((SELECT $node_id FROM Employee WHERE ID = 1),
 (SELECT $node_id FROM Project WHERE ID = 9)),
 ((SELECT $node_id FROM Employee WHERE ID = 9),
 (SELECT $node_id FROM Project WHERE ID = 4)),
 ((SELECT $node_id FROM Employee WHERE ID = 10),
 (SELECT $node_id FROM Project WHERE ID = 9));


INSERT INTO Includes ($from_id, $to_id)
VALUES ((SELECT $node_id FROM Project WHERE ID = 1),
 (SELECT $node_id FROM Task WHERE ID = 6)),
 ((SELECT $node_id FROM Project WHERE ID = 5),
 (SELECT $node_id FROM Task WHERE ID = 1)),
 ((SELECT $node_id FROM Project WHERE ID = 8),
 (SELECT $node_id FROM Task WHERE ID = 7)),
 ((SELECT $node_id FROM Project WHERE ID = 2),
 (SELECT $node_id FROM Task WHERE ID = 2)),
 ((SELECT $node_id FROM Project WHERE ID = 3),
 (SELECT $node_id FROM Task WHERE ID = 5)),
 ((SELECT $node_id FROM Project WHERE ID = 4),
 (SELECT $node_id FROM Task WHERE ID = 3)),
 ((SELECT $node_id FROM Project WHERE ID = 6),
 (SELECT $node_id FROM Task WHERE ID = 4)),
 ((SELECT $node_id FROM Project WHERE ID = 7),
 (SELECT $node_id FROM Task WHERE ID = 2)),
 ((SELECT $node_id FROM Project WHERE ID = 1),
 (SELECT $node_id FROM Task WHERE ID = 9)),
 ((SELECT $node_id FROM Project WHERE ID = 9),
 (SELECT $node_id FROM Task WHERE ID = 8)),
 ((SELECT $node_id FROM Project WHERE ID = 10),
 (SELECT $node_id FROM Task WHERE ID = 9));

 SELECT Employee1.name, Employee2.name
FROM Employee AS Employee1
	, Collaborates AS c
	, Employee AS Employee2
WHERE MATCH(Employee1-(c)->Employee2)
	AND Employee1.name = 'Michael Johnson';

	SELECT e.name, p.name
FROM Employee AS e
	, Works AS w
	, Project AS p
WHERE MATCH(e-(w)->p)
AND p.name = 'Project A';

SELECT p.name, t.name
FROM Project AS p
	, Includes AS i
	, Task as t
WHERE MATCH(p-(i)->t)
AND p.name = 'Project A';

 SELECT Employee1.name, Employee2.name
FROM Employee AS Employee1
	, Collaborates AS c
	, Employee AS Employee2
WHERE MATCH(Employee1-(c)->Employee2)
	AND Employee1.name = 'Sarah Lee';

	SELECT e.name, p.name
FROM Employee AS e
	, Works AS w
	, Project AS p
WHERE MATCH(e-(w)->p)
AND e.name = 'John Smith';

SELECT Employee1.name
	, STRING_AGG(Employee2.name, '->') WITHIN GROUP (GRAPH PATH)
FROM Employee AS Employee1
	, Collaborates FOR PATH AS c
	, Employee FOR PATH AS Employee2
WHERE MATCH(SHORTEST_PATH(Employee1(-(c)->Employee2)+))
	AND Employee1.name = 'Emma Taylor';

	
SELECT Employee1.name
	, STRING_AGG(Employee2.name, '->') WITHIN GROUP (GRAPH PATH)
FROM Employee AS Employee1
	, Collaborates FOR PATH AS c
	, Employee FOR PATH AS Employee2
WHERE MATCH(SHORTEST_PATH(Employee1(-(c)->Employee2){1,2}))
	AND Employee1.name = 'Emma Taylor';

SELECT Employee1.ID AS IdFirst
	, Employee1.name AS First
	, CONCAT(N'employee (', Employee1.id, ')') AS [First image name]
	, Employee2.ID AS IdSecond
	, Employee2.name AS Second
	, CONCAT(N'employee', Employee2.id, ')') AS [Second image name]
FROM Employee AS Employee1
	, Collaborates AS c
	, Employee AS Employee2
WHERE MATCH(Employee1-(c)->Employee2);

SELECT e.ID AS IdFirst
	, e.name AS First
	, CONCAT(N'employee (', e.id, ')') AS [First image name]
	, p.ID AS IdSecond
	, p.name AS Second
	, CONCAT(N'project (', p.id, ')') AS [Second image name]
FROM Employee AS e
	, Works AS w
	, Project AS p
WHERE MATCH(e-(w)->p);

SELECT t.ID AS IdFirst
	, t.name AS First
	, CONCAT(N'task (', t.id, ')') AS [First image name]
	, p.ID AS IdSecond
	, p.name AS Second
	, CONCAT(N'project (', p.id, ')') AS [Second image name]
FROM Task AS t
	, Includes AS i
	, Project AS p
WHERE MATCH(t<-(i)-p);

select @@servername
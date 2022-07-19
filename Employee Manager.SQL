
CREATE TABLE #Employee
(
    Id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    [Name] [VARCHAR](200) NOT NULL,
    ManagerId INT NULL
)
GO


INSERT INTO #Employee
VALUES
('Test User', NUll), ('Test User2', 1),('Test User3',2),('Test User4',2),('Test User5',3),('Test User6',4),('Test User7',5),
('Test User8',5)
GO

--All Employee.
SELECT * from #Employee
GO

--Employee and their immediate manager.
SELECT emp.*, empMgr.[Name] from #Employee emp
JOIN #Employee empMgr on emp.ManagerId = empMgr.Id
GO

--Employee and their immediate manager except top and leaf employee.
SELECT emp.*, empMgr.[Name] from #Employee emp
JOIN #Employee empMgr on emp.ManagerId = empMgr.Id
WHERE emp.Id IN(SELECT DISTINCT ManagerId from #Employee)
GO

--Employee details of nth rank manager.
WITH ManagerRank AS
(
    SELECT *, dense_rank() OVER(ORDER BY ManagerId) MgrRank from #Employee
    WHERE Id IN(SELECT DISTINCT ManagerId from #Employee)
)
SELECT * FROM ManagerRank WHERE MgrRank = 2
GO

DROP TABLE #Employee
GO
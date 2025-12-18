
--HOW MANY PEOPLE HAVE 'GAY' IN THEIR NAME
SELECT Name, "Year", SUM(Count) AS TotalNamesWithGay
FROM NationalNames nn
GROUP BY Name, "Year" 
HAVING Name LIKE 'GAY%'
ORDER BY "Year" ASC, Count DESC;


--WHICH STATE CONTRIBUTED THE MOST IN THIS DATASET
SELECT COUNT(Name) AS TotalNames, State
FROM StateNames sn
GROUP BY State
ORDER BY TotalNames DESC;


--WHETHER JOHNSON OR LARRY IS THE MORE PUPULAR FEMALE NAME
WITH GenderJohnson AS (
	SELECT SUM(Count) AS TotalFemaleJohnson, Gender 
	FROM NationalNames
	WHERE Name = 'Johnson' AND Gender = 'F'
),
GenderLarry AS (
	SELECT SUM(Count) AS TotalFemaleLarry, Gender 
	FROM NationalNames
	WHERE Name = 'Larry' AND Gender = 'F'
)
SELECT 
    CASE
        WHEN L.TotalFemaleLarry > J.TotalFemaleJohnson THEN 'Larry Wins!'
        WHEN L.TotalFemaleLarry < J.TotalFemaleJohnson THEN 'Johnson Wins!'
        ELSE 'Tied!'
    END AS 'Result of The Gender War'
FROM GenderLarry L, GenderJohnson J;

--THIS COMAPRES THE NATIONAL TOTAL OF NAMES TO THE COLELCTED TOTAL STATE NAMES
WITH D AS (
	SELECT 
    	Name AS Name, 
    	SUM(Count) AS StateTotal
	FROM StateNameS
	GROUP BY Name
),
S AS (
	SELECT 
    	Name AS Name, 
    	SUM(Count) AS NationalTotal
	FROM NationalNames nn 
	GROUP BY Name
)	
SELECT *
FROM S INNER JOIN D ON S.Name = D.Name;


--HOW MANY SAMANTHAS ARE BORN IN 1945 AND IS FEMALE
SELECT * 
FROM NationalNames nn
WHERE Name = 'Samantha' AND "Year" = 1945 AND Gender = 'F;
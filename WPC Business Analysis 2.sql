USE data_analytics_batchb;

SHOW TABLES;

DESCRIBE gg_employee;
DESCRIBE owner;
DESCRIBE property;
DESCRIBE service;

SELECT * FROM data_analytics_batchb.gg_employee;

# show all owner information
SELECT * FROM data_analytics_batchb.owner;
SELECT * FROM data_analytics_batchb.property;
SELECT * FROM data_analytics_batchb.service;

# show all OwnerName and OwnerEmail
SELECT owner.ownername, owner.owneremail
FROM owner;

# show all OwnerName and OwnerEmail which OwnerType is ‘Corporation’
SELECT owner.ownername, owner.owneremail, owner.ownertype
FROM Owner
WHERE ownertype LIKE '%corporation%';

# Show PropertyID and ServiceDate for all services have HoursWorked more than 4
SELECT service.propertyid, service.servicedate, Hoursworked
FROM service
WHERE hoursworked > 4;

# Show PropertyID and ServiceDate for all services have HoursWorked between 4 and 6
SELECT service.propertyid, service.servicedate, service.hoursworked
FROM service
WHERE hoursworked BETWEEN 4 AND 6;

# Count how many services have HoursWorked more than 4
SELECT COUNT(hoursworked) AS count_hoursworked_more_than_4
FROM service
WHERE hoursworked > 4;

# Count how many distinct ExperienceLevel in EMPLOYEE table
SELECT COUNT(DISTINCT experiencelevel) unique_experiencelevel
FROM gg_employee;

# Show all employees with CellPhone containing ‘254’ and the ExperienceLevel is Senior
SELECT *
FROM gg_employee
WHERE cellphone LIKE '%254%' AND experiencelevel = 'senior';

# Show all properties not in city ‘Seattle’ or ‘Bellevue’
SELECT *
FROM PROPERTY
WHERE city NOT IN ('seattle', 'bellevue');

# Show all properties with PropertyName begins with ‘P’, but the location is not in NY State
SELECT *
FROM property
WHERE propertyname LIKE 'p%' AND state <> 'NY';

# Show all the services in descending order of their HoursWorked
SELECT *
FROM service
ORDER BY hoursworked DESC;

# services which HoursWorked is greater than 3 in ascending order of their ServiceDate
SELECT *
FROM service
WHERE hoursworked > 3
ORDER BY servicedate;

# Show all owners with Email as NULL
SELECT *
FROM OWNER
WHERE owneremail IS NULL;

# Count how many Owners whose Email is not NULL
SELECT COUNT(owneremail) count_owneremail
FROM OWNER
WHERE owneremail IS NOT NULL;

# sum of Hours Worked in SERVICE
SELECT SUM(hoursworked) AS total_workedhours
FROM SERVICE;

# Only show the employee with sum of Hours Worked more than 7
SELECT DISTINCT g.employeeid, g.lastname, g.firstname, SUM(s.hoursworked) AS totalhours
FROM gg_employee AS g
INNER JOIN service AS s
ON g.employeeid = s.employeeid
GROUP BY g.employeeid
HAVING sum(s.hoursworked) > 7;

# names of employees who have worked on a property owned by a corporation
SELECT g.employeeid, g.lastname, g.firstname, ownertype
FROM gg_employee AS g
INNER JOIN owner AS o
ON g.employeeid = o.ownerid
WHERE ownertype = 'corporation';

# names of employees who have worked on a property in New York
SELECT g.employeeid, g.lastname, g.firstname, p.state
FROM gg_employee AS g
INNER JOIN property AS p
ON g.employeeid = p.propertyid
WHERE p.state = 'ny';

# Sort the employees’ information in ascending order by the total hours of their service
SELECT g.employeeid, g.lastname, g.firstname, g.cellphone, g.experiencelevel, sum(s.hoursworked) AS servicehours
FROM gg_employee AS g
INNER JOIN service AS s
ON g.employeeid = s.employeeid
GROUP BY g.employeeid
HAVING SUM(s.hoursworked)
ORDER BY servicehours;

# names and Email of owners who have the property named 'Private Residence'.
SELECT o.ownerid, o.ownername, o.owneremail, p.propertyname
FROM owner o
INNER JOIN property p
ON o.ownerid = p.ownerid
WHERE p.propertyname = 'private residence';

# Show the number of services on properties with owner’s type as ‘Corporation’
SELECT COUNT(o.ownertype) AS no_of_ownertype_corporation
FROM owner o
GROUP BY o.ownertype
HAVING o.ownertype = 'corporation';

# Show the total hours of service on properties with owner type as ‘Corporation
SELECT o.ownerid, o.ownertype, SUM(s.hoursworked) AS totalhours_corporation
FROM owner o
INNER JOIN property p
ON o.ownerid = p.propertyid
Inner join service s
ON o.ownerid = s.propertyid
WHERE o.ownertype = 'corporation'
GROUP BY o.ownerid;

# Show the names of the employee who has worked most hours
SELECT g.employeeid, g.lastname, g.firstname, SUM(s.hoursworked) AS employee_hours
FROM gg_employee g
INNER JOIN service s
ON g.employeeid = s.employeeid
GROUP BY g.employeeid
ORDER BY employee_hours DESC;


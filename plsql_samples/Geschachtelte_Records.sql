-- So geht es:
DECLARE
TYPE DeptRecType IS RECORD (
deptid NUMBER(4) NOT NULL := 99,
dname departments.department_name%TYPE,
reg regions%ROWTYPE );
dept_rec DeptRecType;
reg_rec regions%ROWTYPE;
BEGIN
SELECT d.department_id, d.department_name, r.region_id, r.region_name 
  INTO dept_rec.deptid, dept_rec.dname, 
       dept_rec.reg.region_id, dept_rec.reg.region_name       
FROM regions r
    JOIN countries c ON c.region_id = r.region_id
    JOIN locations l ON l.country_id = c.country_id
    JOIN departments d ON d.location_id = l.location_id
WHERE department_id = 50;
-- ...
END;


-- so geht es nicht
DECLARE
TYPE DeptRecType IS RECORD (
deptid NUMBER(4) NOT NULL := 99,
dname departments.department_name%TYPE,
reg regions%ROWTYPE );
dept_rec DeptRecType;
BEGIN
SELECT d.department_id, d.department_name, r.region_id, r.region_name 
   INTO dept_rec.deptid, dept_rec.dname, dept_rec.reg
FROM regions r
    JOIN countries c ON c.region_id = r.region_id
    JOIN locations l ON l.country_id = c.country_id
    JOIN departments d ON d.location_id = l.location_id
WHERE department_id = 50;
-- ...
END;

-- so geht es auch nicht
DECLARE
TYPE DeptRecType IS RECORD (
deptid NUMBER(4) NOT NULL := 99,
dname departments.department_name%TYPE,
reg regions%ROWTYPE );
dept_rec DeptRecType;
BEGIN
SELECT d.department_id, d.department_name, r.region_id, r.region_name 
   INTO dept_rec
FROM regions r
    JOIN countries c ON c.region_id = r.region_id
    JOIN locations l ON l.country_id = c.country_id
    JOIN departments d ON d.location_id = l.location_id
WHERE department_id = 50;
-- ...
END;

-- so auch nicht:
DECLARE
TYPE DeptRecType IS RECORD (
deptid NUMBER(4) NOT NULL := 99,
dname departments.department_name%TYPE,
reg regions%ROWTYPE );
dept_rec DeptRecType;
reg_rec regions%ROWTYPE;
BEGIN
SELECT d.department_id, d.department_name, 
       (SELECT r.region_id, r.region_name INTO reg_rec)
       INTO dept_rec
FROM regions r
    JOIN countries c ON c.region_id = r.region_id
    JOIN locations l ON l.country_id = c.country_id
    JOIN departments d ON d.location_id = l.location_id
WHERE department_id = 50;
-- ...
END;


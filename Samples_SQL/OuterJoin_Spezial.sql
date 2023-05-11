-- Vorsicht bei Outer Joins: 
-- Unterschiedliche Verarbeitung bei WHERE und ON-Klausel


-- Einschränkung in der WHERE-Klausel:
-- zuerst JOIN und dann Filterung per WHERE-Klausel
-- Oracle proprietär für LEFT OUTER JOIN
SELECT d.department_name, d.department_id, e.last_name
FROM   departments d, employees e
WHERE  d.department_id = e.department_id(+) and
       d.department_id in (10,40);
       

SELECT d.department_name, d.department_id, e.last_name
FROM   departments d LEFT OUTER JOIN employees e
        ON  d.department_id = e.department_id
WHERE   d.department_id in (10,40);


-- Einschränkung in der ON-Klausel:
-- zuerst gefiltert (gemeinsame Join-Bedingung) 
-- und wer kann diesbzgl. keinen Partner finden!
SELECT d.department_name, d.department_id, e.last_name
FROM   departments d LEFT OUTER JOIN employees e
        ON  d.department_id = e.department_id
            AND d.department_id in (10,40);


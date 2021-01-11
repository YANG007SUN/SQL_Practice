# https://www.hackerrank.com/challenges/the-company/problem

SELECT company_code, founder, 
  
  (SELECT lm 
  FROM (SELECT company_code, COUNT( DISTINCT lead_manager_code) AS lm
        FROM Lead_Manager
        GROUP BY company_code) AS lm_table
  WHERE c.company_code = lm_table.company_code),
  
  (SELECT sm 
  FROM (SELECT company_code, COUNT(DISTINCT senior_manager_code) AS sm
        FROM Senior_Manager
        GROUP BY company_code) AS sm_table
  WHERE c.company_code = sm_table.company_code),
  
  (SELECT m 
  FROM (SELECT company_code, COUNT(DISTINCT manager_code) AS m
        FROM Manager
        GROUP BY company_code) AS m_table
  WHERE c.company_code = m_table.company_code),
  
  (SELECT e 
  FROM (SELECT company_code, COUNT(DISTINCT employee_code) AS e
        FROM Employee
        GROUP BY company_code) AS e_table
  WHERE c.company_code = e_table.company_code)
  
FROM Company AS c
ORDER BY company_code
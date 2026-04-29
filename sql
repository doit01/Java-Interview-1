查询每个部门的最高工资
sql
Copy
-- 员工表 employees (id, name, salary, department_id)
-- 部门表 departments (id, name)

SELECT 
    d.name as department_name,
    MAX(e.salary) as max_salary
FROM employees e
JOIN departments d ON e.department_id = d.id
GROUP BY d.id, d.name
ORDER BY max_salary DESC;
2. 查询工资第N高的员工
sql
Copy
-- 查询工资第二高的员工
-- 方法1：使用子查询
SELECT 
    name,
    salary
FROM employees
WHERE salary = (
    SELECT DISTINCT salary
    FROM employees
    ORDER BY salary DESC
    LIMIT 1 OFFSET 1
);

-- 方法2：使用窗口函数
WITH ranked_employees AS (
    SELECT 
        name,
        salary,
        DENSE_RANK() OVER (ORDER BY salary DESC) as salary_rank
    FROM employees
)
SELECT name, salary
FROM ranked_employees
WHERE salary_rank = 2;

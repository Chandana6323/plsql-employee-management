-- Project 1: Employee Management System
-- Oracle SQL & PL/SQL

-- Table
CREATE TABLE employees (
    emp_id NUMBER PRIMARY KEY,
    emp_name VARCHAR2(50),
    department VARCHAR2(30),
    salary NUMBER,
    hire_date DATE
);

-- Insert sample data
INSERT INTO employees VALUES (1, 'Amit', 'IT', 50000, SYSDATE);
INSERT INTO employees VALUES (2, 'Neha', 'HR', 45000, SYSDATE);
COMMIT;

-- Procedure
CREATE OR REPLACE PROCEDURE add_employee (
    p_id NUMBER,
    p_name VARCHAR2,
    p_dept VARCHAR2,
    p_salary NUMBER
)
AS
BEGIN
    INSERT INTO employees
    VALUES (p_id, p_name, p_dept, p_salary, SYSDATE);
    COMMIT;
END;
/

-- Function
CREATE OR REPLACE FUNCTION get_employee_salary (
    p_emp_id NUMBER
)
RETURN NUMBER
IS
    v_salary NUMBER;
BEGIN
    SELECT salary INTO v_salary
    FROM employees
    WHERE emp_id = p_emp_id;
    RETURN v_salary;
EXCEPTION
    WHEN NO_DATA_FOUND THEN RETURN 0;
END;
/

-- Trigger
CREATE OR REPLACE TRIGGER check_salary
BEFORE INSERT OR UPDATE ON employees
FOR EACH ROW
BEGIN
    IF :NEW.salary < 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Salary cannot be negative');
    END IF;
END;
/

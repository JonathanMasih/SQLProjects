/*
Trigger for employees to show each time they make a sale or
update an old sale. It show's them their total sales to show if they are 
reaching  the sale goal or not.
*/
CREATE OR REPLACE TRIGGER EMPLOYEE_SALES_ADD
BEFORE INSERT OR UPDATE OF TOTAL ON SALE
FOR EACH ROW 
DECLARE
--local var to hold the total sales of a employee
    EMPTOTALSALES NUMBER;
    EMPLOYEEIDEXISTS INT;
    EMPLOYEEFIRSTNAME CHAR(25);
     EMPLOYEELASTNAME CHAR(25);
--cursor to get all the sales made by that employee
    CURSOR EMPLOYEESOLD IS
    SELECT S.EMPLOYEEID , S.TOTAL
    FROM SALE S 
    WHERE S.EMPLOYEEID = :NEW.EMPLOYEEID;
BEGIN
     -- First check to see if EMPLOYEEID exists 
     SELECT COUNT(*) INTO EMPLOYEEIDEXISTS
     FROM EMPLOYEEHW4 S
     WHERE S.EMPLOYEEID = :NEW.EMPLOYEEID;
     IF ( EMPLOYEEIDEXISTS < 1 ) THEN
        BEGIN
             DBMS_OUTPUT.PUT_LINE ('ENTER DIFFERENT EMPLOYEEID');
            RAISE_APPLICATION_ERROR (-20224, 
            'EMPLOYEEID IS DOES NOT EXIST');
            RETURN;
        END;
     END IF;
    --Gets lastname and firstName of the employee
    SELECT lastname INTO EMPLOYEEFIRSTNAME
    FROM EMPLOYEEHW4
    WHERE EMPLOYEEID =:NEW.EMPLOYEEID;
    SELECT FirstName INTO EMPLOYEELASTNAME
    FROM EMPLOYEEHW4
    WHERE EMPLOYEEID = :NEW.EMPLOYEEID;
  -- For each sale the employee made count's up the total.
     EMPTOTALSALES := 0;
  FOR ITEMSOLD IN EMPLOYEESOLD
  LOOP
   EMPTOTALSALES := EMPTOTALSALES + ITEMSOLD.TOTAL;
  END LOOP;
  
  IF(:OLD.TOTAL IS NOT NULL) THEN
     EMPTOTALSALES := EMPTOTALSALES - :OLD.TOTAL;
   END IF;
  
  EMPTOTALSALES := EMPTOTALSALES  + :NEW.TOTAL;
  --ADD THE NEW TOTAL TO THE SALES
   DBMS_OUTPUT.PUT_LINE ('===================================================================');
   DBMS_OUTPUT.PUT_LINE ('EmployeeName: ' || EMPLOYEEFIRSTNAME||', '|| EMPLOYEELASTNAME );
    DBMS_OUTPUT.PUT_LINE ('TOTAL SALES: ' || EMPTOTALSALES);
  DBMS_OUTPUT.PUT_LINE ('===================================================================');
END;
/


--TEST
SET SERVEROUTPUT ON;
INSERT INTO SALE VALUES(55,1,1,TO_DATE('22-JAN-2022', 'DD-MON-YYYY'),58,8,58);
SELECT * FROM SALE;



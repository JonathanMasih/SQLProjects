/*
Given EMPLOYEEID , print out empolyee first name, last name 
and all the items that employee has sold with the Itemid and 
name of the item.
*/
CREATE OR REPLACE PROCEDURE EMPLOYEE_ALL_NUMOFITEMSSOLD
(
    inEMPLOYEEID IN NUMBER
)
IS
    rowCount int;
    readLastName char(25);
    readFirstName char(25);
    readItemId NUMBER(38,0);
    readTtemName VARCHAR(255);
    
    CURSOR EMPLOYEEITEMSOLD IS
    SELECT E.lastname , E.firstname, E.EMPLOYEEID , S.SALEID, I.ITEMID , T.ITEMDESCRIPTION
    FROM EMPLOYEEHW4 E, SALE_ITEM I , SALE S , ITEM T
    WHERE E.EMPLOYEEID = inEMPLOYEEID AND E.EMPLOYEEID = S.EMPLOYEEID 
    AND I.SALEID = S.SALEID AND I.ITEMID = T.ITEMID;
    
BEGIN
    /* Check to see if the EMPLOYEE is in the database */
    SELECT COUNT(*) INTO rowCount
    FROM EMPLOYEEHW4
    WHERE EMPLOYEEID = inEMPLOYEEID;
    IF rowCount = 0 THEN
    DBMS_OUTPUT.PUT_LINE 
    ('==========================================================');
    DBMS_OUTPUT.PUT_LINE ('EMPLOYEE Does Not Exist In Database');
    DBMS_OUTPUT.PUT_LINE ('No Action Taken');
    DBMS_OUTPUT.PUT_LINE 
    ('==========================================================');
    RETURN;
    END IF;
    --Gets lastname and firstName of the employee
    SELECT lastname INTO readLastName
    FROM EMPLOYEEHW4
    WHERE EMPLOYEEID = inEMPLOYEEID;
    SELECT FirstName INTO readFirstName
    FROM EMPLOYEEHW4
    WHERE EMPLOYEEID = inEMPLOYEEID;
    
    --EMPLOYEE exits in database prints the name and last name
    DBMS_OUTPUT.PUT_LINE 
    ('===================================================================');
    DBMS_OUTPUT.PUT_LINE ('Display of EMPLOYEE with all items sold ');
    DBMS_OUTPUT.PUT_LINE ('EmployeeName: ' || readLastName ||', '|| readFirstName );
    DBMS_OUTPUT.PUT_LINE ('===================================================================');
    --Prints out all the items
      FOR ITEMSOLD IN EMPLOYEEITEMSOLD
       LOOP
        readItemId := ITEMSOLD.ITEMID ; 
        readTtemName :=ITEMSOLD.ITEMDESCRIPTION ;
       DBMS_OUTPUT.PUT_LINE ('===================================================================');
       DBMS_OUTPUT.PUT_LINE('ITEMID: ' ||  readItemId || ' ItemName: ' || readTtemName );
       DBMS_OUTPUT.PUT_LINE('===================================================================');
      END LOOP;
END;
/
SET SERVEROUTPUT ON;
--TEST
CALL EMPLOYEE_ALL_NUMOFITEMSSOLD(1);

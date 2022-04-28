/*
Trigger that ensures that when there is a new item add or item price is being updated 
There is a Minimum of profit based on the price of the item.
If the price meets the minimum profit for each price level then the item
will be add or updated. Other wise the update or the insertion will not 
occur.Useful when trying to set the item on a discount price without losing too
much money.
*/
CREATE OR REPLACE TRIGGER MinimumPROFITONSALE
BEFORE INSERT OR UPDATE OF ITEMPRICE ON ITEM
FOR EACH ROW 
DECLARE
      varPorfit int;
BEGIN
      varPorfit := :NEW.ITEMPRICE - :OLD.ITEMCOST;
      IF (varPorfit  < 10 AND :OLD.ITEMCOST < 100 ) THEN
        BEGIN
            DBMS_OUTPUT.PUT_LINE ('PLEASE ENTER A HGIHER PRICE');
            raise_application_error (-20111, 'ITEM PRICE TOO LOW. NOT ENOUGH TO RUN A BUSINESS');
           RETURN;
        END;
       END IF;
       IF (varPorfit  < 50 AND :OLD.ITEMCOST < 500 ) THEN
        BEGIN
            DBMS_OUTPUT.PUT_LINE ('PLEASE ENTER A HGIHER PRICE');
            raise_application_error (-20111, 'ITEM PRICE TOO LOW. NOT ENOUGH TO RUN A BUSINESS');
           RETURN;
        END;
       END IF;
          IF (varPorfit  < 100 AND :OLD.ITEMCOST < 1000 ) THEN
        BEGIN
            DBMS_OUTPUT.PUT_LINE ('PLEASE ENTER A HGIHER PRICE');
            raise_application_error (-20111, 'ITEM PRICE TOO LOW. NOT ENOUGH TO RUN A BUSINESS');
           RETURN;
        END;
       END IF;  
      /* otherwise do nothing and let the insert or update complete */
END;
/
SET SERVEROUTPUT ON;
UPDATE ITEM set ITEMPRICE = 350 WHERE ITEMID = 2;
SELECT * FROM ITEM;

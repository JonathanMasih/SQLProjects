
/* given an existing itemID. It will return the profit margin on the item depending how much 
the item cost and the item price*/
CREATE OR REPLACE FUNCTION itemProfitMargin
    (
        -- input parameter
        InITEMID NUMBER
    )
    RETURN  Varchar
IS
    --Local variable to check of item exists
     varItemExists int;
     --Local variable to profit for the item
     varPorfit int;
     --Local variable to hold cost for the item
     varCost int;
       --Local variable to hold cost for the item
     varPrice int;
BEGIN
    /* check for existence of Employee first */
    SELECT COUNT(*) INTO varItemExists
    FROM ITEM T
    WHERE  T.ITEMID = InITEMID;
    IF (varItemExists = 0) THEN
        raise_application_error (-20111, 'No Such Item');
        return 'No Such Item';
    END IF;    
    
   SELECT ITEMCOST INTO varCost
   FROM ITEM T
   WHERE  T.ITEMID = InITEMID;
   
   SELECT ITEMPRICE INTO varPrice
   FROM ITEM T
   WHERE  T.ITEMID = InITEMID;
   
   varPorfit := varPrice - varCost;
   -- conditional to categorize an artist 
    if ( varPorfit  < 500) THEN RETURN'Below Average';
    elsif( varPorfit  >= 500 and  varPorfit  <= 1000 )THEN RETURN 'Average';
    else RETURN 'Above Average';
    end if;
END;
/
set SERVEROUTPUT on;

/* SQL to test the function: */
SELECT ITEMID , itemProfitMargin(ITEMID) AS profitMargin
FROM ITEM;
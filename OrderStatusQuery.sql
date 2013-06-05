BEGIN TRAN
declare @txtOrder varchar(8) = '679981'

Select Case When oh.status = '1' Then 'UNREL.'
            When oh.status IN ('4','6') Then  CASE WHEN oh.ord_no+item_no IN (SELECT [Ord #]+[item] FROM BG_Transfers_Not_Yet_Received) THEN 'IN TRAN.'
                                                   WHEN oh.ord_no+item_no IN (select ord_no+item_no FROM wsPikPak WHERE shipped = 'N') THEN 'PACKED'
                                                   ELSE 'IN PROD.'
                                        END
            WHEN oh.status IN ('7','8','9') THEN CASE WHEN oh.ord_no + item_no IN (select ord_no+item_no FROM wsPikPak WHERE shipped = 'Y') THEN 'SHIPPED' 
                                                 ELSE 'BACKORDER'
                                                 END
        
  End As Status, rtrim(ltrim(ol.item_no)) As Item, Cast(ol.qty_to_ship As INT) As Qty
From oeordhdr_Sql oh Join
  oeordlin_sql ol On ol.ord_no = oh.ord_no
Where LTrim(oh.ord_no) = @txtOrder And oh.ord_type = 'O'

ROLLBACK

SELECT  *
FROM    oeordhdr_sql
where ord_no = '77777774'

SELECT  *
FROM    BG_Transfers_Not_Yet_Received
where [Ord #] = '77777777'
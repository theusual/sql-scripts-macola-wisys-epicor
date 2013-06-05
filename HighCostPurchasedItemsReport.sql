SELECT bm.item_no AS [ParentItem#], SUM((last_cost * qty_per_par)) AS ActualLastPurchCost, MAX(SlsPrice.LastSoldPrice) AS [Highest Selling Price]
FROM iminvloc_sql IM JOIN dbo.bmprdstr_sql AS BM ON BM.comp_item_no = IM.item_no JOIN imitmidx_sql im2 ON bm.item_no = IM2.item_no
     JOIN (SELECT OL.item_no, MAX(unit_price) AS LastSoldPrice 
           FROM dbo.oelinhst_sql AS OL JOIN oehdrhst_sql OH ON OH.inv_no = OL.inv_no
                JOIN (SELECT item_no, MAX(inv_dt) AS Dt
                      FROM OEHDRHST_SQL OH JOIN OELINHST_SQL OL ON OL.inv_no = OH.inv_no
                      WHERE OH.orig_ord_type = 'O' --AND OL.item_no = 'GRO-010 WM GB'
                      GROUP BY item_no) AS LastSoldDt ON LastSoldDt.item_no = OL.item_no AND LastSoldDt.Dt = OH.inv_dt
           WHERE-- OL.item_no = 'BAK-707EC OBV97' AND
                 OH.orig_ord_type = 'O' AND
                 OH.inv_dt > '01/01/2011'
           GROUP BY OL.item_no
          )  AS SlsPrice ON SlsPrice.item_no = BM.item_no    
WHERE im.loc = 'FW' 
       AND IM.item_no IN (SELECT item_no FROM poordlin_sql)
       AND im2.item_note_1 = 'CH'
       AND IM.prod_cat != 'AP'
       AND IM2.prod_cat != 'AP'
       AND IM2.item_no NOT LIKE 'AP%'
GROUP BY bm.item_no
ORDER BY bm.item_no


SELECT * FROM dbo.iminvloc_sql AS [IS] WHERE item_no like 'GRO-010 WM GB B'

SELECT * 
FROM oelinhst_Sql OL JOIN oehdrhst_sql OH ON OH.inv_no = OL.inv_no
WHERE item_no = 'GRO-011SR KITBV' AND inv_dt > '01/01/2010' AND OH.orig_ord_type = 'O'

SELECT * 
FROM poordlin_Sql 
WHERE item_no = 'ST-043 BV A'
ORDER BY receipt_dt DESC

SELECT * FROM dbo.bmprdstr_sql AS BS  WHERE item_no = 'ST-043 BV'
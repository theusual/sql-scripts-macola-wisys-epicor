SELECT * FROM dbo.oeordlin_sql 
WHERE  ((dbo.oeordlin_sql.ord_no + CAST(dbo.oeordlin_sql.line_no AS CHAR) + CAST(CAST(qty_to_ship AS INT) AS CHAR)) NOT IN
                          (SELECT    Ord_no + CAST(Line_no AS CHAR) + CAST(SUM(qty) AS CHAR) AS Expr1 
                            FROM          dbo.wsPikPak AS pp
                            WHERE      (Shipped = 'Y')
                            GROUP BY ord_no, line_no))
         AND (dbo.oeordlin_sql.ord_no + CAST(dbo.oeordlin_sql.line_no AS CHAR) IN
			(SELECT    Ord_no + CAST(Line_no AS CHAR) 
                            FROM          dbo.wsPikPak AS pp
                            WHERE      (Shipped = 'Y') AND ship_dt > '01/01/2010')


SELECT COUNT(*) FROM dbo.oeordlin_sql 
WHERE   (dbo.oeordlin_sql.ord_no + CAST(dbo.oeordlin_sql.line_no AS CHAR) NOT IN
			(SELECT    oh.Ord_no + CAST(Line_no AS CHAR) 
                            FROM          oelinhst_sql AS ol JOIN oehdrhst_Sql oh ON oh.inv_no = ol.inv_no
                            WHERE inv_dt > '02/01/2011'))







SELECT * FROM oelinhst_Sql WHERE ord_no = '  681591' 

SELECT     Ord_no + CAST(Line_no AS CHAR) + CAST(SUM(qty) AS CHAR) AS Expr1
FROM          dbo.wsPikPak AS pp
WHERE      (Shipped = 'Y')
GROUP BY ord_no, line_no


SELECT dbo.oeordlin_sql.ord_no + CAST(dbo.oeordlin_sql.line_no AS CHAR) + CAST(CAST(qty_to_ship AS INT)AS CHAR)
FROM oeordlin_Sql


SELECT * FROM wspikpak WHERE ord_no = '  363526'
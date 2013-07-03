/*SUPPLY MISSING WM INFO, ASSIGN TO VARIABLES, SEARCH FOR CORRESPONDING MARCO INFO FOR RESEARCH, RESEARCH VARIOUS TABLES USING MARCO INFO.*/
DECLARE @POSEARCH varchar(MAX);
DECLARE @ordsearch varchar(MAX);
DECLARE @macitemsearch varchar(MAX);
DECLARE @wmitemsearch varchar(MAX);

SET @POSEARCH = '31778110';
SET @wmitemsearch = '100035342';

SET @macitemsearch = 
	CASE WHEN EXISTS(SELECT mac_item_num FROM edcitmfl_sql WHERE edi_item_num = @wmitemsearch)
		 THEN (SELECT mac_item_num FROM edcitmfl_sql WHERE edi_item_num = @wmitemsearch)
		 ELSE ''
	END

SET @ordsearch = (SELECT DISTINCT T.ord_no FROM (SELECT OH.ord_no
FROM OEHDRHST_SQL AS OH INNER JOIN OELINHST_SQL AS OL ON OL.ord_no = OH.ord_no 
WHERE oe_po_no like '%' + @POSEARCH + '%'
UNION ALL
SELECT OH.ord_no
FROM OEORDHDR_SQL AS OH INNER JOIN OEORDLIN_SQL AS OL ON OL.ord_no = OH.ord_no 
WHERE oe_po_no like '%' + @POSEARCH + '%') AS T)


SELECT @ordsearch
/*CHECK ORDER HISTORY FOR SHIPMENT INFO*/SELECT @wmitemsearch, @POSEARCH, * FROM oelinhst_sql WHERE ord_no = @ordsearch AND item_no like '%' + @macitemsearch

/*CHECK OPEN ORDERS FOR SHIPMENT INFO*/SELECT @wmitemsearch, @POSEARCH, * FROM oeordlin_sql WHERE ord_no = @ordsearch AND item_no like '%' + @macitemsearch

/*CHECK WISYS WSPIKPAK FOR SHIPMENT INFO*/SELECT @wmitemsearch, @POSEARCH, * FROM WSPIKPAK WHERE ord_no = @ordsearch AND Item_no like '%' + @macitemsearch

/*CHECK MASTER FOR SHIPMENT INFO*/SELECT @wmitemsearch, @POSEARCH, * FROM BG_SHIPPED WHERE ord_no = ltrim(rtrim(@ordsearch)) AND item_no like '%' +  @macitemsearch

/*CHECK WMPO UPLOAD FOR SHIPMENT INFO*/SELECT @wmitemsearch, @POSEARCH, * FROM BG_WMPO WHERE [Supplier Sales/Work Order Number] = @ORDSEARCH  AND [Supplier Item Part Number] = @macitemsearch


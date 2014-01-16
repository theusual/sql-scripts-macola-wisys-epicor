--Created By: BG
--Created On: 3/8/13
--Updated On: 12/2/13
--Purpose:  Calc WM projections using the WM forecasts that are imported into the database
--Last Change:  Added Grouping, joined on EDI table, added BOM query

ALTER Function [dbo].[fn_BG_WMProjection] (@item varchar(30))
RETURNS int
AS
BEGIN

	DECLARE @currentmonth AS INT
	DECLARE @proj AS INT
	
	SET @currentmonth = MONTH(GETDATE())--MONTH(DATEADD(month,1,GETDATE()))
	/*
	IF @currentmonth = 3 BEGIN
		SET @proj = (SELECT SUM(Current_Proj) AS Current_Proj
					FROM (
						SELECT SUM([Apr 2013] + [May 2013] + [Jun 2013]) AS Current_Proj
											FROM WM_Forecast_2013 JOIN dbo.edcitmfl_sql EdiIM ON EdiIM.edi_item_num = dbo.WM_Forecast_2013.[Article Number]
											WHERE EdiIM.mac_item_num = @item 
											GROUP BY EdiIM.mac_item_num
							
						UNION ALL

						SELECT SUM([Apr 2013] + [May 2013] + [Jun 2013]) AS Current_Proj
											FROM WM_Forecast_2013 JOIN dbo.edcitmfl_sql EdiIM ON EdiIM.edi_item_num = dbo.WM_Forecast_2013.[Article Number]
																  LEFT OUTER JOIN dbo.bmprdstr_sql BM ON BM.item_no = EdiIM.mac_item_num
											WHERE BM.comp_item_no = @item
					) AS Temp)
	END

	IF @currentmonth = 4 BEGIN
		SET @proj = (SELECT SUM(Current_Proj) AS Current_Proj
					FROM (
						SELECT SUM([Apr 2013] + [May 2013] + [Jun 2013] + [Jul 2013]) AS Current_Proj
											FROM WM_Forecast_2013 JOIN dbo.edcitmfl_sql EdiIM ON EdiIM.edi_item_num = dbo.WM_Forecast_2013.[Article Number]
											WHERE EdiIM.mac_item_num = @item 
											GROUP BY EdiIM.mac_item_num
							
						UNION ALL

						SELECT SUM([Apr 2013] + [May 2013] + [Jun 2013] + [Jul 2013]) AS Current_Proj
											FROM WM_Forecast_2013 JOIN dbo.edcitmfl_sql EdiIM ON EdiIM.edi_item_num = dbo.WM_Forecast_2013.[Article Number]
																  LEFT OUTER JOIN dbo.bmprdstr_sql BM ON BM.item_no = EdiIM.mac_item_num
											WHERE BM.comp_item_no = @item
					) AS Temp)
	END
	
	IF @currentmonth = 5 BEGIN
		SET @proj = (SELECT SUM(Current_Proj) AS Current_Proj
					FROM (
						SELECT SUM([Jul 2013] + [May 2013] + [Jun 2013] + [Aug 2013]) AS Current_Proj
											FROM WM_Forecast_2013 JOIN dbo.edcitmfl_sql EdiIM ON EdiIM.edi_item_num = dbo.WM_Forecast_2013.[Article Number]
											WHERE EdiIM.mac_item_num = @item 
											GROUP BY EdiIM.mac_item_num
							
						UNION ALL

						SELECT SUM([Jul 2013] + [May 2013] + [Jun 2013] + [Aug 2013]) AS Current_Proj
											FROM WM_Forecast_2013 JOIN dbo.edcitmfl_sql EdiIM ON EdiIM.edi_item_num = dbo.WM_Forecast_2013.[Article Number]
																  LEFT OUTER JOIN dbo.bmprdstr_sql BM ON BM.item_no = EdiIM.mac_item_num
											WHERE BM.comp_item_no = @item
					) AS Temp)
	END
	
	IF @currentmonth = 6 BEGIN
		SET @proj = (SELECT SUM(Current_Proj) AS Current_Proj
					FROM (
						SELECT SUM([Sep 2013] + [Jul 2013] + [Jun 2013] + [Aug 2013]) AS Current_Proj
											FROM WM_Forecast_2013 JOIN dbo.edcitmfl_sql EdiIM ON EdiIM.edi_item_num = dbo.WM_Forecast_2013.[Article Number]
											WHERE EdiIM.mac_item_num = @item 
											GROUP BY EdiIM.mac_item_num
							
						UNION ALL

						SELECT SUM([Sep 2013] + [Jul 2013] + [Jun 2013] + [Aug 2013]) AS Current_Proj
											FROM WM_Forecast_2013 JOIN dbo.edcitmfl_sql EdiIM ON EdiIM.edi_item_num = dbo.WM_Forecast_2013.[Article Number]
																  LEFT OUTER JOIN dbo.bmprdstr_sql BM ON BM.item_no = EdiIM.mac_item_num
											WHERE BM.comp_item_no = @item
					) AS Temp)
	END
	
	IF @currentmonth = 7 BEGIN
		SET @proj = (SELECT SUM(Current_Proj) AS Current_Proj
					FROM (
						SELECT SUM([Oct 2013] + [Sep 2013] + [Jul 2013] + [Aug 2013]) AS Current_Proj
											FROM WM_Forecast_2013 JOIN dbo.edcitmfl_sql EdiIM ON EdiIM.edi_item_num = dbo.WM_Forecast_2013.[Article Number]
											WHERE EdiIM.mac_item_num = @item 
											GROUP BY EdiIM.mac_item_num
							
						UNION ALL

						SELECT SUM([Oct 2013] + [Sep 2013] + [Jul 2013] + [Aug 2013]) AS Current_Proj
											FROM WM_Forecast_2013 JOIN dbo.edcitmfl_sql EdiIM ON EdiIM.edi_item_num = dbo.WM_Forecast_2013.[Article Number]
																  LEFT OUTER JOIN dbo.bmprdstr_sql BM ON BM.item_no = EdiIM.mac_item_num
											WHERE BM.comp_item_no = @item
					) AS Temp)
	END
	
	IF @currentmonth = 8 BEGIN
		SET @proj = (SELECT SUM(Current_Proj) AS Current_Proj
					FROM (
						SELECT SUM([Oct 2013] + [Sep 2013] + [Nov 2013] + [Aug 2013]) AS Current_Proj
											FROM WM_Forecast_2013 JOIN dbo.edcitmfl_sql EdiIM ON EdiIM.edi_item_num = dbo.WM_Forecast_2013.[Article Number]
											WHERE EdiIM.mac_item_num = @item 
											GROUP BY EdiIM.mac_item_num
							
						UNION ALL

						SELECT SUM([Oct 2013] + [Sep 2013] + [Nov 2013] + [Aug 2013]) * BM.qty_per_par AS Current_Proj
											FROM WM_Forecast_2013 JOIN dbo.edcitmfl_sql EdiIM ON EdiIM.edi_item_num = dbo.WM_Forecast_2013.[Article Number]
																  LEFT OUTER JOIN dbo.bmprdstr_sql BM ON BM.item_no = EdiIM.mac_item_num
											WHERE BM.comp_item_no = @item
											GROUP BY BM.qty_per_par
					) AS Temp)
	END
	
	IF @currentmonth = 9 BEGIN
		SET @proj = (SELECT SUM(Current_Proj) AS Current_Proj
					FROM (
						SELECT SUM([Oct 2013] + [Sep 2013] + [Nov 2013] + [Dec 2013]) AS Current_Proj
											FROM WM_Forecast_2013 JOIN dbo.edcitmfl_sql EdiIM ON EdiIM.edi_item_num = dbo.WM_Forecast_2013.[Article Number]
											WHERE EdiIM.mac_item_num = @item 
											GROUP BY EdiIM.mac_item_num
							
						UNION ALL

						SELECT SUM([Oct 2013] + [Sep 2013] + [Nov 2013] + [Dec 2013]) * BM.qty_per_par AS Current_Proj
											FROM WM_Forecast_2013 JOIN dbo.edcitmfl_sql EdiIM ON EdiIM.edi_item_num = dbo.WM_Forecast_2013.[Article Number]
																  LEFT OUTER JOIN dbo.bmprdstr_sql BM ON BM.item_no = EdiIM.mac_item_num
											WHERE BM.comp_item_no = @item
											GROUP BY BM.qty_per_par
					) AS Temp)
	END
	
	IF @currentmonth = 10 BEGIN
		SET @proj = (SELECT SUM(Current_Proj) AS Current_Proj
					FROM (
						SELECT SUM([Oct 2013] + [Jan 2014] + [Nov 2013] + [Dec 2013]) AS Current_Proj
											FROM WM_Forecast_2013 JOIN dbo.edcitmfl_sql EdiIM ON EdiIM.edi_item_num = dbo.WM_Forecast_2013.[Article]
											WHERE EdiIM.mac_item_num = @item 
											GROUP BY EdiIM.mac_item_num
							
						UNION ALL

						SELECT SUM([Oct 2013] + [Jan 2014] + [Nov 2013] + [Dec 2013]) * BM.qty_per_par AS Current_Proj
											FROM WM_Forecast_2013 JOIN dbo.edcitmfl_sql EdiIM ON EdiIM.edi_item_num = dbo.WM_Forecast_2013.[Article]
																  LEFT OUTER JOIN dbo.bmprdstr_sql BM ON BM.item_no = EdiIM.mac_item_num
											WHERE BM.comp_item_no = @item
											GROUP BY BM.qty_per_par
					) AS Temp)
	END
	
	IF @currentmonth = 11 BEGIN
		SET @proj = (SELECT SUM(Current_Proj) AS Current_Proj
					FROM (
						SELECT SUM([Feb 2014] + [Jan 2014] + [Nov 2013] + [Dec 2013]) AS Current_Proj
											FROM WM_Forecast_2013 JOIN dbo.edcitmfl_sql EdiIM ON EdiIM.edi_item_num = dbo.WM_Forecast_2013.[Article]
											WHERE EdiIM.mac_item_num = @item 
											GROUP BY EdiIM.mac_item_num
							
						UNION ALL

						SELECT SUM([Feb 2014] + [Jan 2014] + [Nov 2013] + [Dec 2013]) * BM.qty_per_par AS Current_Proj
											FROM WM_Forecast_2013 JOIN dbo.edcitmfl_sql EdiIM ON EdiIM.edi_item_num = dbo.WM_Forecast_2013.[Article]
																  LEFT OUTER JOIN dbo.bmprdstr_sql BM ON BM.item_no = EdiIM.mac_item_num
											WHERE BM.comp_item_no = @item
											GROUP BY BM.qty_per_par
					) AS Temp)
	END
	*/
	IF @currentmonth = 12 BEGIN
		SET @proj = (SELECT SUM(Current_Proj) AS Current_Proj
					FROM (
						SELECT SUM([Feb 2014] + [Jan 2014]  + [Dec 2013] + [Mar 2014]) AS Current_Proj
											FROM WM_Forecast_2013 JOIN dbo.edcitmfl_sql EdiIM ON EdiIM.edi_item_num = dbo.WM_Forecast_2013.[Article]
											WHERE EdiIM.mac_item_num = @item 
											GROUP BY EdiIM.mac_item_num
							
						UNION ALL

						SELECT SUM([Feb 2014] + [Jan 2014] + [Dec 2013] + [Mar 2014]) * BM.qty_per_par AS Current_Proj
											FROM WM_Forecast_2013 JOIN dbo.edcitmfl_sql EdiIM ON EdiIM.edi_item_num = dbo.WM_Forecast_2013.[Article]
																  LEFT OUTER JOIN dbo.bmprdstr_sql BM ON BM.item_no = EdiIM.mac_item_num
											WHERE BM.comp_item_no = @item
											GROUP BY BM.qty_per_par
					) AS Temp)
	END
	
	RETURN @proj

END
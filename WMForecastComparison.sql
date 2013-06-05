SELECT Curr.[Article Number], ED.mac_item_num, 
		SUM([APR 2013]) AS Apr2013, SUM(Prev.Apr2013) AS PrevApr2013, 
		SUM([MAY 2013]) AS May2013, SUM(Prev.May2013) AS PrevMay2013, 
		SUM([JUN 2013]) AS June2013, SUM(Prev.Jun2013) AS PrevJun2013,
	    SUM([JUL 2013]) AS July2013, SUM(Prev.Jul2013) AS PrevJul2013,
	    SUM([AUG 2013]) AS Aug2013, SUM(Prev.Aug2013) AS PrevAug2013,
	    SUM([SEP 2013]) AS Sep2013, SUM(Prev.Sep2013) AS PrevSep2013,
	    SUM([OCT 2013]) AS Oct2013, SUM(Prev.Oct2013) AS PrevOct2013,
	    SUM([NOV 2013]) AS Nov2013, SUM(Prev.Nov2013) AS PrevNov2013,
	    SUM([DEC 2013]) AS Dec2013, SUM(Prev.Dec2013) AS PrevDec2013
FROM dbo.WM_Forecast_2013  Curr
			    JOIN  dbo.edcitmfl_sql ED ON ED.edi_item_num = Curr.[Article Number]        
				JOIN  (SELECT [Article Number], SUM([APR 2013]) AS Apr2013, SUM([MAY 2013]) AS May2013, SUM([JUN 2013]) AS Jun2013,
				              SUM([JUL 2013]) AS Jul2013, SUM([AUG 2013]) AS Aug2013, SUM([SEP 2013]) AS Sep2013, SUM([OCT 2013]) AS Oct2013,
				              SUM([NOV 2013]) AS Nov2013, SUM([DEC 2013]) AS Dec2013
						FROM WM_Forecast_2013_PreviousUpdate
						GROUP BY [Article Number]) AS Prev ON Prev.[Article Number] = Curr.[Article Number]
GROUP BY Curr.[Article Number], ED.mac_item_num                          
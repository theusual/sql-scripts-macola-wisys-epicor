SELECT  gbkmut.datum, 
		gbkmut.ID, 
		gbkmut.bkstnr, 
		gbkmut.faktuurnr, 
		gbkmut.docnumber, 
		gbkmut.oms25, 
		(CASE WHEN gbkmut.documentID IS NULL THEN 0 ELSE 1 END) AS Note, 
		(CASE WHEN gbkmut.docattachmentID IS NULL THEN 0 ELSE 1 END) AS Attach, 
		ROUND(((CASE WHEN transsubtype NOT IN ('R','S') THEN CASE WHEN bdr_hfl >= 0 THEN  bdr_hfl ELSE NULL END ELSE CASE WHEN bdr_hfl < 0 THEN bdr_hfl ELSE NULL END END)), 2) AS Debit, 
		ROUND(((CASE WHEN transsubtype NOT IN ('R','S') THEN CASE WHEN bdr_hfl >= 0 THEN NULL ELSE -bdr_hfl END ELSE CASE WHEN bdr_hfl < 0 THEN NULL ELSE -bdr_hfl END END)), 2) AS Credit, 
		gbkmut.transsubtype, 
		gbkmut.valcode, 
		gbkmut.bdr_val, 
		gbkmut.docdate, 
		grtbk.oms25_0 AS MyOms, 
		Dagbk.afk, 
		gbkmut.btw_code, 
		gbkmut.tegreknr, 
		gbkmut.betcond, 
		gbkmut.btwper, 
		gbkmut.artcode, 
		gbkmut.transtype, 
		gbkmut.bankacc, 
		gbkmut.project, 
		gbkmut.facode, 
		gbkmut.bkstnr_sub, 
		gbkmut.reknr, 
		humres.fullname, 
		(CASE WHEN reminderlayout = 0 THEN 1 ELSE reminderlayout END) AS Reminderlayout, 
		gbkmut.syscreated, 
		c1.debcode, 
		gbkmut.verwerknrl, 
		gbkmut.betaalref, 
		gbkmut.kstplcode, 
		gbkmut.kstdrcode, 
		(CASE WHEN gbkmut.koers = 0 THEN CONVERT(VARCHAR(20),ROUND(gbkmut.koers,5)) 
			  ELSE (CASE WHEN 1/gbkmut.koers > 10000 THEN '1/' + CONVERT(VARCHAR(20), ROUND(1/gbkmut.koers,5)) 
					ELSE CONVERT(VARCHAR(20), ROUND(gbkmut.koers,5)) 
					END) 
		 END) AS Koers 
FROM gbkmut  INNER JOIN dagbk ON gbkmut.dagbknr = dagbk.dagbknr  
			 INNER JOIN grtbk ON gbkmut.reknr = grtbk.reknr  
			 LEFT OUTER JOIN humres ON gbkmut.res_id = humres.res_id  AND gbkmut.res_id IS NOT NULL  
			 LEFT OUTER JOIN cicmpy c1 ON gbkmut.debnr = c1.debnr  AND gbkmut.debnr IS NOT NULL AND c1.debnr IS NOT NULL  
WHERE gbkmut.debnr = ' 32409' 
		AND grtbk.omzrek = 'D' 
		AND gbkmut.transtype IN ('N', 'C', 'P')  
		AND gbkmut.datum >= {d '2012-02-01'}  
		AND gbkmut.datum <= {d '2012-05-01'}  
		AND remindercount <= 13 
ORDER BY gbkmut.datum, gbkmut.id
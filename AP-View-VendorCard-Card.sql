--CARD 
SELECT gbkmut.datum, gbkmut.docdate, gbkmut.faktuurnr, gbkmut.docnumber, gbkmut.oms25, 
	(CASE WHEN gbkmut.documentID IS NULL THEN 0 ELSE 1 END) AS Note, 
	(CASE WHEN gbkmut.docattachmentID IS NULL THEN 0 ELSE 1 END) AS Attach, ROUND(((
	 CASE WHEN transsubtype NOT IN ('R','S') THEN CASE WHEN bdr_hfl >= 0 THEN  bdr_hfl 
														ELSE NULL 
												  END 
		  ELSE CASE WHEN bdr_hfl < 0 THEN bdr_hfl 
		            ELSE NULL 
		       END 
     END)), 2) AS Debit, ROUND(((
     CASE WHEN transsubtype NOT IN ('R','S') THEN CASE WHEN bdr_hfl >= 0 THEN NULL 
											           ELSE -bdr_hfl 
											       END 
	      ELSE CASE WHEN bdr_hfl < 0 THEN NULL 
	                ELSE -bdr_hfl 
	           END 
	      END)), 2) AS Credit, 
	      gbkmut.transsubtype, gbkmut.valcode, gbkmut.bdr_val, gbkmut.bkstnr_sub, gbkmut.bkstnr, gbkmut.reknr, 
	      grtbk.oms25_0 AS MyOms, gbkmut.btw_code, gbkmut.tegreknr, gbkmut.betcond, gbkmut.btwper, gbkmut.artcode, 
	      gbkmut.transtype, gbkmut.bankacc, gbkmut.project, gbkmut.facode, Dagbk.afk, humres.fullname, gbkmut.syscreated, 
	      c2.crdcode, gbkmut.verwerknrl, gbkmut.betaalref, gbkmut.kstplcode, gbkmut.kstdrcode, gbkmut.ID, 
	(CASE WHEN gbkmut.koers = 0 THEN CONVERT(VARCHAR(20),ROUND(gbkmut.koers,5)) 
	       ELSE (CASE WHEN 1/gbkmut.koers > 10000 THEN '1/' + CONVERT(VARCHAR(20), ROUND(1/gbkmut.koers,5)) 
	                  ELSE CONVERT(VARCHAR(20), ROUND(gbkmut.koers,5)) 
	             END) 
	  END) AS Koers 
FROM gbkmut  INNER JOIN dagbk ON gbkmut.dagbknr = dagbk.dagbknr  
             INNER JOIN grtbk ON gbkmut.reknr = grtbk.reknr  
             LEFT OUTER JOIN humres ON gbkmut.res_id = humres.res_id and gbkmut.res_id IS NOT NULL  
             LEFT OUTER JOIN cicmpy c2 ON gbkmut.crdnr = c2.crdnr AND gbkmut.crdnr IS NOT NULL  

WHERE gbkmut.transtype IN ('N', 'C', 'P') AND gbkmut.crdnr = '  1540' AND grtbk.omzrek = 'C'  AND remindercount <= 13 ORDER BY gbkmut.faktuurnr


--Open AP Report
SELECT  CAST(AV.vend_no AS INT) AS [Vendor #], payee_name AS [Ven Name], city, country,  vchr_no, vchr_dt, ap_po_no AS [PO #], amt AS [Document Total], av.status
FROM   apopnfil_Sql AP INNER JOIN apvenfil_sql AV ON AV.vend_no = AP.vend_no
WHERE not(vchr_no IN (SELECT vchr_no FROM apopnfil_sql WHERE vchr_chk_type = '3'))
ORDER BY vchr_no

--Closed AP Report
SELECT  CAST(AV.vend_no AS INT) AS [Vendor #], payee_name, city, country,  vchr_no, vchr_dt, ap_po_no AS [PO #], pay_amt AS [Document Total], av.status, *
FROM   apopnfil_Sql AP INNER JOIN apvenfil_sql AV ON AV.vend_no = AP.vend_no
WHERE vchr_no IN (SELECT vchr_no FROM apopnfil_sql WHERE vchr_chk_type = '3') AND vchr_chk_type = '3'
ORDER BY vchr_no

--Closed AR Report
SELECT   CAST(AV.cus_no AS INT) AS [Cus #], cus_name AS [Cus Name], curr_doc_type AS [Doc Type], doc_dt, apply_to_no, doc_no, amt_1, amt_2, amt_1 + amt_2 AS [Tot_Amt], reference
FROM    aropnfil_sql AR inner join arcusfil_Sql AV on AR.cus_no = AV.cus_no
WHERE doc_type = 'P' OR doc_no IN (SELECT apply_to_no FROM AROPNFIL_SQL WHERE doc_type = 'P')
ORDER BY apply_to_no, doc_type

--Open AR Report
SELECT   CAST(AV.cus_no AS INT) AS [Cus #], cus_name AS [Cus Name], curr_doc_type AS [Doc Type], doc_dt, apply_to_no, doc_no, amt_1, amt_2, amt_1 + amt_2 AS [Tot_Amt],reference
FROM    aropnfil_sql AR inner join arcusfil_Sql AV on AR.cus_no = AV.cus_no
WHERE doc_type = 'I' AND NOT(doc_no IN (SELECT apply_to_no FROM AROPNFIL_SQL WHERE doc_type = 'P'))
ORDER BY doc_no
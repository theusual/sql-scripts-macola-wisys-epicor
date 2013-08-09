Use [001]

SELECT ord_no, MAX(A4GLIdentity) AS A4GLIdentity, MAX(carrier_cd) AS Expr2, MAX(hand_chg) AS Expr3, MAX(ship_dt) AS Expr1, filler_0001, extra_1
FROM         dbo.ARSHTTBL
WHERE     (void_fg IS NULL) AND (NOT (ord_no = '' OR
                      ord_no IS NULL)) AND (NOT (filler_0001 = '' OR
                      filler_0001 IS NULL)) AND (NOT (tracking_no = '' OR
                      tracking_no IS NULL)) AND (NOT (carrier_cd IS NULL OR
                      carrier_cd = '')) AND (NOT (extra_1 IS NULL OR
                      extra_1 = '')) AND ORD_NO in (651621)
GROUP BY ord_no, ship_dt, A4glidentity, filler_0001, extra_1
ORDER BY MAX(Ship_dt), MAX(A4GLIDENTITY)
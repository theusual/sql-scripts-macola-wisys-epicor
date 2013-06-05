SELECT PL.item_no, PL.item_desc_1, PL.item_desc_2,PL.act_unit_cost, PH.ord_no, PL.qty_ordered, PH.ord_Dt, PH.vend_no, IM.prod_cat FROM dbo.poordlin_sql PL JOIN dbo.poordhdr_sql PH ON PH.ord_no = PL.ord_no JOIN dbo.imitmidx_sql IM ON IM.item_no = PL.item_no --WHERE  PL.item_no LIKE '%TEST%'


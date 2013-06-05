DECLARE @loc AS Varchar(MAX)

SET @loc = 'MDC'

      Insert Into IMTYPLOC_SQL (mat_cost_type, loc, mn_no, sb_no,receiving_mn_no,receiving_sb_no,issue_mn_no, issue_sb_no, receipt_mn_no, receipt_sb_no, qty_adj_mn_no, qty_adj_sb_no,cost_adj_mn_no,cost_adj_sb_no,wip_var_mn_no,wip_var_sb_no,ppv_var_mn_no,ppv_var_sb_no,xfr_var_mn_no, xfr_var_sb_no, qty_xfer_mn_no, qty_xfer_sb_no,wip_mn_no,wip_sb_no,mat_cost_mn_no,mat_cost_sb_no,mat_qty_mn_no,mat_qty_sb_no)
      Select Distinct mat_cost_Type, @loc, mn_no,sb_no,receiving_mn_no,receiving_sb_no,issue_mn_no,issue_sb_no, receipt_mn_no, receipt_sb_no, qty_adj_mn_no, qty_adj_sb_no,cost_adj_mn_no,cost_adj_sb_no,wip_var_mn_no,wip_var_sb_no,ppv_var_mn_no,ppv_var_sb_no,xfr_var_mn_no, xfr_var_sb_no, qty_xfer_mn_no, qty_xfer_sb_no,wip_mn_no,wip_sb_no,mat_cost_mn_no,mat_cost_sb_no,mat_qty_mn_no,mat_qty_sb_no
 
      From imtyploc_sql
      Where not(mat_cost_type IN (SELECT mat_cost_Type FROM IMTYPLOC_SQL WHERE loc = @loc))
      
      
      --SELECT * FROM imtyploc_sql where mat_cost_type = 'n'
      

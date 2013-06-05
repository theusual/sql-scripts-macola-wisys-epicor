--function to return new_avg_Cost from the IMRECHST_SQL table
ALTER function funReturnAvgCostFromIMRECHST(@item_no as varchar(30))
returns decimal(16,6)
AS
begin
	declare @new_avg_cost decimal(16,6)
		
	SELECT  top (1) @new_avg_cost = new_avg_cost
	FROM  imrechst_sql
	WHERE item_no = @item_no and new_avg_cost > 0
	GROUP BY item_no, rec_hst_dt, new_avg_Cost
	ORDER BY rec_hst_dt desc
	
	return @new_avg_cost
end

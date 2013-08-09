IF NOT EXISTS(SELECT * FROM bg_holdingtbl_WMPO)
   INSERT INTO bg_holdingtbl_wmpo 
     SELECT 
         Cell, CellSettings, RecipeInstanceId, 
         BiasStartTime, SubId, RuleInstanceId
     FROM CTE
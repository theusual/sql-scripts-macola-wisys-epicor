CREATE function FindLastDelimited
(@Delimiter varchar(100),
 @OriginalString varchar(500))
 
 RETURNS varchar(500) AS
 BEGIN
 RETURN(
	SELECT  COALESCE(RIGHT(@OriginalString, NullIf(CHARINDEX(REVERSE(@Delimiter), REVERSE(@OriginalString)), 0)-1), @OriginalString)
	)
 END
 
 
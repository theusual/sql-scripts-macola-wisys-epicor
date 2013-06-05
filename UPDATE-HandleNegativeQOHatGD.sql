DECLARE @execstatementsbatch varchar(max)
DECLARE @BrysysObject VARCHAR(MAX)
DECLARE @JobName AS VARCHAR(MAX)

SET @JobName = '''JOB: Set_GD_QOH_To_0'''

------------------------------------------------
--Kit negative parents up to 0
------------------------------------------------
SET @execstatementsbatch = ''
--IssueBOMs -------------
SET @BrysysObject = 'BG_Brysys_Invtrx_IssueBOM'
SELECT @execstatementsbatch = @execstatementsbatch   + 'EXEC ' + @BrysysObject + ' ''' + RTRIM(IL.item_no) +  ''', '  + IL.loc +  + ', ' + CAST((IL.qty_on_hand * -1) AS VARCHAR) + ', ' + @JobName + '; '
FROM dbo.iminvloc_sql IL JOIN dbo.imitmidx_sql IM ON IM.item_no = IL.item_no
WHERE IL.loc = 'GD' AND qty_on_hand < 0 AND IM.extra_1 = 'P' 

--SELECT @execstatementsbatch
exec(@execstatementsbatch)
SET @execstatementsbatch = ''

--Receive parents -------------
SET @BrysysObject = 'BG_Brysys_Invtrx_Receipt'
SELECT @execstatementsbatch = @execstatementsbatch   + 'EXEC ' + @BrysysObject + ' ''' + IL.item_no +  ''', '   + IL.loc +  + ', ' + CAST((IL.qty_on_hand * -1) AS VARCHAR) + ', ' + @JobName + '; '
FROM dbo.iminvloc_sql IL JOIN dbo.imitmidx_sql IM ON IM.item_no = IL.item_no
WHERE IL.loc = 'GD' AND qty_on_hand < 0 AND IM.extra_1 = 'P' 

--SELECT @execstatementsbatch
exec(@execstatementsbatch)
SET @execstatementsbatch = ''

-----------------------------------------------
--Kit negative subassemblies up to 0
-----------------------------------------------
--IssueBOMs -------------
SET @BrysysObject = 'BG_Brysys_Invtrx_IssueBOM'
SELECT @execstatementsbatch = @execstatementsbatch   + 'EXEC ' + @BrysysObject + ' ''' + IL.item_no +  ''', '   + IL.loc +  + ', ' + CAST((IL.qty_on_hand * -1) AS VARCHAR) + ', ' + @JobName + '; '
FROM dbo.iminvloc_sql IL JOIN dbo.imitmidx_sql IM ON IM.item_no = IL.item_no
WHERE IL.loc = 'GD' AND qty_on_hand < 0 AND IM.extra_1 = 'S' 

--SELECT @execstatementsbatch
exec(@execstatementsbatch)
SET @execstatementsbatch = ''

--Receive subassemblies -------------
SET @BrysysObject = 'BG_Brysys_Invtrx_Receipt'
SELECT @execstatementsbatch = @execstatementsbatch   + 'EXEC ' + @BrysysObject + ' ''' + IL.item_no +  ''', '  + IL.loc +  + ', ' + CAST((IL.qty_on_hand * -1) AS VARCHAR) + ', ' + @JobName + '; '
FROM dbo.iminvloc_sql IL JOIN dbo.imitmidx_sql IM ON IM.item_no = IL.item_no
WHERE IL.loc = 'GD' AND qty_on_hand < 0 AND IM.extra_1 = 'S'

--SELECT @execstatementsbatch
exec(@execstatementsbatch)
SET @execstatementsbatch = ''

------------------------------------------------------------------------------------------------------------------
--Receive components that are negative (extra_1 = 'C') AND non-BOM items (purchased components) (extra_1 = 'X'
------------------------------------------------------------------------------------------------------------------
--Receive components -------------
SET @BrysysObject = 'BG_Brysys_Invtrx_Receipt'
SELECT @execstatementsbatch = @execstatementsbatch   + 'EXEC ' + @BrysysObject + ' ''' + IL.item_no +  ''', '  + IL.loc +  + ', ' + CAST((IL.qty_on_hand * -1) AS VARCHAR) + ', ' + @JobName + '; '
FROM dbo.iminvloc_sql IL JOIN dbo.imitmidx_sql IM ON IM.item_no = IL.item_no
WHERE IL.loc = 'GD' AND qty_on_hand < 0 AND IM.extra_1 IN ('C','X') --AND IM.item_no = 'TEST ITEM BOM'

--SELECT @execstatementsbatch
exec(@execstatementsbatch)
SET @execstatementsbatch = ''
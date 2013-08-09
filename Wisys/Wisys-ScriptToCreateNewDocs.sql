If Not Exists (Select top 1 1 from wsSectionDefine Where Sec_Type = 'CS2' and Sec_Def = 'Custom Item Label')
Insert into wsSectionDefine (Sec_cd, Sec_ParDesc, Sec_Type, Sec_ParSeq, Sec_Seq, Sec_Sub, Sec_Def, Sec_Int, Sec_String, Sec_BPrpt, Sec_BItem, Sec_BCust, Sec_BPcat, Sec_BPtyp, Sec_BVend, Active)
Select Sec_cd, Sec_ParDesc, 'CS2', Sec_ParSeq, Sec_Seq, Sec_Sub, 'Custom Item Label', Sec_Int, Sec_String, Sec_BPrpt, Sec_BItem, Sec_BCust, Sec_BPcat, Sec_BPtyp, Sec_BVend, Active
From wsSectionDefine
Where Sec_Type = 'PAL' and Sec_ParDesc = 'Shipping'

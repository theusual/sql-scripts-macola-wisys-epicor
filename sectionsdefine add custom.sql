select * from wsSectionDefine

insert into wsSectionDefine (Sec_cd, Sec_ParDesc, Sec_Type, Sec_ParSeq, Sec_Seq, Sec_Sub, Sec_Def, Sec_Int, Sec_String, Sec_BPrpt, Sec_BItem, Sec_BCust, Sec_BPcat, Sec_BPtyp, Sec_BVend, Active)
select Sec_cd, Sec_ParDesc, 'CS1', Sec_ParSeq, Sec_Seq, Sec_Sub, Sec_Def, Sec_Int, Sec_String, Sec_BPrpt, Sec_BItem, Sec_BCust, Sec_BPcat, Sec_BPtyp, Sec_BVend, Active
from wsSectionDefine where Sec_Type = 'PAL'

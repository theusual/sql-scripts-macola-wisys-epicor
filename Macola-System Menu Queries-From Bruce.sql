BEGIN TRAN

select * from sysmnu
where prnt_id = 17475
where mnu_id = 1747
--where descr64 = 'Confirm Shipping'

--delete from sysmnu where mnu_id = 17479

select * from sysmnu where descr64 = 'WMS Pick Pack'

select * from sysmnu where descr64 = 'WMS Pick Tickets'

update sysmnu set seq_no = seq_no + 1 where prnt_id = (select max(mnu_id) from sysmnu where descr64 = 'Shipping' and prnt_id = (select 
max(mnu_id) from sysmnu where descr64 = 'Billing/Picking/Shipping' and m_type = 'M')) and seq_no >= 0 

INSERT INTO Pwfunc 
(fnc_id,descr30,term_id,exename,param,app_type,option_exp,settings,mpackage_0,mpackage_1,mpackage_2,mpackage_3,mpackage_4,mpackage_5,mpackage_6,mpackage_7,slic,sparam,origin,icon,pwreg,rtype,descr64,helpcontext,syscreated,syscreator,sysmodified,sysmodifier,sysguid) 
Values ('66960000015', NULL, 0, 'WMS PickPack 2006.exe','-V', 'X', NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, 11506, 1, 'N', 
'WMS Pick Pack', NULL, getdate(), 1, getdate() , 1, newid() )



INSERT INTO sysmnu (root_id, sysguid, prnt_id, seq_no, m_type, fnc_id, descr64, keyshortcut,tree_level) select (SELECT TOP 1 mnu_id FROM 
sysmnu WHERE fnc_id = 'Go Menu 1' AND m_type =  'G'),newid(), (select mnu_id from sysmnu where descr64 = 'Shipping' and prnt_id = (select 
mnu_id from sysmnu where descr64 = 'Billing/Picking/Shipping' and m_type = 'M')), 0, 'F', '66960000015', 'WMS Pick Pack', 'P',4 

UPDATE syscrc SET ewfCrc = ewfCrc + 1


ROLLBACK
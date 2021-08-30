-- SCRIPT 1
-- AE extract for EM region coverting time to gmt 
select s_at_date as 'cst',  
	DATEADD(hour,5,s_at_date) 'GMT datetime', --add 5 hours to s_at_date to convert from cst to gmt
	Dateadd(hour,5,s_at_time) as 'Time stamp gmt',  --add 5 hours to s_at_date to convert from cst to gmt
	DATEPART(HOUR,Dateadd(hour,5,s_at_time))as 'hour', --extract hour from gmt
	DATEPART(MINUTE,Dateadd(hour,5,s_at_time)) as 'minute', --extract minute from gmt
	TIMEFROMPARTS (DATEPART(HOUR,Dateadd(hour,5,s_at_time)),((DATEPART(MINUTE,Dateadd(hour,5,s_at_time)))-((DATEPART(MINUTE,Dateadd(hour,5,s_at_time)))%15)),0,0,0) as '15 min', --hour + min- min(mod)15
	t_at_account_number 'GIO account',
	t_at_command 'GIO Screen',
	t_at_mode 'mode',
	left(t_at_userid,len(t_at_userid)-4) as 'userid' --user id stored as BRK3EMXX so extract user id by stripping right 4 chars
from [daedbo].[dae_fabi_audit_trail] 
where right(t_at_userid,4) like 'EMXX' and
t_at_filetype like 'AE'



--SCRIPT 2
--SD extract from EM region

select s_at_date as 'cst',  
	DATEADD(hour,5,s_at_date) 'GMT datetime', --add 5 hours to s_at_date to convert from cst to gmt
	Dateadd(hour,5,s_at_time) as 'Time stamp gmt',  --add 5 hours to s_at_date to convert from cst to gmt
	DATEPART(HOUR,Dateadd(hour,5,s_at_time))as 'hour', --extract hour from gmt
	DATEPART(MINUTE,Dateadd(hour,5,s_at_time)) as 'minute', --extract minute from gmt
	TIMEFROMPARTS (DATEPART(HOUR,Dateadd(hour,5,s_at_time)),((DATEPART(MINUTE,Dateadd(hour,5,s_at_time)))-((DATEPART(MINUTE,Dateadd(hour,5,s_at_time)))%15)),0,0,0) as '15 min', --hour + min- min(mod)15
	t_at_security_number 'Asset identifier',
	t_at_command 'GIO Screen',
	t_at_mode 'mode',
	left(t_at_userid,len(t_at_userid)-4) as 'userid' --user id stored as BRK3EMXX so extract user id by stripping right 4 chars
from [daedbo].[dae_fabi_audit_trail] 
where right(t_at_userid,4) like 'EMXX' and
t_at_filetype like 'SD'



--SCRIPT 3
--SR(bond rates),SV(equity rates) extract from EM region

select top 100 DATEADD(hour,5,s_at_date) 'GMT datetime', --add 5 hours to s_at_date to convert from cst to gmt
	Dateadd(hour,5,s_at_time) as 'Time stamp gmt',  --add 5 hours to s_at_date to convert from cst to gmt
	DATEPART(HOUR,Dateadd(hour,5,s_at_time))as 'hour', --extract hour from gmt
	DATEPART(MINUTE,Dateadd(hour,5,s_at_time)) as 'minute', --extract minute from gmt
	TIMEFROMPARTS (DATEPART(HOUR,Dateadd(hour,5,s_at_time)),((DATEPART(MINUTE,Dateadd(hour,5,s_at_time)))-((DATEPART(MINUTE,Dateadd(hour,5,s_at_time)))%15)),0,0,0) as '15 min', --hour + min- min(mod)15
	t_at_security_number 'Asset identifier',
	t_at_command 'GIO Screen',
	t_at_mode 'mode',
	left(t_at_userid,len(t_at_userid)-4) as 'userid', --user id stored as BRK3EMXX so extract user id by stripping right 4 chars
	t_at_filetype as 'filetype'
from [daedbo].[dae_fabi_audit_trail]
where right(t_at_userid,4) like 'EMXX' and
t_at_filetype in ('SR','SV')

--SCRIPT 4
--TS extract from EM region

select top 10 DATEADD(hour,5,s_at_date) 'GMT datetime', --add 5 hours to s_at_date to convert from cst to gmt
	Dateadd(hour,5,s_at_time) as 'Time stamp gmt',  --add 5 hours to s_at_date to convert from cst to gmt
	DATEPART(HOUR,Dateadd(hour,5,s_at_time))as 'hour', --extract hour from gmt
	DATEPART(MINUTE,Dateadd(hour,5,s_at_time)) as 'minute', --extract minute from gmt
	TIMEFROMPARTS (DATEPART(HOUR,Dateadd(hour,5,s_at_time)),((DATEPART(MINUTE,Dateadd(hour,5,s_at_time)))-((DATEPART(MINUTE,Dateadd(hour,5,s_at_time)))%15)),0,0,0) as '15 min', --hour + min- min(mod)15
	t_at_account_number as 'GIO Account',
	t_at_security_number 'Asset identifier',
	t_at_command 'GIO Screen',
	t_at_mode 'mode',
	t_at_trans as 'Tran Code',
	t_at_memo as 'memo no',
	left(t_at_userid,len(t_at_userid)-4) as 'userid' --user id stored as BRK3EMXX so extract user id by stripping right 4 chars
from [daedbo].[dae_fabi_audit_trail]
where right(t_at_userid,4) like 'EMXX' and
t_at_filetype like 'TS' and
t_at_security_number not in ('BU MULTIS','BG MULTIS','BG MASTER','BU MASTER')

--SCRIPT 4
--TS extract from EM region

select top 10 DATEADD(hour,5,s_at_date) 'GMT datetime', --add 5 hours to s_at_date to convert from cst to gmt
	Dateadd(hour,5,s_at_time) as 'Time stamp gmt',  --add 5 hours to s_at_date to convert from cst to gmt
	DATEPART(HOUR,Dateadd(hour,5,s_at_time))as 'hour', --extract hour from gmt
	DATEPART(MINUTE,Dateadd(hour,5,s_at_time)) as 'minute', --extract minute from gmt
	TIMEFROMPARTS (DATEPART(HOUR,Dateadd(hour,5,s_at_time)),((DATEPART(MINUTE,Dateadd(hour,5,s_at_time)))-((DATEPART(MINUTE,Dateadd(hour,5,s_at_time)))%15)),0,0,0) as '15 min', --hour + min- min(mod)15
	t_at_account_number as 'GIO Account',
	t_at_security_number 'Asset identifier',
	t_at_command 'GIO Screen',
	t_at_mode 'mode',
	t_at_trans as 'Tran Code',
	t_at_memo as 'memo no',
	left(t_at_userid,len(t_at_userid)-4) as 'userid' --user id stored as BRK3EMXX so extract user id by stripping right 4 chars
from [daedbo].[dae_fabi_audit_trail]
where right(t_at_userid,4) like 'EMXX' and
t_at_filetype like 'T2' and
t_at_security_number not in ('BU MULTIS','BG MULTIS','BG MASTER','BU MASTER')



----------------------------------------------------------------------------------------
-----FUND STATIC 
-----------------------------------------------------------------------------------------
select [t_fs_account_number] 'Account no'
      ,[t_fs_manager] 'manager'
      ,[t_fs_tl] 'teamlead'
      ,[t_fs_accountant] 'accountant'
      ,[t_fs_fund_group] 'fund group'
      ,[t_fs_proc_group] 'processing group'
      ,[t_fs_group_account] 'group account'
      ,[t_fs_account_indicator] 'account indicator'
      ,[t_fs_account_name] 'account name'
      ,[t_fs_investment_discpl] 'structure'
from [daedbo].[dae_fabi_fund_static]
where t_fs_user_bank like 'EM'

------------------------------------------------------------------------------------------
----EMS 
-----------------------------------------------------------------------------------------
SELECT [t_account_nbr] 'Account'
      ,[t_projection] 'package'
      ,[t_rule_name] 'rule name'
      ,[t_text] 'ems generated'
	  ,datefromparts(year(DATEADD(hour,5,[s_createdat])),MONTH(DATEADD(hour,5,[s_createdat])),day(DATEADD(hour,5,[s_createdat]))) as 'calendar_date'
	  ,TIMEFROMPARTS(datepart(hour,(DATEADD(hour,5,[s_createdat]))),datepart(minute,(DATEADD(hour,5,[s_createdat]))),datepart(second,(DATEADD(hour,5,[s_createdat]))),0,0) as 'runat'
      ,datefromparts(year([t_system_4]),month([t_system_4]),day([t_system_4])) 'nav_date'
      ,[t_system_9] 'severity'
	  ,[t_system_2] 'Asset'
      ,[t_exception_key]
      ,[t_action_type] 'Action'
      ,RIGHT([t_userid],LEN([t_userid])-3) 'Action_by'
      ,DATEADD(hour,5,[s_action_date]) as 'actiondate'
	  ,TIMEFROMPARTS (DATEPART(HOUR,Dateadd(hour,5,s_action_date)),((DATEPART(MINUTE,Dateadd(hour,5,s_action_date)))-((DATEPART(MINUTE,Dateadd(hour,5,s_action_date)))%15)),0,0,0) as '15 min' --hour + min- min(mod)15
	  ,[t_comment_] 'ems_comment'
  FROM [ccwdb].[daedbo].[dae_fabi_ems_data]
  WHERE t_userbank like 'EM'

--------------------------------------------------
---BENCHMARK TOOL 
-------------------------------------------------
SELECT [t_account_nbr] 'Account'
      ,[t_rule_name] 'EMS rule'
	  ,datefromparts(year(DATEADD(hour,5,[s_createdat])),MONTH(DATEADD(hour,5,[s_createdat])),day(DATEADD(hour,5,[s_createdat]))) as 'Calander date' --this is calendar date
      ,datefromparts(year([t_system_4]),month([t_system_4]),day([t_system_4])) 'navdate'
      ,DATEADD(hour,5,[s_researchedat]) 'researchdat'
      ,[t_system_9] 'severity'
	  ,[t_system_2] 'Asset'
      ,[t_exception_key]  -- select count of distinct of these to identify count of rules.
  FROM [ccwdb].[daedbo].[dae_fabi_ems_data] --below list of 153 funds are part of Tranche 1 of testing for BM rules.
  WHERE t_account_nbr in ('1700379','1700605','1702883','1702884','1702886','1702887','1702888','1702889','1706033','1706034','1706035','1706036','1706037','1706038','1706959','1707508','1709478','1713723','1714131','1714134','1714136','1714137','1714146','1717805','1718463','1720750','1720751','1723001','1723516','1728170','1731216','1731230','1731231','1731803','1731804','1731805','1731806','1737189','1737190','1738558','1738841','1738842','1738843','1740429','1743748','1743749','1743750','1744254','1744255','1750686','1767095','1767952','1770112','1770113','1773249','1773273','1774781','1775384','1784476','1784731','1785160','1709957','6002306','1735526','1708175','1708176','1709767','1710751','1732571','1737919','1741944','1746553','1746554','1750099','1750101','1755216','1757701','1760514','1760526','1760527','1763544','1763545','1778646','1778648','1716085','1716086','1716087','1716088','1716089','1716090','1716091','1716093','1716094','1744260','1744261','1762589','1766332','1767110','1767112','1767113','1767114','1767115','1715972','1715973','1715974','1715975','1715978','1715979','1715980','1715981','1715983','1715986','1715988','1715989','1730465','1771173','1771174','1771176','1771177','1771179','1771180','1771181','1771182','1777148','1777149','1777150','1777151','2150301','2150302','2150303','2150304','2150305','2150306','2150307','2150308','6008142','1736917','1736938','1740040','1740041','1745443','1748760','1750023','1751062','1751063','1762287','1778174','1782658','6013468','6013472','1750094','1732387','1769177') and
  LEFT(t_rule_name,6) in ('NT3022','NT3202','NT0009','NT0114') and
  datefromparts(year([t_system_4]),month([t_system_4]),day([t_system_4])) between '2020/06/29' and datefromparts(year(getdate()),month(getdate()),DAY(getdate())-2) --BM prod parallel was put in production only on 29th June onwards. 
  order by navdate


--------------------------------------------------------
---------------PRICESS MANAGER
--------------------------------------------------------

  


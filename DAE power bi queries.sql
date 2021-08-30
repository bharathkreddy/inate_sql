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


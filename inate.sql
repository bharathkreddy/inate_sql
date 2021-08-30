select distinct t_at_command + ' '+t_at_userid
from [daedbo].[dae_fabi_audit_trail]

--prevent divide by zero
select top 10000 t_pm_userbank,
cast(s_pm_submission_time as date) as sub_dt,
cast(s_pm_submission_time as time) as sub_time,
i_pm_task_dur_sec as task,
i_pm_proc_dur_sec as process,
i_pm_task_dur_sec/i_pm_proc_dur_sec as div
from [daedbo].[dae_fabi_process_manager_log]
where 
	case
		when i_pm_proc_dur_sec = 0 Then 'no'
		when i_pm_task_dur_sec/i_pm_proc_dur_sec >0 then 'yes'
		else 'no'
	end = 'yes'

--concat with NULL is a NULL
select CONCAT(t_at_filetype,s_at_inserttimestamp,t_at_trans) as mash
from [daedbo].[dae_fabi_audit_trail]

--coalesce returns from input parameters the first non null paramenter
select 'abc'+coalesce(NULL,' ','cde')+'bcd'

-- len ingnores trailing spaces.
select len('abc   ')

--returns first instance of a argument, in second argument
SELECT CHARINDEX(' ','Itzik Ben-Gan');

--returns first instance of a pattern
SELECT PATINDEX('%[0-9]%', 'abcd123efgh');


SELECT t_at_userid as usr,
PATINDEX('%DV',t_at_userid) as pos_of_dv
from [daedbo].[dae_fabi_audit_trail]

SELECT PATINDEX('%DV','DVR3dv')
SELECT PATINDEX('%DV%','DVR3dv')
SELECT PATINDEX('DV%','DVR3dv')

select DISTINCT t_at_userid
from [daedbo].[dae_fabi_audit_trail]
where t_at_userid like '[YA][bc]%';

select top 10 * 
from [daedbo].[dae_fabi_audit_trail]

select top 10 *
from [daedbo].[dae_fabi_ems_data]

Select t_account_nbr,t_rule_name,count(*) as cnt
from [daedbo].[dae_fabi_ems_data]
where t_account_nbr in 
(select distinct t_at_account_number
from [daedbo].[dae_fabi_audit_trail]
where t_at_userid like '[YA]%')
group by t_account_nbr,t_rule_name
order by t_account_nbr,t_rule_name;

select t_account_nbr as acc, 
t_rule_name as ems,
count(*) as cnt
from [daedbo].[dae_fabi_ems_data] as T1
where t_system_4 = 
	(select max(t_system_4)
	  from [daedbo].[dae_fabi_ems_data] as T2
	  where T2.t_account_nbr = T1.t_account_nbr) 
group by t_account_nbr,t_rule_name;


select t_account_nbr as acc,
t_system_2 as sec,
t_system_4 as dt,
t_rule_name as ems
from [daedbo].[dae_fabi_ems_data] as T1
where t_rule_name = 
	(select max(t_rule_name)
	 from [daedbo].[dae_fabi_ems_data] as T2
	 where T1.t_account_nbr = T2.t_account_nbr)


--getting % of a value amongst the subgroup -- 
With A 
as
(
select T1.t_account_nbr as acc,
cast(T1.t_system_4 as date) as dt,
count(T1.t_rule_name) as ems_cnt
from [daedbo].[dae_fabi_ems_data] as T1
where cast(t_system_4 as date) > '20210824'
and t_userbank = 'EM'
and t_account_nbr in ('1771078','1770493','1770492','1770491')
group by t_account_nbr, cast(t_system_4 as date)
),
B as
(
select T1.acc,T1.dt,T1.ems_cnt,
(select sum(T2.ems_cnt) 
	from A as T2
	where T1.dt = T2.dt) as tot
from A as T1
)
select acc,dt,ems_cnt,tot,cast(100* ems_cnt/tot as numeric(5,2)) as pct
from B
order by dt desc, acc desc

--getting previous date and next date--
with A as
(
select T1.t_account_nbr as acc,
cast(T1.t_system_4 as date) as dt,
count(T1.t_rule_name) as ems_cnt
from [daedbo].[dae_fabi_ems_data] as T1
where cast(t_system_4 as date) > '20210824'
and t_userbank = 'EM'
and t_account_nbr in ('1771078','1770493','1770492','1770491')
group by t_account_nbr, cast(t_system_4 as date)
)
select T1.acc,
	T1.dt,
	T1.ems_cnt,
	(select max(T2.dt) from A as T2 where T1.dt>T2.dt and T1.acc = T2.acc) as prev_dt,
	(select min(T2.dt) from A as T2 where T1.dt<T2.dt and T1.acc = T2.acc) as next_dt,
from A as T1
order by dt desc, acc desc


--PREV VALUES WITH APPLY and CROSS APPLY
--OUTER APPLY rejoins left side of table where right has NULL values.
with A as
(
select t_account_nbr as acc,
count(distinct t_rule_name) as ems_count,
cast(t_system_4 as date) as val_dt
from [daedbo].[dae_fabi_ems_data]
where cast(t_system_4 as date) > '20210817'
and t_userbank = 'EM'
and t_account_nbr in ('1771078','1770493','1770492','1770491')
group by t_account_nbr,cast(t_system_4 as date)
)
select T1.acc,
T1.ems_count,
T1.val_dt,
T3.cnt as prev_ems_count
from A as T1
	OUTER APPLY
	(select top (1) ems_count as cnt
	from A as T2
	where T1.acc = T2.acc
	and T2.val_dt < T1.val_dt
	order by Val_dt desc) as T3
order by acc desc, val_dt desc

--windows function for runing total
with A as
(
select t_account_nbr as acc,
count(distinct t_rule_name) as ems_count,
cast(t_system_4 as date) as val_dt
from [daedbo].[dae_fabi_ems_data]
where cast(t_system_4 as date) > '20210817'
and t_userbank = 'EM'
and t_account_nbr in ('1771078','1770493','1770492','1770491')
group by t_account_nbr,cast(t_system_4 as date)
)
select *, 
	SUM(ems_count) OVER(PARTITION BY acc
		ORDER BY val_dt desc
		ROWS BETWEEN UNBOUNDED PRECEDING
		AND CURRENT ROW) AS ems_count_cumulative,
	ROW_NUMBER() OVER(PARTITION BY acc ORDER BY val_dt desc) AS rownum,
	RANK() OVER(PARTITION BY acc ORDER BY ems_count desc) AS rank, --a rank of 9 indicates eight rows with lower values
	DENSE_RANK() OVER(ORDER BY val_dt desc) AS dense_rank, --A dense rank of 9 indicates eight distinct lower values.
	NTILE(10) OVER(ORDER BY ems_count asc) AS ntile
from A
order by acc desc, val_dt asc

-- LAG & LEAD VALUES WITH % CHANGES
with A as
(
select t_account_nbr as acc,
count(distinct t_rule_name) as ems_count,
cast(t_system_4 as date) as val_dt
from [daedbo].[dae_fabi_ems_data]
where cast(t_system_4 as date) > '20210817'
and t_userbank = 'EM'
and t_account_nbr in ('1771078','1770493','1770492','1770491')
group by t_account_nbr,cast(t_system_4 as date)
),
B as
(
select acc,val_dt,ems_count,
LAG(ems_count,1,0) over(partition by acc order by val_dt asc) as prev_ems_count, --lag(var,offset,default for NULL)
LEAD(ems_count,1,0) over(partition by acc order by val_dt asc) as next_ems_count, --lead(var,offset,default for NULL)
LAG(val_dt) over (partition by acc order by val_dt asc) as prev_val_dt --grabs prev val date with default offset of 1 and null where no prior value
from A
)
select acc,val_dt,prev_val_dt,
DATEDIFF(d,prev_val_dt,val_dt) as day_diff, --gives days betwen prev val and current val
ems_count,prev_ems_count,next_ems_count,    --decimal(p,s) p is total digits, s is digits after decimal.
CAST(cast (100*(1-(cast (prev_ems_count as decimal(4,2))/next_ems_count ))as decimal(8,2)) AS VARCHAR(150))+'%' as pct_chg
from B
where    --to prevent divide by zero errors
	case
		when next_ems_count = 0 Then 'no'
		else 'yes'
	end = 'yes'
order by acc desc, val_dt asc

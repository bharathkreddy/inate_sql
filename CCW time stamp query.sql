SELECT top 500 t_sldm_checklist_name_vc,
	t_sldm_entity_name_vc,
	t_sldm_entity_description_vc,
	t_sldm_section_group_name_vc,
	t_sldm_section_name_vc,
	s_sldm_start_time_dt,
	s_sldm_finish_time_dt,
	t_sldm_checkliststatus_vc,
	s_sldm_business_date_due_date_dt,
	t_ngs_group_name,
	t_ngs_group_desc,
	t_ngs_fa_dept,
	s_ngs_deadline,
	t_ngs_fundtype,
	t_ngm_group_code,
	t_ngm_group_desc,
	i_ngm_account_number,
	i_ngm_isrowcurrent,
	t_eb_checklist,
	t_eb_benchmark,
	s_eb_client_deadline,
	t_eb_group,
	t_eb_team,
	t_eb_fund_type
FROM
    [daedbo].[dae_fabi_sl_data_main_tbl]  as a
INNER JOIN [daedbo].[dae_fabi_nav_group_static] as b 
    ON a.t_sldm_entity_description_vc = b.t_ngs_group_desc
INNER JOIN [daedbo].[dae_fabi_nav_group_mapping] as c
	ON b.t_ngs_group_desc = c.t_ngm_group_desc
INNER JOIN [daedbo].[dae_fabi_entity_benchmark] as d
	ON a.t_sldm_entity_name_vc  = d.t_eb_entity


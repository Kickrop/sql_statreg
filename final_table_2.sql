--drop materialized view statregistr.registr
create materialized view statregistr.registr as
--version 2
with registr as (
select 
	case when s7.pole_1 is not null then s7.pole_1 else oi.okpo end as kod_okpo
	,case when pole_3 is not null then pole_3 else oi.okpo end as id_n --2
	,oi.okpo as okpo --3
	,case when pole_2 is not null and length(pole_2) = 8 then pole_2 else left(oi.okpo,8) end as okpo_head 
	--,case when pole_6 is not null then pole_6 else oi.short_name end as short_name 
	,case 	
		when left(pole_6,5) like '%85-К%' or left(pole_6,5) like '%85-к%' then trim(substring(pole_6,5)) 
		when pole_6 is not null then pole_6
		else oi.short_name
	end	short_name
	--,case when pole_7 is not null then pole_7 else oi.full_name end as full_name
	,case 	
		when pole_7 like '%Группы кратковременного пребывания%' then trim(substring(pole_7,40)) 
		when left(pole_7,5) like '%85-К%' or left(pole_7,5) like '%85-к%' then trim(substring(pole_7,5)) 
		when pole_7 is not null then pole_7
		else oi.full_name
	end as full_name
	,case when pole_8 is not null then pole_8 else noreg_org.noreg_inn end as inn
	,case when pole_9 is not null and pole_9::int = 1 then 1 else 2 end as org_tip
	,case when pole_40 is not null and length(pole_40) > 0 then pole_40 else oi.ur_address end as ur_address
	,case when pole_41 is not null then pole_41 else oi.phys_address end as phys_address
	,case when pole_42 is not null then pole_42 when r11.tel <> '9999' then r11.tel else null end as tel
	,case when pole_43 is not null and length(pole_43) > 0 then pole_43 when r11.mail <> '9999' then r11.mail else null end as mail
	,case when pole_44 is not null and length(pole_44) > 0 then pole_44 when r11.fax <> '9999' then r11.fax else null end as fax
	,case when pole_10 is not null then pole_10 else r11.okato_reg end as okato_reg
	,case when pole_11 is not null then pole_11 else r11.okato_fact end as okato_fact
	,case when pole_13 is not null and length(pole_13) = 11 then pole_13 else r11.oktmo_reg end as oktmo_reg
	,case when pole_14 is not null and length(pole_14) = 11 then pole_14 else r11.oktmo_fact end as oktmo_fact
	,case when pole_24 is not null then pole_24 else noreg_org.noreg_okogu end as okogu
	,case when pole_25 is not null then pole_25 else noreg_org.noreg_okfs end as okfs
	,case when pole_26 is not null then pole_26 else r11.okopf end as okopf
	,case when pole_27 is not null then pole_27 else noreg_org.noreg_ogrn end as ogrn
	,case when pole_21 is not null then pole_21 else r11.okved_main_reg end as okved_main_reg
	,okved_add.okved_add
	,case when pole_117 in ('1','2') or oi."1dop2018" = '1' then 1 else 0 end as "1dop_2015-2018" 
	,case when pole_118 in ('1','2') then 1 else 0 end as "1dop_2016"
	,case when pole_119 in ('1','2') then 1 else 0 end as "1dop_2017"
	,case when oi."1dop2018" in ('1') then 1 else 0 end as "1dop_2018"
	,case when included_in_registr = 1 then 1 else null end as lic_o 
	,case when included_in_registr = 1 then 1 else null end as lic_dop
	,case when oi.included_in_registr = 1 and lic_do is not null then lic_do when oi.included_in_registr = 2 then null else 0 end as lic_do
	,case when oi.included_in_registr = 1 and lic_no is not null then lic_no when oi.included_in_registr = 2 then null else 0 end as lic_no
	,case when oi.included_in_registr = 1 and lic_oo is not null then lic_oo when oi.included_in_registr = 2 then null else 0 end as lic_oo
	,case when oi.included_in_registr = 1 and lic_so is not null then lic_so when oi.included_in_registr = 2 then null else 0 end as lic_so
	,case when oi.included_in_registr = 1 and lic_spo is not null then lic_spo when oi.included_in_registr = 2 then null else 0 end as lic_spo
	,case when oi.included_in_registr = 1 and lic_vo_b is not null then lic_vo_b when oi.included_in_registr = 2 then null else 0 end as lic_vo_b
	,case when oi.included_in_registr = 1 and lic_vo_s is not null then lic_vo_s when oi.included_in_registr = 2 then null else 0 end as lic_vo_s
	,case when oi.included_in_registr = 1 and lic_vo_m is not null then lic_vo_m when oi.included_in_registr = 2 then null else 0 end as lic_vo_m
	,case when oi.included_in_registr = 1 and lic_vo_kvk is not null then lic_vo_kvk when oi.included_in_registr = 2 then null else 0 end as lic_vo_kvk
	,case when oi.included_in_registr = 1 and lic_po is not null then lic_po when oi.included_in_registr = 2 then null else 0 end as lic_po
	,case when oi.included_in_registr = 1 and lic_dpo is not null then lic_dpo when oi.included_in_registr = 2 then null else 0 end as lic_dpo
	,case when oi.included_in_registr = 1 and status_lic_o is not null then status_lic_o when oi.included_in_registr = 2 then null else null end as status_lic_o
	,case when oi.included_in_registr = 1 and status_lic_dop is not null then status_lic_dop when oi.included_in_registr = 2 then null else null end as status_lic_dop	
	,case when pole_74 is not null then pole_74 else noreg_org.noreg_predpr_type end as predpr_type
	,case when pole_78 is not null then pole_78 else r11.okved_main_fact end as okved_main_fact
	,okved_add_fact.okved_add_fact
	,case when is_dod = 1 and r2.str_n::int = 13 then r2.gr3 else null end as ped_rab
	,deti_dod
	,case 
		when s7.org_type_p21 is not null then s7.org_type_p21
		when included_in_registr = 1 and s7.org_type_p21 is null and r11.org_type::int = 1 then '01'
		when included_in_registr = 1 and s7.org_type_p21 is null and r11.org_type::int = 2 then '02'
		when included_in_registr = 1 and s7.org_type_p21 is null and r11.org_type::int = 3 then '03'
		when included_in_registr = 1 and s7.org_type_p21 is null and r11.org_type::int = 4 then '04'
		when included_in_registr = 1 and s7.org_type_p21 is null and r11.org_type::int = 5 then '05'
		when included_in_registr = 1 and s7.org_type_p21 is null and r11.org_type::int = 6 then '06'
		when included_in_registr = 1 and s7.org_type_p21 is null and r11.org_type::int in (7,8,9) then '07'
	end as org_type	
	,case 
		when included_in_registr = 1 and is_dod = 1 then 1
		when included_in_registr = 1 and is_dod = 0 then 0
	end as dop_dod
	,dop_ad
	,dop_dod_raz
	,dop_dod_is
	,dop_dod_fs
	,dop_dod_tn
	,dop_dod_en
	,dop_dod_fn
	,dop_dod_artn
	,dop_dod_turn
	,dop_dod_socn
	,case 
		when r11.org_sost::int = 2 then '01'
		when r11.org_sost::int = 1 then '02'
		when r11.org_sost::int = 3 then '03'
	end as org_sost
	,case 
		when r11.org_ovz::int = 1 then 11
		when r11.org_ovz::int = 2 then 12
		when r11.org_ovz::int = 3 then 13
		when r11.org_ovz::int = 4 then 20
	end as org_ovz
	,case when oi.included_in_registr = 1 and r2 is not null and dop_dod_adap_raz is not null then dop_dod_adap_raz when oi.included_in_registr = 2 or r2 is null then null else 0 end as dop_dod_adap_raz
	,case when oi.included_in_registr = 1 and r2 is not null and dop_dod_adap_is is not null then dop_dod_adap_is when oi.included_in_registr = 2 or r2 is null then null else 0 end as dop_dod_adap_is
	,case when oi.included_in_registr = 1 and r2 is not null and dop_dod_adap_fs is not null then dop_dod_adap_fs when oi.included_in_registr = 2 or r2 is null then null else 0 end as dop_dod_adap_fs	
	,case 	
		when r11.org_izm::int = 3 then 2
		when r11.org_izm::int = 1 then 1
	end as org_izm
	,case when ron_match.okpo_id is not null then 1 else 0 end as lic_ron	
	,case 
		when included_in_registr = 1 and is_dod = 1 then 1
		when included_in_registr = 1 and is_dod = 0 then 2
		when included_in_registr = 2 then 3
	end as included_in_fsn		
from 
	org_inf oi 
	left join statregistr7 s7 
		on oi.okpo = s7.pole_1 or oi.okpo = s7.pole_3
	left join razdel_1_1 r11 
		on oi.okpo = r11.okpo
--	left join razdel_1_2_2 r122
--		on oi.okpo = r122.okpo
--	left join razdel_1_2_1 r121
--		on oi.okpo = r121.okpo	
--	left join additional_okved aokv 
--		on aokv.okpo = oi.okpo
	left join okved_add_fact
		on okved_add_fact.okpo = oi.okpo
	left join okved_add
		on okved_add.okpo = oi.okpo
	--left join statreg7_ron_matched_edu_level ron_edu_lvl	
	--	on ron_edu_lvl.pole_1 = s7.pole_1
	left join statreg7_ron_matched ron_match 
		on ron_match.okpo_id = oi.okpo
	left join (select * from razdel_2 where str_n::int=13) r2 on r2.okpo = oi.okpo	
	left join deti_dod2 on deti_dod2.okpo = oi.okpo
	left join dop_ad on dop_ad.okpo = oi.okpo
	left join dop_dod_raz on dop_dod_raz.okpo = oi.okpo
	left join dop_dod_is on dop_dod_is.okpo = oi.okpo
	left join dop_dod_fs on dop_dod_fs.okpo = oi.okpo
	left join dop_dod_tn on dop_dod_tn.okpo = oi.okpo
	left join dop_dod_fn on dop_dod_fn.okpo = oi.okpo
	left join dop_dod_en on dop_dod_en.okpo = oi.okpo
	left join dop_dod_turn on dop_dod_turn.okpo = oi.okpo
	left join dop_dod_socn on dop_dod_socn.okpo = oi.okpo
	left join dop_dod_adap_raz on dop_dod_adap_raz.okpo = oi.okpo
	left join dop_dod_adap_is on dop_dod_adap_is.okpo = oi.okpo
	left join dop_dod_adap_fs on dop_dod_adap_fs.okpo = oi.okpo
	left join dop_dod_artn on dop_dod_artn.okpo = oi.okpo
	left join lic_do on oi.okpo = lic_do.okpo
	left join lic_no on oi.okpo = lic_no.okpo
	left join lic_oo on oi.okpo = lic_oo.okpo
	left join lic_so on oi.okpo = lic_so.okpo
	left join lic_spo on oi.okpo = lic_spo.okpo
	left join lic_vo_b on oi.okpo = lic_vo_b.okpo
	left join lic_vo_s on oi.okpo = lic_vo_s.okpo
	left join lic_vo_m on oi.okpo = lic_vo_m.okpo
	left join lic_vo_kvk on oi.okpo = lic_vo_kvk.okpo
	left join lic_po on oi.okpo = lic_po.okpo
	left join lic_dpo on oi.okpo = lic_dpo.okpo
	left join status_lic_o on oi.okpo = status_lic_o.okpo
	left join status_lic_dop on oi.okpo = status_lic_dop.okpo	
	left join noreg_org on oi.okpo = noreg_org.okpo
where included_in_registr in (1,2)		
)
select --*
dop_dod_adap_raz,count(*)
from registr 
group by dop_dod_adap_raz
--where left(short_name,5) like '%85-К%'

--where lic_ron = 0
--where included_in_fsn <> 3


--CREATE INDEX idx_ron_match_edu_okpo ON statreg7_ron_matched_edu_level(pole_1);
--CREATE INDEX idx_ron_match_edu_okpo ON statreg7_ron_matched_edu_level(pole_1);
--CREATE INDEX idx_registr_p1 ON statregistr7(pole_1);
--CREATE INDEX idx_registr_p3 ON statregistr7(pole_3);
--CREATE INDEX idx_ron_p1 ON statreg7_ron_matched(pole_1);
--CREATE INDEX idx_ron_okpo_1 ON statreg7_ron_matched(okpo_id);
--CREATE INDEX idx_ron_edu_okpo_1d ON statreg7_ron_matched_edu_level(okpo_id);
--CREATE INDEX idx_ron_edu_p1 ON statreg7_ron_matched_edu_level(pole_1);
--CREATE INDEX idx_ron_oi_okpo ON org_inf(okpo);


--alter table org_inf ALTER COLUMN included_in_registr type integer using included_in_registr::int
--alter table org_inf ALTER COLUMN is_dod type integer using is_dod::int
--alter table razdel_2 ALTER COLUMN str_n type integer using str_n::int
--alter table razdel_1_2_2 ALTER COLUMN str_n type integer using str_n::int
--alter table razdel_1_2_1 ALTER COLUMN str_n type integer using str_n::int
--alter table razdel_2 ALTER COLUMN gr3 type numeric using gr3::numeric
--
--
--update statregistr7
--set pole_1 = trim(pole_1)
--where pole_1=pole_1
--	
--
--update statregistr7
--set pole_3 = trim(pole_3)
--where pole_3=pole_3



--drop table statregistr7 cascade
--DROP MATERIALIZED VIEW statregistr.status_lic_o;

select dop_dod_adap_fs,count(okpo) from dop_dod_adap_fs
group by dop_dod_adap_fs

select count(okpo) from dop_dod_adap_fs
where dop_dod_adap_fs is null


select count(distinct okpo) from razdel_2 r

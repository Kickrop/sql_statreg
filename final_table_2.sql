--select *
--from statregistr7 s
--where --pole_10 is null
--length(pole_26) < 5
--
--select * from org_inf oi where okpo = '08741405030002'
--drop materialized view statregistr.registr
create materialized view statregistr.registr as
--version 2
with registr as (
select 
	case when s7.pole_1 is not null then s7.pole_1 else oi.okpo end as kod_okpo
	--s7.pole_1
	,case when pole_3 is not null then pole_3 else oi.okpo end as id_n --2
	,oi.okpo as okpo --3
	,case when pole_2 is not null and length(pole_2) = 8 then pole_2 else left(oi.okpo,8) end as okpo_head 
	,case when pole_6 is not null then pole_6 else oi.short_name end as short_name 
	,case when pole_7 is not null then pole_7 else oi.full_name end as full_name
	--,pole_8 as inn 
	,case when pole_8 is not null then pole_8 else noreg_org.noreg_inn end as inn
	,case when pole_9 is not null and pole_9::int = 1 then 1 else 2 end as org_tip
	,case when pole_40 is not null and length(pole_40) > 0 then pole_40 else oi.ur_address end as ur_address
	,case when pole_41 is not null then pole_41 else oi.phys_address end as phys_address
	,case when pole_42 is not null then pole_42 else r11.tel end as tel
	,case when pole_43 is not null and length(pole_43) > 0 then pole_43 else r11.mail end as mail
	,case when pole_44 is not null and length(pole_44) > 0 then pole_44 else r11.fax end as fax
	,case when pole_10 is not null then pole_10 else r11.okato_reg end as okato_reg
	,case when pole_13 is not null and length(pole_13) = 11 then pole_13 else r11.oktmo_reg end as oktmo_reg
	,case when pole_14 is not null and length(pole_14) = 11 then pole_14 else r11.oktmo_fact end as oktmo_fact
	--,pole_24 as okogu 
	,case when pole_24 is not null then pole_24 else noreg_org.noreg_okogu end as okogu
	--,pole_25 as okfs 
	,case when pole_25 is not null then pole_25 else noreg_org.noreg_okfs end as okfs
	,case when pole_26 is not null then pole_26 else r11.okopf end as okopf
	--,pole_27 as ogrn
	,case when pole_27 is not null then pole_27 else noreg_org.noreg_ogrn end as ogrn
	,case when pole_21 is not null then pole_21 else r11.okved_main_reg end as okved_main_reg
	,okved_add.okved_add
	,case when pole_116 in ('1','2') then 1 else 0 end as "1dop_2015-2018" 
	,case when pole_117 in ('1','2') then 1 else 0 end as "1dop_2016"
	,case when pole_118 in ('1','2') then 1 else 0 end as "1dop_2017"
	,case when pole_119 in ('1','2') then 1 else 0 end as "1dop_2018"
	,case when included_in_registr = 1 then 1 else null end as lic_o --уточнить чем отличается
	,case when included_in_registr = 1 then 1 else null end as lic_dop
--	,case 
--		when included_in_registr = 1 and r122.str_n = 2 and r122.gr3::int=1 and r122.gr4::int<>2 then 1 
--		when r122.okpo is null and included_in_registr = 1 and edu_level in ('Дошкольное образование','Дополнительное дошкольное образование') and license_status <> 'Не действует' then 1
--		when included_in_registr = 2 then null
--		else 0
--	end as lic_do --проверить
	,lic_do.lic_do
--	,case 
--		when included_in_registr = 1 and r122.str_n = 3 and r122.gr3::int=1 and r122.gr4::int<>2 then 1 
--		when r122.okpo is null and included_in_registr = 1 and edu_level in ('Начальное общее образование') and license_status <> 'Не действует' then 1
--		when included_in_registr = 2 then null
--		else 0
--	end as lic_no --проверить
	,lic_no.lic_no
--	,case 
--		when included_in_registr = 1 and r122.str_n = 4 and r122.gr3::int=1 and r122.gr4::int<>2 then 1 
--		when r122.okpo is null and included_in_registr = 1 and edu_level in ('Основное общее образование','Дополнительное основное общее образование') and license_status <> 'Не действует' then 1
--		when included_in_registr = 2 then null
--		else 0
--	end as lic_oo --проверить
	,lic_oo
--	,case 
--		when included_in_registr = 1 and r122.str_n = 5 and r122.gr3::int=1 and r122.gr4::int<>2 then 1 
--		when r122.okpo is null and included_in_registr = 1 and edu_level in ('Среднее общее образование','Среднее (полное) общее образование') and license_status <> 'Не действует' then 1
--		when included_in_registr = 2 then null
--		else 0
--	end as lic_so --проверить
	,lic_so
--	,case 
--		when included_in_registr = 1 and r122.str_n = 6 and r122.gr3::int=1 and r122.gr4::int<>2 then 1 
--		when r122.okpo is null and included_in_registr = 1 and edu_level in ('Среднее профессиональное образование','Начальное профессиональное образование') and license_status <> 'Не действует' then 1
--		when included_in_registr = 2 then null
--		else 0
--	end as lic_spo --проверить
	,lic_spo
--	,case 
--		when included_in_registr = 1 and r122.str_n = 7 and r122.gr3::int=1 and r122.gr4::int<>2 then 1 
--		when r122.okpo is null and included_in_registr = 1 and edu_level in ('ВО - Бакалавриат','Высшее образование - бакалавриат') and license_status <> 'Не действует' then 1
--		when included_in_registr = 2 then null
--		else 0
--	end as lic_vo_b --проверить
	,lic_vo_b
--	,case 
--		when included_in_registr = 1 and r122.str_n = 8 and r122.gr3::int=1 and r122.gr4::int<>2 then 1 
--		when r122.okpo is null and included_in_registr = 1 and edu_level in ('ВО - Специалитет','Высшее образование - специалитет') and license_status <> 'Не действует' then 1
--		when included_in_registr = 2 then null
--		else 0
--	end as lic_vo_s --проверить	
	,lic_vo_s
--	,case 
--		when included_in_registr = 1 and r122.str_n = 9 and r122.gr3::int=1 and r122.gr4::int<>2 then 1 
--		when r122.okpo is null and included_in_registr = 1 and edu_level in ('ВО - Магистратура','Высшее образование - магистратура') and license_status <> 'Не действует' then 1
--		when included_in_registr = 2 then null
--		else 0
--	end as lic_vo_m --проверить	
	,lic_vo_m
--	,case 
--		when included_in_registr = 1 and r122.str_n = 10 and r122.gr3::int=1 and r122.gr4::int<>2 then 1 
--		when r122.okpo is null and included_in_registr = 1 and edu_level in ('ВО - ПКВК','ВО - подготовка кадров высшей квалификации','Послевузовское профессиональное образование') and license_status <> 'Не действует' then 1
--		when included_in_registr = 2 then null
--		else 0
--	end as lic_vo_kvk --проверить		
	,lic_vo_kvk	
--	,case 
--		when included_in_registr = 1 and r122.str_n = 11 and r122.gr3::int=1 and r122.gr4::int<>2 then 1 
--		when r122.okpo is null and included_in_registr = 1 and edu_level in ('Профессиональное обучение','Профессиональная подготовка','Программа профессиональной подготовки') and license_status <> 'Не действует' then 1
--		when included_in_registr = 2 then null
--		else 0
--	end as lic_po
	,lic_po	
--	,case 
--		when included_in_registr = 1 and r122.str_n = 12 and r122.gr3::int=1 and r122.gr4::int<>2 then 1 
--		when r122.okpo is null and included_in_registr = 1 and lower(edu_level) in ('дополнительное профессиональное образование','дополнительное к начальному и среднему профессиональному образованию','дополнительное к начальному, среднему и высшему профессиональному образованию','дополнительное к среднему и высшему профессиональному образованию','дополнительное к среднему профессиональному образованию') and license_status <> 'Не действует' then 1
--		when included_in_registr = 2 then null
--		else 0
--	end as lic_dpo
	,lic_dpo
--	,case 
--		when included_in_registr = 1 and r121.str_n = 1 and r121.gr6::int=1 then 1
--		when included_in_registr = 1 and r121.str_n = 1 and r121.gr6::int=3 then 2 
--		when included_in_registr = 1 and r121.str_n = 1 and r121.gr3::int <> 1 and r121.gr7::int = 1 then 3 
--		when r121.okpo is null and included_in_registr = 1 and license_status in ('Действует','Действующее') then 1
--		when r121.okpo is null and included_in_registr = 1 and license_status in ('Приостановлено','Приостановлена в части филиалов') then 2
--		when r121.okpo is null and included_in_registr = 1 and license_status in ('Проект') then 3
--		--when included_in_registr = 2 then null
--		else null
--	end as lic_o
	,status_lic_o
--	,case 
--		when included_in_registr = 1 and r122.str_n = 1 and r122.gr4::int = 1 then 1
--		when included_in_registr = 1 and r122.str_n = 1 and r122.gr4::int in (3,4) then 2
--		when included_in_registr = 1 and r122.str_n = 1 and r122.gr5::int = 1 and r122.gr3::int <> 1 then 3
--		when r122.okpo is null and included_in_registr = 1 and edu_level in ('Дополнительное образование детей и взрослых','Дополнительное образование') and license_status in ('Действует','Действующее') then 1
--		when r122.okpo is null and included_in_registr = 1 and edu_level in ('Дополнительное образование детей и взрослых','Дополнительное образование') and license_status in ('Приостановлено','Приостановлена в части филиалов') then 2
--		when r122.okpo is null and included_in_registr = 1 and edu_level in ('Дополнительное образование детей и взрослых','Дополнительное образование') and license_status in ('Проект') then 3
--		--when included_in_registr = 2 then null
--		else null
--	end as status_lic_dop
	,status_lic_dop
	--,pole_74 as predpr_type
	,case when pole_74 is not null then pole_74 else noreg_org.noreg_predpr_type end as predpr_type
	,case when pole_78 is not null then pole_78 else r11.okved_main_fact end as okved_main_fact
--	,case 
--			when pole_79 is not null and pole_79 like '%85.41%' then '85.41' 
--			when aokv.str_n::int = 4 and gr4_okved_add like '%85.41%' then '85.41'
--	end as okved_add_fact
	,okved_add_fact.okved_add_fact
	,case when is_dod = 1 and r2.str_n::int = 13 then r2.gr3 else null end as ped_rab
--	,case 
--		when is_dod = 1 and r2.str_n::int = 1 and (r2.gr3::int = 0 or r2.gr3 is null) then max_gr3 
--		when is_dod = 1 and r2.str_n::int = 1 and r2.gr3 > 0 then r2.gr3
--	end as deti_dod
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
--	,case 
--		when included_in_registr = 1 and r2.str_n::int = 11 and r2.gr3::int > 0 then 1 
--		when included_in_registr = 1 and r2.str_n::int = 11 and r2.gr3::int <= 0 then 0 
--		when included_in_registr = 2 then null
--	end as dop_ad
	,dop_ad
--	,case 
--		when included_in_registr = 1 and r2.str_n::int = 2 and r2.gr3::int > 0 then 1
--		when included_in_registr = 1 and r2.str_n::int = 2 and r2.gr3::int <= 0 then 0
--		when included_in_registr = 2 then null
--	end as dop_dod_raz
	,dop_dod_raz
--	,case 
--		when included_in_registr = 1 and r2.str_n::int = 3 and r2.gr3::int > 0 then 1
--		when included_in_registr = 1 and r2.str_n::int = 3 and r2.gr3::int <= 0 then 0
--		when included_in_registr = 2 then null
--	end as dop_dod_is
	,dop_dod_is
--	,case 
--		when included_in_registr = 1 and r2.str_n::int = 4 and r2.gr3::int > 0 then 1
--		when included_in_registr = 1 and r2.str_n::int = 4 and r2.gr3::int <= 0 then 0
--		when included_in_registr = 2 then null
--	end as dop_dod_fs
	,dop_dod_fs
--	,case 
--		when included_in_registr = 1 and r2.str_n::int = 5 and r2.gr3::int > 0 then 1
--		when included_in_registr = 1 and r2.str_n::int = 5 and r2.gr3::int <= 0 then 0
--		when included_in_registr = 2 then null
--	end as dop_dod_tn
	,dop_dod_tn
--	,case 
--		when included_in_registr = 1 and r2.str_n::int = 6 and r2.gr3::int > 0 then 1
--		when included_in_registr = 1 and r2.str_n::int = 6 and r2.gr3::int <= 0 then 0
--		when included_in_registr = 2 then null
--	end as dop_dod_en
	,dop_dod_en
--	,case 
--		when included_in_registr = 1 and r2.str_n::int = 7 and r2.gr3::int > 0 then 1
--		when included_in_registr = 1 and r2.str_n::int = 7 and r2.gr3::int <= 0 then 0
--		when included_in_registr = 2 then null
--	end as dop_dod_fn
	,dop_dod_fn
--	,case 
--		when included_in_registr = 1 and r2.str_n::int = 8 and r2.gr3::int > 0 then 1
--		when included_in_registr = 1 and r2.str_n::int = 8 and r2.gr3::int <= 0 then 0
--		when included_in_registr = 2 then null
--	end as dop_dod_artn
	,dop_dod_artn
--	,case 
--		when included_in_registr = 1 and r2.str_n::int = 9 and r2.gr3::int > 0 then 1
--		when included_in_registr = 1 and r2.str_n::int = 9 and r2.gr3::int <= 0 then 0
--		when included_in_registr = 2 then null
--	end as dop_dod_turn
	,dop_dod_turn
--	,case 
--		when included_in_registr = 1 and r2.str_n::int = 10 and r2.gr3::int > 0 then 1
--		when included_in_registr = 1 and r2.str_n::int = 10 and r2.gr3::int <= 0 then 0
--		when included_in_registr = 2 then null
--	end as dop_dod_socn
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
--	,case 
--		when included_in_registr = 1 and is_dod = 1 and r11.org_ovz::int in (1,2,3) and r2.str_n::int = 2 and r2.gr6::int > 0 then 1
--		when included_in_registr = 1 and is_dod = 1 and r11.org_ovz::int not in (1,2,3) and r2.str_n::int = 2 and r2.gr6::int = 0 then 0
--		when included_in_registr = 2 then null
--	end as dop_dod_adap_raz	
	,dop_dod_adap_raz
--	,case 
--		when included_in_registr = 1 and is_dod = 1 and r11.org_ovz::int in (1,2,3) and r2.str_n::int = 3 and r2.gr6::int > 0 then 1
--		when included_in_registr = 1 and is_dod = 1 and r11.org_ovz::int not in (1,2,3) and r2.str_n::int = 3 and r2.gr6::int = 0 then 0
--		when included_in_registr = 2 then null
--	end as dop_dod_adap_is
	,dop_dod_adap_is
--	,case 
--		when included_in_registr = 1 and is_dod = 1 and r11.org_ovz::int in (1,2,3) and r2.str_n::int = 4 and r2.gr6::int > 0 then 1
--		when included_in_registr = 1 and is_dod = 1 and r11.org_ovz::int not in (1,2,3) and r2.str_n::int = 4 and r2.gr6::int = 0 then 0
--		when included_in_registr = 2 then null
--	end as dop_dod_adap_fs	
	,dop_dod_adap_fs
	,case 
		when r11.org_izm::int = 1 then 1
		when r11.org_izm::int = 2 then 3
	end as org_izm
	,case when ron_match.pole_1 is not null then 1 else 0 end as lic_ron	
	,case 
		when included_in_registr = 1 and is_dod = 1 then 1
		when included_in_registr = 1 and is_dod = 0 then 2
		when included_in_registr = 2 then 3
	end as included_in_fsn		
--select count(distinct oi.okpo)	
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
		on ron_match.pole_1 = s7.pole_1
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
select * from registr 
--where included_in_fsn <> 3


--CREATE INDEX idx_ron_match_edu_okpo ON statreg7_ron_matched_edu_level(pole_1);

--select count(*)
--from 
--	org_inf oi 
--	join statregistr7 s7 
--		on oi.okpo = s7.pole_1 or oi.okpo = s7.pole_3
--		where included_in_registr = 1
--		
--select count(*)
--from 
--	org_inf oi 
--	--join statregistr7 s7 
--	--	on oi.okpo = s7.pole_1 or oi.okpo = s7.pole_3
--		where okpo not in 
--		(select --pole_1
--			case when pole_9 = '1' then pole_1 else pole_3 end
--		from statregistr7 s7 
--		)
--and included_in_registr = 1		
--


		
--select count(*) from 
--(select pole_1 from statregistr7
--where pole_1 not in (select okpo from razdel_1_2_2) --or okpo not in (select pole_3 from statregistr7)
--) x


--select distinct edu_level
--from statreg7_ron_matched_edu_level
--order by edu_level
--
--select distinct license_status
--from statreg7_ron_matched
--order by license_status
--
--select distinct org_type
--from razdel_1_1 r
--order by org_type
--
--create materialized view deti_dod as 
--with deti_dod as (
--select 
--	r2.okpo,
--	greatest(sum(case when str_n in (2,3,4) then gr3 else 0 end) --gr3_2_4
--	,sum(case when str_n in (5,6,7,8,9,10) then gr3 else 0 end)) max_gr3
--from razdel_2 r2
--join org_inf oi on oi.okpo=r2.okpo
--where r2.okpo in (select 
--		r2.okpo
--		from razdel_2 r2
--		join org_inf oi on oi.okpo=r2.okpo
--		where is_dod = 1 and r2.str_n::int = 1 and (r2.gr3::int = 0 or r2.gr3 is null))
--group by r2.okpo
--)
--select * from deti_dod
--where max_gr3 > 0

--select length(pole_43)
--from statregistr7 s
--where pole_43 is not null
--order by length desc
--
--select pole_43
--from statregistr7 s




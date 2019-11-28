with registr as (
select 
	case when s7.pole_1 is not null then s7.pole_1 else oi.okpo end as kod_okpo --1
	,case when pole_3 is not null then pole_3 else oi.okpo end as id_n --2
	,oi.okpo as okpo --3
	,case when pole_2 is not null then pole_2 else left(oi.okpo,8) end as okpo_head 
	,case when pole_6 is not null then pole_6 else oi.short_name end as short_name 
	,case when pole_7 is not null then pole_7 else oi.full_name end as full_name
	,pole_8 as inn --доработать
	,case when pole_7 is not null then pole_7 else oi.full_name end as org_tip
	,case when pole_40 is not null then pole_40 else oi.ur_address end as ur_address
	,case when pole_41 is not null then pole_41 else oi.phys_address end as phys_address
	,case when pole_42 is not null then pole_42 else r11.tel end as tel
	,case when pole_43 is not null then pole_43 else r11.mail end as mail
	,case when pole_44 is not null then pole_44 else r11.fax end as fax
	,case when pole_10 is not null then pole_10 else r11.okato_reg end as okato_reg
	,case when pole_13 is not null then pole_13 else r11.oktmo_reg end as oktmo_reg
	,case when pole_14 is not null then pole_14 else r11.oktmo_fact end as oktmo_fact
	,pole_24 as okogu --доработать
	,pole_25 as okfs --доработать
	,case when pole_26 is not null then pole_26 else r11.okopf end as okopf
	,pole_27 as ogrn --доработать
	,case when pole_21 is not null then pole_21 else r11.okved_main_reg end as okved_main_reg
	,case 
			when pole_22 is not null and pole_22 like '%85.41%' then pole_22 
			when aokv.str_n::int = 2 and gr4_okved_add like '%85.41%' then '85.41' --Доработать
	end as okved_add
	,case when pole_116 in ('1','2') or pole_117 in ('1','2') or pole_118 in ('1','2') or pole_119 in ('1','2') then 1 else 0 end as "1dop_2015-2018" --проверить
	,case when pole_117 in ('1','2') then 1 else 0 end as "1dop_2016"
	,case when pole_118 in ('1','2') then 1 else 0 end as "1dop_2017"
	,case when pole_119 in ('1','2') then 1 else 0 end as "1dop_2018"
	,case when included_in_registr = 1 then 1 else null end as lic_o --уточнить чем отличается
	,case when included_in_registr = 1 then 1 else null end as lic_dop
	,case 
		when included_in_registr = 1 and r122.str_n = 2 and r122.gr3::int=1 and r122.gr4::int<>2 then 1 
		when r122.okpo is null and included_in_registr = 1 and edu_level in ('Дошкольное образование','Дополнительное дошкольное образование') and license_status <> 'Не действует' then 1
		when included_in_registr = 2 then null
		else 0
	end as lic_do --проверить
	,case 
		when included_in_registr = 1 and r122.str_n = 3 and r122.gr3::int=1 and r122.gr4::int<>2 then 1 
		when r122.okpo is null and included_in_registr = 1 and edu_level in ('Начальное общее образование') and license_status <> 'Не действует' then 1
		when included_in_registr = 2 then null
		else 0
	end as lic_no --проверить
	,case 
		when included_in_registr = 1 and r122.str_n = 4 and r122.gr3::int=1 and r122.gr4::int<>2 then 1 
		when r122.okpo is null and included_in_registr = 1 and edu_level in ('Основное общее образование','Дополнительное основное общее образование') and license_status <> 'Не действует' then 1
		when included_in_registr = 2 then null
		else 0
	end as lic_oo --проверить
	,case 
		when included_in_registr = 1 and r122.str_n = 5 and r122.gr3::int=1 and r122.gr4::int<>2 then 1 
		when r122.okpo is null and included_in_registr = 1 and edu_level in ('Среднее общее образование','Среднее (полное) общее образование') and license_status <> 'Не действует' then 1
		when included_in_registr = 2 then null
		else 0
	end as lic_so --проверить
	,case 
		when included_in_registr = 1 and r122.str_n = 6 and r122.gr3::int=1 and r122.gr4::int<>2 then 1 
		when r122.okpo is null and included_in_registr = 1 and edu_level in ('Среднее профессиональное образование','Начальное профессиональное образование') and license_status <> 'Не действует' then 1
		when included_in_registr = 2 then null
		else 0
	end as lic_spo --проверить
	,case 
		when included_in_registr = 1 and r122.str_n = 7 and r122.gr3::int=1 and r122.gr4::int<>2 then 1 
		when r122.okpo is null and included_in_registr = 1 and edu_level in ('ВО - Бакалавриат','Высшее образование - бакалавриат') and license_status <> 'Не действует' then 1
		when included_in_registr = 2 then null
		else 0
	end as lic_vo_b --проверить
	,case 
		when included_in_registr = 1 and r122.str_n = 8 and r122.gr3::int=1 and r122.gr4::int<>2 then 1 
		when r122.okpo is null and included_in_registr = 1 and edu_level in ('ВО - Специалитет','Высшее образование - специалитет') and license_status <> 'Не действует' then 1
		when included_in_registr = 2 then null
		else 0
	end as lic_vo_s --проверить	
	,case 
		when included_in_registr = 1 and r122.str_n = 9 and r122.gr3::int=1 and r122.gr4::int<>2 then 1 
		when r122.okpo is null and included_in_registr = 1 and edu_level in ('ВО - Магистратура','Высшее образование - магистратура') and license_status <> 'Не действует' then 1
		when included_in_registr = 2 then null
		else 0
	end as lic_vo_m --проверить	
	,case 
		when included_in_registr = 1 and r122.str_n = 10 and r122.gr3::int=1 and r122.gr4::int<>2 then 1 
		when r122.okpo is null and included_in_registr = 1 and edu_level in ('ВО - ПКВК','ВО - подготовка кадров высшей квалификации','Послевузовское профессиональное образование') and license_status <> 'Не действует' then 1
		when included_in_registr = 2 then null
		else 0
	end as lic_vo_kvk --проверить			
	,case 
		when included_in_registr = 1 and r122.str_n = 11 and r122.gr3::int=1 and r122.gr4::int<>2 then 1 
		when r122.okpo is null and included_in_registr = 1 and edu_level in ('Профессиональное обучение','Профессиональная подготовка','Программа профессиональной подготовки') and license_status <> 'Не действует' then 1
		when included_in_registr = 2 then null
		else 0
	end as lic_po	
	,case 
		when included_in_registr = 1 and r122.str_n = 12 and r122.gr3::int=1 and r122.gr4::int<>2 then 1 
		when r122.okpo is null and included_in_registr = 1 and lower(edu_level) in ('дополнительное профессиональное образование','дополнительное к начальному и среднему профессиональному образованию','дополнительное к начальному, среднему и высшему профессиональному образованию','дополнительное к среднему и высшему профессиональному образованию','дополнительное к среднему профессиональному образованию') and license_status <> 'Не действует' then 1
		when included_in_registr = 2 then null
		else 0
	end as lic_dpo
	,case 
		when included_in_registr = 1 and r121.str_n = 1 and r121.gr6::int=1 then 1
		when included_in_registr = 1 and r121.str_n = 1 and r121.gr6::int=3 then 2 
		when included_in_registr = 1 and r121.str_n = 1 and r121.gr3::int <> 1 and r121.gr7::int = 1 then 3 
		when r121.okpo is null and included_in_registr = 1 and license_status in ('Действует','Действующее') then 1
		when r121.okpo is null and included_in_registr = 1 and license_status in ('Приостановлено','Приостановлена в части филиалов') then 2
		when r121.okpo is null and included_in_registr = 1 and license_status in ('Проект') then 3
		--when included_in_registr = 2 then null
		else null
	end as lic_o
	,case 
		when included_in_registr = 1 and r122.str_n = 1 and r122.gr4::int = 1 then 1
		when included_in_registr = 1 and r122.str_n = 1 and r122.gr4::int in (3,4) then 2
		when included_in_registr = 1 and r122.str_n = 1 and r122.gr5::int = 1 and r122.gr3::int <> 1 then 3
		when r122.okpo is null and included_in_registr = 1 and edu_level in ('Дополнительное образование детей и взрослых','Дополнительное образование') and license_status in ('Действует','Действующее') then 1
		when r122.okpo is null and included_in_registr = 1 and edu_level in ('Дополнительное образование детей и взрослых','Дополнительное образование') and license_status in ('Приостановлено','Приостановлена в части филиалов') then 2
		when r122.okpo is null and included_in_registr = 1 and edu_level in ('Дополнительное образование детей и взрослых','Дополнительное образование') and license_status in ('Проект') then 3
		--when included_in_registr = 2 then null
		else null
	end as status_lic_dop
	,pole_74 as predpr_type
	,case when pole_78 is not null then pole_78 else r11.okved_main_fact end as okved_main_fact
	,case 
			when pole_79 is not null and pole_79 like '%85.41%' then pole_79 
			when aokv.str_n::int = 4 and gr4_okved_add like '%85.41%' then '85.41' --Доработать
	end as okved_add_fact
	,case when is_dod = 1 and r2.str_n::int = 13 then r2.gr3 else null end as ped_rab
	,case 
		when is_dod = 1 and r2.str_n::int = 1 and (r2.gr3::int = 0 or r2.gr3 is null) then max_gr3 --else null 
		when is_dod = 1 and r2.str_n::int = 1 and r2.gr3 > 0 then r2.gr3
	end as deti_dod --уточнить про максимум
	,case 
		when included_in_registr is null then s7.org_type_p21
		when included_in_registr = 1 and r11.org_type::int = 1 then '01'
		when included_in_registr = 1 and r11.org_type::int = 2 then '02'
		when included_in_registr = 1 and r11.org_type::int = 3 then '03'
		when included_in_registr = 1 and r11.org_type::int = 4 then '04'
		when included_in_registr = 1 and r11.org_type::int = 5 then '05'
		when included_in_registr = 1 and r11.org_type::int = 6 then '06'
		when included_in_registr = 1 and r11.org_type::int in (7,8,9) then '07'
	end as org_type	
	,case 
		when included_in_registr = 1 and is_dod = 1 then 1
		when included_in_registr = 1 and is_dod = 0 then 0
	end as dop_dod
	,case when included_in_registr = 1 and r2.str_n::int = 11 and r2.gr3::int > 0 then 1 end as dop_ad
	,case when included_in_registr = 1 and r2.str_n::int = 2 and r2.gr3::int > 0 then 1 end as dop_dod_raz	--сумма по все строкам гр3?
from 
	org_inf oi 
	join statregistr7 s7 
		on oi.okpo = s7.pole_1 or oi.okpo = s7.pole_3
	full join razdel_1_1 r11 
		on oi.okpo = r11.okpo
	full join razdel_1_2_2 r122
		on oi.okpo = r122.okpo
	full join razdel_1_2_1 r121
		on oi.okpo = r121.okpo	
	join additional_okved aokv 
		on aokv.okpo = oi.okpo
	full join statreg7_ron_matched_edu_level ron_edu_lvl	
		on ron_edu_lvl.pole_1 = s7.pole_1
	full join statreg7_ron_matched ron_match 
		on ron_match.pole_1 = s7.pole_1
	left join razdel_2 r2 on r2.okpo = oi.okpo	
	left join deti_dod on deti_dod.okpo = r2.okpo
	
where included_in_registr in (1,2)		
)
select count(*) from registr 


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
--		where okpo  in 
--		(select --pole_1
--			case when pole_9 = '1' then pole_1 else pole_3 end
--		from statregistr7 s7 
--		)
--and included_in_registr = 1		
		
		
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




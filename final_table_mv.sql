--okved_add_fact
drop materialized view okved_add_fact
create materialized view okved_add_fact as
select * from (
select 
	oi.okpo
	,case 
			when pole_79 is not null and pole_79 like '%85.41%' then '85.41' 
			when gr4_okved_add::text like '%85.41%' then '85.41'
	end as okved_add_fact
from org_inf oi
join statregistr7 s7 on oi.okpo = s7.pole_1 or oi.okpo = s7.pole_3
left join razdel_1_1 r11 
		on oi.okpo = r11.okpo
left join 
	(
	select okpo,array_agg(gr4_okved_add) as gr4_okved_add 
	from additional_okved
	where str_n::int=4
	group by okpo
	) as aokv 
		on aokv.okpo = oi.okpo	
) x
where okved_add_fact is not null

--okved_add
drop materialized view okved_add
create materialized view okved_add as
select * from (
select 
	oi.okpo
	,case 
			when pole_22 like '%85.41%' then '85.41' 
			when gr4_okved_add::text like '%85.41%' then '85.41'
	end as okved_add
from org_inf oi
join statregistr7 s7 on oi.okpo = s7.pole_1 or oi.okpo = s7.pole_3
left join razdel_1_1 r11 
		on oi.okpo = r11.okpo
left join 
	(
	select okpo,array_agg(gr4_okved_add) as gr4_okved_add 
	from additional_okved
	where str_n::int=2
	group by okpo
	) as aokv 
		on aokv.okpo = oi.okpo	
) x
where okved_add is not null
--
select lic_ron,count(*)
from registr
where registr.included_in_fsn in (3)
group by lic_ron
--select count(distinct pole_1)
--from statreg7_ron_matched_edu_level
--drop materialized view registr
--statreg7_ron_matched_edu_level lic_do
drop materialized view lic_do--!!
create materialized view lic_do as
--
with pam as (
select --* --count(org_inf.okpo)
	org_inf.okpo
	,case 
		--when r122.okpo is not null and included_in_registr = 1 and r122.str_n::int = 2 and r122.gr3::int=1 and r122.gr4::int<>2 then 1
		
		--when r122.okpo is null and included_in_registr = 1 and (edu_level like '%Дошкольное образование%' or edu_level like '%Дополнительное дошкольное образование%') and license_status not like '%Не действует%' then 1
		when included_in_registr = 2 then null
		when (r122.okpo is not null and included_in_registr = 1 and r122.str_n::int = 2 and r122.gr3::int=1 and r122.gr4::int<>2) then 1--or	
		when r122.okpo is null and ((edu_level like '%Дошкольное образование%' or edu_level like '%Дополнительное дошкольное образование%') and license_status not like '%Не действует%') then 1
		--when included_in_registr = 2 then null

	end as lic_do 
from org_inf 
	left join razdel_1_2_2 r122
		on org_inf.okpo = r122.okpo
	left join statreg7_ron_matched 
		on statreg7_ron_matched.okpo_id = org_inf.okpo or statreg7_ron_matched.pole_1 = org_inf.okpo
	left join 
	(
		select okpo_id,array_agg(edu_level)::text as edu_level 
		from statreg7_ron_matched_edu_level
		group by okpo_id
	) as aokv 
		on aokv.okpo_id = statreg7_ron_matched.okpo_id
--where r122.str_n::int = 2 and included_in_registr in (1,2)
)
SELECT --lic_do, count(distinct okpo)
	distinct okpo, lic_do --count(distinct okpo) --
from pam
where lic_do is not null 
--group by lic_do
--full join query_lic_do_accb on pam.okpo=query_lic_do_accb.﻿okpo
--where lic_do is not null and okpo not in (select * from query_lic_do_accb) --(pam.okpo is null or query_lic_do_accb.﻿okpo is null)

select d --count(distinct ﻿okpo)
from query_lic_do_accb
where ﻿okpo not in (select okpo from lic_do)

select *
from razdel_1_2_2 r
where r.okpo = '00792969'

--try
with pam as (
select --* --count(org_inf.okpo)
	org_inf.okpo
	,case 
		when r122.okpo is not null and included_in_registr = 1 and r122.str_n::int = 2 and r122.gr3::int=1 and r122.gr4::int<>2 then 1
		--when r122.okpo is not null and included_in_registr = 1 and r122.str_n = 2 and (r122.gr3::int<>1 and r122.gr4::int=2) then 0 
		when r122.okpo is null and included_in_registr = 1 and (edu_level like '%Дошкольное образование%' or edu_level like '%Дополнительное дошкольное образование%') and license_status not like '%Не действует%' then 1
		--when r122.okpo is null and included_in_registr = 1 and edu_level::text not in ('Дошкольное образование','Дополнительное дошкольное образование') and license_status = 'Не действует' then 0
		--when included_in_registr = 2 then null
		--else 0
	end as lic_do 
from org_inf 
	left join razdel_1_2_2 r122
		on org_inf.okpo = r122.okpo
	left join statreg7_ron_matched 
		on statreg7_ron_matched.okpo_id = org_inf.okpo or statreg7_ron_matched.pole_1 = org_inf.okpo
	left join 
	(
--		select okpo_id,array_agg(edu_level)::text as edu_level 
--		from statreg7_ron_matched_edu_level
--		group by okpo_id
		select *
		from statreg7_ron_matched_edu_level
	) as aokv 
		on aokv.okpo_id = statreg7_ron_matched.okpo_id
--where r122.str_n::int = 2 and included_in_registr in (1,2)
)
SELECT * --distinct okpo --okpo, lic_do
from pam
where lic_do is not null

select * 
from razdel_1_2_2
where okpo = '43450431'


select count(*)
from org_inf
left join razdel_1_2_2 r122
		on org_inf.okpo = r122.okpo 
where included_in_registr = 1 and r122.str_n::int = 2 and r122.gr3::int=1 and r122.gr4::int<>2		

--from statreg7_ron_matched
--join statreg7_ron_matched_edu_level on statreg7_ron_matched_edu_level.okpo_id=statreg7_ron_matched.okpo_id
--left join (select org_inf.okpo from razdel_1_2_2 join org_inf on org_inf.okpo=razdel_1_2_2.okpo) rr on rr.okpo=statreg7_ron_matched.okpo_id
--where rr.okpo is null
--and (edu_level like '%Дошкольное образование%' or edu_level like '%Дополнительное дошкольное образование%') and license_status not like '%Не действует%'
select count(org_inf.okpo) 
from org_inf join statregistr7 s7 on org_inf.okpo = s7.pole_1 or org_inf.okpo = s7.pole_3
where s7.pole_21 like '%85.41%' --or s7.pole_21 like ''

select count(*)
from statregistr7 s
join org_inf on org_inf.okpo=s.pole_1 or org_inf.okpo=s.pole_3
where --org_type_p21 = '01' and 
pole_21 like '%85.41%' and
org_inf.included_in_registr = '1'
--group by org_type_p21
--and s.in_vyborka = '1'
select count(*)
from registr r
where r.org_type = '01'

--statreg7_ron_matched_edu_level lic_no
drop materialized view lic_no --!!
create materialized view lic_no as
--
with pam as (
select --* --count(org_inf.okpo)
	org_inf.okpo
	,case 
		--when r122.okpo is not null and included_in_registr = 1 and r122.str_n = 3 and r122.gr3::int=1 and r122.gr4::int<>2 then 1 
		--when r122.okpo is null and included_in_registr = 1 and edu_level like ('%Начальное общее образование%') and license_status not like '%Не действует%' then 1
		when (r122.okpo is not null and included_in_registr = 1 and r122.str_n = 3 and r122.gr3::int=1 and r122.gr4::int<>2) or
	    (included_in_registr = 1 and edu_level like ('%Начальное общее образование%') and license_status not like '%Не действует%') then 1
	end as lic_no
from org_inf 
	left join razdel_1_2_2 r122
		on org_inf.okpo = r122.okpo
	left join statreg7_ron_matched 
		on statreg7_ron_matched.okpo_id = org_inf.okpo or statreg7_ron_matched.pole_1 = org_inf.okpo
	left join 
	(
	select okpo_id,array_agg(edu_level)::text as edu_level 
	from statreg7_ron_matched_edu_level
	group by okpo_id
	) as aokv 
		on aokv.okpo_id = statreg7_ron_matched.okpo_id
--where r122.str_n::int = 3 and included_in_registr in (1)
)
select count(distinct okpo) --okpo, lic_no
from pam
where lic_no = 1 --lic_no is not null --and lic_no = 1
--

--statreg7_ron_matched_edu_level lic_oo
--drop materialized view lic_oo 
create materialized view lic_oo as
--
with pam as (
select --* --count(org_inf.okpo)
	org_inf.okpo
	,case 
		when r122.okpo is not null and included_in_registr = 1 and r122.str_n::int = 4 and r122.gr3::int=1 and r122.gr4::int<>2 then 1 
		--when r122.okpo is not null and included_in_registr = 1 and r122.str_n::int = 4 and (r122.gr3::int<>1 or r122.gr4::int=2) then 0 
		when r122.okpo is null and included_in_registr = 1 and (edu_level like '%Основное общее образование%' or edu_level like '%Дополнительное основное общее образование%') and license_status <> 'Не действует' then 1
		--when r122.okpo is null and included_in_registr = 1 and edu_level in ('Основное общее образование','Дополнительное основное общее образование') and license_status = 'Не действует' then 0
		--else 0
	end as lic_oo	
from org_inf 
	left join razdel_1_2_2 r122
		on org_inf.okpo = r122.okpo
	left join statreg7_ron_matched 
		on statreg7_ron_matched.okpo_id = org_inf.okpo or statreg7_ron_matched.pole_1 = org_inf.okpo
	left join 
	(
	select okpo_id,array_agg(edu_level)::text as edu_level 
	from statreg7_ron_matched_edu_level
	group by okpo_id
	) as aokv 
		on aokv.okpo_id = statreg7_ron_matched.okpo_id
--where r122.okpo is null 
--where r122.str_n::int = 4 and included_in_registr in (1)
)
select okpo, lic_oo
from pam
where lic_oo is not null --and lic_oo =1
---
	 
drop materialized view lic_so	--!!
create materialized view lic_so as
--
with pam as (
select --* --count(org_inf.okpo)
	org_inf.okpo
	,case 
		when included_in_registr = 1 and r122.str_n = 5 and r122.gr3::int=1 and r122.gr4::int<>2 then 1 
		--when included_in_registr = 1 and r122.str_n = 5 and (r122.gr3::int<>1 or r122.gr4::int=2) then 0
		when r122.okpo is null and included_in_registr = 1 and (edu_level like '%Среднее общее образование%' or edu_level like '%Среднее (полное) общее образование%') and license_status <> 'Не действует' then 1
		--when r122.okpo is null and included_in_registr = 1 and edu_level in ('Среднее общее образование','Среднее (полное) общее образование') and license_status = 'Не действует' then 0
		when included_in_registr = 2 then null
	end as lic_so
from org_inf 
	left join razdel_1_2_2 r122
		on org_inf.okpo = r122.okpo
	left join statreg7_ron_matched 
		on statreg7_ron_matched.okpo_id = org_inf.okpo or statreg7_ron_matched.pole_1 = org_inf.okpo
	left join 
	(
	select okpo_id,array_agg(edu_level)::text as edu_level 
	from statreg7_ron_matched_edu_level
	group by okpo_id
	) as aokv 
		on aokv.okpo_id = statreg7_ron_matched.okpo_id
--where r122.str_n::int = 5 and included_in_registr in (1)		
)
select okpo, lic_so
from pam
where lic_so is not null --and lic_so=1
---
---

drop materialized view lic_spo
create materialized view lic_spo as 
--
with pam as (
select --* --count(org_inf.okpo)
	org_inf.okpo
	,case 
		when r122.okpo is not null and included_in_registr = 1 and r122.str_n::int = 6 and r122.gr3::int=1 and r122.gr4::int<>2 then 1
		--when included_in_registr = 1 and r122.str_n = 6 and (r122.gr3::int<>1 or r122.gr4::int=2) then 0 
		when r122.okpo is null and included_in_registr = 1 and (edu_level like '%Среднее профессиональное образование%' or edu_level like '%Начальное профессиональное образование%') and license_status <> 'Не действует' then 1
		--when r122.okpo is null and included_in_registr = 1 and edu_level in ('Среднее профессиональное образование','Начальное профессиональное образование') and license_status = 'Не действует' then 0
		--when included_in_registr = 2 then null
		--when included_in_registr = 1 then 0
	end as lic_spo
from org_inf 
	left join razdel_1_2_2 r122
		on org_inf.okpo = r122.okpo
	left join statreg7_ron_matched 
		on statreg7_ron_matched.okpo_id = org_inf.okpo or statreg7_ron_matched.pole_1 = org_inf.okpo
	left join 
	(
		select okpo_id,array_agg(edu_level)::text as edu_level 
		from statreg7_ron_matched_edu_level
		group by okpo_id
	) as aokv 
		on aokv.okpo_id = statreg7_ron_matched.okpo_id--on aokv.okpo_id = org_inf.okpo or aokv.pole_1 = org_inf.okpo
--where included_in_registr in (1)		
--where r122.okpo is null 
)
select okpo, lic_spo
from pam
where lic_spo is not null --and lic_spo=1
--

drop materialized view lic_vo_b 
create materialized view lic_vo_b as
--
with pam as (
select --* --count(org_inf.okpo)
	org_inf.okpo
	,case 
		when included_in_registr = 1 and r122.str_n = 7 and r122.gr3::int=1 and r122.gr4::int<>2 then 1
		--when included_in_registr = 1 and r122.str_n = 7 and (r122.gr3::int<>1 or r122.gr4::int=2) then 0
		when r122.okpo is null and included_in_registr = 1 and (edu_level like '%ВО - Бакалавриат%' or edu_level like '%Высшее образование - бакалавриат%') and license_status <> 'Не действует' then 1
		--when r122.okpo is null and included_in_registr = 1 and edu_level in ('ВО - Бакалавриат','Высшее образование - бакалавриат') and license_status = 'Не действует' then 0
		--when included_in_registr = 2 then null
	end as lic_vo_b
from org_inf 
	left join razdel_1_2_2 r122
		on org_inf.okpo = r122.okpo
	left join statreg7_ron_matched 
		on statreg7_ron_matched.okpo_id = org_inf.okpo or statreg7_ron_matched.pole_1 = org_inf.okpo
	left join 
	(
		select okpo_id,array_agg(edu_level)::text as edu_level 
		from statreg7_ron_matched_edu_level
		group by okpo_id
	) as aokv 
		on aokv.okpo_id = statreg7_ron_matched.okpo_id
--where r122.okpo is null 
)
select okpo, lic_vo_b
from pam
where lic_vo_b is not null	
--


drop materialized view lic_vo_s	
create materialized view lic_vo_s as
--
with pam as (
select --* --count(org_inf.okpo)
	org_inf.okpo
	,case 
		when included_in_registr = 1 and r122.str_n = 8 and r122.gr3::int=1 and r122.gr4::int<>2 then 1 
		--when included_in_registr = 1 and r122.str_n = 8 and (r122.gr3::int<>1 or r122.gr4::int=2) then 0 
		when r122.okpo is null and included_in_registr = 1 and (edu_level like '%ВО - Специалитет%' or edu_level like '%Высшее образование - специалитет%') and license_status <> 'Не действует' then 1
		--when r122.okpo is null and included_in_registr = 1 and edu_level in ('ВО - Специалитет','Высшее образование - специалитет') and license_status = 'Не действует' then 0
		--when included_in_registr = 2 then null
	end as lic_vo_s
from org_inf 
	left join razdel_1_2_2 r122
		on org_inf.okpo = r122.okpo
	left join statreg7_ron_matched 
		on statreg7_ron_matched.okpo_id = org_inf.okpo or statreg7_ron_matched.pole_1 = org_inf.okpo
	left join 
	(
	select okpo_id,array_agg(edu_level)::text as edu_level 
	from statreg7_ron_matched_edu_level
	group by okpo_id
	) as aokv 
		on aokv.okpo_id = statreg7_ron_matched.okpo_id
--where r122.okpo is null 
)
select okpo, lic_vo_s
from pam
where lic_vo_s is not null	
--

drop materialized view lic_vo_m
create materialized view lic_vo_m as
--
with pam as (
select --* --count(org_inf.okpo)
	org_inf.okpo
	,case 
		when r122.okpo is not null and included_in_registr = 1 and r122.str_n = 9 and r122.gr3::int=1 and r122.gr4::int<>2 then 1 
		--when r122.okpo is not null and included_in_registr = 1 and r122.str_n = 9 and (r122.gr3::int<>1 or r122.gr4::int=2) then 0 
		when r122.okpo is null and included_in_registr = 1 and (edu_level like '%ВО - Магистратура%' or edu_level like '%Высшее образование - магистратура%') and license_status <> 'Не действует' then 1
		--when r122.okpo is null and included_in_registr = 1 and edu_level in ('ВО - Магистратура','Высшее образование - магистратура') and license_status = 'Не действует' then 0
		--when included_in_registr = 2 then null
	end as lic_vo_m 
from org_inf 
	left join razdel_1_2_2 r122
		on org_inf.okpo = r122.okpo
	left join statreg7_ron_matched 
		on statreg7_ron_matched.okpo_id = org_inf.okpo or statreg7_ron_matched.pole_1 = org_inf.okpo
	left join 
	(
		select okpo_id,array_agg(edu_level)::text as edu_level 
		from statreg7_ron_matched_edu_level
		group by okpo_id
	) as aokv 
		on aokv.okpo_id = statreg7_ron_matched.okpo_id
)
select okpo, lic_vo_m
from pam
where lic_vo_m is not null	
--

drop materialized view lic_vo_kvk
create materialized view lic_vo_kvk as
--
with pam as (
select --* --count(org_inf.okpo)
	org_inf.okpo
	,case 
		when r122.okpo is not null and included_in_registr = 1 and r122.str_n = 10 and r122.gr3::int=1 and r122.gr4::int<>2 then 1 
		--when r122.okpo is not null and included_in_registr = 1 and r122.str_n = 10 and (r122.gr3::int<>1 or r122.gr4::int=2) then 0
		when r122.okpo is null and included_in_registr = 1 and (edu_level like '%ВО - ПКВК%' or edu_level like '%ВО - подготовка кадров высшей квалификации%' or edu_level like '%Послевузовское профессиональное образование%') and license_status <> 'Не действует' then 1
		--when r122.okpo is null and included_in_registr = 1 and edu_level in ('ВО - ПКВК','ВО - подготовка кадров высшей квалификации','Послевузовское профессиональное образование') and license_status = 'Не действует' then 1
		--when included_in_registr = 2 then null
	end as lic_vo_kvk --проверить		
from org_inf 
	left join razdel_1_2_2 r122
		on org_inf.okpo = r122.okpo
	left join statreg7_ron_matched 
		on statreg7_ron_matched.okpo_id = org_inf.okpo or statreg7_ron_matched.pole_1 = org_inf.okpo
	left join 
	(
	select okpo_id,array_agg(edu_level)::text as edu_level 
	from statreg7_ron_matched_edu_level
	group by okpo_id
	) as aokv 
		on aokv.okpo_id = statreg7_ron_matched.okpo_id
--where r122.okpo is null 
)
select okpo, lic_vo_kvk
from pam
where lic_vo_kvk is not null
--

drop materialized view lic_po	
create materialized view lic_po as
--
with pam as (
select --* --count(org_inf.okpo)
	org_inf.okpo
	,case 
		when r122.okpo is not null and included_in_registr = 1 and r122.str_n = 11 and r122.gr3::int=1 and r122.gr4::int<>2 then 1 
		--when r122.okpo is not null and included_in_registr = 1 and r122.str_n = 11 and (r122.gr3::int<>1 or r122.gr4::int=2) then 0
		when r122.okpo is null and included_in_registr = 1 and (edu_level like '%Профессиональное обучение%' or edu_level like '%Профессиональная подготовка%' or edu_level like '%Программа профессиональной подготовки%') and license_status <> 'Не действует' then 1
		--when r122.okpo is null and included_in_registr = 1 and edu_level in ('Профессиональное обучение','Профессиональная подготовка','Программа профессиональной подготовки') and license_status = 'Не действует' then 0
		--when included_in_registr = 2 then null
	end as lic_po
from org_inf 
	left join razdel_1_2_2 r122
		on org_inf.okpo = r122.okpo
	left join statreg7_ron_matched 
		on statreg7_ron_matched.okpo_id = org_inf.okpo or statreg7_ron_matched.pole_1 = org_inf.okpo
	left join 
	(
		select okpo_id,array_agg(edu_level)::text as edu_level 
		from statreg7_ron_matched_edu_level
		group by okpo_id
	) as aokv 
		on aokv.okpo_id = statreg7_ron_matched.okpo_id
)
select okpo, lic_po
from pam
where lic_po is not null
--


drop materialized view lic_dpo
create materialized view lic_dpo as
--
with pam as (
select --* --count(org_inf.okpo)
	org_inf.okpo
	,case 
		when r122.okpo is not null and included_in_registr = 1 and r122.str_n = 12 and r122.gr3::int=1 and r122.gr4::int<>2 then 1 
		--when r122.okpo is not null and included_in_registr = 1 and r122.str_n = 12 and (r122.gr3::int<>1 or r122.gr4::int=2) then 0 
		when r122.okpo is null and included_in_registr = 1 and (lower(edu_level) like '%дополнительное профессиональное образование%' or lower(edu_level) like '%дополнительное к начальному и среднему профессиональному образованию%' or lower(edu_level) like '%дополнительное к начальному, среднему и высшему профессиональному образованию%' or lower(edu_level) like '%дополнительное к среднему и высшему профессиональному образованию%' or lower(edu_level) like '%дополнительное к среднему профессиональному образованию%') and license_status <> 'Не действует' then 1
		--when r122.okpo is null and included_in_registr = 1 and lower(edu_level) in ('дополнительное профессиональное образование','дополнительное к начальному и среднему профессиональному образованию','дополнительное к начальному, среднему и высшему профессиональному образованию','дополнительное к среднему и высшему профессиональному образованию','дополнительное к среднему профессиональному образованию') and license_status = 'Не действует' then 0
		--when included_in_registr = 2 then null
	end as lic_dpo
from org_inf 
	left join razdel_1_2_2 r122
		on org_inf.okpo = r122.okpo
	left join statreg7_ron_matched 
		on statreg7_ron_matched.okpo_id = org_inf.okpo or statreg7_ron_matched.pole_1 = org_inf.okpo
	left join 
	(
		select okpo_id,array_agg(edu_level)::text as edu_level 
		from statreg7_ron_matched_edu_level
		group by okpo_id
	) as aokv 
		on aokv.okpo_id = statreg7_ron_matched.okpo_id
--where r122.okpo is null 
)
select okpo, lic_dpo
from pam
where lic_dpo is not null	
--

--select count(*) from razdel_1_2_1 r
where gr3 is null
--drop materialized view registr
--drop materialized view status_lic_o
create materialized view status_lic_o as
--
with pam as (
select --* --count(org_inf.okpo)
	org_inf.okpo
	,case 
		when r121.okpo is not null and included_in_registr = 1 and r121.str_n = 1 and r121.gr6::int=1 then 1
		when r121.okpo is not null and included_in_registr = 1 and r121.str_n = 1 and r121.gr6::int=3 then 2 
		when r121.okpo is not null and included_in_registr = 1 and r121.str_n = 1 and r121.gr3::int <> 1 and r121.gr7::int = 1 then 3 
		when r121.okpo is null and included_in_registr = 1 and license_status in ('Действует','Действующее') then 1
		when r121.okpo is null and included_in_registr = 1 and license_status in ('Приостановлено','Приостановлена в части филиалов') then 2
		when r121.okpo is null and included_in_registr = 1 and license_status in ('Проект') then 3
		--when included_in_registr = 2 then null
		else null
		--when included_in_registr = 2 then 99
		--when included_in_registr = 1 then 100
	end as status_lic_o
from org_inf 
	left join razdel_1_2_1 r121
		on org_inf.okpo = r121.okpo
	left join statreg7_ron_matched 
		on statreg7_ron_matched.okpo_id = org_inf.okpo or statreg7_ron_matched.pole_1 = org_inf.okpo
)
select 
	--count(*) 
	okpo, status_lic_o
from pam
where status_lic_o is not null --and okpo in (select okpo_id from statreg7_ron_matched where license_status is not null or license_status <> '')	
--
select * from statreg7_ron_matched srm
where okpo_id = '07659239405002'

select * from razdel_1_2_1 r
where okpo = '48556557'


--drop materialized view status_lic_dop
create materialized view status_lic_dop as
--
with pam as (
select --* --count(org_inf.okpo)
	org_inf.okpo
	,case 
		when included_in_registr = 1 and r122.str_n = 1 and r122.gr4::int = 1 then 1
		when included_in_registr = 1 and r122.str_n = 1 and r122.gr4::int in (3,4) then 2
		when included_in_registr = 1 and r122.str_n = 1 and r122.gr5::int = 1 and r122.gr3::int <> 1 then 3
		when r122.okpo is null and included_in_registr = 1 and (edu_level like '%Дополнительное образование детей и взрослых%' or edu_level like '%Дополнительное образование%') and license_status in ('Действует','Действующее') then 1
		when r122.okpo is null and included_in_registr = 1 and (edu_level like '%Дополнительное образование детей и взрослых%' or edu_level like '%Дополнительное образование%') and license_status in ('Приостановлено','Приостановлена в части филиалов') then 2
		when r122.okpo is null and included_in_registr = 1 and (edu_level like '%Дополнительное образование детей и взрослых%' or edu_level like '%Дополнительное образование%') and license_status in ('Проект') then 3
		--when included_in_registr = 2 then null
		when included_in_registr in (1) and (r122.str_n = 1 or r122.okpo is null) then 100
	end as status_lic_dop	
from org_inf 
	left join razdel_1_2_2 r122
		on org_inf.okpo = r122.okpo
	left join statreg7_ron_matched 
		on statreg7_ron_matched.okpo_id = org_inf.okpo or statreg7_ron_matched.pole_1 = org_inf.okpo
	left join 
	(
	select okpo_id,array_agg(edu_level)::text as edu_level 
	from statreg7_ron_matched_edu_level
	group by okpo_id
	) as aokv 
		on aokv.okpo_id = statreg7_ron_matched.okpo_id
--where r122.okpo is null 
)
select 
	--count(*)
	okpo, status_lic_dop
from pam
where status_lic_dop = 100 and okpo in (select okpo from razdel_1_2_2) --and okpo in (select okpo_id from statreg7_ron_matched) --is not null	
--

select * from statreg7_ron_matched srm
where okpo_id = '02538028580002'

select * from statreg7_ron_matched_edu_level srm
where okpo_id = '00035106305002'

select * from razdel_1_2_2 r
where okpo = '00035106305002'


select *
from statregistr7 s
where pole_1 = '40957251'
and in_vyborka is not null
group by pole_74


--
--update razdel_1_2_2
--set gr5 = null
--select * from razdel_1_2_2
--where gr5 like ''
--

drop materialized view deti_dod
create materialized view deti_dod as 
with deti_dod as (
select 
	r2.okpo,
	greatest(sum(case when str_n in (2,3,4) then gr3 else 0 end) --gr3_2_4
	,sum(case when str_n in (5,6,7,8,9,10) then gr3 else 0 end)) max_gr3
from razdel_2 r2
join org_inf oi on oi.okpo=r2.okpo
where r2.okpo in (select 
		r2.okpo
		from razdel_2 r2
		join org_inf oi on oi.okpo=r2.okpo
		where is_dod = 1 and r2.str_n::int = 1 and (r2.gr3::int = 0 or r2.gr3 is null))
group by r2.okpo
)
select * from deti_dod
where max_gr3 > 0
--

drop materialized view deti_dod2
create materialized view deti_dod2 as
--
with pam as (
select --* --count(org_inf.okpo)
	org_inf.okpo
	,case 
		when is_dod = 1 and r2.str_n::int = 1 and (r2.gr3::int = 0 or r2.gr3 is null) then max_gr3 
		when is_dod = 1 and r2.str_n::int = 1 and r2.gr3::int > 0 then r2.gr3
	end as deti_dod	
from org_inf 
	left join razdel_2 r2
		on org_inf.okpo = r2.okpo
	left join deti_dod on org_inf.okpo=deti_dod.okpo
where r2.str_n::int = 1
)
select okpo, deti_dod --count(*)--
from pam
where deti_dod is not null	
--

drop materialized view dop_ad as
create materialized view dop_ad as
--
with pam as (
select --* --count(org_inf.okpo)
	org_inf.okpo
	,case 
		when included_in_registr = 1 and r2.str_n::int = 11 and r2.gr3::int > 0 then 1 
		when included_in_registr = 1 and r2.str_n::int = 11 and r2.gr3::int <= 0 then 0 
		when included_in_registr = 2 then null
	end as dop_ad
from org_inf 
	left join razdel_2 r2
		on org_inf.okpo = r2.okpo
--	left join deti_dod on org_inf.okpo=deti_dod.okpo
where r2.str_n::int = 11
)
select okpo, dop_ad
from pam
where dop_ad is not null		
--

drop materialized view dop_dod_raz
create materialized view dop_dod_raz as
--
with pam as (
select --* --count(org_inf.okpo)
	org_inf.okpo
	,case 
		when included_in_registr = 1 and r2.str_n::int = 2 and r2.gr3::int > 0 then 1
		when included_in_registr = 1 and r2.str_n::int = 2 and r2.gr3::int <= 0 then 0
		when included_in_registr = 2 then null
	end as dop_dod_raz
from org_inf 
	left join razdel_2 r2
		on org_inf.okpo = r2.okpo
where r2.str_n::int = 2
)
select okpo, dop_dod_raz
from pam
where dop_dod_raz is not null	
--

drop materialized view dop_dod_is
create materialized view dop_dod_is as
--
with pam as (
select --* --count(org_inf.okpo)
	org_inf.okpo
	,case 
		when included_in_registr = 1 and r2.str_n::int = 3 and r2.gr3::int > 0 then 1
		when included_in_registr = 1 and r2.str_n::int = 3 and r2.gr3::int <= 0 then 0
	end as dop_dod_is
from org_inf 
	left join razdel_2 r2
		on org_inf.okpo = r2.okpo
where r2.str_n::int = 3
)
select okpo, dop_dod_is
from pam
where dop_dod_is is not null	
--

drop materialized view dop_dod_fs
create materialized view dop_dod_fs as
--
with pam as (
select --* --count(org_inf.okpo)
	org_inf.okpo
	,case 
		when included_in_registr = 1 and r2.str_n::int = 4 and r2.gr3::int > 0 then 1
		when included_in_registr = 1 and r2.str_n::int = 4 and r2.gr3::int <= 0 then 0
		when included_in_registr = 2 then null
	end as dop_dod_fs
from org_inf 
	left join razdel_2 r2
		on org_inf.okpo = r2.okpo
where r2.str_n::int = 4
)
select okpo, dop_dod_fs
from pam
where dop_dod_fs is not null	

---
---

drop materialized view dop_dod_tn
create materialized view dop_dod_tn as
--
with pam as (
select --* --count(org_inf.okpo)
	org_inf.okpo
	,case 
		when included_in_registr = 1 and r2.str_n::int = 5 and r2.gr3::int > 0 then 1
		when included_in_registr = 1 and r2.str_n::int = 5 and r2.gr3::int <= 0 then 0
	end as dop_dod_tn	
from org_inf 
	left join razdel_2 r2
		on org_inf.okpo = r2.okpo
where r2.str_n::int = 5
)
select okpo, dop_dod_tn
from pam
where dop_dod_tn is not null
--

drop materialized view dop_dod_en
create materialized view dop_dod_en as
--
with pam as (
select --* --count(org_inf.okpo)
	org_inf.okpo
	,case 
		when included_in_registr = 1 and r2.str_n::int = 6 and r2.gr3::int > 0 then 1
		when included_in_registr = 1 and r2.str_n::int = 6 and r2.gr3::int <= 0 then 0
	end as dop_dod_en	
from org_inf 
	left join razdel_2 r2
		on org_inf.okpo = r2.okpo
where r2.str_n::int = 6
)
select okpo, dop_dod_en
from pam
where dop_dod_en is not null
--


drop materialized view dop_dod_fn	
create materialized view dop_dod_fn as
--
with pam as (
select --* --count(org_inf.okpo)
	org_inf.okpo
	,case 
		when included_in_registr = 1 and r2.str_n::int = 7 and r2.gr3::int > 0 then 1
		when included_in_registr = 1 and r2.str_n::int = 7 and r2.gr3::int <= 0 then 0
	end as dop_dod_fn	
from org_inf 
	left join razdel_2 r2
		on org_inf.okpo = r2.okpo
where r2.str_n::int = 7
)
select okpo, dop_dod_fn
from pam
where dop_dod_fn is not null	
---

drop materialized view dop_dod_artn
create materialized view dop_dod_artn as
--
with pam as (
select --* --count(org_inf.okpo)
	org_inf.okpo
	,case 
		when included_in_registr = 1 and r2.str_n::int = 8 and r2.gr3::int > 0 then 1
		when included_in_registr = 1 and r2.str_n::int = 8 and r2.gr3::int <= 0 then 0
	end as dop_dod_artn
from org_inf 
	left join razdel_2 r2
		on org_inf.okpo = r2.okpo
where r2.str_n::int = 8
)
select okpo, dop_dod_artn
from pam
where dop_dod_artn is not null
--

drop materialized view dop_dod_turn
create materialized view dop_dod_turn as
--
with pam as (
select --* --count(org_inf.okpo)
	org_inf.okpo
	,case 
		when included_in_registr = 1 and r2.str_n::int = 9 and r2.gr3::int > 0 then 1
		when included_in_registr = 1 and r2.str_n::int = 9 and r2.gr3::int <= 0 then 0
	end as dop_dod_turn
from org_inf 
	left join razdel_2 r2
		on org_inf.okpo = r2.okpo
where r2.str_n::int = 9
)
select okpo, dop_dod_turn
from pam
where dop_dod_turn is not null
--
	
drop materialized view dop_dod_socn
create materialized view dop_dod_socn as
--
with pam as (
select --* --count(org_inf.okpo)
	org_inf.okpo
	,case 
		when included_in_registr = 1 and r2.str_n::int = 10 and r2.gr3::int > 0 then 1
		when included_in_registr = 1 and r2.str_n::int = 10 and r2.gr3::int <= 0 then 0
	end as dop_dod_socn
from org_inf 
	left join razdel_2 r2
		on org_inf.okpo = r2.okpo
where r2.str_n::int = 10
)
select okpo, dop_dod_socn
from pam
where dop_dod_socn is not null	
--

	
drop materialized view dop_dod_adap_raz
create materialized view dop_dod_adap_raz as
--
with pam as (
select --* --count(org_inf.okpo)
	org_inf.okpo
	,case 
		when included_in_registr = 1 and is_dod = 1 and r11.org_ovz::int in (1,2,3) and r2.str_n::int = 2 and r2.gr6::int > 0 then 1
		when included_in_registr = 1 and is_dod = 1 and r11.org_ovz::int in (1,2,3) and r2.str_n::int = 2 and r2.gr6::int = 0 then 0
	end as dop_dod_adap_raz	
from org_inf 
	left join razdel_2 r2
		on org_inf.okpo = r2.okpo
	left join razdel_1_1 r11 on org_inf.okpo=r11.okpo
--where r2.str_n::int = 11
)
select okpo, dop_dod_adap_raz
from pam
where dop_dod_adap_raz is not null	
--

drop materialized view dop_dod_adap_is	
create materialized view dop_dod_adap_is as
--
with pam as (
select --* --count(org_inf.okpo)
	org_inf.okpo
	,case 
		when included_in_registr = 1 and is_dod = 1 and r11.org_ovz::int in (1,2,3) and r2.str_n::int = 3 and r2.gr6::int > 0 then 1
		--when included_in_registr = 1 and is_dod = 1 and r11.org_ovz::int in (1,2,3) and r2.str_n::int = 3 and r2.gr6::int = 0 then 0
	end as dop_dod_adap_is
from org_inf 
	left join razdel_2 r2
		on org_inf.okpo = r2.okpo
	left join razdel_1_1 r11 on org_inf.okpo=r11.okpo
--where r2.str_n::int = 11
)
select okpo, dop_dod_adap_is
from pam
where dop_dod_adap_is is not null	
---

drop materialized view dop_dod_adap_fs
create materialized view dop_dod_adap_fs as
--
with pam as (
select --* --count(org_inf.okpo)
	org_inf.okpo
	,case 
		when included_in_registr = 1 and is_dod = 1 and r11.org_ovz::int in (1,2,3) and r2.str_n::int = 4 and r2.gr6::int > 0 then 1
		--when included_in_registr = 1 and is_dod = 1 and r11.org_ovz::int in (1,2,3) and r2.str_n::int = 4 and r2.gr6::int = 0 then 0
	end as dop_dod_adap_fs
from org_inf 
	left join razdel_2 r2
		on org_inf.okpo = r2.okpo
	left join razdel_1_1 r11 on org_inf.okpo=r11.okpo
--where r2.str_n::int = 11
)
--select okpo, dop_dod_adap_fs
--from pam
--where dop_dod_adap_fs is not null	
select count(*)
from pam
where dop_dod_adap_fs = 1	
--
--pustota
with pam as (

select count(org_inf.okpo)
--org_inf.okpo
--	,case 
--		when included_in_registr = 2 or r2 is null then 1
--		when included_in_registr = 1 and is_dod = 1 and r11.org_ovz::int in (1,2,3) and r2.str_n::int = 4 and r2.gr6::int = 0 then 0
--	end as dop_dod_adap_fs
from org_inf 
	 join razdel_2 r2
		on org_inf.okpo = r2.okpo
	 join razdel_1_1 r11 on org_inf.okpo=r11.okpo
--where r2.str_n::int = 11
where included_in_registr = 1 and r2.str_n::int = 4 and ((r2.gr6::int = 0) or (r11.org_ovz::int not in (1,2,3) or r11.org_ovz is null))

)
--select okpo, dop_dod_adap_fs
--from pam
--where dop_dod_adap_fs is not null	
select count(*)
from pam
where dop_dod_adap_fs 

select count(r.okpo)
from org_inf 
	 join razdel_2 r
on org_inf.okpo = r.okpo
where included_in_registr = 1 and str_n = 4
group by gr6

select org_ovz, count(okpo)
from razdel_1_1 r 
group by org_ovz


select count(*)
from org_inf 
where included_in_registr = 1 and
report between 2 and 10

select distinct report from org_inf


--drop materialized view noreg_org
create materialized view noreg_org as
select 
	distinct okpo,s72.pole_1 as noreg_pole_1
	,s72.pole_8 as noreg_inn
	,s72.pole_24 as noreg_okogu
	,s72.pole_25 as noreg_okfs
	,s72.pole_27 as noreg_ogrn
	,s72.pole_74 as noreg_predpr_type
from 
(select oi.*
from 
	org_inf oi 
	left join statregistr7 s7 
		on oi.okpo = s7.pole_1 or oi.okpo = s7.pole_3
where included_in_registr = 1 and s7.pole_1 is null and s7.pole_3 is null
) no_registr
join statregistr7 s72 on left(no_registr.okpo,8) = s72.pole_1
--


select count(distinct okpo) from 
org_inf 
where left(okpo,8) in (select noreg_pole_1 from noreg_org) and status <> '1'



--
select *
from statregistr7 s
where pole_1 = '52186865'


select --count(*) 
	*
from org_inf oi
where oi.included_in_registr = 2 and okpo in (select okpo_id from statreg7_ron_matched srm)


select * --count(*)
from statreg7_ron_matched srm
where okpo_id = '48556557'

select --org_type,
count(*)
from org_inf oi join razdel_1_1 r11 on oi.okpo=r11.okpo
where included_in_registr = 1 and org_type in ('7','8','9')
group by org_type


select org_type,count(*)
from org_inf oi
left join statregistr7 s on oi.okpo = s.pole_1 or oi.okpo = s.pole_3
join razdel_1_1 r11 on oi.okpo = r11.okpo
where --org_type_p21 = '01' and 
included_in_registr in (1,2) and s.org_type_p21 is null
group by org_type



select lic_do, count(*)
from registr
group by lic_do
	
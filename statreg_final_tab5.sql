--tab5 final
--drop materialized view statregistr._0_analit_tab_5
--create materialized view statregistr._0_analit_tab_5 as
--with tab_5 as ( 
--select --count(*) --73428  73431
--	org_inf.okpo
--	,pole_11 --as p11_okato_fact
--	,sub_name
--	,is_dod
--	,included_in_registr
--	,pole_9::text
--	,pole_74
--from 
--	org_inf 
--	--join okato_codes on left(pole_11,2)=okato_codes.sub
--	--join org_inf on razdel_1_1.okpo = org_inf.okpo
--	join (select 
--			--case when pole_9 not in ('1') then pole_3 else statregistr7.pole_1 end as okpo_id
--			pole_1,pole_3
--			,pole_11,pole_9,sub_name,pole_74 
--			from statregistr7 
--		join okato_codes on left(pole_11,2)=okato_codes.sub
--	) as statregistr7 
--	on org_inf.okpo = statregistr7.pole_1 or org_inf.okpo = statregistr7.pole_3--statregistr7.okpo_id
----where included_in_registr = 1
--union
--select --94
--	org_inf.okpo
--	,okato_fact
--	,sub_name
--	,is_dod
--	,included_in_registr
--	,org_status
--	,case when razdel_1_1.predpr_type = '3' then '9' 
--		  when razdel_1_1.predpr_type = '1' then '3'
--	end as predpr_type
----count(distinct org_inf.okpo)
--from 
--	org_inf 	
--	join razdel_1_1 on razdel_1_1.okpo = org_inf.okpo
--	join okato_codes on left(razdel_1_1.okato_fact,2)=okato_codes.sub
--	left join (select case when pole_9 not in ('1') then pole_3 else statregistr7.pole_1 end as okpo_id,pole_11 from statregistr7) as statregistr7 on org_inf.okpo = statregistr7.okpo_id
--where 
--	statregistr7.okpo_id is null
--)
--select * from tab_5
--
drop materialized view statregistr._1_analit_tab_5
create materialized view statregistr._1_analit_tab_5 as
with cnts as (
select sub_name,
	count(*)
	,count(case when pole_74 = '2' then 1 end) as gr2
	,count(case when pole_74 = '3' then 2 end) as gr3
	,count(case when pole_74 = '9' then 3 end) as gr4
from _0_analit_tab_5
where is_dod = 1
group by sub_name
)
select * 
from cnts
--

select count(*) from _0_analit_tab_5
where pole_74 = '2' and is_dod = 1

--tab5 final
select 
	sub_name, "count" as vsego, gr2,gr3,gr4
	,round(gr2/"count"*100,2) as gr5 
	,round(gr3/"count"*100,2) as gr6 
	,round(gr4/"count"*100,2) as gr7 
from (
select * from _1_analit_tab_5
union 
select 'Всего', sum("count") "Всего",sum(gr2) gr2,sum(gr3) gr3,sum(gr4) gr4 from _1_analit_tab_5 
union	
select fo_name,
	sum("count")
	,sum(gr2) gr2
	,sum(gr3) gr3
	,sum(gr4) gr4
	--fo_name
--	,sum(vsego) vsego
--	,sum(ur_lic) ur_lic
--	,sum(filial) filial
--	,sum(dod) dod
--	,sum(dod_ur_lic) dod_ur_lic
--	,sum(dod_filial) dod_filial
from _1_analit_tab_5
	join okato_codes on _1_analit_tab_5.sub_name=okato_codes.sub_name
	join fo_codes on fo_codes."﻿fo_code" = okato_codes.fo
--where is_dod = 1	
group by fo_name
union
select 
	case 
		when left(pole_11,3) = '112' or left(pole_11,3) = '114' or left(pole_11,3) = '115' then 'Архангельская область кроме Ненецкого АО' 
		when left(pole_11,3) = '111' then 'Ненецкий АО' --else 'арх без АО'
		when left(pole_11,4) in ('7114','7115','7116','7117') then 'Ямало-Ненецкий АО' --else 'тюм без АО' '7116',
		when left(pole_11,4) in ('7111','7112','7113','7118') then 'Ханты-Мансийский АО'
		when left(pole_11,3) in ('712','714') then 'Тюменская область без АО'
	end as tum_arh
	,count(*) as vsego
	,count(case when pole_74 = '2' then 1 end) as gr2
	,count(case when pole_74 = '3' then 2 end) as gr3
	,count(case when pole_74 = '9' then 3 end) as gr4
from _0_analit_tab_5
where 
	(left(pole_11,2) = '11' or left(pole_11,2) = '71')
	and is_dod = 1
group by tum_arh
) tab1_fo
join sub_order on sub_order.sub=tab1_fo.sub_name
order by sub_order."﻿sub_order"::int





--select 
--	case 
--		when left(pole_11,3) = '112' or left(pole_11,3) = '114' or left(pole_11,3) = '115' then 'Архангельская область кроме Ненецкого АО' 
--		when left(pole_11,3) = '111' then 'Ненецкий АО' --else 'арх без АО'
--		when left(pole_11,4) in ('7114','7115','7116','7117') then 'Ямало-Ненецкий АО' --else 'тюм без АО' '7116',
--		when left(pole_11,4) in ('7111','7112','7113','7118') then 'Ханты-Мансийский АО'
--		when left(pole_11,3) in ('712','714') then 'Тюменская область без АО'
--	end as tum_arh
--	,count(*) as vsego
--	,count(case when pole_74 = '2' then 1 end) as gr2
--	,count(case when pole_74 = '3' then 2 end) as gr3
--	,count(case when pole_74 = '9' then 3 end) as gr4
--from _0_analit_tab_5
--where 
--	(left(pole_11,2) = '11' or left(pole_11,2) = '71')
--	and is_dod = 1
--group by tum_arh







select predpr_type from razdel_1_1 r
group by predpr_type

select pole_74,count(*) from statregistr7 r
group by pole_74
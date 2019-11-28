create materialized view statregistr._0_analit_tab_3_step_1 as
with tab_3 as ( 
select --count(*) --73428  73431
	org_inf.okpo
	--,pole_11 --as p11_okato_fact
	,case when pole_11 is not null then pole_11 else okato_fact end as pole_11
	--,sub_name
	,org_ovz
	,is_dod
	,included_in_registr
--	,razdel_2.gr3
--	,razdel_2.gr4
--	,razdel_2.gr5
--	,razdel_2.gr6
--	,razdel_2.gr7
	--,summa4_7
	,gr4_7sum
from 
	org_inf 
	left join (select 
			pole_1,pole_3
			,pole_11
			--,sub_name
			from statregistr7 
		--join okato_codes on left(pole_11,2)=okato_codes.sub
	) as statregistr7 
	on org_inf.okpo = statregistr7.pole_1 or org_inf.okpo = statregistr7.pole_3--statregistr7.okpo_id
	join (select 
			okpo
			--, sum(gr4) + sum(gr5) + sum(gr6) + sum(gr7) as summa4_7, sum(gr3) gr3sum 
			,sum(gr4+gr5+gr6+gr7) gr4_7sum 
			from razdel_2 group by okpo) razdel_2 on org_inf.okpo=razdel_2.okpo
	join razdel_1_1 on org_inf.okpo=razdel_1_1.okpo 
where is_dod = 1 and (razdel_2.gr4_7sum > 0)
)
select * from tab_3
--select count(*) from (
--	select okpo, sum(gr4) + sum(gr5) + sum(gr6) + sum(gr7) as summa4_7, sum(gr3) gr3sum
--	from tab_3	
--	join okato_codes on left(pole_11,2)=okato_codes.sub
--	where 
--		org_ovz in ('1','2','3') --and (gr4 > 0 or gr5 > 0 or gr6 > 0 or gr7 > 0 or gr3 > 0)
--	group by okpo	
--	) x
--where summa4_7 > 0 or gr3sum > 0
	
		
--tab3 вывод: р2 str = 1 сумма гр4-гр7 НЕ равна гр3: 27423/27859	(98%)
--tab3 вывод: р2 str = 1 сумма гр4-гр7 равна гр3: 436/27859	

--select count(sumall) from (
--	select 
--		okpo
--		--, sum(gr4) + sum(gr5) + sum(gr6) + sum(gr7) + sum(gr3) as sumall
--		,sum(gr4+gr5+gr6+gr7+gr3) sumall
--	from razdel_2 
--	group by okpo
--	) x
--where sumall > 0	

with tab3_osn as (
select 
	sub_name
	,fo
	,count(*) as vsego
	,count(case when right(pole_11,3) = '000' and pole_11 <> '36217820000' then 1 end) gorod
	,count(case when (SUBSTRING(pole_11, 6, 1) in ('8','9') or right(pole_11,3)::int between 1 and 999) then 2 end) selo
from 
	_0_analit_tab_3_step_1
	join okato_codes on left(pole_11,2)=okato_codes.sub
where org_ovz in ('1','2','3')	
group by sub_name,fo
)
select 
	sub_name,vsego,gorod,selo
	--,round(vsego/62303*100,2) as gr4
	--,round(gorod/40521*100,2) as gr5
	--,round(gorod/21782*100,2) as gr6
from (
	select * from tab3_osn
	union
	select 'Всего','', sum(vsego) vsego, sum(gorod) vsego, sum(selo) vsego from tab3_osn
	union
	select fo_name,'', sum(vsego) vsego, sum(gorod) vsego, sum(selo) vsego 
	from tab3_osn join fo_codes on tab3_osn.fo=fo_codes."﻿fo_code"
	group by fo_name
	union
	select 
		tum_arh
		,fo
		,count(*) as vsego
		,count(case when right(pole_11,3) = '000' and pole_11 <> '36217820000' then 1 end) gorod
		,count(case when (SUBSTRING(pole_11, 6, 1) in ('8','9') or right(pole_11,3)::int between 1 and 999) then 2 end) selo
	from (
		select 
			case 
				when left(pole_11,3) = '112' or left(pole_11,3) = '114' or left(pole_11,3) = '115' then 'Архангельская область кроме Ненецкого АО' 
				when left(pole_11,3) = '111' then 'Ненецкий АО' --else 'арх без АО'
				when left(pole_11,4) in ('7114','7115','7116','7117') then 'Ямало-Ненецкий АО' --else 'тюм без АО' '7116',
				when left(pole_11,4) in ('7111','7112','7113','7118') then 'Ханты-Мансийский АО'
				when left(pole_11,3) in ('712','714') then 'Тюменская область без АО'
			end as tum_arh
			,pole_11
			,fo
		from _0_analit_tab_3_step_1
		join okato_codes on left(pole_11,2)=okato_codes.sub) x 
	where tum_arh is not null
	group by tum_arh,fo
) subs_fo_ao_data
join sub_order on subs_fo_ao_data.sub_name=sub_order.sub
order by sub_order.﻿sub_order::int



















create materialized view statregistr._0_analit_tab_3_step_1_no_r2 as
with tab_3 as ( 
select --count(*) --73428  73431
	org_inf.okpo
	--,pole_11 --as p11_okato_fact
	,case when pole_11 is not null then pole_11 else okato_fact end as pole_11
	--,sub_name
	,org_ovz
	,is_dod
	,included_in_registr
--	,razdel_2.gr3
--	,razdel_2.gr4
--	,razdel_2.gr5
--	,razdel_2.gr6
--	,razdel_2.gr7
	--,summa4_7
	--,gr4_7sum
from 
	org_inf 
	left join (select 
			pole_1,pole_3
			,pole_11
			--,sub_name
			from statregistr7 
		--join okato_codes on left(pole_11,2)=okato_codes.sub
	) as statregistr7 
	on org_inf.okpo = statregistr7.pole_1 or org_inf.okpo = statregistr7.pole_3--statregistr7.okpo_id
	--join (select 
	--		okpo
			--, sum(gr4) + sum(gr5) + sum(gr6) + sum(gr7) as summa4_7, sum(gr3) gr3sum 
	--		,sum(gr4+gr5+gr6+gr7) gr4_7sum 
	--		from razdel_2 group by okpo) razdel_2 on org_inf.okpo=razdel_2.okpo
	join razdel_1_1 on org_inf.okpo=razdel_1_1.okpo 
where is_dod = 1 --and (razdel_2.gr4_7sum > 0)
)
select * from tab_3
--select count(*) from (
--	select okpo, sum(gr4) + sum(gr5) + sum(gr6) + sum(gr7) as summa4_7, sum(gr3) gr3sum
--	from tab_3	
--	join okato_codes on left(pole_11,2)=okato_codes.sub
--	where 
--		org_ovz in ('1','2','3') --and (gr4 > 0 or gr5 > 0 or gr6 > 0 or gr7 > 0 or gr3 > 0)
--	group by okpo	
--	) x
--where summa4_7 > 0 or gr3sum > 0
	
		
--tab3 вывод: р2 str = 1 сумма гр4-гр7 НЕ равна гр3: 27423/27859	(98%)
--tab3 вывод: р2 str = 1 сумма гр4-гр7 равна гр3: 436/27859	

--select count(sumall) from (
--	select 
--		okpo
--		--, sum(gr4) + sum(gr5) + sum(gr6) + sum(gr7) + sum(gr3) as sumall
--		,sum(gr4+gr5+gr6+gr7+gr3) sumall
--	from razdel_2 
--	group by okpo
--	) x
--where sumall > 0	

with tab3_osn as (
select 
	sub_name
	,fo
	,count(*) as vsego
	,count(case when right(pole_11,3) = '000' and pole_11 <> '36217820000' then 1 end) gorod
	,count(case when (SUBSTRING(pole_11, 6, 1) in ('8','9') or right(pole_11,3)::int between 1 and 999) then 2 end) selo
from 
	_0_analit_tab_3_step_1_no_r2
	join okato_codes on left(pole_11,2)=okato_codes.sub
where org_ovz in ('1','2','3')	
group by sub_name,fo
)
select 
	sub_name,vsego,gorod,selo
	--,round(vsego/62303*100,2) as gr4
	--,round(gorod/40521*100,2) as gr5
	--,round(gorod/21782*100,2) as gr6
from (
	select * from tab3_osn
	union
	select 'Всего','', sum(vsego) vsego, sum(gorod) vsego, sum(selo) vsego from tab3_osn
	union
	select fo_name,'', sum(vsego) vsego, sum(gorod) vsego, sum(selo) vsego 
	from tab3_osn join fo_codes on tab3_osn.fo=fo_codes."﻿fo_code"
	group by fo_name
	union
	select 
		tum_arh
		,fo
		,count(*) as vsego
		,count(case when right(pole_11,3) = '000' and pole_11 <> '36217820000' then 1 end) gorod
		,count(case when (SUBSTRING(pole_11, 6, 1) in ('8','9') or right(pole_11,3)::int between 1 and 999) then 2 end) selo
	from (
		select 
			case 
				when left(pole_11,3) = '112' or left(pole_11,3) = '114' or left(pole_11,3) = '115' then 'Архангельская область кроме Ненецкого АО' 
				when left(pole_11,3) = '111' then 'Ненецкий АО' --else 'арх без АО'
				when left(pole_11,4) in ('7114','7115','7116','7117') then 'Ямало-Ненецкий АО' --else 'тюм без АО' '7116',
				when left(pole_11,4) in ('7111','7112','7113','7118') then 'Ханты-Мансийский АО'
				when left(pole_11,3) in ('712','714') then 'Тюменская область без АО'
			end as tum_arh
			,pole_11
			,fo
		from _0_analit_tab_3_step_1_no_r2
		join okato_codes on left(pole_11,2)=okato_codes.sub) x 
	where tum_arh is not null
	group by tum_arh,fo
) subs_fo_ao_data
join sub_order on subs_fo_ao_data.sub_name=sub_order.sub
order by sub_order.﻿sub_order::int
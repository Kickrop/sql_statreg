--tab4 final
--drop materialized view statregistr._0_analit_tab_4
create materialized view statregistr._0_analit_tab_4_p1 as
with tab_4 as ( 
select --count(*) --73428  73431
	org_inf.okpo
	,pole_11 --as p11_okato_fact
	,sub_name
	,is_dod
	,included_in_registr
	,pole_21
	,pole_25
from 
	org_inf 
	--join okato_codes on left(pole_11,2)=okato_codes.sub
	--join org_inf on razdel_1_1.okpo = org_inf.okpo
	join (select 
			--case when pole_9 not in ('1') then pole_3 else statregistr7.pole_1 end as okpo_id
			pole_1,pole_3
			,pole_11
			--,pole_9
			,sub_name
			,pole_21
			,pole_25
			from statregistr7 
		join okato_codes on left(pole_11,2)=okato_codes.sub
	) as statregistr7 
	on org_inf.okpo = statregistr7.pole_1 or org_inf.okpo = statregistr7.pole_3--statregistr7.okpo_id
where is_dod = 1	
)
select * from tab_4	

--where included_in_registr = 1
-------first part
--union
-------second part
create materialized view statregistr._0_analit_tab_4_p2 as
with tab_4 as ( 
select --94
	org_inf.okpo
	,okato_fact
	,sub_name
	,is_dod
	--,included_in_registr
	,org_status
	,okfs
	,org_type
--count(distinct org_inf.okpo)
from 
	org_inf 	
	join razdel_1_1 on razdel_1_1.okpo = org_inf.okpo
	join okato_codes on left(razdel_1_1.okato_fact,2)=okato_codes.sub
	left join (select case when pole_9 not in ('1') then pole_3 else statregistr7.pole_1 end as okpo_id,pole_11 from statregistr7) as statregistr7 on org_inf.okpo = statregistr7.okpo_id
where 
	statregistr7.okpo_id is null
	and is_dod = 1
)
select * from tab_4

--
drop materialized view statregistr._1_analit_tab_4_p1_p2
create materialized view statregistr._1_analit_tab_4_p1_p2 as
--summa
select 
	sub_name
	, sum(vsego) vsego
	, sum(gr2)	gr2
	, sum(gr3)	gr3
	, sum(gr4)	gr4
	, sum(gr5)	gr5
	, sum(gr6)	gr6
	, sum(gr7)	gr7
	, sum(gr8)	gr8
	, sum(gr9)	gr9
	, sum(gr10)	gr10
	, sum(gr11)	gr11
	, sum(gr12)	gr12
	, sum(gr13)	gr13
	, sum(gr14)	gr14
	, sum(gr15)	gr15
	, sum(gr16)	gr16
	, sum(gr17)	gr17
	, sum(gr18)	gr18
	, sum(gr19)	gr19
	, sum(gr20)	gr20
	, sum(gr21)	gr21
	, sum(gr22)	gr22
	, sum(gr23)	gr23
	, sum(gr24)	gr24
from 	
--p1
(select 
	sub_name
	,count(*) vsego
	,count(case when pole_25 in ('12','13','14') then 2 end) as gr2
	,count(case when pole_25 not in ('12','13','14') then 3 end) as gr3
	,count(case when pole_21 like '%85.41%' then 4 end) as gr4
	,count(case when pole_21 like '%85.41%' and pole_25 in ('12','13','14') then 5 end) as gr5
	,count(case when pole_21 like '%85.41%' and pole_25 not in ('12','13','14') then 6 end) as gr6
	,count(case when pole_21 like '%85.11%' then 7 end) as gr7
	,count(case when pole_21 like '%85.11%' and pole_25 in ('12','13','14') then 8 end) as gr8
	,count(case when pole_21 like '%85.11%' and pole_25 not in ('12','13','14') then 9 end) as gr9
	,count(case when pole_21 like '%85.12%' or pole_21 like '%85.13%' or pole_21 like '%85.14%' then 10 end) as gr10
	,count(case when pole_25 in ('12','13','14') and (pole_21 like '%85.12%' or pole_21 like '%85.13%' or pole_21 like '%85.14%') then 11 end) as gr11
	,count(case when pole_25 not in ('12','13','14') and (pole_21 like '%85.12%' or pole_21 like '%85.13%' or pole_21 like '%85.14%') then 12 end) as gr12
	,count(case when pole_21 like '%85.21%' or pole_21 like '%85.3%' then 13 end) as gr13
	,count(case when pole_25 in ('12','13','14') and (pole_21 like '%85.21%' or pole_21 like '%85.3%') then 14 end) as gr14
	,count(case when pole_25 not in ('12','13','14') and (pole_21 like '%85.21%' or pole_21 like '%85.3%') then 15 end) as gr15
	,count(case when pole_21 like '%85.22%' then 16 end) as gr16
	,count(case when pole_25 in ('12','13','14') and pole_21 like '%85.22%' then 17 end) as gr17
	,count(case when pole_25 not in ('12','13','14') and pole_21 like '%85.22%' then 18 end) as gr18
	,count(case when pole_21 like '%85.42%' then 19 end) as gr19
	,count(case when pole_25 in ('12','13','14') and pole_21 like '%85.42%' then 20 end) as gr20
	,count(case when pole_25 not in ('12','13','14') and pole_21 like '%85.42%' then 21 end) as gr21
	,count(case when pole_21 like '%85.23%' or pole_21 not like '%85%' or pole_21 is null then 22 end) as gr22
	,count(case when pole_25 in ('12','13','14') and (pole_21 like '%85.23%' or pole_21 not like '%85%' or pole_21 is null) then 23 end) as gr23
	,count(case when (pole_21 like '%85.23%' or pole_21 not like '%85%') and pole_25 not in ('12','13','14') then 24 end) as gr24
from _0_analit_tab_4_p1
group by sub_name
union all
--
--p2
select 
	sub_name
	,count(*) vsego
	,count(case when okfs in ('11','12','13','14') then 2 end) as gr2
	,count(case when okfs not in ('11','12','13','14') then 3 end) as gr3
	,count(case when org_type = '1' then 4 end) as gr4
	,count(case when org_type = '1' and okfs in ('11','12','13','14') then 5 end) as gr5
	,count(case when org_type = '1' and okfs not in ('11','12','13','14') then 6 end) as gr6
	,count(case when org_type = '2' then 7 end) as gr7
	,count(case when org_type = '2' and okfs in ('11','12','13','14') then 8 end) as gr8
	,count(case when org_type = '2' and okfs not in ('11','12','13','14') then 9 end) as gr9
	,count(case when org_type = '3' then 10 end) as gr10
	,count(case when org_type = '3' and okfs in ('11','12','13','14') then 11 end) as gr11
	,count(case when org_type = '3' and okfs not in ('11','12','13','14') then 12 end) as gr12
	,count(case when org_type = '4' then 13 end) as gr13
	,count(case when org_type = '4' and okfs in ('11','12','13','14') then 14 end) as gr14
	,count(case when org_type = '4' and okfs not in ('11','12','13','14') then 15 end) as gr15
	,count(case when org_type = '5' then 16 end) as gr16
	,count(case when org_type = '5' and okfs in ('11','12','13','14') then 17 end) as gr17
	,count(case when org_type = '5' and okfs not in ('11','12','13','14') then 18 end) as gr18
	,count(case when org_type = '6' then 19 end) as gr19
	,count(case when org_type = '6' and okfs in ('11','12','13','14') then 20 end) as gr20
	,count(case when org_type = '6' and okfs not in ('11','12','13','14') then 21 end) as gr21
	,count(case when org_type in ('7','8','9') then 22 end) as gr22
	,count(case when org_type in ('7','8','9') and okfs in ('11','12','13','14') then 23 end) as gr23
	,count(case when org_type in ('7','8','9') and okfs not in ('11','12','13','14') then 23 end) as gr24
from _0_analit_tab_4_p2
group by sub_name
) p1_p2
group by sub_name
--


--tum and arh
drop materialized view statregistr._1_analit_tab_4_tum_arh_p1_p2
create materialized view statregistr._1_analit_tab_4_tum_arh_p1_p2 as
select 
	tum_arh
	, sum(vsego) vsego
	, sum(gr2)	gr2
	, sum(gr3)	gr3
	, sum(gr4)	gr4
	, sum(gr5)	gr5
	, sum(gr6)	gr6
	, sum(gr7)	gr7
	, sum(gr8)	gr8
	, sum(gr9)	gr9
	, sum(gr10)	gr10
	, sum(gr11)	gr11
	, sum(gr12)	gr12
	, sum(gr13)	gr13
	, sum(gr14)	gr14
	, sum(gr15)	gr15
	, sum(gr16)	gr16
	, sum(gr17)	gr17
	, sum(gr18)	gr18
	, sum(gr19)	gr19
	, sum(gr20)	gr20
	, sum(gr21)	gr21
	, sum(gr22)	gr22
	, sum(gr23)	gr23
	, sum(gr24)	gr24
from 		
--tum and arh p1
(select 
	case 
		when left(pole_11,3) = '112' or left(pole_11,3) = '114' or left(pole_11,3) = '115' then 'Архангельская область кроме Ненецкого АО' 
		when left(pole_11,3) = '111' then 'Ненецкий АО' --else 'арх без АО'
		when left(pole_11,4) in ('7114','7115','7116','7117') then 'Ямало-Ненецкий АО' --else 'тюм без АО' '7116',
		when left(pole_11,4) in ('7111','7112','7113','7118') then 'Ханты-Мансийский АО'
		when left(pole_11,3) in ('712','714') then 'Тюменская область без АО'
	end as tum_arh
	,count(*) vsego
	,count(case when pole_25 in ('12','13','14') then 2 end) as gr2
	,count(case when pole_25 not in ('12','13','14') then 3 end) as gr3
	,count(case when pole_21 like '%85.41%' then 4 end) as gr4
	,count(case when pole_21 like '%85.41%' and pole_25 in ('12','13','14') then 5 end) as gr5
	,count(case when pole_21 like '%85.41%' and pole_25 not in ('12','13','14') then 6 end) as gr6
	,count(case when pole_21 like '%85.11%' then 7 end) as gr7
	,count(case when pole_21 like '%85.11%' and pole_25 in ('12','13','14') then 8 end) as gr8
	,count(case when pole_21 like '%85.11%' and pole_25 not in ('12','13','14') then 9 end) as gr9
	,count(case when pole_21 like '%85.12%' or pole_21 like '%85.13%' or pole_21 like '%85.14%' then 10 end) as gr10
	,count(case when pole_25 in ('12','13','14') and (pole_21 like '%85.12%' or pole_21 like '%85.13%' or pole_21 like '%85.14%') then 11 end) as gr11
	,count(case when pole_25 not in ('12','13','14') and (pole_21 like '%85.12%' or pole_21 like '%85.13%' or pole_21 like '%85.14%') then 12 end) as gr12
	,count(case when pole_21 like '%85.21%' or pole_21 like '%85.3%' then 13 end) as gr13
	,count(case when pole_25 in ('12','13','14') and (pole_21 like '%85.21%' or pole_21 like '%85.3%') then 14 end) as gr14
	,count(case when pole_25 not in ('12','13','14') and (pole_21 like '%85.21%' or pole_21 like '%85.3%') then 15 end) as gr15
	,count(case when pole_21 like '%85.22%' then 16 end) as gr16
	,count(case when pole_25 in ('12','13','14') and pole_21 like '%85.22%' then 17 end) as gr17
	,count(case when pole_25 not in ('12','13','14') and pole_21 like '%85.22%' then 18 end) as gr18
	,count(case when pole_21 like '%85.42%' then 19 end) as gr19
	,count(case when pole_25 in ('12','13','14') and pole_21 like '%85.42%' then 20 end) as gr20
	,count(case when pole_25 not in ('12','13','14') and pole_21 like '%85.42%' then 21 end) as gr21
	,count(case when pole_21 like '%85.23%' or pole_21 not like '%85%' or pole_21 is null then 22 end) as gr22
	,count(case when pole_25 in ('12','13','14') and (pole_21 like '%85.23%' or pole_21 not like '%85%' or pole_21 is null) then 23 end) as gr23
	,count(case when (pole_21 like '%85.23%' or pole_21 not like '%85%') and pole_25 not in ('12','13','14') then 24 end) as gr24	
from _0_analit_tab_4_p1
where 
	(left(pole_11,2) = '11' or left(pole_11,2) = '71')
	and is_dod = 1
group by tum_arh
--
union all
--tum and arh p2
select 
	case 
		when left(okato_fact,3) = '112' or left(okato_fact,3) = '114' or left(okato_fact,3) = '115' then 'Архангельская область кроме Ненецкого АО' 
		when left(okato_fact,3) = '111' then 'Ненецкий АО' --else 'арх без АО'
		when left(okato_fact,4) in ('7114','7115','7116','7117') then 'Ямало-Ненецкий АО' --else 'тюм без АО' '7116',
		when left(okato_fact,4) in ('7111','7112','7113','7118') then 'Ханты-Мансийский АО'
		when left(okato_fact,3) in ('712','714') then 'Тюменская область без АО'
	end as tum_arh
	,count(*) vsego
	,count(case when okfs in ('11','12','13','14') then 2 end) as gr2
	,count(case when okfs not in ('11','12','13','14') then 3 end) as gr3
	,count(case when org_type = '1' then 4 end) as gr4
	,count(case when org_type = '1' and okfs in ('11','12','13','14') then 5 end) as gr5
	,count(case when org_type = '1' and okfs not in ('11','12','13','14') then 6 end) as gr6
	,count(case when org_type = '2' then 7 end) as gr7
	,count(case when org_type = '2' and okfs in ('11','12','13','14') then 8 end) as gr8
	,count(case when org_type = '2' and okfs not in ('11','12','13','14') then 9 end) as gr9
	,count(case when org_type = '3' then 10 end) as gr10
	,count(case when org_type = '3' and okfs in ('11','12','13','14') then 11 end) as gr11
	,count(case when org_type = '3' and okfs not in ('11','12','13','14') then 12 end) as gr12
	,count(case when org_type = '4' then 13 end) as gr13
	,count(case when org_type = '4' and okfs in ('11','12','13','14') then 14 end) as gr14
	,count(case when org_type = '4' and okfs not in ('11','12','13','14') then 15 end) as gr15
	,count(case when org_type = '5' then 16 end) as gr16
	,count(case when org_type = '5' and okfs in ('11','12','13','14') then 17 end) as gr17
	,count(case when org_type = '5' and okfs not in ('11','12','13','14') then 18 end) as gr18
	,count(case when org_type = '6' then 19 end) as gr19
	,count(case when org_type = '6' and okfs in ('11','12','13','14') then 20 end) as gr20
	,count(case when org_type = '6' and okfs not in ('11','12','13','14') then 21 end) as gr21
	,count(case when org_type in ('7','8','9') then 22 end) as gr22
	,count(case when org_type in ('7','8','9') and okfs in ('11','12','13','14') then 23 end) as gr23
	,count(case when org_type in ('7','8','9') and okfs not in ('11','12','13','14') then 23 end) as gr24
from _0_analit_tab_4_p2
where 
	(left(okato_fact,2) = '11' or left(okato_fact,2) = '71')
	and is_dod = 1
group by tum_arh
) x
group by tum_arh


--final tab4_a
drop materialized view statregistr._2_analit_tab_4_a
create materialized view statregistr._2_analit_tab_4_a as
select tab4_fo.* from 
(
select * from _1_analit_tab_4_p1_p2
union 
select 'Всего' as "Всего",sum(vsego),sum(gr2), sum(gr3), sum(gr4), sum(gr5), sum(gr6), sum(gr7), sum(gr8), sum(gr9), sum(gr10), sum(gr11), sum(gr12), sum(gr13), sum(gr14), sum(gr15), sum(gr16), sum(gr17), sum(gr18), sum(gr19), sum(gr20), sum(gr21), sum(gr22), sum(gr23), sum(gr24) from _1_analit_tab_4_p1_p2
union 
select fo_name,sum(vsego),sum(gr2), sum(gr3), sum(gr4), sum(gr5), sum(gr6), sum(gr7), sum(gr8), sum(gr9), sum(gr10), sum(gr11), sum(gr12), sum(gr13), sum(gr14), sum(gr15), sum(gr16), sum(gr17), sum(gr18), sum(gr19), sum(gr20), sum(gr21), sum(gr22), sum(gr23), sum(gr24)
	from 
		_1_analit_tab_4_p1_p2
		join okato_codes on _1_analit_tab_4_p1_p2.sub_name=okato_codes.sub_name
		join fo_codes on fo_codes."﻿fo_code" = okato_codes.fo
	group by fo_name
union 
select * from _1_analit_tab_4_tum_arh_p1_p2
) tab4_fo
join sub_order on sub_order.sub=tab4_fo.sub_name
order by sub_order."﻿sub_order"::int
--

--tab4 приложение 1
select 
	sub_name
	,round(gr2/vsego*100,2) gr25
	,round(gr3/vsego*100,2) gr26
	,round(gr5/gr4*100,2) gr28
	,round(gr6/gr4*100,2) gr29
	,round(NULLIF(gr8,0)/gr7*100,2) gr31
	,round(NULLIF(gr9,0)/gr7*100,2) gr32
	,round(gr11/gr10*100,2) gr34
	,round(gr12/gr10*100,2) gr35
	,round(NULLIF(gr14,0)/gr13*100,2) gr37
	,round(NULLIF(gr15,0)/gr13*100,2) gr38
	,round(NULLIF(gr17,0)/gr16*100,2) gr40
	,round(NULLIF(gr18,0)/gr16*100,2) gr41
	,round(NULLIF(gr20,0)/gr19*100,2) gr43
	,round(NULLIF(gr21,0)/gr19*100,2) gr44
	,round(NULLIF(gr23,0)/gr22*100,2) gr46
	,round(NULLIF(gr24,0)/gr22*100,2) gr47
from _2_analit_tab_4_a

--tab4 приложение 2
select 
	sub_name
	,round(NULLIF(gr5,0)/gr2*100,2) gr51
	,round(NULLIF(gr6,0)/gr3*100,2) gr52
	,round(NULLIF(gr8,0)/gr2*100,2) gr54
	,round(NULLIF(gr9,0)/gr3*100,2) gr55	
	,round(NULLIF(gr11,0)/gr2*100,2) gr57
	,round(NULLIF(gr12,0)/gr3*100,2) gr58	
	,round(NULLIF(gr14,0)/gr2*100,2) gr60	
	,round(NULLIF(gr15,0)/gr3*100,2) gr61	
	,round(NULLIF(gr17,0)/gr2*100,2) gr63
	,round(NULLIF(gr18,0)/gr3*100,2) gr64	
	,round(NULLIF(gr20,0)/gr2*100,2) gr66
	,round(NULLIF(gr21,0)/gr3*100,2) gr67	
	,round(NULLIF(gr23,0)/gr2*100,2) gr69
	,round(NULLIF(gr24,0)/gr3*100,2) gr70
from _2_analit_tab_4_a



select COALESCE(0,null)

SELECT
   NULLIF (0, 0)
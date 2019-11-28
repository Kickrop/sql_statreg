--drop materialized view statregistr._1_analit_tab_2_gsv
--create materialized view statregistr._1_analit_tab_2_gsv as
--select vsego.*,"Село","Город" from
--(select sub_name, count(distinct okpo) as "Всего"
--from _0_analit_tab_1
--where 
--	is_dod = 1
--group by sub_name
--union 
--select 'Всего', count(distinct okpo)
--from _0_analit_tab_1
--where 
--	is_dod = 1
--) vsego
--left join
--(select sub_name, count(distinct okpo) as "Село"
--from _0_analit_tab_1
--where 
--	is_dod = 1 and 
--	(SUBSTRING(pole_11, 6, 1) in ('8','9') or
--	right(pole_11,3)::int between 1 and 999)
--group by sub_name
--union 
--select 'Всего', count(distinct okpo)
--from _0_analit_tab_1
--where 
--	is_dod = 1 and 
--	(SUBSTRING(pole_11, 6, 1) in ('8','9') or
--	right(pole_11,3)::int between 1 and 999)
--) selo
--on vsego.sub_name = selo.sub_name
--left join
--(select sub_name, count(distinct okpo) as "Город"
--from _0_analit_tab_1
--where 
--	is_dod = 1 and 
--	right(pole_11,3) = '000' and pole_11 <> '36217820000'
--group by sub_name
--union 
--select 'Всего', count(distinct okpo)
--from _0_analit_tab_1
--where 
--	is_dod = 1 and 
--	right(pole_11,3) = '000' and pole_11 <> '36217820000'
--) gorod
--on vsego.sub_name = gorod.sub_name
--order by sub_name

--
--сверка города и села
with tab5_gsv as (
select * from statregistr._1_analit_tab_2_gsv
union
select vsego.*,selo,gorod
from 
(select 
	case 
		when left(pole_11,3) = '112' or left(pole_11,3) = '114' or left(pole_11,3) = '115' then 'Архангельская область кроме Ненецкого АО' 
		when left(pole_11,3) = '111' then 'Ненецкий АО' --else 'арх без АО'
		when left(pole_11,4) in ('7114','7115','7116','7117') then 'Ямало-Ненецкий АО' --else 'тюм без АО' '7116',
		when left(pole_11,4) in ('7111','7112','7113','7118') then 'Ханты-Мансийский АО'
		when left(pole_11,3) in ('712','714') then 'Тюменская область без АО'
	end as tum_arh
	,count(okpo) as vsego
from _0_analit_tab_1
where 
	(left(pole_11,2) = '11' or left(pole_11,2) = '71')
	and is_dod = 1
group by tum_arh
) vsego
left join
(select 
	case 
		when left(pole_11,3) = '112' or left(pole_11,3) = '114' or left(pole_11,3) = '115' then 'Архангельская область кроме Ненецкого АО' 
		when left(pole_11,3) = '111' then 'Ненецкий АО' --else 'арх без АО'
		when left(pole_11,4) in ('7114','7115','7116','7117') then 'Ямало-Ненецкий АО' --else 'тюм без АО' '7116',
		when left(pole_11,4) in ('7111','7112','7113','7118') then 'Ханты-Мансийский АО'
		when left(pole_11,3) in ('712','714') then 'Тюменская область без АО'
	end as tum_arh
	,count(okpo) as selo
from _0_analit_tab_1
where 
	(left(pole_11,2) = '11' or left(pole_11,2) = '71')
	and is_dod = 1
	and (SUBSTRING(pole_11, 6, 1) in ('8','9') or
	right(pole_11,3)::int between 1 and 999)
group by tum_arh
) selo
on vsego.tum_arh = selo.tum_arh
left join
(select 
	case 
		when left(pole_11,3) = '112' or left(pole_11,3) = '114' or left(pole_11,3) = '115' then 'Архангельская область кроме Ненецкого АО' 
		when left(pole_11,3) = '111' then 'Ненецкий АО' --else 'арх без АО'
		when left(pole_11,4) in ('7114','7115','7116','7117') then 'Ямало-Ненецкий АО' --else 'тюм без АО' '7116',
		when left(pole_11,4) in ('7111','7112','7113','7118') then 'Ханты-Мансийский АО'
		when left(pole_11,3) in ('712','714') then 'Тюменская область без АО'
	end as tum_arh
	,count(okpo) as gorod
from _0_analit_tab_1
where 
	(left(pole_11,2) = '11' or left(pole_11,2) = '71')
	and is_dod = 1
	and right(pole_11,3) = '000' and pole_11 <> '36217820000'
group by tum_arh
) gorod
on vsego.tum_arh = gorod.tum_arh
)
select sub_name,"Всего","Село","Город" from (
select * from tab5_gsv
union
select fo_name,sum("Всего"),sum("Село"),sum("Город")
	from statregistr._1_analit_tab_2_gsv
	join okato_codes on _1_analit_tab_2_gsv.sub_name=okato_codes.sub_name
	join fo_codes on fo_codes."﻿fo_code" = okato_codes.fo
group by fo_name
) tab5_fo
join sub_order on sub_order.sub=tab5_fo.sub_name
order by sub_order."﻿sub_order"::int







--для работы по таб 2, в поле place город и село
drop materialized view statregistr._0_analit_tab_2
create materialized view statregistr._0_analit_tab_2 as
with tab_1 as ( 
select --count(*) --73428  73431
	org_inf.okpo
	,pole_11 --as p11_okato_fact
	--,sub_name
	,is_dod
	,included_in_registr
	,pole_9::text
	,pole_21
from 
	org_inf 
	--join okato_codes on left(pole_11,2)=okato_codes.sub
	--join org_inf on razdel_1_1.okpo = org_inf.okpo
	join (select 
			--case when pole_9 not in ('1') then pole_3 else statregistr7.pole_1 end as okpo_id
			pole_1,pole_3
			,pole_11,pole_9,pole_21--,sub_name 
			from statregistr7 
		--join okato_codes on left(pole_11,2)=okato_codes.sub
	) as statregistr7 
	on org_inf.okpo = statregistr7.pole_1 or org_inf.okpo = statregistr7.pole_3--statregistr7.okpo_id
--where included_in_registr = 1
union
select --94
	org_inf.okpo
	,okato_fact
	--,sub_name
	,is_dod
	,included_in_registr
	,org_status
	,org_type
--count(distinct org_inf.okpo)
from 
	org_inf 	
	join razdel_1_1 on razdel_1_1.okpo = org_inf.okpo
	--join okato_codes on left(razdel_1_1.okato_fact,2)=okato_codes.sub
	left join (select case when pole_9 not in ('1') then pole_3 else statregistr7.pole_1 end as okpo_id,pole_11 from statregistr7) as statregistr7 on org_inf.okpo = statregistr7.okpo_id
where 
	statregistr7.okpo_id is null --and is_dod=1
	--and included_in_registr = 1
)
select 
	tab_1.*
	,case 
		when right(pole_11,3) = '000' and pole_11 <> '36217820000' then 'gorod'
		when (SUBSTRING(pole_11, 6, 1) in ('8','9') or right(pole_11,3)::int between 1 and 999) then 'selo'
	end as place 
from tab_1
where is_dod = 1



--
--tab 2a
with tab2a as (
select 
	sub_name
	,fo_name
	,count(okpo) vsego
	, count(case when pole_21 like '%85.41%' or pole_21 = '1' then 2 end) gr2
	, count(case when pole_21 like '%85.11%' or pole_21 = '2' then 3 end) gr3
	, count(case when pole_21 like '%85.12%' or pole_21 like '%85.13%' or pole_21 like '%85.14%' or pole_21 = '3' then 4 end) gr4 
	, count(case when pole_21 like '%85.21%' or pole_21 like '%85.3%' or pole_21 = '4' then 5 end) gr5 
	, count(case when pole_21 like '%85.22%' or pole_21 = '5' then 6 end) gr6
	, count(case when pole_21 like '%85.42%' or pole_21 = '6' then 7 end) gr7
	, count(case when (pole_21 not like '%85%' and pole_21 not in ('1','2','3','4','5','6')) or pole_21 like '%85.23%' or pole_21 is null or pole_21 in ('7','8','9') then 8 end) gr8
from _0_analit_tab_2
left join okato_codes on left(pole_11,2)=okato_codes.sub
left join fo_codes on fo_codes."﻿fo_code" = okato_codes.fo
group by sub_name,fo_name
)
select x.sub_name,vsego,gr2,gr3,gr4,gr5,gr6,gr7,gr8 
	,round(gr2/vsego*100,2) as gr9
	,round(gr3/vsego*100,2) as gr10
	,round(gr4/vsego*100,2) as gr11
	,round(gr5/vsego*100,2) as gr12
	,round(gr6/vsego*100,2) as gr13
	,round(gr7/vsego*100,2) as gr14
	,round(gr8/vsego*100,2) as gr15
from (
	select * from tab2a
	union
	select fo_name,'',sum(vsego),sum(gr2),sum(gr3),sum(gr4),sum(gr5),sum(gr6),sum(gr7),sum(gr8) 
	from tab2a
	group by fo_name
	union 
	select 'Всего','',sum(vsego),sum(gr2),sum(gr3),sum(gr4),sum(gr5),sum(gr6),sum(gr7),sum(gr8) 
	from tab2a
	union
	select 
		case 
			when left(pole_11,3) = '112' or left(pole_11,3) = '114' or left(pole_11,3) = '115' then 'Архангельская область кроме Ненецкого АО' 
			when left(pole_11,3) = '111' then 'Ненецкий АО' --else 'арх без АО'
			when left(pole_11,4) in ('7114','7115','7116','7117') then 'Ямало-Ненецкий АО' --else 'тюм без АО' '7116',
			when left(pole_11,4) in ('7111','7112','7113','7118') then 'Ханты-Мансийский АО'
			when left(pole_11,3) in ('712','714') then 'Тюменская область без АО'
		end as tum_arh
		,''
		,count(*) as vsego
		, count(case when pole_21 like '%85.41%' or pole_21 = '1' then 2 end) gr2
		, count(case when pole_21 like '%85.11%' or pole_21 = '2' then 3 end) gr3
		, count(case when pole_21 like '%85.12%' or pole_21 like '%85.13%' or pole_21 like '%85.14%' or pole_21 = '3' then 4 end) gr4 
		, count(case when pole_21 like '%85.21%' or pole_21 like '%85.3%' or pole_21 = '4' then 5 end) gr5 
		, count(case when pole_21 like '%85.22%' or pole_21 = '5' then 6 end) gr6
		, count(case when pole_21 like '%85.42%' or pole_21 = '6' then 7 end) gr7
		, count(case when (pole_21 not like '%85%' and pole_21 not in ('1','2','3','4','5','6')) or pole_21 like '%85.23%' or pole_21 is null or pole_21 in ('7','8','9') then 8 end) gr8
	from _0_analit_tab_2
	where 
		(left(pole_11,2) = '11' or left(pole_11,2) = '71')
		and is_dod = 1
	group by tum_arh
) x 
join sub_order on sub_order.sub=x.sub_name
order by sub_order."﻿sub_order"::int
--

--tab 2b
with tab2a as (
select 
	sub_name
	,fo_name
	,count(okpo) vsego
	, count(case when pole_21 like '%85.41%' or pole_21 = '1' then 2 end) gr2
	, count(case when pole_21 like '%85.11%' or pole_21 = '2' then 3 end) gr3
	, count(case when pole_21 like '%85.12%' or pole_21 like '%85.13%' or pole_21 like '%85.14%' or pole_21 = '3' then 4 end) gr4 
	, count(case when pole_21 like '%85.21%' or pole_21 like '%85.3%' or pole_21 = '4' then 5 end) gr5 
	, count(case when pole_21 like '%85.22%' or pole_21 = '5' then 6 end) gr6
	, count(case when pole_21 like '%85.42%' or pole_21 = '6' then 7 end) gr7
	, count(case when (pole_21 not like '%85%' and pole_21 not in ('1','2','3','4','5','6')) or pole_21 like '%85.23%' or pole_21 is null or pole_21 in ('7','8','9') then 8 end) gr8
from _0_analit_tab_2
left join okato_codes on left(pole_11,2)=okato_codes.sub
left join fo_codes on fo_codes."﻿fo_code" = okato_codes.fo
where place='gorod'
group by sub_name,fo_name
)
select x.sub_name,vsego,gr2,gr3,gr4,gr5,gr6,gr7,gr8 
	,round(gr2/vsego*100,2) as gr9
	,round(gr3/vsego*100,2) as gr10
	,round(gr4/vsego*100,2) as gr11
	,round(gr5/vsego*100,2) as gr12
	,round(gr6/vsego*100,2) as gr13
	,round(gr7/vsego*100,2) as gr14
	,round(gr8/vsego*100,2) as gr15
from (
	select * from tab2a
	union
	select fo_name,'',sum(vsego),sum(gr2),sum(gr3),sum(gr4),sum(gr5),sum(gr6),sum(gr7),sum(gr8) 
	from tab2a
	group by fo_name
	union 
	select 'Всего','',sum(vsego),sum(gr2),sum(gr3),sum(gr4),sum(gr5),sum(gr6),sum(gr7),sum(gr8) 
	from tab2a
	union
	select 
		case 
			when left(pole_11,3) = '112' or left(pole_11,3) = '114' or left(pole_11,3) = '115' then 'Архангельская область кроме Ненецкого АО' 
			when left(pole_11,3) = '111' then 'Ненецкий АО' --else 'арх без АО'
			when left(pole_11,4) in ('7114','7115','7116','7117') then 'Ямало-Ненецкий АО' --else 'тюм без АО' '7116',
			when left(pole_11,4) in ('7111','7112','7113','7118') then 'Ханты-Мансийский АО'
			when left(pole_11,3) in ('712','714') then 'Тюменская область без АО'
		end as tum_arh
		,''
		,count(*) as vsego
		, count(case when pole_21 like '%85.41%' or pole_21 = '1' then 2 end) gr2
		, count(case when pole_21 like '%85.11%' or pole_21 = '2' then 3 end) gr3
		, count(case when pole_21 like '%85.12%' or pole_21 like '%85.13%' or pole_21 like '%85.14%' or pole_21 = '3' then 4 end) gr4 
		, count(case when pole_21 like '%85.21%' or pole_21 like '%85.3%' or pole_21 = '4' then 5 end) gr5 
		, count(case when pole_21 like '%85.22%' or pole_21 = '5' then 6 end) gr6
		, count(case when pole_21 like '%85.42%' or pole_21 = '6' then 7 end) gr7
		, count(case when (pole_21 not like '%85%' and pole_21 not in ('1','2','3','4','5','6')) or pole_21 like '%85.23%' or pole_21 is null or pole_21 in ('7','8','9') then 8 end) gr8
	from _0_analit_tab_2
	where 
		(left(pole_11,2) = '11' or left(pole_11,2) = '71')
		and is_dod = 1 and place='gorod'
	group by tum_arh
) x 
join sub_order on sub_order.sub=x.sub_name
order by sub_order."﻿sub_order"::int
--

--tab 2c
with tab2c as (
select 
	sub_name
	,fo_name
	,count(okpo) vsego
	, count(case when pole_21 like '%85.41%' or pole_21 = '1' then 2 end) gr2
	, count(case when pole_21 like '%85.11%' or pole_21 = '2' then 3 end) gr3
	, count(case when pole_21 like '%85.12%' or pole_21 like '%85.13%' or pole_21 like '%85.14%' or pole_21 = '3' then 4 end) gr4 
	, count(case when pole_21 like '%85.21%' or pole_21 like '%85.3%' or pole_21 = '4' then 5 end) gr5 
	, count(case when pole_21 like '%85.22%' or pole_21 = '5' then 6 end) gr6
	, count(case when pole_21 like '%85.42%' or pole_21 = '6' then 7 end) gr7
	, count(case when (pole_21 not like '%85%' and pole_21 not in ('1','2','3','4','5','6')) or pole_21 like '%85.23%' or pole_21 is null or pole_21 in ('7','8','9') then 8 end) gr8
from _0_analit_tab_2
left join okato_codes on left(pole_11,2)=okato_codes.sub
left join fo_codes on fo_codes."﻿fo_code" = okato_codes.fo
where place='selo'
group by sub_name,fo_name
)
select 
	x.sub_name,vsego,gr2,gr3,gr4,gr5,gr6,gr7,gr8
	,round(gr2/vsego*100,2) as gr9
	,round(gr3/vsego*100,2) as gr10
	,round(gr4/vsego*100,2) as gr11
	,round(gr5/vsego*100,2) as gr12
	,round(gr6/vsego*100,2) as gr13
	,round(gr7/vsego*100,2) as gr14
	,round(gr8/vsego*100,2) as gr15
from (
	select * from tab2c
	union
	select fo_name,'',sum(vsego),sum(gr2),sum(gr3),sum(gr4),sum(gr5),sum(gr6),sum(gr7),sum(gr8) 
	from tab2c
	group by fo_name
	union 
	select 'Всего','',sum(vsego),sum(gr2),sum(gr3),sum(gr4),sum(gr5),sum(gr6),sum(gr7),sum(gr8) 
	from tab2c
	union
	select 
		case 
			when left(pole_11,3) = '112' or left(pole_11,3) = '114' or left(pole_11,3) = '115' then 'Архангельская область кроме Ненецкого АО' 
			when left(pole_11,3) = '111' then 'Ненецкий АО' --else 'арх без АО'
			when left(pole_11,4) in ('7114','7115','7116','7117') then 'Ямало-Ненецкий АО' --else 'тюм без АО' '7116',
			when left(pole_11,4) in ('7111','7112','7113','7118') then 'Ханты-Мансийский АО'
			when left(pole_11,3) in ('712','714') then 'Тюменская область без АО'
		end as tum_arh
		,''
		,count(*) as vsego
		, count(case when pole_21 like '%85.41%' or pole_21 = '1' then 2 end) gr2
		, count(case when pole_21 like '%85.11%' or pole_21 = '2' then 3 end) gr3
		, count(case when pole_21 like '%85.12%' or pole_21 like '%85.13%' or pole_21 like '%85.14%' or pole_21 = '3' then 4 end) gr4 
		, count(case when pole_21 like '%85.21%' or pole_21 like '%85.3%' or pole_21 = '4' then 5 end) gr5 
		, count(case when pole_21 like '%85.22%' or pole_21 = '5' then 6 end) gr6
		, count(case when pole_21 like '%85.42%' or pole_21 = '6' then 7 end) gr7
		, count(case when (pole_21 not like '%85%' and pole_21 not in ('1','2','3','4','5','6')) or pole_21 like '%85.23%' or pole_21 is null or pole_21 in ('7','8','9') then 8 end) gr8
	from _0_analit_tab_2
	where 
		(left(pole_11,2) = '11' or left(pole_11,2) = '71')
		and is_dod = 1 and place='selo'
	group by tum_arh
) x 
join sub_order on sub_order.sub=x.sub_name
order by sub_order."﻿sub_order"::int

--
select distinct org_type
from razdel_1_1










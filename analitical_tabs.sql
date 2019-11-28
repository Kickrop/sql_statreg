--тюменская и архангельская
with tum_arh_ao as (
select 
	--left(okato_fact,2) sub_2_dig,
--	case 
--		when left(okato_fact,2) = '11' then left(okato_fact,5)
--		when left(okato_fact,2) = '71' then left(okato_fact,5)
--	end as arh
	okato_fact as arh
--	,case 
--		when left(okato_fact,2) = '71' then left(okato_fact,5)
--	end as tum
	,sub_name
	--,count(*) 
from 
	razdel_1_1 join okato_codes on left(okato_fact,2)=okato_codes.sub
where 
	left(okato_fact,2) = '11' or left(okato_fact,2) = '71'
--group by 
--	arh,tum,sub_name
)
select 
	case 
		when left(arh,3) = '112' or left(arh,3) = '114' or left(arh,3) = '115' then 'Архангельская область кроме Ненецкого АО' 
		when left(arh,3) = '111' then 'Ненецкий АО' --else 'арх без АО'
		when left(arh,4) = '7114' then 'Ямало-Ненецкий АО' --else 'тюм без АО'
		when left(arh,4) = '7111' or left(arh,4) = '7113' or left(arh,4) = '7118' then 'Ханты-Мансийский АО'
		when left(arh,3) = '712' or left(arh,3) = '714' or (left(arh,3) = '711' and not left(arh,4) = '7111') then 'Тюменская область без АО'
	end as tum_arh
	--,arh
	, count(*)
from tum_arh_ao
group by tum_arh

--
--таблица 2б
--
--select *
----delete 
--from okato_codes
--where sub_name in ('Архангельская область кроме Ненецкого АО','Ненецкий автономный округ','Ханты-Мансийский АО','Ямало-Ненецкий АО','Тюменская область без АО')

--города
with tab_2b as ( 
select 
	org_inf.okpo
	,pole_11 --as p11_okato_fact
	,sub_name
from 
	razdel_1_1 
	--join okato_codes on left(pole_11,2)=okato_codes.sub
	join org_inf on razdel_1_1.okpo = org_inf.okpo
	join (select case when pole_9 not in ('1') then pole_3 else statregistr7.pole_1 end as okpo_id,pole_11,sub_name from statregistr7 join okato_codes on left(pole_11,2)=okato_codes.sub) as statregistr7 on org_inf.okpo = statregistr7.okpo_id
where 
	is_dod = 1 and 
	(SUBSTRING(pole_11, 3, 1) = '4' or
	SUBSTRING(pole_11, 6, 1) = '5')
union
select 
	org_inf.okpo
	,okato_fact
	,sub_name
--count(distinct org_inf.okpo)
from 
	razdel_1_1 
	join okato_codes on left(okato_fact,2)=okato_codes.sub	
	join org_inf on razdel_1_1.okpo = org_inf.okpo
	left join (select case when pole_9 not in ('1') then pole_3 else statregistr7.pole_1 end as okpo_id,pole_11 from statregistr7) as statregistr7 on org_inf.okpo = statregistr7.okpo_id
where 
	statregistr7.okpo_id is null and
	is_dod = 1 and 
	(SUBSTRING(okato_fact, 3, 1) = '4' or
	SUBSTRING(okato_fact, 6, 1) = '5')
)
select sub_name, count(distinct okpo) as "Города"
from tab_2b
group by sub_name
union 
select '1_Всего', count(distinct okpo)
from tab_2b
order by sub_name
--
with tab_2b as (
select 
	okpo
	,pole_11
	,sub_name
from _0_analit_tab_1
where 
	is_dod = 1 and 
	(SUBSTRING(pole_11, 3, 1) = '4' or
	SUBSTRING(pole_11, 6, 1) = '5') and right(pole_11,3)::int = 0--or left(pole_11,2) in ('40','67')
) 
select sub_name, count(distinct okpo) as "Город"
from tab_2b
group by sub_name
union 
select '1_Всего', count(distinct okpo)
from tab_2b
order by sub_name
--
with tab_2b as (
select 
	--okpo
	pole_11
	--sub_name
	--,is_dod
	,case 
		when 
		--(SUBSTRING(pole_11, 3, 1) = '4' or SUBSTRING(pole_11, 6, 1) = '5') and 
		right(pole_11,3) = '000' and pole_11 <> '36217820000'
		--or left(pole_11,2) in ('40','67')
		then 1 
	end as gorod
	,case
		when (SUBSTRING(pole_11, 6, 1) in ('8','9') or right(pole_11,3)::int between 1 and 999) then 1
	end as selo
from _0_analit_tab_1
where is_dod = 1
)
select --okpo,sub_name
	 --pole_11,
	 count(gorod) gorod
	 ,count(selo) selo
	 ,count(gorod)+count(selo) as vsego
	--count(distinct pole_11) 
from tab_2b
--where selo = gorod
--group by pole_11
--where gorod = 2

--
select substring('00035106085002',6,1) = '4'
select substring('00035106085002',9,3)
--

group by sub_name
--where 


with tab_2b as (
select 
	okpo
	,pole_11
	,sub_name
from _0_analit_tab_1
where 
	is_dod = 1 and 
	right(pole_11,3) = '000' and pole_11 <> '36217820000'
) 
select sub_name, count(distinct okpo) as "Город"
from tab_2b
group by sub_name
union 
select '1_Всего', count(distinct okpo)
from tab_2b
order by sub_name




--таблица 2в, село
--with tab_2b as ( 
--select 
--	org_inf.okpo
--	,pole_11 --as p11_okato_fact
--	,sub_name
--from 
--	razdel_1_1 
--	--join okato_codes on left(pole_11,2)=okato_codes.sub
--	join org_inf on razdel_1_1.okpo = org_inf.okpo
--	join (select case when pole_9 not in ('1') then pole_3 else statregistr7.pole_1 end as okpo_id,pole_11,sub_name from statregistr7 join okato_codes on left(pole_11,2)=okato_codes.sub) as statregistr7 on org_inf.okpo = statregistr7.okpo_id
--where 
--	is_dod = 1 and 
--	(SUBSTRING(pole_11, 6, 1) in ('8','9') or
--	right(pole_11,3)::int between 1 and 999)
--union
--select 
--	org_inf.okpo
--	,okato_fact
--	,sub_name
----count(distinct org_inf.okpo)
--from 
--	razdel_1_1 
--	join okato_codes on left(okato_fact,2)=okato_codes.sub	
--	join org_inf on razdel_1_1.okpo = org_inf.okpo
--	left join (select case when pole_9 not in ('1') then pole_3 else statregistr7.pole_1 end as okpo_id,pole_11 from statregistr7) as statregistr7 on org_inf.okpo = statregistr7.okpo_id
--where 
--	statregistr7.okpo_id is null and
--	is_dod = 1 and 
--	(SUBSTRING(okato_fact, 6, 1) in ('8','9') or
--	right(okato_fact,3)::int between 1 and 999)
--)
--select sub_name, count(distinct okpo) as "Село"
--from tab_2b
--group by sub_name
--union 
--select '1_Всего', count(distinct okpo)
--from tab_2b
--order by sub_name
--
with tab_2bs as (
select 
	okpo
	,pole_11
	,sub_name
from _0_analit_tab_1
where 
	is_dod = 1 and 
	(SUBSTRING(pole_11, 6, 1) in ('8','9') or
	right(pole_11,3)::int between 1 and 999)
) 
select sub_name, count(distinct okpo) as "Село"
from tab_2bs
group by sub_name
union 
select '1_Всего', count(distinct okpo)
from tab_2bs
order by sub_name

--пересекающиеся окато
select a.pole_11 selo, b.pole_11 gorod, b.sub_name 
	--count(*)
from 
(select 
	--count(okpo)
	distinct pole_11
	,sub_name
from _0_analit_tab_1
where 
	is_dod = 1 and right(pole_11,3)::int between 1 and 999
	--(SUBSTRING(pole_11, 6, 1) in ('8','9') or
	--(right(pole_11,3)::int between 1 and 999))
) a --selo
join
(select 
	--count(okpo)
	distinct pole_11
	,sub_name
from _0_analit_tab_1
where 
	is_dod = 1 and right(pole_11,3) = '000'
	--(SUBSTRING(pole_11, 3, 1) = '4' or
	--SUBSTRING(pole_11, 6, 1) = '5') and right(pole_11,3) = '000' or left(pole_11,2) in ('40','67')
) b --gorod
on a.pole_11=b.pole_11
--where a.pole_11 is null and b.pole_11 is null


--
--таблица 2а, всего
--with tab_2b as ( 
--select 
--	org_inf.okpo
--	,pole_11 --as p11_okato_fact
--	,sub_name
----count(*)
--from 
--	razdel_1_1 
--	--join okato_codes on left(pole_11,2)=okato_codes.sub
--	join org_inf on razdel_1_1.okpo = org_inf.okpo
--	join (select case when pole_9 not in ('1') then pole_3 else statregistr7.pole_1 end as okpo_id,pole_11
--	,sub_name from statregistr7 join okato_codes on left(pole_11,2)=okato_codes.sub) as statregistr7 on org_inf.okpo = statregistr7.okpo_id
--where 
--	is_dod = 1
--union
--select 
--	org_inf.okpo
--	,okato_fact
--	,sub_name
----count(distinct org_inf.okpo)
--from 
--	razdel_1_1 
--	join okato_codes on left(okato_fact,2)=okato_codes.sub	
--	join org_inf on razdel_1_1.okpo = org_inf.okpo
--	left join (select case when pole_9 not in ('1') then pole_3 else statregistr7.pole_1 end as okpo_id,pole_11 from statregistr7) as statregistr7 on org_inf.okpo = statregistr7.okpo_id
--where 
--	statregistr7.okpo_id is null and
--	is_dod = 1
--)
--select sub_name, count(distinct okpo) as "Всего"
--from tab_2b
--group by sub_name
--union 
--select '1_Всего', count(distinct okpo)
--from tab_2b
--order by sub_name

with tab_2a as (
select 
	okpo
	,pole_11
	,sub_name
from _0_analit_tab_1
where 
	is_dod = 1
) 
select sub_name, count(distinct okpo) as "Всего"
from tab_2a
group by sub_name
union 
select '1_Всего', count(distinct okpo)
from tab_2a
order by sub_name
--

--
select count(distinct okpo) from org_inf
where is_dod = 1

select count(distinct org_inf.okpo) 
from razdel_1_1 --join (select case when pole_9 not in ('1') then pole_3 else statregistr7.pole_1 end as okpo_id from statregistr7) statregistr7 on razdel_1_1.okpo = statregistr7.okpo_id
join org_inf on razdel_1_1.okpo=org_inf.okpo
where is_dod = 1

select *
from statregistr7
where SUBSTRING(pole_11, 6)::int > 0
--добавить ведущий ноль окато организации
----select *
--update statregistr7
--set pole_10 = '01202807001'
----from statregistr7
--where pole_1 = '02099273'
----where length(pole_11)<>11
--

--
--tab 1 
--
drop materialized view statregistr._0_analit_tab_1
create materialized view statregistr._0_analit_tab_1 as
with tab_1 as ( 
select --count(*) --73428  73431
	org_inf.okpo
	,pole_11 --as p11_okato_fact
	,sub_name
	,is_dod
	,included_in_registr
	,pole_9::text
from 
	org_inf 
	--join okato_codes on left(pole_11,2)=okato_codes.sub
	--join org_inf on razdel_1_1.okpo = org_inf.okpo
	join (select 
			--case when pole_9 not in ('1') then pole_3 else statregistr7.pole_1 end as okpo_id
			pole_1,pole_3
			,pole_11,pole_9,sub_name 
			from statregistr7 
		join okato_codes on left(pole_11,2)=okato_codes.sub
	) as statregistr7 
	on org_inf.okpo = statregistr7.pole_1 or org_inf.okpo = statregistr7.pole_3--statregistr7.okpo_id
--where included_in_registr = 1
union
select --94
	org_inf.okpo
	,okato_fact
	,sub_name
	,is_dod
	,included_in_registr
	,org_status
--count(distinct org_inf.okpo)
from 
	org_inf 	
	join razdel_1_1 on razdel_1_1.okpo = org_inf.okpo
	join okato_codes on left(razdel_1_1.okato_fact,2)=okato_codes.sub
	left join (select case when pole_9 not in ('1') then pole_3 else statregistr7.pole_1 end as okpo_id,pole_11 from statregistr7) as statregistr7 on org_inf.okpo = statregistr7.okpo_id
where 
	statregistr7.okpo_id is null --and is_dod=1
	--and included_in_registr = 1
)
select * from tab_1
--
--select
--	sub_name, count(distinct okpo) as "Всего"
--from tab_1
--group by sub_name
--union 
--select '1_Всего', count(distinct okpo)
--from tab_1
--order by sub_name

--
--
--tab 1 agg
drop materialized view statregistr._1_analit_tab_1
create materialized view statregistr._1_analit_tab_1 as
select vsego.*
	, ur_lic.ur_lic
	,filial.filial
	,dod.dod
	,dod_ur_lic.dod_ur_lic
	,dod_filial.dod_filial
from (
	select sub_name,count(okpo) as vsego from statregistr._0_analit_tab_1
	where 
		included_in_registr = 1
	group by
		sub_name
	) vsego
left join (
	select sub_name,count(okpo) as ur_lic from statregistr._0_analit_tab_1
	where 
		included_in_registr = 1 and
		pole_9 = '1'
	group by
		sub_name
) ur_lic
on vsego.sub_name = ur_lic.sub_name	
left join (
	select sub_name,count(okpo) as filial from statregistr._0_analit_tab_1
	where 
		included_in_registr = 1 and
		pole_9 in ('2','3')
	group by
		sub_name
) filial
on vsego.sub_name = filial.sub_name	
left join (
	select sub_name,count(okpo) as dod from statregistr._0_analit_tab_1
	where 
		is_dod = 1 
	group by
		sub_name
) dod
on vsego.sub_name = dod.sub_name
left join (
	select sub_name,count(okpo) as dod_ur_lic from statregistr._0_analit_tab_1
	where 
		is_dod = 1 and 
		pole_9 = '1'
	group by
		sub_name
) dod_ur_lic
on vsego.sub_name = dod_ur_lic.sub_name
left join (
	select sub_name,count(okpo) as dod_filial from statregistr._0_analit_tab_1
	where 
		is_dod = 1 and 
		pole_9 in ('2','3')
	group by
		sub_name
) dod_filial
on vsego.sub_name = dod_filial.sub_name
union 
select vsego.*
	,ur_lic.ur_lic
	,filial.filial
	,dod.dod
	,dod_ur_lic.dod_ur_lic
	,dod_filial.dod_filial
from (
	select 'Российская Федерация' as rf,count(okpo) as vsego from statregistr._0_analit_tab_1
	where 
		included_in_registr = 1
		and sub_name <> 'Байконур'
	) vsego
left join (
	select 'Российская Федерация' as rf,count(okpo) as ur_lic from statregistr._0_analit_tab_1
	where 
		included_in_registr = 1 and
		pole_9 = '1'
		and sub_name <> 'Байконур'
) ur_lic
on vsego.rf = ur_lic.rf	
left join (
	select 'Российская Федерация' as rf,count(okpo) as filial from statregistr._0_analit_tab_1
	where 
		included_in_registr = 1 and
		pole_9 in ('2','3')
		and sub_name <> 'Байконур'
) filial
on vsego.rf = filial.rf	
left join (
	select 'Российская Федерация' as rf,count(okpo) as dod from statregistr._0_analit_tab_1
	where 
		is_dod = 1 
		and sub_name <> 'Байконур'
) dod
on vsego.rf = dod.rf
left join (
	select 'Российская Федерация' as rf,count(okpo) as dod_ur_lic from statregistr._0_analit_tab_1
	where 
		is_dod = 1 and 
		pole_9 = '1'
		and sub_name <> 'Байконур'
) dod_ur_lic
on vsego.rf = dod_ur_lic.rf
left join (
	select 'Российская Федерация' as rf,count(okpo) as dod_filial from statregistr._0_analit_tab_1
	where 
		is_dod = 1 and 
		pole_9 in ('2','3')
		and sub_name <> 'Байконур'
) dod_filial
on vsego.rf = dod_filial.rf
union
select 
	tum_arh_vsego.*
	,ur_lic
	,filial
	,dod
	,dod_ur_lic
	,dod_filial 
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
	and included_in_registr = 1
group by tum_arh
) tum_arh_vsego
left join
(select 
	case 
		when left(pole_11,3) = '112' or left(pole_11,3) = '114' or left(pole_11,3) = '115' then 'Архангельская область кроме Ненецкого АО' 
		when left(pole_11,3) = '111' then 'Ненецкий АО' --else 'арх без АО'
		when left(pole_11,4) in ('7114','7115','7116','7117') then 'Ямало-Ненецкий АО' --else 'тюм без АО' '7116',
		when left(pole_11,4) in ('7111','7112','7113','7118') then 'Ханты-Мансийский АО'
		when left(pole_11,3) in ('712','714') then 'Тюменская область без АО'
	end as tum_arh
	,count(okpo) as ur_lic
from _0_analit_tab_1
where 
	(left(pole_11,2) = '11' or left(pole_11,2) = '71')
	and included_in_registr = 1
	and pole_9 = '1'
group by tum_arh
) ur_lic
on tum_arh_vsego.tum_arh = ur_lic.tum_arh
left join
(select 
	case 
		when left(pole_11,3) = '112' or left(pole_11,3) = '114' or left(pole_11,3) = '115' then 'Архангельская область кроме Ненецкого АО' 
		when left(pole_11,3) = '111' then 'Ненецкий АО' --else 'арх без АО'
		when left(pole_11,4) in ('7114','7115','7116','7117') then 'Ямало-Ненецкий АО' --else 'тюм без АО' '7116',
		when left(pole_11,4) in ('7111','7112','7113','7118') then 'Ханты-Мансийский АО'
		when left(pole_11,3) in ('712','714') then 'Тюменская область без АО'
	end as tum_arh
	,count(okpo) as filial
from _0_analit_tab_1
where 
	(left(pole_11,2) = '11' or left(pole_11,2) = '71')
	and included_in_registr = 1
	and pole_9 in ('2','3')
group by tum_arh
) filial
on tum_arh_vsego.tum_arh = filial.tum_arh
left join
(select 
	case 
		when left(pole_11,3) = '112' or left(pole_11,3) = '114' or left(pole_11,3) = '115' then 'Архангельская область кроме Ненецкого АО' 
		when left(pole_11,3) = '111' then 'Ненецкий АО' --else 'арх без АО'
		when left(pole_11,4) in ('7114','7115','7116','7117') then 'Ямало-Ненецкий АО' --else 'тюм без АО' '7116',
		when left(pole_11,4) in ('7111','7112','7113','7118') then 'Ханты-Мансийский АО'
		when left(pole_11,3) in ('712','714') then 'Тюменская область без АО'
	end as tum_arh
	,count(okpo) as dod
from _0_analit_tab_1
where 
	(left(pole_11,2) = '11' or left(pole_11,2) = '71')
	and included_in_registr = 1
	and is_dod = 1
group by tum_arh
) dod
on tum_arh_vsego.tum_arh = dod.tum_arh
left join
(select 
	case 
		when left(pole_11,3) = '112' or left(pole_11,3) = '114' or left(pole_11,3) = '115' then 'Архангельская область кроме Ненецкого АО' 
		when left(pole_11,3) = '111' then 'Ненецкий АО' --else 'арх без АО'
		when left(pole_11,4) in ('7114','7115','7116','7117') then 'Ямало-Ненецкий АО' --else 'тюм без АО' '7116',
		when left(pole_11,4) in ('7111','7112','7113','7118') then 'Ханты-Мансийский АО'
		when left(pole_11,3) in ('712','714') then 'Тюменская область без АО'
	end as tum_arh
	,count(okpo) as dod_ur_lic
from _0_analit_tab_1
where 
	(left(pole_11,2) = '11' or left(pole_11,2) = '71')
	and included_in_registr = 1
	and is_dod = 1
	and pole_9 = '1'
group by tum_arh
) dod_ur_lic
on tum_arh_vsego.tum_arh = dod_ur_lic.tum_arh
left join
(select 
	case 
		when left(pole_11,3) = '112' or left(pole_11,3) = '114' or left(pole_11,3) = '115' then 'Архангельская область кроме Ненецкого АО' 
		when left(pole_11,3) = '111' then 'Ненецкий АО' --else 'арх без АО'
		when left(pole_11,4) in ('7114','7115','7116','7117') then 'Ямало-Ненецкий АО' --else 'тюм без АО' '7116',
		when left(pole_11,4) in ('7111','7112','7113','7118') then 'Ханты-Мансийский АО'
		when left(pole_11,3) in ('712','714') then 'Тюменская область без АО'
	end as tum_arh
	,count(okpo) as dod_filial
from _0_analit_tab_1
where 
	(left(pole_11,2) = '11' or left(pole_11,2) = '71')
	and included_in_registr = 1
	and is_dod = 1
	and pole_9 in ('2','3')
group by tum_arh
) dod_filial
on tum_arh_vsego.tum_arh = dod_filial.tum_arh
union 
select vsego.*
	,ur_lic.ur_lic
	,filial.filial
	,dod.dod
	,dod_ur_lic.dod_ur_lic
	,dod_filial.dod_filial
from (
	select 'Всего' as rf,count(okpo) as vsego from statregistr._0_analit_tab_1
	where 
		included_in_registr = 1
	) vsego
left join (
	select 'Всего' as rf,count(okpo) as ur_lic from statregistr._0_analit_tab_1
	where 
		included_in_registr = 1 and
		pole_9 = '1'
) ur_lic
on vsego.rf = ur_lic.rf	
left join (
	select 'Всего' as rf,count(okpo) as filial from statregistr._0_analit_tab_1
	where 
		included_in_registr = 1 and
		pole_9 in ('2','3')
) filial
on vsego.rf = filial.rf	
left join (
	select 'Всего' as rf,count(okpo) as dod from statregistr._0_analit_tab_1
	where 
		is_dod = 1 
) dod
on vsego.rf = dod.rf
left join (
	select 'Всего' as rf,count(okpo) as dod_ur_lic from statregistr._0_analit_tab_1
	where 
		is_dod = 1 and 
		pole_9 = '1'
) dod_ur_lic
on vsego.rf = dod_ur_lic.rf
left join (
	select 'Всего' as rf,count(okpo) as dod_filial from statregistr._0_analit_tab_1
	where 
		is_dod = 1 and 
		pole_9 in ('2','3')
) dod_filial
on vsego.rf = dod_filial.rf
--

select 
	sub_name
	--left(pole_11,2)
	,count(*)
--left(pole_11,2),sub_name,pole_11
from _0_analit_tab_1
where --left(pole_11,2)='11'
included_in_registr = 1
group by 
	sub_name
	--left(pole_11,2)
--tum and arh
--tab1 final
select 
	tab1_fo.*
	,round(dod/vsego*100,2) as gr7
	,round(dod_ur_lic/ur_lic*100,2) as gr8
	,round(dod_filial/filial*100,2) as gr9
from	
(select *
from _1_analit_tab_1
union	
select 
	fo_name
	,sum(vsego) vsego
	,sum(ur_lic) ur_lic
	,sum(filial) filial
	,sum(dod) dod
	,sum(dod_ur_lic) dod_ur_lic
	,sum(dod_filial) dod_filial
from _1_analit_tab_1
	join okato_codes on _1_analit_tab_1.sub_name=okato_codes.sub_name
	join fo_codes on fo_codes."?fo_code" = okato_codes.fo
group by fo_name) tab1_fo
join sub_order on sub_order.sub=tab1_fo.sub_name
order by sub_order."?sub_order"::int


	
	
	
--26112019 Добавил столбец org_type_p21
--alter table statregistr.statregistr7 add column org_type_p21 text
update statregistr.statregistr7
set org_type_p21=x.org_type_p21
from (
select 
	case 
		when pole_21 like '%85.41%' or pole_21 like '%85.41.1%' or pole_21 like '%85.41.2%' or pole_21 like '%85.41.9%' then '01' 
		when pole_21 like '%85.11%' then '02'
		when pole_21 like '%85.12%' or pole_21 like '%85.13%' or pole_21 like '%85.14%' then '03'
		when pole_21 like '%85.21%' or pole_21 like '%85.3%' or pole_21 like '%85.30%' then '04'
		when pole_21 like '%85.22%' or pole_21 like '%85.22.1%' or pole_21 like '%85.22.2%' or pole_21 like '%85.22.3%' then '05'
		when pole_21 like '%85.42%' or pole_21 like '%85.42.1%' or pole_21 like '%85.42.9%' then '06'
		when pole_21 not like '%85%' or pole_21 like '%85.23%' then '07'
	end org_type_p21
	,pole_1
from statregistr.statregistr7 s
) x
where statregistr.statregistr7.pole_1=x.pole_1
--

--добавлены поля 116-120 из статрег6
--update statregistr.statregistr7
--set pole_120=s6.pole_120
from (
select pole_1, pole_116, pole_117, pole_118, pole_119, pole_120
from --statregistr.statregistr7 s7
--join 
statregistr.statregistr6 s6
--on s7.pole_1=s6.pole_1
) s6
where s6.pole_1=statregistr.statregistr7.pole_1
--

select 
	count(case when pole_21 like '%85.41%' or pole_21 like '%85.41.1%' or pole_21 like '%85.41.2%' or pole_21 like '%85.41.9%' then 1 end) c01
	,count(case when pole_21 like '%85.11%' then 2 end) c02
	,count(case when pole_21 like '%85.12%' or pole_21 like '%85.13%' or pole_21 like '%85.14%' then 3 end) c03
	,count(case when pole_21 like '%85.21%' or pole_21 like '%85.3%' or pole_21 like '%85.30%' then 4 end) c04
	,count(case when pole_21 like '%85.22%' or pole_21 like '%85.22.1%' or pole_21 like '%85.22.2%' or pole_21 like '%85.22.3%' then 5 end) c05
	,count(case when pole_21 like '%85.42%' or pole_21 like '%85.42.1%' or pole_21 like '%85.42.9%' then 6 end) c06
	,count(case when pole_21 not like '%85%' then 7 end) c07
from statregistr7 s
--where in_vyborka in ('1','2','3')




select gr4+gr7+gr10+gr13+gr16+gr19+gr22,x.* from (
select 
--	count(case when pole_21 like '%85.41%' or pole_21 like '%85.41.1%' or pole_21 like '%85.41.2%' or pole_21 like '%85.41.9%' then 1 end) c01
	count(case when pole_21 like '%85.41%' then 2 end) gr4
	,count(case when pole_21 like '%85.11%' then 7 end) as gr7
	,count(case when pole_21 like '%85.12%' or pole_21 like '%85.13%' or pole_21 like '%85.14%' then 10 end) as gr10
	,count(case when pole_21 like '%85.21%' or pole_21 like '%85.3%' then 13 end) as gr13
	,count(case when pole_21 like '%85.22%' then 16 end) as gr16
	,count(case when pole_21 like '%85.42%' then 19 end) as gr19
	,count(case when pole_21 not like '%85%' then 22 end) as gr22
	,count(case when pole_21 like '' then 23 end) as gryy
	,count(case when pole_21 like '%85%' then 24 end) as vsego85
--	,count(case when pole_21 like '%85.12%' or pole_21 like '%85.13%' or pole_21 like '%85.14%' then 3 end) c03
--	,count(case when pole_21 like '%85.21%' or pole_21 like '%85.3%' or pole_21 like '%85.30%' then 4 end) c04
--	,count(case when pole_21 like '%85.22%' or pole_21 like '%85.22.1%' or pole_21 like '%85.22.2%' or pole_21 like '%85.22.3%' then 5 end) c05
--	,count(case when pole_21 like '%85.42%' or pole_21 like '%85.42.1%' or pole_21 like '%85.42.9%' then 6 end) c06
--	,count(case when pole_21 not like '%85%' then 7 end) c07
from statregistr7 s join org_inf o on s.pole_1=o.okpo or s.pole_3 = o.okpo
where is_dod = 1
) x


select * from (
	--2919
	select count(o.okpo)
	--okved_main_fact r1_1_okved_main_fact,razdel_1_1.okpo r1_1_okpo,pole_1,pole_3,pole_21,pole_6 -- count(okpo)
	from statregistr7 s join org_inf o on s.pole_1=o.okpo or s.pole_3 = o.okpo
	join razdel_1_1 on o.okpo=razdel_1_1.okpo
	where is_dod = 1 and (pole_21 like '%85.23%' or pole_21 not like '%85%')
--group by pole_21
) x
where pole_21 like '%85.23%'

	--61391
	select count(o.okpo)
	--okved_main_fact r1_1_okved_main_fact,razdel_1_1.okpo r1_1_okpo,pole_1,pole_3,pole_21,pole_6 -- count(okpo)
	from statregistr7 s join org_inf o on s.pole_1=o.okpo or s.pole_3 = o.okpo
	join razdel_1_1 on o.okpo=razdel_1_1.okpo
	where is_dod = 1 and (pole_21 not like '%85.23%' and pole_21 like '%85%')
	
	--61409
	select count(o.okpo)
	--okved_main_fact r1_1_okved_main_fact,razdel_1_1.okpo r1_1_okpo,pole_1,pole_3,pole_21,pole_6 -- count(okpo)
	from statregistr7 s join org_inf o on s.pole_1=o.okpo or s.pole_3 = o.okpo
	join razdel_1_1 on o.okpo=razdel_1_1.okpo
	where is_dod = 1
	
	--18
	select count(o.okpo)
	--okved_main_fact r1_1_okved_main_fact,razdel_1_1.okpo r1_1_okpo,pole_1,pole_3,pole_21,pole_6 -- count(okpo)
	from statregistr7 s join org_inf o on s.pole_1=o.okpo or s.pole_3 = o.okpo
	join razdel_1_1 on o.okpo=razdel_1_1.okpo
	where is_dod = 1 and pole_21 is null
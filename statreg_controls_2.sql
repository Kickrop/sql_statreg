drop MATERIALIZED VIEW statreg7_ron_matched
CREATE MATERIALIZED VIEW statreg7_ron_matched
AS  
select pole_1::varchar(255), pole_3::varchar(255), pole_6, pole_7, pole_14, pole_8::varchar(255), pole_27::varchar(255), pole_21, pole_67, license_status, edu_level --a.okpo, gr3, pole_67, pole_8, pole_7, pole_6, pole_27 
from --statregistr.razdel_1_2_1 a
		(select pole_1,pole_3,pole_14,pole_8,pole_21, pole_27, pole_67, lower(trim(pole_7)) pole_7,lower(trim(pole_6)) pole_6
		from statregistr7
		where in_vyborka = '1') c
--on ba.okpo = c.pole_1 --on a.okpo=c.pole_1 or (c.pole_3=a.okpo)
join 
		(select inn,ogrn, lower(trim(fullname)) fullname, lower(trim(shortname)) shortname, license_status, edu_level
		from
		licenses_edited
		where fullname <> 'nan' and shortname <> 'nan' and length(shortname)>2 and length(fullname)>2) d 
		on (c.pole_8=d.inn or c.pole_27=d.ogrn or c.pole_7=d.fullname or c.pole_6=d.shortname)
WITH DATA;


--3 a сравнение окпо
select count(*) from
(select razdel_1_1.okpo, inn, full_name
from razdel_1_1 join org_inf on razdel_1_1.okpo=org_inf.okpo
where length(razdel_1_1.okpo)=8) a
left join 
(select pole_1
from statregistr7
where length(pole_1)=8 and in_vyborka = '1') b
on a.okpo=b.pole_1
where b.pole_1 is null
--
--3 b филиалов нет в статрегистре
select * from
(select razdel_1_1.okpo, inn, full_name
from razdel_1_1 join org_inf on razdel_1_1.okpo=org_inf.okpo
where length(razdel_1_1.okpo)=14) a
left join 
(select pole_1
from statregistr7
where length(pole_3)=14 and in_vyborka = '1') b
on a.okpo=b.pole_1
where b.pole_1 is null
--
CREATE INDEX idx_pole14_oktmo ON statregistr7(pole_14);
---
select min(length(okpo))
from razdel_1_2_2

---
--
--по окпо (филиалы по полю 9)
select RANK () OVER (
      ORDER BY pole_2
   ) rank_number
,pole_2 "окпо из выборки (поле 2)"
,okpo_head "окпо головы бд инв (okpo_head)"
--,statreg_filials
, pole_3 "Статрег. филиалы (поле 3)"
,inv_filials, pole_2=okpo_head "совпала голова?" from 
(select pole_2, pole_3 --, pole_1 statreg_filials --, count(pole_1) statreg_filials --, pole_2
from statregistr7
join okpo_statreg_by_gleb on statregistr7.pole_1=okpo_statreg_by_gleb.okpo
where pole_9 in ('2','3')
--where pole_3 is not null and right(pole_3, 9) > '001'
--and pole_2 = '27128343'--and pole_6 like '%НИУ ВШЭ%'
--group by pole_2, pole_1
order by pole_1 desc
) statreg
full join
(select okpo_head, okpo inv_filials
from razdel_1_1
where org_status in ('2','3')
--and okpo_head = '27128343'
--group by okpo_head, okpo
order by inv_filials desc
) inv
on statreg.pole_2=inv.okpo_head and statreg.pole_3=inv.inv_filials

---
select count(distinct rank_number) from (
select RANK () OVER (
      ORDER BY pole_2
   ) rank_number
,pole_2 "окпо из выборки (поле 2)"
,okpo_head "окпо головы бд инв (okpo_head)"
--,statreg_filials
, pole_3 "Статрег. филиалы (поле 3)"
,inv_filials, pole_2=okpo_head "совпала голова?" from 
(select pole_2, pole_3 --, pole_1 statreg_filials --, count(pole_1) statreg_filials --, pole_2
from statregistr7
join okpo_statreg_by_gleb on statregistr7.pole_1=okpo_statreg_by_gleb.okpo
where pole_9 in ('2','3') or (right(pole_3,4) <> '0001')   
--((length(pole_3) > 2) and (pole_3 <> pole_2))
--where pole_3 is not null and right(pole_3, 9) > '001'
--and pole_2 = '27128343'--and pole_6 like '%НИУ ВШЭ%'
--group by pole_2, pole_1
order by pole_1 desc
) statreg
full join
(select okpo_head, okpo inv_filials
from razdel_1_1
where org_status in ('2','3')
--and okpo_head = '27128343'
--group by okpo_head, okpo
order by inv_filials desc
) inv
on statreg.pole_2=inv.okpo_head and statreg.pole_3=inv.inv_filials
) z
--order by "окпо из выборки (поле 2)"
select count(*) --pole_2, pole_3 --, pole_1 statreg_filials --, count(pole_1) statreg_filials --, pole_2
from statregistr7
join okpo_statreg_by_gleb on statregistr7.pole_1=okpo_statreg_by_gleb.okpo
where --pole_9 in ('2','3') or 
(right(pole_3,4) <> '0001')  or 
((length(pole_3) > 2) and pole_3 <> pole_2)


--where pole_2=okpo_head is True
---
select count(pole_1) statreg_filials --, pole_2
from statregistr7
join okpo_statreg_by_gleb on statregistr7.pole_1=okpo_statreg_by_gleb.okpo
where pole_9 in ('2','3')
--

select count(*) --pole_2, pole_3 --, pole_1 statreg_filials --, count(pole_1) statreg_filials --, pole_2
from statregistr7
join okpo_statreg_by_gleb on statregistr7.pole_1=okpo_statreg_by_gleb.okpo
--where pole_9 in ('2','3')
where pole_3 is not null 
and length(trim(pole_3))=14 --or length(trim(pole_3))=8
and pole_3 <> ''
and right(pole_3::text, 3)::int > 1
--

(select *
from licenses_edited
where right(inn,2)='.0'   
--40762+186
---
select count(*) from
(select *
from (
select pole_1,array_agg(edu_level) e_l
from statreg7_ron_matched
group by pole_1
) x
where (e_l::text not like '%Дополнительное образование детей и взрослых%'
or e_l::text not like '%Дополнительное образование%')
) z
join 
(select distinct pole_1 from
statreg7_ron_matched
where pole_67 like '%054%') y
on z.pole_1=y.pole_1
--

---
--40762 сошлось
--43743 сошлось по lower
--43757 сошлось по lower trim
--169045
--full 170626
--trim 170608

--42
select RANK () OVER (
      ORDER BY pole_2
   ) rank_number
,pole_2 "окпо из выборки (поле 2)"
,pole_6 "кор.название из выборки"
,okpo_head "окпо головы бд инв (okpo_head)"
--,statreg_filials
, pole_3 "Статрег. филиалы (поле 3)"
,inv_filials
, short_name "кор.название бд инв"
, pole_2=okpo_head "совпала голова?" from 
(select pole_2, pole_3, pole_6 --, pole_1 statreg_filials --, count(pole_1) statreg_filials --, pole_2
from statregistr7
join okpo_statreg_by_gleb on statregistr7.pole_1=okpo_statreg_by_gleb.okpo
where pole_9 in ('2','3') 
--and pole_2 = '27128343'--and pole_6 like '%НИУ ВШЭ%'
--group by pole_2, pole_1
order by pole_1 desc
) statreg
full join
(select okpo_head, razdel_1_1.okpo inv_filials, short_name
from razdel_1_1
join org_inf on razdel_1_1.okpo=org_inf.okpo
where org_status in ('2','3')
--and okpo_head = '27128343'
--group by okpo_head, okpo
order by inv_filials desc
) inv
on statreg.pole_2=inv.okpo_head and statreg.pole_3=inv.inv_filials
--
-- 43 совпадение окпо и названий
select pole_1
,inv_okpo
,pole_6 "статрег.кор.назв."
,short_name "бд инв.кор.назв."
,pole_7 "статрег.длин.назв."
,full_name "бд инв.длин.назв."
,lower(trim(replace(pole_6,'"','')))=lower(trim(replace(short_name,'"',''))) "совп. кор. названия?"
,lower(trim(replace(pole_7,'"','')))=lower(trim(replace(full_name,'"',''))) "совп. длин. названия?"
--select count(*)
from (
(select pole_1, pole_6, pole_7
from statregistr7
--join okpo_statreg_by_gleb on statregistr7.pole_1=okpo_statreg_by_gleb.okpo
where in_vyborka = '1'
--where pole_9 in ('2','3') 
--and pole_2 = '27128343'--and pole_6 like '%НИУ ВШЭ%'
) statreg
full join
(select razdel_1_1.okpo inv_okpo, short_name, full_name
from razdel_1_1
join org_inf on razdel_1_1.okpo=org_inf.okpo
--where org_status in ('2','3')
--and okpo_head = '27128343'
--group by okpo_head, okpo
order by inv_okpo desc
) inv
on statreg.pole_1=inv.inv_okpo --and statreg.pole_3=inv.inv_okpo
) x
-- 43 длин
select pole_1
,inv_okpo
,pole_7 "статрег.длин.назв."
,full_name "бд инв.длин.назв."
,lower(trim(replace(pole_7,'"','')))=lower(trim(replace(full_name,'"',''))) "совп. названия?"
--select count(*)
from (
(select pole_1, pole_7 
from statregistr7
join okpo_statreg_by_gleb on statregistr7.pole_1=okpo_statreg_by_gleb.okpo
--where pole_9 in ('2','3') 
--and pole_2 = '27128343'--and pole_6 like '%НИУ ВШЭ%'
) statreg
full join
(select razdel_1_1.okpo inv_okpo, full_name
from razdel_1_1
join org_inf on razdel_1_1.okpo=org_inf.okpo
--where org_status in ('2','3')
--and okpo_head = '27128343'
--group by okpo_head, okpo
order by inv_okpo desc
) inv
on statreg.pole_1=inv.inv_okpo --and statreg.pole_3=inv.inv_okpo
) x
--
select okpo, okpo_head
from razdel_1_1
where org_status in ('2', '3')

select okpo, okpo_head
from razdel_1_1
where okpo_head <> '9999' and okpo <> okpo_head

--6 (1_1=1_3)
select okpo, okpo_branch, branch_name from
(select * 
from razdel_1_1
where org_status in ('2', '3') and okpo <> okpo_head and okpo_head <> '9999') a
full join
(select distinct okpo_branch, branch_name
from razdel_1_3
where gr3 <> '9999' and gr4 <> '9999' and okpo_branch <> '9999' and gr6 <> '9999' ) b
on a.okpo=b.okpo_branch
--where okpo is null
--6 b (р1_3=Статрегистр)
select okpo_branch,pole_3, branch_name from
(select distinct okpo_branch, branch_name
from razdel_1_3
where gr3 <> '9999' and gr4 <> '9999' and okpo_branch <> '9999' and gr6 <> '9999' ) b
join
(select pole_3
from statregistr7
where in_vyborka = '1') c
on b.okpo_branch=c.pole_3
--6 c (р1_3=РОН
select okpo_branch,pole_3, branch_name from
(select distinct okpo_branch, branch_name
from razdel_1_3
where gr3 <> '9999' and gr4 <> '9999' and okpo_branch <> '9999' and gr6 <> '9999' ) b
join
(select pole_3
from statreg7_ron_matched
) c
on b.okpo_branch=c.pole_3
--
select *
from licenses_edited
where branch = 'nan'
--
select count(inn) from (
select distinct inn,ogrn, fullname
from vyborka_lic --statreg7_ron_matched
) x
where head = 'H'

select count(distinct pole_1)
from statreg7_ron_matched
where head = 'F'
--
ALTER TABLE statregistr.razdel_1_1 ADD COLUMN id SERIAL PRIMARY KEY;
ALTER TABLE statregistr.razdel_1_3 ALTER COLUMN okpo_branch TYPE varchar(255)
select count(*) from org_inf

--drop table razdel_1_1

--статрег 163885
--Новые организации в лицензиях
select count(*)
from
(select distinct razdel_1_1.okpo, inn, ogrn, lower(trim(replace(short_name,'"',''))) short_name
, lower(trim(replace(full_name,'"',''))) full_name from razdel_1_1 join org_inf on razdel_1_1.okpo=org_inf.okpo
left join statregistr7 on razdel_1_1.okpo=pole_1
where pole_1 is null --and in_vyborka = '1'
) new_org
join 
(select distinct inn, ogrn
, lower(trim(replace(fullname,'"',''))) fullname
, lower(trim(replace(shortname,'"',''))) shortname from licenses_edited) b
on (new_org.inn=b.inn and new_org.ogrn=b.ogrn) 
and (new_org.full_name=b.fullname or new_org.short_name=b.shortname)
--
select count(distinct "1")
from statregistr_statregistr6
--
select count(distinct "1")
from _0_statregistr_statregistr7

--select (replace(name,'.0','')::int) from 
select replace(name,'.0','') from 
(
select * from get_google_table('https://docs.google.com/spreadsheets/d/e/2PACX-1vQBXVgsSWOe28Dr0sZPv6pne96aJYGvVr7utkXHh1CdC-oPwVYoa8LA4Nhvl_1IlLT0Itqfxa9nKEAz/pub?gid=0&single=true&output=csv'::text) a(id text, name text)
where name <> 'nan'
order by name
) a





select report::int, status::int, count(okpo)
from (select * from statregistr7 where in_vyborka='1') statregistr7 right join org_inf
on statregistr7.pole_1=org_inf.okpo or org_inf.okpo=statregistr7.pole_3
where statregistr7.pole_1 is null 
group by report,status
union
select 100 report, 100 status, count(*)
from (select * from statregistr7 where in_vyborka='1'
) statregistr7 right join org_inf
on statregistr7.pole_1=org_inf.okpo or org_inf.okpo=statregistr7.pole_3
where statregistr7.pole_1 is null --or statregistr7.pole_3 is null
order by report, status
--
select count(*) from (
select distinct pole_1
from (select distinct pole_1 from statregistr7 --where in_vyborka='1'
) statregistr7
union all
select distinct pole_3
from (select * from statregistr7 --where in_vyborka='1'
) statregistr7
) x
right join org_inf
on x.pole_1=org_inf.okpo
where x.pole_1 is null
--
select count(pole_1)
from statregistr7
--
select okpo okpo_org_inf, full_name full_name_org_inf, pole_1,pole_3,pole_6 from
(select a.okpo, a.full_name
from
(select okpo, full_name
from (select * from statregistr7 where in_vyborka='1') statregistr7 right join org_inf
on statregistr7.pole_1=org_inf.okpo or org_inf.okpo=statregistr7.pole_3
where statregistr7.pole_1 is null 
) a
full join 
(select okpo,pole_1 --, full_name
from statregistr7 right join org_inf
on statregistr7.pole_1=org_inf.okpo or org_inf.okpo=statregistr7.pole_3
where statregistr7.pole_1 is null 
) b
on a.okpo=b.okpo
where a.okpo is null or b.okpo is null) x
join statregistr7
on x.okpo=statregistr7.pole_1 or x.okpo=statregistr7.pole_3


--
select report, count(*)
from (select * from statregistr7 where in_vyborka='1') statregistr7 right join org_inf
on statregistr7.pole_1=org_inf.okpo or org_inf.okpo=statregistr7.pole_3
where statregistr7.pole_1 is null
group by report
--order by report::int
union
select '100' report,count(*)
from (select * from statregistr7 where in_vyborka='1') statregistr7 right join org_inf
on statregistr7.pole_1=org_inf.okpo or org_inf.okpo=statregistr7.pole_3
where statregistr7.pole_1 is null
order by count

select count(*)
from (select * from statregistr7 where in_vyborka='1') statregistr7 right join razdel_1_1
on statregistr7.pole_1=razdel_1_1.okpo
where statregistr7.pole_1 is null 
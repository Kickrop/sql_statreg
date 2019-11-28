--drop MATERIALIZED VIEW statreg7_ron_matched
CREATE MATERIALIZED VIEW statreg7_ron_matched
AS  
select pole_1::varchar(255), pole_3::varchar(255), pole_6, pole_7, pole_14, pole_8::varchar(255), pole_27::varchar(255), pole_21, pole_67, license_status, edu_level --a.okpo, gr3, pole_67, pole_8, pole_7, pole_6, pole_27 
from --statregistr.razdel_1_2_1 a
--join statregistr.razdel_1_1 b on a.okpo=b.okpo
--join 
okpo_statreg_by_gleb ba
--join 
--statregistr7 c on ba.okpo = c.pole_1 --on a.okpo=c.pole_1 or (c.pole_3=a.okpo)
join
		(select pole_1,pole_3,pole_14,pole_8,pole_21, pole_27, pole_67, lower(trim(pole_7)) pole_7,lower(trim(pole_6)) pole_6
		from statregistr7) c
on ba.okpo = c.pole_1 --on a.okpo=c.pole_1 or (c.pole_3=a.okpo)
join 
		(select inn,ogrn, lower(trim(fullname)) fullname, lower(trim(shortname)) shortname, license_status, edu_level
		from
		licenses_edited) d on (c.pole_8=d.inn or c.pole_27=d.ogrn or c.pole_7=d.fullname or c.pole_6=d.shortname)
WITH DATA;

CREATE INDEX idx_pole27 ON statreg7_ron_matched(pole_27);
CREATE INDEX idx_pole1 ON statreg7_ron_matched(pole_1);
CREATE INDEX idx_pole6 ON statreg7_ron_matched(pole_6);
CREATE INDEX idx_license_status ON statreg7_ron_matched(license_status);
CREATE INDEX idx_edu_level ON statreg7_ron_matched(edu_level);

CREATE INDEX idx_pole14_oktmo ON statregistr7(pole_14);

---
select pole_1, pole_2, pole_6
from statregistr7
where 
--pole_2=pole_1
--and length(pole_2)=8
--and 
pole_6 like '%НИУ ВШЭ%'
order by pole_6
--
--по окпо
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
--order by "окпо из выборки (поле 2)"
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

--
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
,pole_6=short_name "совп. названия?"
--select count(*)
from (
(select pole_1, pole_6 
from statregistr7
join okpo_statreg_by_gleb on statregistr7.pole_1=okpo_statreg_by_gleb.okpo
--where pole_9 in ('2','3') 
--and pole_2 = '27128343'--and pole_6 like '%НИУ ВШЭ%'
) statreg
full join
(select razdel_1_1.okpo inv_okpo, short_name
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
,pole_7=full_name "совп. названия?"
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

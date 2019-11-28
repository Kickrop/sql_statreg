select count(*) from
(select a.okpo, gr3, pole_8, pole_67, pole_7, pole_6, pole_27 from statregistr.razdel_1_2_2 a
join statregistr.razdel_1_1 b on a.okpo=b.okpo
join statregistr.statregistr7 c on a.okpo=c.pole_1 or (c.pole_3=a.okpo)
--join statregistr.licenses_edited d on (c.pole_8=d.inn) or (c.pole_27=d.ogrn) or (c.pole_7=d.fullname) or (c.pole_6=d.shortname) --or (b.kpp=d.kpp) --or c.pole_7=d.fullname
where a.gr3='2' and a.str_n = 1 and pole_67 like '%054%' and in_vyborka = '1'
) z
join
(select pole_1, edu_level::text
from (
select pole_1, array_agg(edu_level) edu_level
FROM statregistr.statreg7_ron_matched
group by pole_1
) x
--where edu_level::text not like ('%ƒополнительное образование детей и взрослых%') or edu_level::text not like '%ƒополнительное образование%'
) b
on z.okpo=b.pole_1
--where b.pole_1 is null

select count(*) from (
select * from (
select distinct a.okpo, a.inn, a.ogrn, trim(lower(replace(replace(a2.full_name,'"','')::text,'-',''))) full_name
from razdel_1_1 a
join org_inf a2 on a.okpo=a2.okpo
--join vyborka_lic b on a.okpo=
left join statreg7_ron_matched b on a.okpo=b.pole_1
where --in_vyborka='1' and 
b.pole_1 is null
) x
join 
(select distinct inn, ogrn, trim(lower(replace(replace(fullname,'"','')::text,'-',''))) fullname from vyborka_lic) z
on (x.inn=z.inn and x.ogrn=z.ogrn) or x.full_name=z.fullname

order by x.inn




--33
SELECT a.okpo, a.str_n, a.gr3, a.gr6
, b.okpo, b.str_n, b.gr3, b.gr4
, c.okpo, c.str_n, c.gr3
select count(*)
FROM (select okpo, str_n, gr3, gr6 from razdel_1_2_1
where gr3 = '1' and gr6<>'2') AS a 
INNER JOIN 
(select *
	from razdel_1_2_2
WHERE (str_n = 1 and gr3 = '2') or (str_n = 1 and gr4 = '2')
	)  AS b ON a.okpo = b.okpo
INNER JOIN (select okpo, str_n, gr3, gr4, gr5, gr6, gr7
	from razdel_2
WHERE (str_n = 1 and gr3 <> 0) or (str_n = 11 and gr3 <> 0)
	)  AS c ON c.okpo = b.okpo
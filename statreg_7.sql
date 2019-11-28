select count(distinct x.okpo) --, gr3, pole_67 
from (
select a.okpo, gr3, pole_67, pole_8, pole_7, pole_6, pole_27 from statregistr.razdel_1_2_1 a
join statregistr.razdel_1_1 b on a.okpo=b.okpo
join statregistr.statregistr7 c on a.okpo=c.pole_1 or (c.pole_3=a.okpo)
where a.gr3='1' and c.pole_67 like '%005%'
) x
join
statregistr.licenses_edited d on (x.pole_8=d.inn) or (x.pole_27=d.ogrn) or (x.pole_7=d.fullname) or (x.pole_6=d.shortname)
--
select distinct x.okpo, gr3, pole_67 
from (
select a.okpo, gr3, pole_67, pole_8, pole_7, pole_6, pole_27 from statregistr.razdel_1_2_1 a
join statregistr.razdel_1_1 b on a.okpo=b.okpo
join statregistr.statregistr7 c on a.okpo=c.pole_1 or (c.pole_3=a.okpo)
join
statregistr.licenses_edited d on (c.pole_8=d.inn) or (c.pole_27=d.ogrn) or (c.pole_7=d.fullname) or (c.pole_6=d.shortname)
where a.gr3='1' and c.pole_67 not like '%005%'
) x
--
select distinct x.okpo, gr3, count(edu_level) --, pole_67 SIMILAR TO '005'--REGEXP_MATCHES(pole_67,'005') pole_67_005 --count(distinct a.okpo) --distinct a.okpo--count(distinct a.okpo) --REGEXP_MATCHES(pole_67,'005') 
from (
select a.okpo, gr3, pole_8, pole_67, pole_7, pole_6, pole_27, edu_level from statregistr.razdel_1_2_2 a
join statregistr.razdel_1_1 b on a.okpo=b.okpo
join statregistr.statregistr7 c on a.okpo=c.pole_1 or (c.pole_3=a.okpo)
--join statregistr.licenses_edited d on (c.pole_8=d.inn) or (c.pole_27=d.ogrn) or (c.pole_7=d.fullname) or (c.pole_6=d.shortname) --or (b.kpp=d.kpp) --or c.pole_7=d.fullname
join
statregistr.licenses_edited d on (c.pole_8=d.inn) --or (x.pole_27=d.ogrn) or (x.pole_7=d.fullname) or (x.pole_6=d.shortname)
where a.gr3='1' and a.str_n = 1 and pole_67 not like '%054%' and edu_level not in ('Дополнительное образование детей и взрослых', 'Дополнительное образование') --and branch = '1'--and d.inn is null 
--group by x.okpo
) x
group by x.okpo, gr3
--
select distinct x.okpo, gr3, edu_level --, pole_67 SIMILAR TO '005'--REGEXP_MATCHES(pole_67,'005') pole_67_005 --count(distinct a.okpo) --distinct a.okpo--count(distinct a.okpo) --REGEXP_MATCHES(pole_67,'005') 
from (
select a.okpo, gr3, pole_8, pole_67, pole_7, pole_6, pole_27 from statregistr.razdel_1_2_2 a
join statregistr.razdel_1_1 b on a.okpo=b.okpo
join statregistr.statregistr7 c on a.okpo=c.pole_1 or (c.pole_3=a.okpo)
--join statregistr.licenses_edited d on (c.pole_8=d.inn) or (c.pole_27=d.ogrn) or (c.pole_7=d.fullname) or (c.pole_6=d.shortname) --or (b.kpp=d.kpp) --or c.pole_7=d.fullname
where a.gr3='2' and a.str_n = 1 and pole_67 like '%054%'
) x
 join
statregistr.licenses_edited d on (x.pole_8=d.inn) --or (x.pole_27=d.ogrn) or (x.pole_7=d.fullname) or (x.pole_6=d.shortname)
where edu_level not in ('Дополнительное образование детей и взрослых', 'Дополнительное образование')
--
select x.okpo
, case when add_okved_85_41 = 1 then 'БД ИНВ Содержит 85.41' end
, case when pole_22_85_41 is null then 'Статрег Не содержит 85.41' end
from	 
	(select okpo, avg(case when left(gr4_okved_add,5) = '85.41' then 1 end) add_okved_85_41
	from statregistr.additional_okved
	where str_n = 2
	group by okpo
	) x
join 
(select okpo
 , avg(case when left(pole_22_trimed,5) = '85.41' then 1 end) pole_22_85_41
 , avg(case when left(pole_22_trimed,5) <> '85.41' then 2 end) pole_22_not 
 from statregistr._1_dop_reg_okved_statregistr7
 group by okpo
 ) y
 on (x.okpo = y.okpo)
 where pole_22_85_41 is null and add_okved_85_41 is not null
---
CREATE MATERIALIZED VIEW statregistr._1_dop_fact_okved_statregistr7
AS
select okpo, trim(from pole_79_unnested) pole_79_trimed from (
		select okpo,pole_79_ed, unnest(pole_79_ed) pole_79_unnested
		--select okpo,pole_22_ed--, trim(from pole_22_ed) --pole_22_trimed
			from
				(SELECT *
				from statregistr.okpo_statreg_by_gleb) a
			join
				(SELECT pole_1, string_to_array(pole_79,';') pole_79_ed
				FROM statregistr._0_statregistr7
				) b
			on (a.okpo = b.pole_1)
		--limit 100
		) c
WITH DATA;
---
select max(length(shortname))
from licenses_edited

ALTER TABLE statregistr7 ALTER COLUMN pole_6 TYPE varchar(500) USING pr_code_upd::integer
ALTER TABLE licenses_edited ALTER COLUMN shortname TYPE varchar(500) USING pr_code_upd::integer

--DROP index statregistr_statregistr7_fullname

create index statregistr_statregistr7_fullname_
  on _0_statregistr7 ("pole_7");

create index "_statregistr_statregistr7_id_"
  on statregistr._0_statregistr7 ("pole_3");

create index "_statregistr_statregistr7_inn_"
  on statregistr._0_statregistr7 ("pole_8");

create index "_statregistr_statregistr7_ogrn_"
  on statregistr._0_statregistr7 ("pole_27");

create index "_statregistr_statregistr7_okpo_"
  on statregistr._0_statregistr7 ("pole_1");

create index "_statregistr_statregistr7_shortname_"
  on statregistr._0_statregistr7 ("pole_6");

create index "_statregistr_statregistr7_9_"
  on statregistr._0_statregistr7 ("pole_9");

create index "_statregistr_statregistr7_2"
  on statregistr._0_statregistr7 ("pole_2");
  
 
 
 
 
SELECT *
FROM 
	(
	select okpo_statreg_by_gleb.okpo from (
	statregistr.okpo_statreg_by_gleb 
	LEFT JOIN 
	statregistr.razdel_1_1 
	ON statregistr.okpo_statreg_by_gleb.okpo = statregistr.razdel_1_1.okpo
	--WHERE statregistr.razdel_1_1.okpo is null and len(okpo)=14 And Right(RTrim(okpo),3)>1
	) as a
) as b
INNER JOIN statregistr.statregistr7
on statregistr7.pole_3 = b.okpo
; 
select count(*) from statregistr.razdel_2
delete from statregistr.razdel_2
--drop table public.additional_okved

--select * --x.okpo, statregistr.statregistr7.pole_3 
--from (
select max(length(pole_3)) from statregistr.statregistr7 
--3b
	select okpo_statreg_by_gleb.okpo, pole_3 
	from statregistr.okpo_statreg_by_gleb 
	LEFT JOIN statregistr.razdel_1_1 
	ON okpo_statreg_by_gleb.okpo = razdel_1_1.okpo
	join statregistr.statregistr7
	on okpo_statreg_by_gleb.okpo = statregistr.statregistr7.pole_1
	WHERE statregistr.razdel_1_1.okpo is null and length(okpo_statreg_by_gleb.okpo) = 14 and right(TRIM(okpo_statreg_by_gleb.okpo),3) > '001' --len(okpo)=14 And Right(RTrim(okpo),3)>1
	and okpo_statreg_by_gleb.okpo <> pole_3
	--) x
---	) a
join statregistr.statregistr7
on a.okpo = statregistr.statregistr7.pole_3
limit 100

) as a
) as b
INNER JOIN statregistr.statregistr7
on statregistr7.pole_3 = b.okpo
 
--2494
SELECT Count(org_inf.okpo)
FROM (((org_inf INNER JOIN razdel_1_1 ON org_inf.okpo = razdel_1_1.okpo) INNER JOIN razdel_1_2_1 ON org_inf.okpo = razdel_1_2_1.okpo) LEFT JOIN razdel_1_2_2 ON org_inf.okpo = razdel_1_2_2.okpo) INNER JOIN statreg7_ron_matched ON org_inf.okpo = statreg7_ron_matched.okpo_id
WHERE (((org_inf.report)=1 Or (org_inf.report)=18) AND ((razdel_1_1.org_izm)='1' Or (razdel_1_1.org_izm)='3' Or (razdel_1_1.org_izm) Is Null) AND ((razdel_1_2_1.gr3)='1') AND ((razdel_1_2_1.gr6)<>'2' Or (razdel_1_2_1.gr6) Is Null) AND ((razdel_1_2_2.str_n)=1) AND ((razdel_1_2_2.gr3)<>'1' Or (razdel_1_2_2.gr3) Is Null)) OR (((org_inf.report)=1 Or (org_inf.report)=18) AND ((razdel_1_1.org_izm)='1' Or (razdel_1_1.org_izm)='3' Or (razdel_1_1.org_izm) Is Null) AND ((razdel_1_2_1.gr3)='1') AND ((razdel_1_2_1.gr6)<>'2' Or (razdel_1_2_1.gr6) Is Null) AND ((razdel_1_2_2.str_n) Is Null) AND ((razdel_1_2_2.gr3) Is Null));
--
--3011
SELECT Count(org_inf.okpo)
FROM org_inf INNER JOIN statreg7_ron_matched ON org_inf.okpo = statreg7_ron_matched.okpo_id
WHERE (((org_inf.report)=8 Or (org_inf.report)=10));
--
--705
SELECT Count(org_inf.okpo)
FROM org_inf INNER JOIN statreg7_ron_matched ON org_inf.okpo = statreg7_ron_matched.okpo_id
WHERE (((org_inf.report)=6));
--
--67315
SELECT Count(org_inf.okpo)
FROM ((org_inf INNER JOIN razdel_1_1 ON org_inf.okpo = razdel_1_1.okpo) INNER JOIN razdel_1_2_1 ON org_inf.okpo = razdel_1_2_1.okpo) INNER JOIN razdel_1_2_2 ON org_inf.okpo = razdel_1_2_2.okpo
WHERE (((org_inf.report)=1 Or (org_inf.report)=18) AND ((razdel_1_1.org_izm)='1' Or (razdel_1_1.org_izm)='3' Or (razdel_1_1.org_izm) Is Null) AND ((razdel_1_2_1.gr3)='1') AND ((razdel_1_2_1.gr6)<>'2' Or (razdel_1_2_1.gr6) Is Null) AND ((razdel_1_2_2.str_n)=1) AND ((razdel_1_2_2.gr3)='1') AND ((razdel_1_2_2.gr4)<>'2' Or (razdel_1_2_2.gr4) Is Null)) OR (((org_inf.report)=1 Or (org_inf.report)=18) AND ((razdel_1_1.org_izm)='1' Or (razdel_1_1.org_izm)='3' Or (razdel_1_1.org_izm) Is Null) AND ((razdel_1_2_1.gr3)<>'1' Or (razdel_1_2_1.gr3) Is Null) AND ((razdel_1_2_2.str_n)=1) AND ((razdel_1_2_1.gr7)='1') AND ((razdel_1_2_2.gr5)='1'));

--update included_in_registr
--included_in_registr
--alter table org_inf add column included_in_registr bool default False
update org_inf
set included_in_registr = True
where okpo in (
--select count(distinct okpo) from (  ----73525
		SELECT org_inf.okpo
		FROM (((org_inf INNER JOIN razdel_1_1 ON org_inf.okpo = razdel_1_1.okpo) INNER JOIN razdel_1_2_1 ON org_inf.okpo = razdel_1_2_1.okpo) LEFT JOIN razdel_1_2_2 ON org_inf.okpo = razdel_1_2_2.okpo) INNER JOIN statreg7_ron_matched ON org_inf.okpo = statreg7_ron_matched.okpo_id
		WHERE (((org_inf.report)=1 Or (org_inf.report)=18) AND ((razdel_1_1.org_izm)='1' Or (razdel_1_1.org_izm)='3' Or (razdel_1_1.org_izm) Is Null) AND ((razdel_1_2_1.gr3)='1') AND ((razdel_1_2_1.gr6)<>'2' Or (razdel_1_2_1.gr6) Is Null) AND ((razdel_1_2_2.str_n)=1) AND ((razdel_1_2_2.gr3)<>'1' Or (razdel_1_2_2.gr3) Is Null)) OR (((org_inf.report)=1 Or (org_inf.report)=18) AND ((razdel_1_1.org_izm)='1' Or (razdel_1_1.org_izm)='3' Or (razdel_1_1.org_izm) Is Null) AND ((razdel_1_2_1.gr3)='1') AND ((razdel_1_2_1.gr6)<>'2' Or (razdel_1_2_1.gr6) Is Null) AND ((razdel_1_2_2.str_n) Is Null) AND ((razdel_1_2_2.gr3) Is Null))
		union
		SELECT org_inf.okpo
		FROM org_inf INNER JOIN statreg7_ron_matched ON org_inf.okpo = statreg7_ron_matched.okpo_id
		WHERE (((org_inf.report)=8 Or (org_inf.report)=10))
		union
		SELECT org_inf.okpo
		FROM org_inf INNER JOIN statreg7_ron_matched ON org_inf.okpo = statreg7_ron_matched.okpo_id
		WHERE (((org_inf.report)=6))
		union
		SELECT org_inf.okpo
		FROM ((org_inf INNER JOIN razdel_1_1 ON org_inf.okpo = razdel_1_1.okpo) INNER JOIN razdel_1_2_1 ON org_inf.okpo = razdel_1_2_1.okpo) INNER JOIN razdel_1_2_2 ON org_inf.okpo = razdel_1_2_2.okpo
		WHERE (((org_inf.report)=1 Or (org_inf.report)=18) AND ((razdel_1_1.org_izm)='1' Or (razdel_1_1.org_izm)='3' Or (razdel_1_1.org_izm) Is Null) AND ((razdel_1_2_1.gr3)='1') AND ((razdel_1_2_1.gr6)<>'2' Or (razdel_1_2_1.gr6) Is Null) AND ((razdel_1_2_2.str_n)=1) AND ((razdel_1_2_2.gr3)='1') AND ((razdel_1_2_2.gr4)<>'2' Or (razdel_1_2_2.gr4) Is Null)) OR (((org_inf.report)=1 Or (org_inf.report)=18) AND ((razdel_1_1.org_izm)='1' Or (razdel_1_1.org_izm)='3' Or (razdel_1_1.org_izm) Is Null) AND ((razdel_1_2_1.gr3)<>'1' Or (razdel_1_2_1.gr3) Is Null) AND ((razdel_1_2_2.str_n)=1) AND ((razdel_1_2_1.gr7)='1') AND ((razdel_1_2_2.gr5)='1'))
)
--) x
--check included_in_registr true == 73525
select count(*)
from org_inf
where included_in_registr = true
--
--

--in registr is dod
--1) 58862
SELECT count(distinct org_inf.okpo)
FROM (((org_inf INNER JOIN razdel_1_1 ON org_inf.okpo = razdel_1_1.okpo) INNER JOIN razdel_1_2_1 ON org_inf.okpo = razdel_1_2_1.okpo) INNER JOIN razdel_1_2_2 ON org_inf.okpo = razdel_1_2_2.okpo) INNER JOIN razdel_2 ON org_inf.okpo = razdel_2.okpo
WHERE (((org_inf.report)=1 Or (org_inf.report)=18) AND ((razdel_1_1.org_izm)='1' Or (razdel_1_1.org_izm)='3' Or (razdel_1_1.org_izm) Is Null) AND ((razdel_1_2_1.gr3)='1') AND ((razdel_1_2_1.gr6)<>'2' Or (razdel_1_2_1.gr6) Is Null) AND ((razdel_1_2_2.str_n)=1) AND ((razdel_1_2_2.gr3)='1') AND ((razdel_1_2_2.gr4)<>'2' Or (razdel_1_2_2.gr4) Is Null) AND ((razdel_2.str_n) Between 1 And 10 Or (razdel_2.str_n)=14) AND ((razdel_2.gr3)>0)) OR (((org_inf.report)=1 Or (org_inf.report)=18) AND ((razdel_1_1.org_izm)='1' Or (razdel_1_1.org_izm)='3' Or (razdel_1_1.org_izm) Is Null) AND ((razdel_1_2_1.gr3)<>'1' Or (razdel_1_2_1.gr3) Is Null) AND ((razdel_1_2_2.str_n)=1) AND ((razdel_2.str_n) Between 1 And 10 Or (razdel_2.str_n)=14) AND ((razdel_2.gr3)>0) AND ((razdel_1_2_1.gr7)='1') AND ((razdel_1_2_2.gr5)='1'))
GROUP BY org_inf.okpo
--
--8453
--select count(*) from (
create materialized view statregistr.graf_27_vsp1 as 
SELECT org_inf.okpo
FROM 
	(((org_inf 
	INNER JOIN razdel_1_1 ON org_inf.okpo = razdel_1_1.okpo) 
	INNER JOIN razdel_1_2_1 ON org_inf.okpo = razdel_1_2_1.okpo) 
	INNER JOIN razdel_1_2_2 ON org_inf.okpo = razdel_1_2_2.okpo) 
	LEFT JOIN razdel_2 ON org_inf.okpo = razdel_2.okpo
WHERE 
	(((org_inf.report)=1 Or 
	(org_inf.report)=18) AND 
	((razdel_1_1.org_izm)='1' Or 
	(razdel_1_1.org_izm)='3' Or 
	(razdel_1_1.org_izm) Is Null) AND 
	((razdel_1_2_1.gr3)='1') AND 
	((razdel_1_2_1.gr6)<>'2' Or 
	(razdel_1_2_1.gr6) Is Null) AND 
	((razdel_1_2_2.str_n)=1) AND 
	((razdel_1_2_2.gr3)='1') AND 
	((razdel_1_2_2.gr4)<>'2' Or 
	(razdel_1_2_2.gr4) Is Null) AND 
	((razdel_2.str_n) Between 1 And 10 Or 
	(razdel_2.str_n)=14)) OR 
	(((org_inf.report)=1 Or 
	(org_inf.report)=18) AND 
	((razdel_1_1.org_izm)='1' Or 
	(razdel_1_1.org_izm)='3' Or 
	(razdel_1_1.org_izm) Is Null) AND 
	((razdel_1_2_1.gr3)<>'1' Or 
	(razdel_1_2_1.gr3) Is Null) AND 
	((razdel_1_2_2.str_n)=1) AND 
	((razdel_2.str_n) Between 1 And 10 Or 
	(razdel_2.str_n)=14) AND ((razdel_1_2_1.gr7)='1') AND 
	((razdel_1_2_2.gr5)='1')) OR 
	(((org_inf.report)=1 Or 
	(org_inf.report)=18) AND 
	((razdel_1_1.org_izm)='1' Or 
	(razdel_1_1.org_izm)='3' Or 
	(razdel_1_1.org_izm) Is Null) AND 
	((razdel_1_2_1.gr3)='1') AND 
	((razdel_1_2_1.gr6)<>'2' Or 
	(razdel_1_2_1.gr6) Is Null) AND 
	((razdel_1_2_2.str_n)=1) AND 
	((razdel_1_2_2.gr3)='1') AND 
	((razdel_1_2_2.gr4)<>'2' Or 
	(razdel_1_2_2.gr4) Is Null) AND 
	((razdel_2.okpo) Is Null)) OR 
	(((org_inf.report)=1 Or 
	(org_inf.report)=18) AND 
	((razdel_1_1.org_izm)='1' Or 
	(razdel_1_1.org_izm)='3' Or 
	(razdel_1_1.org_izm) Is Null) AND 
	((razdel_1_2_1.gr3)<>'1' Or 
	(razdel_1_2_1.gr3) Is Null) AND 
	((razdel_1_2_2.str_n)=1) AND 
	((razdel_1_2_1.gr7)='1') AND 
	((razdel_1_2_2.gr5)='1') AND 
	((razdel_2.okpo) Is Null))
GROUP BY org_inf.okpo
HAVING 
	(((Sum(razdel_2.gr3))=0 Or 
	(Sum(razdel_2.gr3)) Is Null Or 
	((Sum(razdel_2.gr3))=0 Or 
	(Sum(razdel_2.gr3)) Is Null)))
) x;
--
select count(*)
from graf_27_vsp1
--
--2048
SELECT Count(graf_27_vsp1.okpo)
FROM graf_27_vsp1 INNER JOIN org_inf ON graf_27_vsp1.okpo = org_inf.okpo
WHERE (((org_inf."1dop2018")=1));
--
--156
SELECT Count(org_inf.okpo)
FROM org_inf INNER JOIN statreg7_ron_matched ON org_inf.okpo = statreg7_ron_matched.okpo_id
WHERE (((org_inf.report)=6) AND ((org_inf."1dop2018")=1));
--
--659
SELECT Count(org_inf.okpo)
FROM org_inf INNER JOIN statreg7_ron_matched ON org_inf.okpo = statreg7_ron_matched.okpo_id
WHERE (((org_inf.report)=8 Or (org_inf.report)=10) AND ((org_inf."1dop2018")=1));
--
--578
SELECT Count(org_inf.okpo)
FROM (((org_inf 
	INNER JOIN razdel_1_1 ON org_inf.okpo = razdel_1_1.okpo) 
	INNER JOIN razdel_1_2_1 ON org_inf.okpo = razdel_1_2_1.okpo) 
	LEFT JOIN razdel_1_2_2 ON org_inf.okpo = razdel_1_2_2.okpo) 
	INNER JOIN statreg7_ron_matched ON org_inf.okpo = statreg7_ron_matched.okpo_id
WHERE 
	(((org_inf.report)=1 Or 
	(org_inf.report)=18) AND 
	((razdel_1_1.org_izm)='1' Or 
	(razdel_1_1.org_izm)='3' Or 
	(razdel_1_1.org_izm) Is Null) AND 
	((razdel_1_2_1.gr3)='1') AND 
	((razdel_1_2_1.gr6)<>'2' Or 
	(razdel_1_2_1.gr6) Is Null) AND 
	((razdel_1_2_2.str_n)=1) AND 
	((razdel_1_2_2.gr3)<>'1' Or 
	(razdel_1_2_2.gr3) Is Null) AND 
	((org_inf."1dop2018")=1)) OR 
	(((org_inf.report)=1 Or 
	(org_inf.report)=18) AND 
	((razdel_1_1.org_izm)='1' Or 
	(razdel_1_1.org_izm)='3' Or 
	(razdel_1_1.org_izm) Is Null) AND 
	((razdel_1_2_1.gr3)='1') AND 
	((razdel_1_2_1.gr6)<>'2' Or 
	(razdel_1_2_1.gr6) Is Null) AND 
	((razdel_1_2_2.str_n) Is Null) AND 
	((razdel_1_2_2.gr3) Is Null) AND 
	((org_inf."1dop2018")=1));
--
--union //62303
--update is_dod
--alter table org_inf add column is_dod bool default False
update org_inf
set is_dod = True
where okpo in (
--select count(*) from (
	SELECT distinct org_inf.okpo
	FROM (((org_inf INNER JOIN razdel_1_1 ON org_inf.okpo = razdel_1_1.okpo) INNER JOIN razdel_1_2_1 ON org_inf.okpo = razdel_1_2_1.okpo) INNER JOIN razdel_1_2_2 ON org_inf.okpo = razdel_1_2_2.okpo) INNER JOIN razdel_2 ON org_inf.okpo = razdel_2.okpo
	WHERE (((org_inf.report)=1 Or (org_inf.report)=18) AND ((razdel_1_1.org_izm)='1' Or (razdel_1_1.org_izm)='3' Or (razdel_1_1.org_izm) Is Null) AND ((razdel_1_2_1.gr3)='1') AND ((razdel_1_2_1.gr6)<>'2' Or (razdel_1_2_1.gr6) Is Null) AND ((razdel_1_2_2.str_n)=1) AND ((razdel_1_2_2.gr3)='1') AND ((razdel_1_2_2.gr4)<>'2' Or (razdel_1_2_2.gr4) Is Null) AND ((razdel_2.str_n) Between 1 And 10 Or (razdel_2.str_n)=14) AND ((razdel_2.gr3)>0)) OR (((org_inf.report)=1 Or (org_inf.report)=18) AND ((razdel_1_1.org_izm)='1' Or (razdel_1_1.org_izm)='3' Or (razdel_1_1.org_izm) Is Null) AND ((razdel_1_2_1.gr3)<>'1' Or (razdel_1_2_1.gr3) Is Null) AND ((razdel_1_2_2.str_n)=1) AND ((razdel_2.str_n) Between 1 And 10 Or (razdel_2.str_n)=14) AND ((razdel_2.gr3)>0) AND ((razdel_1_2_1.gr7)='1') AND ((razdel_1_2_2.gr5)='1'))
	GROUP BY org_inf.okpo
	union
	SELECT graf_27_vsp1.okpo
	FROM graf_27_vsp1 INNER JOIN org_inf ON graf_27_vsp1.okpo = org_inf.okpo
	WHERE (((org_inf."1dop2018")=1))
	union
	SELECT org_inf.okpo
	FROM org_inf INNER JOIN statreg7_ron_matched ON org_inf.okpo = statreg7_ron_matched.okpo_id
	WHERE (((org_inf.report)=6) AND ((org_inf."1dop2018")=1))
	union
	SELECT org_inf.okpo
	FROM org_inf INNER JOIN statreg7_ron_matched ON org_inf.okpo = statreg7_ron_matched.okpo_id
	WHERE (((org_inf.report)=8 Or (org_inf.report)=10) AND ((org_inf."1dop2018")=1))
	union
	SELECT org_inf.okpo
	FROM (((org_inf 
		INNER JOIN razdel_1_1 ON org_inf.okpo = razdel_1_1.okpo) 
		INNER JOIN razdel_1_2_1 ON org_inf.okpo = razdel_1_2_1.okpo) 
		LEFT JOIN razdel_1_2_2 ON org_inf.okpo = razdel_1_2_2.okpo) 
		INNER JOIN statreg7_ron_matched ON org_inf.okpo = statreg7_ron_matched.okpo_id
	WHERE 
		(((org_inf.report)=1 Or 
		(org_inf.report)=18) AND 
		((razdel_1_1.org_izm)='1' Or 
		(razdel_1_1.org_izm)='3' Or 
		(razdel_1_1.org_izm) Is Null) AND 
		((razdel_1_2_1.gr3)='1') AND 
		((razdel_1_2_1.gr6)<>'2' Or 
		(razdel_1_2_1.gr6) Is Null) AND 
		((razdel_1_2_2.str_n)=1) AND 
		((razdel_1_2_2.gr3)<>'1' Or 
		(razdel_1_2_2.gr3) Is Null) AND 
		((org_inf."1dop2018")=1)) OR 
		(((org_inf.report)=1 Or 
		(org_inf.report)=18) AND 
		((razdel_1_1.org_izm)='1' Or 
		(razdel_1_1.org_izm)='3' Or 
		(razdel_1_1.org_izm) Is Null) AND 
		((razdel_1_2_1.gr3)='1') AND 
		((razdel_1_2_1.gr6)<>'2' Or 
		(razdel_1_2_1.gr6) Is Null) AND 
		((razdel_1_2_2.str_n) Is Null) AND 
		((razdel_1_2_2.gr3) Is Null) AND 
		((org_inf."1dop2018")=1))
)		
--) z
--
--check is_dod 62303
select count(*)
from org_inf
where is_dod = True
--
--
--comments
comment on column org_inf.okpo_otch is 'ОКПО из анкеты';
--
select count(*) from (
select count(r1_1okpo) from (
	select distinct okpo r1_1okpo,okato_fact,pole_11
	--select count(distinct okpo)--,okato_fact,pole_11
	from razdel_1_1 join statregistr7 on razdel_1_1.okpo=statregistr7.pole_1 or razdel_1_1.okpo=statregistr7.pole_3
	--where okato_fact<>pole_11) x
) z
	
CREATE INDEX idx_razdel_1_1_okpo ON razdel_1_1(okpo);

where razdel_1_1.okpo is null or statregistr7.pole_1 is null

where okato_fact not in (select pole_11 from statregistr7)


select distinct left(okato_fact,2)
from razdel_1_1

select distinct left(pole_11,2)
from statregistr7


select count(distinct okpo) --r1_1okpo,okato_fact,pole_11
	--select count(distinct okpo)--,okato_fact,pole_11
	from razdel_1_1 --join statregistr7 on razdel_1_1.okpo=statregistr7.pole_1
	where okpo not in (select pole_1 from statregistr7 --where statregistr7.in_vyborka in ('0','1')
	)

select count(distinct okpo) --r1_1okpo,okato_fact,pole_11
	--select count(distinct okpo)--,okato_fact,pole_11
	from razdel_1_1 --join statregistr7 on razdel_1_1.okpo=statregistr7.pole_1
		where okpo not in (select 
		case
			when right(pole_3,1) <> '1' then pole_3 else statregistr7.pole_1
		end as okpo_id from statregistr7 
	) 

select count(distinct okpo) 
from org_inf --join statregistr7 on org_inf.okpo=statregistr7.pole_1
where status in ('1') and 
okpo not in (select pole_1 from statregistr7)


select count(distinct okpo) 
from razdel_1_1 --join statregistr7 on org_inf.okpo=statregistr7.pole_1
where --status in ('2','3') and 
okpo not in (select pole_1 from statregistr7)

--okato сравнение
select distinct org_inf.okpo org_inf_okpo, okato_fact,pole_11
from razdel_1_1 join org_inf on razdel_1_1.okpo=org_inf.okpo
join 
(select	case
			when pole_9 not in ('1') then pole_3 else statregistr7.pole_1
		end as okpo,pole_11 from statregistr7) x 
on x.okpo=org_inf.okpo
where --status in ('2','3') and 
--org_inf.okpo not in (select pole_1 from statregistr7)
okato_fact<>pole_11

--добавить новый признак в дод и included_in_registr 20.11.19
select count(*)
from org_inf
where is_dod='1'

select count(*)
update org_inf
set is_dod = '0'
--from org_inf
where is_dod='false'

ALTER TABLE statregistr.org_inf ALTER COLUMN is_dod TYPE text USING pr_code_upd::integer
ALTER TABLE statregistr.org_inf ALTER COLUMN is_dod TYPE int USING is_dod::integer
alter table statregistr.org_inf alter column is_dod drop default

ALTER TABLE statregistr.org_inf ALTER COLUMN included_in_registr TYPE text --USING pr_code_upd::integer
ALTER TABLE statregistr.org_inf ALTER COLUMN included_in_registr TYPE int USING included_in_registr::integer
alter table statregistr.org_inf alter column included_in_registr drop default

select count(*)
from org_inf
where included_in_registr='1'

select count(*)
update org_inf
set included_in_registr = '0'
--from org_inf
where included_in_registr='false'

SELECT --count(distinct org_inf.okpo)
distinct org_inf.okpo
FROM org_inf LEFT JOIN razdel_1_1 ON org_inf.okpo = razdel_1_1.okpo
WHERE (((org_inf."1dop2018")='1') AND ((org_inf.included_in_registr)=0) AND ((org_inf.report)<>'2' And (org_inf.report)<>'5' And (org_inf.report)<>'9' And (org_inf.report)<>12 And (org_inf.report)<>'15' And (org_inf.report)<>'19') AND ((razdel_1_1.org_izm)<>'2' Or (razdel_1_1.org_izm) Is Null))
--GROUP BY org_inf.okpo;


update org_inf
set included_in_registr = 2
--select count(*) from org_inf
where okpo in (
SELECT distinct org_inf.okpo
FROM org_inf LEFT JOIN razdel_1_1 ON org_inf.okpo = razdel_1_1.okpo
WHERE (((org_inf."1dop2018")='1') AND ((org_inf.included_in_registr)=0) AND ((org_inf.report)<>'2' And (org_inf.report)<>'5' And (org_inf.report)<>'9' And (org_inf.report)<>12 And (org_inf.report)<>'15' And (org_inf.report)<>'19') AND ((razdel_1_1.org_izm)<>'2' Or (razdel_1_1.org_izm) Is Null))
)

update org_inf
set is_dod = 2
--select count(*) from org_inf
where included_in_registr = 2

select * from org_inf
where included_in_registr = 2
--------------


select left(okato_fact,2) sub_code,sub_name,count(*) 
from razdel_1_1 join okato_codes on left(okato_fact,2)=okato_codes.sub
group by left(okato_fact,2),sub_name
order by sub_code

--
--тюменская и архангельская
with pam as (
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
		when left(arh,3) = '112' or left(arh,3) = '114' or left(arh,3) = '115' then 'арх без АО' 
		when left(arh,3) = '111' then 'ненец' --else 'арх без АО'
		when left(arh,4) = '7114' then 'ямало-ненец' --else 'тюм без АО'
		when left(arh,4) = '7111' or left(arh,4) = '7113' or left(arh,4) = '7118' then 'ханты-мансийский'
		when left(arh,3) = '712' or left(arh,3) = '714' or (left(arh,3) = '711' and not left(arh,4) = '7111') then 'тюм без АО'
	end as no_ao,
	arh
	--case when arh like '111%' then 'ненец' end as nenec
from pam
--where arh is not null
	
--

--update 20112019
select pole_1,pole_21 from statregistr7
--update statregistr7
--set pole_21 = '85.14'
where pole_1 = '34763548'

select pole_1,pole_21 from statregistr7
--update statregistr7
--set pole_21 = '85.41.9'
where pole_1 = '30424795'

 
--alter table okato_codes rename column ﻿sub_name to sub_name

--with pam as (
select --okpo,is_dod,pole_1,pole_3
	count(distinct okpo)
	--*
from org_inf o join statregistr7 s on o.okpo=s.pole_1 or o.okpo=s.pole_3
where included_in_registr = 1 and (pole_1 is null and pole_3 is null)
--) select --sum(is_dod) 

select * from 
(select pole_1,pole_3,pole_11
	--left(pole_11,2)--,count(distinct pole_1)
	from statregistr7
	--where left(pole_11,2) is null
--where left(pole_11,2) not in (select sub from okato_codes)
) reg 
join org_inf on reg.pole_1=org_inf.okpo or reg.pole_3=org_inf.okpo
join razdel_1_1 on razdel_1_1.okpo=org_inf.okpo
where left(pole_11,2) = '55' and included_in_registr = 1
--group by left(pole_11,2)
--
select 
	left(okato_fact,2)--,count(distinct okpo)
	from razdel_1_1
	where left(okato_fact,2) not in (select sub from okato_codes)
group by left(okato_fact,2)	
--
select count(*)
from org_inf
where included_in_registr = 1
--
select count(*)
from org_inf o join razdel_1_1 r on o.okpo=r.okpo
where --included_in_registr = 1 and 
left(okato_fact,2) = '55'
--insert into okato_codes values('Байконур','55','','55',NULL)


CREATE INDEX idx_statreg_pole3 ON statregistr7(pole_3);
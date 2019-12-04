-- drop table statregistr.statregistr7

-- create table statregistr.statregistr7
-- as 
-- select case when statregistr.okpo_statreg_by_gleb.okpo is not null then '1' else '' end as in_vyborka,statregistr._0_statregistr7.pole_1,	statregistr._0_statregistr7.pole_2,	statregistr._0_statregistr7.pole_3,	statregistr._0_statregistr7.pole_4,	pole_5,	pole_6,	statregistr._0_statregistr7.pole_7,	pole_8,	pole_9,	pole_10,	pole_11,	pole_12,	pole_13,	pole_14,	pole_15,	pole_16,	pole_17,	pole_18,	pole_19,	pole_20,	pole_21,	pole_22,	pole_23,	pole_24,	pole_25,	pole_26,	pole_27,	pole_28,	pole_29,	pole_30,	pole_31,	pole_32,	pole_33,	pole_34,	pole_35,	pole_36,	pole_37,	pole_38,	pole_39,	pole_40,	pole_41,	pole_42,	pole_43,	pole_44,	pole_45,	pole_46,	pole_47,	pole_48,	pole_49,	pole_50,	pole_51,	pole_52,	pole_53,	pole_54,	pole_55,	pole_66,	pole_67,	pole_74,	pole_75,	pole_78,	pole_79,	pole_80,	pole_81,	pole_82,	pole_83,	pole_93,	pole_94,	pole_95,	pole_97,	pole_105,	pole_106,	pole_112,	pole_113,	pole_115
-- from 
-- 	statregistr._0_statregistr7 join statregistr._0_statregistr7_plus1
-- 	on statregistr._0_statregistr7.pole_1 = statregistr._0_statregistr7_plus1.pole_1
-- 	left join statregistr.okpo_statreg_by_gleb on statregistr._0_statregistr7.pole_1 = statregistr.okpo_statreg_by_gleb.okpo
-- --limit 10

insert into statregistr.statregistr7
--temp table for update
--CREATE TEMP TABLE temp_table_51 as
select --count(distinct statregistr.samodvizh_1.pole_1)
	'2' as in_vyborka, statregistr.samodvizh_1.pole_1,	statregistr.samodvizh_1.pole_2,	statregistr.samodvizh_1.pole_3,	statregistr.samodvizh_1.pole_4,	pole_5,	pole_6,	statregistr.samodvizh_1.pole_7,	pole_8,	pole_9,	pole_10,	pole_11,	pole_12,	pole_13,	pole_14,	pole_15,	pole_16,	pole_17,	pole_18,	pole_19,	pole_20,	pole_21,	pole_22,	pole_23,	pole_24,	pole_25,	pole_26,	pole_27,	pole_28,	pole_29,	pole_30,	pole_31,	pole_32,	pole_33,	pole_34,	pole_35,	pole_36,	pole_37,	pole_38,	pole_39,	pole_40,	pole_41,	pole_42,	pole_43,	pole_44,	pole_45,	pole_46,	pole_47,	pole_48,	pole_49,	pole_50,	pole_51,	pole_52,	pole_53,	pole_54,	pole_55,	pole_66,	pole_67,	pole_74,	pole_75,	pole_78,	pole_79,	pole_80,	pole_81,	pole_82,	pole_83,	pole_93,	pole_94,	pole_95,	pole_97,	pole_105,	pole_106,	pole_112,	pole_113,	pole_115
from 
	statregistr.samodvizh_1 join statregistr.samodvizh_2 on statregistr.samodvizh_1.pole_1 = statregistr.samodvizh_2.pole_1
where 
	statregistr.samodvizh_1.pole_1 is not null and
	statregistr.samodvizh_1.pole_1 not in (select pole_1 from statregistr.statregistr7 --where in_vyborka <> '2'
)
--update 51 from temp table										   
-- update statregistr.statregistr7
-- set in_vyborka = '2'
-- where statregistr.statregistr7.pole_1 in (select pole_1 from temp_table_51)

select * from temp_table_51
--limit 10
select count(*) from statregistr.statregistr7
where in_vyborka = ''

with pam as
(select distinct inn,ogrn,fullname,address from statregistr.licenses_edited where is_deleted = '0')
select count(*) from pam

--CREATE TEMP TABLE temp_table_747 as
--insert into statregistr.statregistr7
select 
	'3' as in_vyborka, statregistr.okpo_923_1.pole_1,	statregistr.okpo_923_1.pole_2,	statregistr.okpo_923_1.pole_3,	statregistr.okpo_923_1.pole_4,	pole_5,	pole_6,	statregistr.okpo_923_1.pole_7,	pole_8,	pole_9,	pole_10,	pole_11,	pole_12,	pole_13,	pole_14,	pole_15,	pole_16,	pole_17,	pole_18,	pole_19,	pole_20,	pole_21,	pole_22,	pole_23,	pole_24,	pole_25,	pole_26,	pole_27,	pole_28,	pole_29,	pole_30,	pole_31,	pole_32,	pole_33,	pole_34,	pole_35,	pole_36,	pole_37,	pole_38,	pole_39,	pole_40,	pole_41,	pole_42,	pole_43,	pole_44,	pole_45,	pole_46,	pole_47,	pole_48,	pole_49,	pole_50,	pole_51,	pole_52,	pole_53,	pole_54,	pole_55,	pole_66,	pole_67,	pole_74,	pole_75,	pole_78,	pole_79,	pole_80,	pole_81,	pole_82,	pole_83,	pole_93,	pole_94,	pole_95,	pole_97,	pole_105,	pole_106,	pole_112,	pole_113,	pole_115
from
	statregistr.okpo_923_1 join statregistr.okpo_923_2 on statregistr.okpo_923_1.pole_1 = statregistr.okpo_923_2.pole_1
where statregistr.okpo_923_1.pole_1 is not null and 
statregistr.okpo_923_1.pole_1 not in (select pole_1 from statregistr.statregistr7 ) --where in_vyborka = ''

----update 747 from temp table										   
-- update statregistr.statregistr7
-- set in_vyborka = '3'
-- where statregistr.statregistr7.pole_1 in (select pole_1 from temp_table_747)

select count(*)
from statregistr.samodvizh_1 as a join statregistr.statreg7_ron_matched as b on a.pole_1 = b.pole_1

-- ALTER TABLE statregistr.statreg7_ron_matched
-- ADD COLUMN in_vyborka text;

pole_1	fullname license_authority	license_number	license_issue_date

--17 samodvizh
--CREATE TEMP TABLE temp_table_17 as
--insert into statregistr.statreg7_ron_matched
select 
	case 
		when length(pole_1)=14 then 'F' else 'H' 
	end as head,
	pole_1,
	NULL as source
	,fullname
	,NULL as shortname
	,case 
		when length(pole_1)=14 then '1' else '0' 
	end as branch
	,NULL as org_type
	,NULL as inn
	,NULL as ogrn
	,NULL as kpp
	,NULL as region
	,NULL as address
	,NULL as license_status
	,array_agg(license_authority)::text as license_authority
	,array_agg(license_number)::text as license_number
	,array_agg(license_issue_date)::text as license_issue_date
	,NULL as validity
	,'0' as is_deleted
	,'2' as in_vyborka
from statregistr.samodvizh_lic
--where pole_1 in (select distinct pole_1 from statregistr.samodvizh_1)
where pole_1 not in (select pole_1 from statregistr.statreg7_ron_matched where in_vyborka <> '1')
group by 
	pole_1,fullname

-- alter table statregistr.statreg7_ron_matched
-- drop column edu_level

-- update statregistr.statreg7_ron_matched
-- set in_vyborka = '2'
-- where pole_1 in (select pole_1 from temp_table_17)

-- --CREATE TEMP TABLE temp_table_915 as
-- -- update statregistr.statreg7_ron_matched
-- -- set in_vyborka = '3'
-- -- where pole_1 in (select pole_1 from temp_table_915)

--insert into statregistr.statreg7_ron_matched
select 
	case 
		when length(pole_1)=14 then 'F' else 'H' 
	end as head,
	pole_1,
	NULL as source
	,fullname
	,NULL as shortname
	,case 
		when length(pole_1)=14 then '1' else '0' 
	end as branch
	,NULL as org_type
	,NULL as inn
	,NULL as ogrn
	,NULL as kpp
	,NULL as region
	,NULL as address
	,NULL as license_status
	,array_agg(license_authority)::text as license_authority
	,array_agg(license_number)::text as license_number
	,array_agg(license_issue_date)::text as license_issue_date
	,NULL as validity
	,'0' as is_deleted
	,'3' as in_vyborka
from statregistr.okpo_923_lic
--where pole_1 in (select distinct pole_1 from statregistr.samodvizh_1)
where pole_1 not in (select pole_1 from statregistr.statreg7_ron_matched) --where in_vyborka <> '1')
group by 
	pole_1,fullname

--ALTER TABLE statregistr.okpo_923_lic RENAME COLUMN pole_73 TO license_issue_date

select count(distinct pole_1) from statregistr.statreg7_ron_matched where in_vyborka = '2' --and pole_1 is null


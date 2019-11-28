select *
from statregistr7
where pole_1 = '44538290'


--select count(*)
--from (
--     select distinct inn, fullname, ogrn, address
--      from licenses_edited
--where branch = '1' and is_deleted = '0'
--       ) x; 
      
--количество филиалов
select count(*) from (    
select distinct inn, fullname, ogrn, address
--count(distinct pole_3)
--select distinct org_type
--select count(*)
from licenses_edited
--where branch = 'nan'
where branch in ('1','1.0') and is_deleted = '0' --and lower(fullname) like '%филиал%'
) x
--количество голов
select count(*) from (    
select distinct inn, shortname,fullname, ogrn, address
--count(distinct pole_3)
--select distinct org_type
--select count(*)
from licenses_edited
--where branch = 'nan'
where branch in ('0','0.0') and is_deleted = '0' --and lower(fullname) like '%филиал%'
) x

--соединение голов, 34483 (должно быть 35680)
select count(*)
from
(select *
from statregistr7
where ((right(pole_3,3) = '001') or pole_9='1') and in_vyborka = '1'
) a
join
(select distinct inn, fullname, shortname, ogrn, address
--count(distinct pole_3)
--select distinct org_type
--select count(*)
from licenses_edited
--where branch = 'nan'
where branch in ('0','0.0') and is_deleted = '0'
) b
on a.pole_8=b.inn or a.pole_27=b.ogrn --or b.shortname=a.pole_6 --or b.fullname=a.pole_7
--- соединение филиалов
select count(*)
from
(select distinct pole_8--, pole_27, pole_6, pole_7
from statregistr7
where ((right(pole_3,3) <> '001') and pole_9<>'1') and in_vyborka = '1'
) a
join
(select distinct inn, fullname, shortname, ogrn, address
from licenses_edited
--where branch = 'nan'
where branch in ('1','1.0') and is_deleted = '0') b
on a.pole_8=b.inn --or a.pole_27=b.ogrn--b.shortname=a.pole_6 or b.fullname=a.pole_7 -- 

select count(*)
from (
select distinct pole_8--,pole_27, pole_6, pole_7
from statregistr7
where right(pole_3,3) <> '001' and in_vyborka = '1'
--where ((right(pole_3,3) <> '001') and pole_9<>'1') and in_vyborka = '1'
order by pole_8
) x
left join statregistr7 c on x.pole_8=c.pole_8

---41041 количество уникальных организаций в лицензиях
select count(distinct (inn || kpp) || lower(trim(fullname))) AS total
from licenses_edited
---
select fullname, inn, count(*) from (
select distinct inn, lower(trim(replace(fullname,'"',''))) fullname
from statreg7_ron_matched) a
group by inn,fullname
--order by count desc
union all
select 'Всего', 'Всего', count(*)--count(distinct lower(trim(replace(fullname,'"',''))))
from (
select distinct inn, lower(trim(replace(fullname,'"','')))
from statreg7_ron_matched) x
order by count desc
---
select count(*) from
(select  pole_6
from statregistr7
where pole_6 is null or pole_6 = ''
) x

select count(*)
--count(distinct pole_3)
from statregistr7
--where pole_3='99999'
--where in_vyborka = '1' and length(pole_27)=13--and (pole_9 <>'1' or (right(pole_3,3) <> '001'))
where pole_3 is not null and pole_3<>'' and pole_3<>'9999' and in_vyborka = '1' and ((right(pole_3,3) = '001') or pole_9='1')
--where lower(pole_6) like '%филиал%'

select count(*) from (
select distinct inn, ogrn, fullname, address
FROM "_1_statregistr_join_filials"
) x;

select count(*)
FROM "_1_stratregistr_join_number_branches";

select count(*)
FROM "_2_statregistr_join_stats";

select count(*)
FROM "_1_statregistr_license_errors";

select count(*)
from _2_statregistr_heads_for_unjoined_filials

--select "1" into temp table vyborka17
-- from _._0_statregistr_statregistr7
--where "1" in (
--  select distinct "1"
--  from _._1_statregistr_join_heads
--  where "1" not in (select "1" from statregistr6)
--    and "1" not in (select "1" from statregistr7)
--    and "1" in (select distinct "1" from _._0_statregistr_statregistr7_plus1 where "50" != '1')
--);


create materialized view _._2_statregistr_heads_for_unjoined_filials as
select distinct "1", inn, ogrn, fullname
from (
       select *
       from _._0_statregistr_statregistr7
       where (length("3") < 2 or right("3", 4) = '0001' or "3" is null)
         and "1" not in (select "1" from _._0_statregistr_second_head)
     ) a
       right join
     (
       select distinct inn, ogrn, fullname
              -- select *
       from (
              select distinct a.inn, a.ogrn, a.fullname, a.address, a.license_status
              from _._0_statregistr_licenses_edited a
                     left join _._1_statregistr_join_filials b
                               on a.inn = b.inn and a.ogrn = b.ogrn and a.fullname = b.fullname and
                                  a.address = b.address
              where b."1" is null
                and a.branch = '1'
                and lower(a.license_status) not like '%не%'
                and is_deleted = '0'
                and a.inn not in (
                select replace(inn, '_', '') as inn
                from get_google_table(
                         'https://docs.google.com/spreadsheets/d/e/2PACX-1vRD4RejyrjcnZ0R7-wCzoRZZ6JrC17UsUrO3WfkuR8dqBb_vUK8c7c0W_0GRfiYXegs810IdF9iUy_8/pub?gid=1798315107&single=true&output=csv') a (inn text))
            ) x
     ) b on a."8" = b.inn or a."27" = b.ogrn
where a."1" is not null;
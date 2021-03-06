select max(length("67")) from _._0_statregistr_statregistr7

create materialized view _._1_statregistr_join_heads as
select *
from (
  select * from
       _._0_statregistr_statregistr7
  where (length("3") < 2 or right("3", 4) = '0001' or "3" is null)
  and "1" not in (select "1" from _._0_statregistr_second_head)
       ) a
inner join
  (select * from _._0_statregistr_licenses_edited
    where branch = '0' and is_deleted = '0'
  ) b on ((a."8" = b.inn or a."27" = b.ogrn) and a."1" != '99208616');

select distinct inn,ogrn,fullname,address,kpp, array_agg(edu_level)
from _._0_statregistr_licenses_edited
where is_deleted = '0' and branch='0'
group by inn, ogrn,fullname,address,kpp

-- 12
select count(distinct "1") from _._1_statregistr_join_heads;
select count(distinct inn) from _._1_statregistr_join_heads;

-- select * from _.statregistr_statregistr6
-- where "1" in (
--   select unnest(array_agg)
--   from (
--          select inn, array_agg(distinct "1")
--          from _._1_statregistr_join_heads
--          group by inn
--          having count(distinct "1") > 1
--        ) x
-- );

-- всего юр.лиц в лицензиях по инн
select count(distinct inn)
from _._0_statregistr_licenses_edited
where branch = '0' and is_deleted = '0';
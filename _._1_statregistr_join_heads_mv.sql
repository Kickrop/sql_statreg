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


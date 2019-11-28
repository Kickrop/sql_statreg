--выборка
--with vyborka as (
--  select replace(okpo, '_', '') as "1"
--  from get_google_table(
--           'https://docs.google.com/spreadsheets/d/e/2PACX-1vQQCEZiYuzvJzqqzlVVPfru9NMukwDhO-S2vtk3yLWSD4NaSHoRZgRjJ4cBReSv0Mpmq4M2MomyQRlU/pub?gid=2026021521&single=true&output=csv'::text) a(okpo text)
--)
--
---- select a.*,
----        case when b."1" is null then '0' else '1' end as "121"
----        from _._0_statregistr_statregistr7 a
---- left join vyborka b on a."1" = b."1";
--
--select a."1", "2", "3", "4", "7", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53", "54",
--              "66", "75", "80", "81", "82", "83", "93", "94", "97", "106", "112", "115",
--       case when b."1" is null then '0' else '1' end as "121"
--       from _._0_statregistr_statregistr7_plus1 a
--left join vyborka b on a."1" = b."1";
select count(distinct "1") from _._1_statregistr_join_heads;
select count(distinct inn) from _._1_statregistr_join_heads;
select count(distinct inn)

    
--create index idx_second_head on _._0_statregistr_second_head("1")
--create index idx_statreg7_3 on _._0_statregistr_statregistr7("3")
--create index idx_statreg7_8 on _._0_statregistr_statregistr7("8")
--create index idx_statreg7_27 on _._0_statregistr_statregistr7("27")
--create index idx_statreg7_1 on _._0_statregistr_statregistr7("1")
--
--create materialized view _._1_statregistr_join_heads as
--select *
--from (
--  select * from
--       _._0_statregistr_statregistr7
--  where (length("3") < 2 or right("3", 4) = '0001' or "3" is null)
--  and "1" not in (select "1" from _._0_statregistr_second_head)
--       ) a
--inner join
--  (select * from _._0_statregistr_licenses_edited
--    where branch = '0' and is_deleted = '0'
--  ) b on ((a."8" = b.inn or a."27" = b.ogrn) and a."1" != '99208616');
--
--
--create materialized view _._1_statregistr_join_filials_dop as
--
--  with filials1 as (
--    select replace(okpo, '''', '')  as "1",
--           replace(inn2, '''', '')  as inn,
--           replace(ogrn2, '''', '') as ogrn,
--           replace(kpp2, '''', '')  as kpp,
--           fullname,
--           shortname
--    from get_google_table(
--             'https://docs.google.com/spreadsheets/d/e/2PACX-1vRD4RejyrjcnZ0R7-wCzoRZZ6JrC17UsUrO3WfkuR8dqBb_vUK8c7c0W_0GRfiYXegs810IdF9iUy_8/pub?gid=112002731&single=true&output=csv'::text) a ("1" text,
--                                                                                                                                                                                                  fullname text,
--                                                                                                                                                                                                  shortname text,
--                                                                                                                                                                                                  inn text,
--                                                                                                                                                                                                  ogrn text,
--                                                                                                                                                                                                  kpp text,
--                                                                                                                                                                                                  okpo text,
--                                                                                                                                                                                                  inn2 text,
--                                                                                                                                                                                                  ogrn2 text,
--                                                                                                                                                                                                  kpp2 text)
--    ),
--
--    filials2 as (
--    select replace(okpo, '''', '')  as "1",
--           replace(inn2, '''', '')  as inn,
--           replace(ogrn2, '''', '') as ogrn,
--           replace(kpp2, '''', '')  as kpp,
--           fullname,
--           shortname
--    from get_google_table(
--             'https://docs.google.com/spreadsheets/d/e/2PACX-1vRD4RejyrjcnZ0R7-wCzoRZZ6JrC17UsUrO3WfkuR8dqBb_vUK8c7c0W_0GRfiYXegs810IdF9iUy_8/pub?gid=1593286949&single=true&output=csv'::text) a ("1" text,
--                                                                                                                                                                                                  fullname text,
--                                                                                                                                                                                                  shortname text,
--                                                                                                                                                                                                  inn text,
--                                                                                                                                                                                                  ogrn text,
--                                                                                                                                                                                                  kpp text,
--                                                                                                                                                                                                  okpo text,
--                                                                                                                                                                                                  inn2 text,
--                                                                                                                                                                                                  ogrn2 text,
--                                                                                                                                                                                                  kpp2 text)
--    )
--
--select *
--from (
--       select *
--       from _.statregistr_statregistr_plus1
--       where ("9" in ('2', '3') or (length("3") > 1 and right("3", 4) != '0001'))
--         and "1" not in (select "1" from _._0_statregistr_second_head2)
--     ) a
--       inner join
--     (select *
--      from _.statregistr_licenses
--      where branch = '1'
--     ) b on ((a."8" = b.inn or a."27" = b.ogrn) and (a."7" = b.fullname or a."6" = b.shortname))
--
--union
--
--select a.*,
--  source             ,
--  fullname           ,
--  shortname          ,
--  branch             ,
--  org_type           ,
--  inn                ,
--  ogrn               ,
--  kpp                ,
--  region             ,
--  address            ,
--  license_status     ,
--  license_authority  ,
--  license_number     ,
--  license_issue_date ,
--  validity           ,
--  edu_level
--from (
--       select *
--       from _.statregistr_statregistr_plus1
--       where ("9" in ('2', '3') or (length("3") > 1 and right("3", 4) != '0001'))
--         and "1" not in (select "1" from _._0_statregistr_second_head2)
--     ) a
--       inner join
--     (select a.*, b."1"
--      from _.statregistr_licenses a
--     join (
--       select * from filials1
--       union
--       select * from filials2
--        ) b on a.inn = b.inn and a.ogrn = b.ogrn and a.kpp = b.kpp and a.fullname = b.fullname
--      where branch = '1'
--     ) b on a."1" = b."1"
--;

--create materialized view _._2_statregistr_licencse_heads_not_in_statregistr as
--select *
---- select count(*)
--from _._0_statregistr_licenses_edited
--where branch = '0' and is_deleted = '0'
--  and inn not in (select distinct inn from _._1_statregistr_join_heads)
--  and lower(license_status) not like '%не%'
--  and inn not in (
--   select replace(inn, '_', '') as inn
--  from get_google_table(
--           'https://docs.google.com/spreadsheets/d/e/2PACX-1vRD4RejyrjcnZ0R7-wCzoRZZ6JrC17UsUrO3WfkuR8dqBb_vUK8c7c0W_0GRfiYXegs810IdF9iUy_8/pub?gid=1798315107&single=true&output=csv') a (inn text)
--);

from _._0_statregistr_licenses_edited
where branch = '0' and is_deleted = '0';

-- всего юр.лиц в лицензиях по инн
select count(distinct inn)
from _._0_statregistr_licenses_edited
where branch = '0' and is_deleted = '0';

-- всего юр.лиц в лицензиях по инн, огрн, названию и адресу
select count(*)
from (
     select distinct inn, fullname, ogrn, address
      from _._0_statregistr_licenses_edited
where branch = '0' and is_deleted = '0'
--   group by inn
--   having count(distinct ogrn) > 1
       ) x;

      
 -- всего филиалов в лицензиях по инн, огрн, названию и адресу
select count(*)
from (
     select distinct inn, fullname, ogrn, address
      from _._0_statregistr_licenses_edited
where branch = '1' and is_deleted = '0'
--   group by inn
--   having count(distinct ogrn) > 1
       ) x;      
      
-- 19 филиалы без юр.лиц
select count(*)
from (
       select distinct inn, ogrn, fullname, address
       from _._0_statregistr_licenses_edited
       where is_deleted = '0'
         and branch = '1'
         and inn not in (select distinct inn
                         from _._0_statregistr_licenses_edited
                         where is_deleted = '0'
                           and branch = '0')
     ) x;
 
 -- 19.1 филиалы без юр.лиц, поиск их голов в статрегистре
select count(*)
from (
       select distinct inn, ogrn, fullname, address
       from _._0_statregistr_licenses_edited
       where is_deleted = '0'
         and branch = '1'
         and inn not in
             (select distinct inn from _._0_statregistr_licenses_edited where is_deleted = '0' and branch = '0')
         and inn in (select distinct "8" from _._0_statregistr_statregistr7)
     ) x;
 -- 12.1 удаленные
select count(distinct a."1") from _._1_statregistr_join_heads a
inner join _._0_statregistr_statregistr7_plus1 b on a."1" = b."1"
where "50" = '1';

-- 20
select count(distinct inn)
from _._0_statregistr_licenses_edited
where branch = '0' and is_deleted = '0'
and inn not in (select distinct inn from _._1_statregistr_join_heads);


-- 20.1
select count(distinct inn)
from _._0_statregistr_licenses_edited
where branch = '0' and is_deleted = '0'
  and inn not in (select distinct inn from _._1_statregistr_join_heads)
  and inn not in (
  select replace(inn, '_', '') as inn
  from get_google_table(
           'https://docs.google.com/spreadsheets/d/e/2PACX-1vRD4RejyrjcnZ0R7-wCzoRZZ6JrC17UsUrO3WfkuR8dqBb_vUK8c7c0W_0GRfiYXegs810IdF9iUy_8/pub?gid=1798315107&single=true&output=csv') a (inn text)
);

-- 20.2
select count(distinct inn)
from _._0_statregistr_licenses_edited
where branch = '0' and is_deleted = '0'
  and inn not in (select distinct inn from _._1_statregistr_join_heads)
  and inn in (
  select replace(inn, '_', '') as inn
  from get_google_table(
           'https://docs.google.com/spreadsheets/d/e/2PACX-1vRD4RejyrjcnZ0R7-wCzoRZZ6JrC17UsUrO3WfkuR8dqBb_vUK8c7c0W_0GRfiYXegs810IdF9iUy_8/pub?gid=1798315107&single=true&output=csv') a (inn text)
);


select * from
(
  select distinct inn, ogrn, fullname, address
  from _._0_statregistr_licenses_edited
  where branch = '1'
    and is_deleted = '0'
    and inn in (
    select inn
    from get_google_table(
             'https://docs.google.com/spreadsheets/d/e/2PACX-1vRD4RejyrjcnZ0R7-wCzoRZZ6JrC17UsUrO3WfkuR8dqBb_vUK8c7c0W_0GRfiYXegs810IdF9iUy_8/pub?gid=1798315107&single=true&output=csv') a (inn text)
  )
) a
inner join
  _._1_statregistr_join_filials b on a.inn = b.inn and a.ogrn = b.ogrn and a.fullname = b.fullname and a.address = b.address
  
  
--drop table statregistr_dop2
select distinct a."1", a."2", a."3", a."4", a."8", a."27", a."6", a."7", a."9",
                  a."21", a."22", a."16", a."17", a."18", a."19", a."78", a."79", b."81", b."82",
                  "117", "118", "119", "120", "67", "50" into temp table statregistr_dop2 from _.statregistr_statregistr_plus1 a
                  inner join _.statregistr_statregistr6_plus1 b on a."1" = b."1"
where --"50" != '1' and
--        a."1" not in (select "1" from _._0_statregistr_second_head) and
      a."1" not in (select "1" from _.statregistr_main);    

select count(*) from _.statregistr_statregistr_plus1;
select count(*) from statregistr_dop2;   

select distinct a."1", a."2", a."3", a."4", a."8", a."27", a."6", a."7", a."9",
                  a."21", a."22", a."16", a."17", a."18", a."19", a."78", a."79", b."81", b."82",
                  "117", "118", "119", "120", "67", "50" into temp table statregistr from _._0_statregistr_statregistr7 a
                  inner join _._0_statregistr_statregistr7_plus1 b on a."1" = b."1"
where a."1" not in (select "1" from _._0_statregistr_second_head) and "50" != '1';

-- 0.1
select count(distinct "1") from statregistr;

-- 1
select count(distinct "1") from statregistr where (("21" like '%85.41%' and "21" is not null) or ("22" like '%85.41%' and "22" is not null));

-- 2
select count(distinct "1") from statregistr where ("16" like '%80.10.3%' and "16" is not null) or ("17" like '%80.10.3%' and "17" is not null)
                                               or ("18" like '%80.10.3%' and "18" is not null) or ("19" like '%80.10.3%' and "19" is not null);

 
                                              
                                              
select distinct "1" into temp table statregistr6
    from statregistr
    where "50" != '1'
      and (("67" like '%054%' and ("67" is not null))
      or (("117" in ('1', '2') and "117" is not null)
        or ("118" in ('1', '2') and "118" is not null)
        or ("119" in ('1', '2') and "119" is not null)
        or ("120" in ('1') and "120" is not null))
      or (("81" like '%80.10.3%' and "81" is not null) or ("82" like '%80.10.3%' and "82" is not null))
      or (("78" like '%85.41%' and "78" is not null) or ("79" like '%85.41%' and "79" is not null))
      or (("16" like '%80.10.3%' and "16" is not null)
        or ("17" like '%80.10.3%' and "17" is not null)
        or ("18" like '%80.10.3%' and "18" is not null)
        or ("19" like '%80.10.3%' and "19" is not null))
      or (("21" like '%85.41%' and ("21" is not null))
        or ("22" like '%85.41%' and ("22" is not null))));
       
select "1" into temp table statregistr7 from statregistr
     -- where "2" = "1"
where (length("3") < 2 or right("3", 4) = '0001' or "3" is null)
  and not (
      ("67" like '%054%' and "67" is not null)
      or (("117" in ('1', '2') and "117" is not null)
      or ("118" in ('1', '2') and "118" is not null)
      or ("119" in ('1', '2') and "119" is not null)
      or ("120" in ('1') and "120" is not null))
      or (("81" like '%80.10.3%' and "81" is not null) or
          ("82" like '%80.10.3%' and "82" is not null))
      or (("78" like '%85.41%' and "78" is not null) or
          ("79" like '%85.41%' and "79" is not null))
      or (("16" like '%80.10.3%' and "16" is not null)
      or ("17" like '%80.10.3%' and "17" is not null)
      or ("18" like '%80.10.3%' and "18" is not null)
      or ("19" like '%80.10.3%' and "19" is not null))
      or (("21" like '%85.41%' and ("21" is not null))
      or ("22" like '%85.41%' and ("22" is not null)))
    )
  and "2" in (
    select distinct "2"
    from statregistr
    where "9" in ('2', '3')
      and (
        ("67" like '%054%' and "67" is not null)
        or (("117" in ('1', '2') and "117" is not null)
        or ("118" in ('1', '2') and "118" is not null)
        or ("119" in ('1', '2') and "119" is not null)
        or ("120" in ('1') and "120" is not null))
        or (("81" like '%80.10.3%' and "81" is not null) or
            ("82" like '%80.10.3%' and "82" is not null))
        or (("78" like '%85.41%' and "78" is not null) or
            ("79" like '%85.41%' and "79" is not null))
        or (("16" like '%80.10.3%' and "16" is not null)
        or ("17" like '%80.10.3%' and "17" is not null)
        or ("18" like '%80.10.3%' and "18" is not null)
        or ("19" like '%80.10.3%' and "19" is not null))
        or (("21" like '%85.41%' and ("21" is not null))
        or ("22" like '%85.41%' and ("22" is not null))))
  );                                             
 -- 12.2
 select count(distinct "1") from _._1_statregistr_join_heads
where "1" in (select "1" from statregistr6) or "1" in (select "1" from statregistr7);

-- 12.3
select count(distinct "1") from _._1_statregistr_join_heads
where "1" not in (select "1" from statregistr6) and "1" not in (select "1" from statregistr7) and
      "1" in (select distinct "1" from _._0_statregistr_statregistr7_plus1 where "50" != '1');
   
-- 12.3 выборка
select "1" into temp table vyborka17
 from _._0_statregistr_statregistr7
where "1" in (
  select distinct "1"
  from _._1_statregistr_join_heads
  where "1" not in (select "1" from statregistr6)
    and "1" not in (select "1" from statregistr7)
    and "1" in (select distinct "1" from _._0_statregistr_statregistr7_plus1 where "50" != '1')
);

select count(distinct "1") from _._1_statregistr_join_filials
where "1" in (select "1" from statregistr6) or "1" in (select "1" from statregistr7);

-- 15.3 --31 из отчета
select count(distinct "1") from _._1_statregistr_join_filials
where "1" not in (select "1" from statregistr6) and "1" not in (select "1" from statregistr7) and
      "1" in (select distinct "1" from _._0_statregistr_statregistr7_plus1 where "50" != '1');
      
-- 15.3 выборка     
 select "1" into temp table vyborka28
 from _._0_statregistr_statregistr7
where  "1" in (
select distinct "1" from _._1_statregistr_join_filials
where "1" not in (select "1" from statregistr6) and "1" not in (select "1" from statregistr7) and
      "1" in (select distinct "1" from _._0_statregistr_statregistr7_plus1 where "50" != '1'));
      
-- 15.3.1
select count(distinct inn) from _._1_statregistr_join_filials
where "1" not in (select "1" from statregistr6) and "1" not in (select "1" from statregistr7) and
      "1" in (select distinct "1" from _._0_statregistr_statregistr7_plus1 where "50" != '1');   
      
     
-- 15.3.1.1
select count(distinct inn) from _._1_statregistr_join_filials
where "1" not in (select "1" from statregistr6) and "1" not in (select "1" from statregistr7) and
       "1" in (select distinct "1" from _._0_statregistr_statregistr7_plus1 where "50" != '1') and
     inn in (
       select distinct inn from _._0_statregistr_statregistr7
       where "1"  in (select "1" from statregistr6) and "1" not in (select "1" from statregistr7)
      and "1" in (select distinct "1" from _._0_statregistr_statregistr7_plus1 where "50" != '1')
       );    
       
 -- 15.3.1.1.1
select count(distinct inn) from _._1_statregistr_join_filials
where "1" not in (select "1" from statregistr6) and "1" not in (select "1" from statregistr7) and
      "1" in (select distinct "1" from _._0_statregistr_statregistr7_plus1 where "50" != '1')
    and inn in (select distinct inn from _._1_statregistr_join_heads)
;

select count(distinct inn) from _._1_statregistr_join_filials
where "1" not in (select "1" from statregistr6) and "1" not in (select "1" from statregistr7) and
      "1" in (select distinct "1" from _._0_statregistr_statregistr7_plus1 where "50" != '1')
    and inn not in (select distinct inn from _._1_statregistr_join_heads)
and inn not in (
  select replace(inn, '_', '') as inn
  from get_google_table(
           'https://docs.google.com/spreadsheets/d/e/2PACX-1vRD4RejyrjcnZ0R7-wCzoRZZ6JrC17UsUrO3WfkuR8dqBb_vUK8c7c0W_0GRfiYXegs810IdF9iUy_8/pub?gid=1798315107&single=true&output=csv') a (inn text)
);

-- 15.3.1.2.1
select count(distinct inn) from _._1_statregistr_join_filials
where "1" not in (select "1" from statregistr6) and "1" not in (select "1" from statregistr7) and
      "1" in (select distinct "1" from _._0_statregistr_statregistr7_plus1 where "50" != '1')
    and inn not in (select distinct inn from _._1_statregistr_join_heads)
  and lower(license_status) not like '%не%'
and inn not in (
  select replace(inn, '_', '') as inn
  from get_google_table(
           'https://docs.google.com/spreadsheets/d/e/2PACX-1vRD4RejyrjcnZ0R7-wCzoRZZ6JrC17UsUrO3WfkuR8dqBb_vUK8c7c0W_0GRfiYXegs810IdF9iUy_8/pub?gid=1798315107&single=true&output=csv') a (inn text)
);
-- 15.3.1.2.1 выборка
select distinct inn from _._1_statregistr_join_filials
where "1" not in (select "1" from statregistr6) and "1" not in (select "1" from statregistr7) and
      "1" in (select distinct "1" from _._0_statregistr_statregistr7_plus1 where "50" != '1')
    and inn not in (select distinct inn from _._1_statregistr_join_heads)
  and lower(license_status) not like '%не%'
and inn not in (
  select replace(inn, '_', '') as inn
  from get_google_table(
           'https://docs.google.com/spreadsheets/d/e/2PACX-1vRD4RejyrjcnZ0R7-wCzoRZZ6JrC17UsUrO3WfkuR8dqBb_vUK8c7c0W_0GRfiYXegs810IdF9iUy_8/pub?gid=1798315107&single=true&output=csv') a (inn text)
);

-- 17.2.1.2
select count(distinct "1") from _._2_statregistr_heads_for_unjoined_filials
where "1" in (select "1" from statregistr6) or "1" in (select "1" from statregistr7);

select count(distinct "1") from _._2_statregistr_heads_for_unjoined_filials
where "1" not in (select "1" from statregistr6) and "1" not in (select "1" from statregistr7) and
      "1" in (select distinct "1" from _._0_statregistr_statregistr7_plus1 where "50" != '1');
      
 -- 17.2.1.3-1
select count(distinct "1") from _._2_statregistr_heads_for_unjoined_filials
where "1" not in (select "1" from statregistr6) and "1" not in (select "1" from statregistr7) and
      "1" in (select distinct "1" from _._0_statregistr_statregistr7_plus1 where "50" != '1')
and inn not in (
  select replace(inn, '_', '') as inn
  from get_google_table(
           'https://docs.google.com/spreadsheets/d/e/2PACX-1vRD4RejyrjcnZ0R7-wCzoRZZ6JrC17UsUrO3WfkuR8dqBb_vUK8c7c0W_0GRfiYXegs810IdF9iUy_8/pub?gid=1798315107&single=true&output=csv') a (inn text)
);
-- 17.2.1.3-1 выборка
select distinct "1" into temp table vyborka_heads_from_filials from _._2_statregistr_heads_for_unjoined_filials
where "1" not in (select "1" from statregistr6) and "1" not in (select "1" from statregistr7) and
      "1" in (select distinct "1" from _._0_statregistr_statregistr7_plus1 where "50" != '1')
and inn not in (
  select replace(inn, '_', '') as inn
  from get_google_table(
           'https://docs.google.com/spreadsheets/d/e/2PACX-1vRD4RejyrjcnZ0R7-wCzoRZZ6JrC17UsUrO3WfkuR8dqBb_vUK8c7c0W_0GRfiYXegs810IdF9iUy_8/pub?gid=1798315107&single=true&output=csv') a (inn text)
);

-- 17.2.1.3.1
select count(distinct "1")
from _._2_statregistr_heads_for_unjoined_filials
where "1" not in (select "1" from statregistr6)
  and "1" not in (select "1" from statregistr7)
  and "1" in (select distinct "1" from _._0_statregistr_statregistr7_plus1 where "50" != '1')
  and "1" not in (
  select distinct "1"
  from _._1_statregistr_join_heads
  where "1" not in (select "1" from statregistr6)
    and "1" not in (select "1" from statregistr7)
    and "1" in (select distinct "1" from _._0_statregistr_statregistr7_plus1 where "50" != '1')
);
-- выборка критерии 1-7
select "1" into temp table vyborka_17
 from _._0_statregistr_statregistr7
where "1" in (
  select "1"
  from statregistr6
  union
  select "1"
  from statregistr7
);
-- выборка ОКПО
select "1" into temp table vyborka_okpo
from (
       select *
       from vyborka17
       union
       select *
       from vyborka_17
       union
       select *
       from vyborka28
       union
       select *
       from vyborka_heads_from_filials
     ) x;
     
  -- выборка ОКПО без малых и микро
select x."1"
from (
       select *
       from vyborka17
       union
       select *
       from vyborka_17
       union
       select *
       from vyborka28
       union
       select *
       from vyborka_heads_from_filials
     ) x
inner join _._0_statregistr_statregistr7 y on x."1" = y."1"
where "74" not in ('1', '4');

select count(distinct "1")
from (
       select a."1"
       from vyborka17 a
  join vyborka_heads_from_filials b on a."1" = b."1"
     ) x;
     
    
 select count(distinct "1")
from (
       select *
       from vyborka_17
     ) x; 
     
 select count(distinct "1")
from (
       select *
       from vyborka28
     ) x;

select count(distinct "1")
from (
       select *
       from vyborka_heads_from_filials
     ) x;
-- проверка наличия голов для филиалов из выборки
select a."1", b.*, c."50"
from vyborka_okpo a inner join _._0_statregistr_statregistr7 b on a."1" = b."1"
inner join _._0_statregistr_statregistr7_plus1 c on a."1" = c."1"
-- where b."8" not in (
--   select distinct "8"
--   from _._0_statregistr_statregistr7
--   where (length("3") < 2 or right("3", 4) = '0001' or "3" is null)
--   and "1" not in (select "1" from _._0_statregistr_second_head)
--   )
where b."2" not in
(select distinct "1" from _._0_statregistr_statregistr7
 where (length("3") < 2 or right("3", 4) = '0001' or "3" is null)
  and "1" not in (select "1" from _._0_statregistr_second_head)
  )
  
  
  
select *
from _._2_statregistr_vyborka_license
where inn not in
      (select distinct "8" from _._0_statregistr_statregistr7
 where (length("3") < 2 or right("3", 4) = '0001' or "3" is null)
  and "1" not in (select "1" from _._0_statregistr_second_head)
  and "8" is not null
  ) and
      ogrn not in
      (select distinct "27" from _._0_statregistr_statregistr7
 where (length("3") < 2 or right("3", 4) = '0001' or "3" is null)
  and "1" not in (select "1" from _._0_statregistr_second_head)
  and "27" is not null
  )
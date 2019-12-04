select count(distinct "1") from _._0_statregistr_statregistr7
select count(distinct "1") from _.statregistr_statregistr6
select count(distinct inn || fullname) from _.statregistr_licenses where branch = '0'

select count(*) from (
select distinct inn,lower(fullname)
from _._0_statregistr_licenses_edited--_._1_statregistr_join_filials
--_._1_statregistr_join_heads
	where inn = ''--branch='0' --or branch=''
	) x


SELECT replace(a_1.inn, '_'::text, ''::text) AS inn,
            a_1.ogrn
			select *
           FROM get_google_table_v2('https://docs.google.com/spreadsheets/d/e/2PACX-1vRD4RejyrjcnZ0R7-wCzoRZZ6JrC17UsUrO3WfkuR8dqBb_vUK8c7c0W_0GRfiYXegs810IdF9iUy_8/pub?gid=149956506&single=true&output=csv'::text) a_1(inn text, ogrn text)
        )	
	
	select count(distinct inn) from 
_._1_statregistr_join_heads

select count(distinct inn)
from _._0_statregistr_licenses_edited
where branch = '0' and is_deleted = '0'
and inn not in (select distinct inn from _._1_statregistr_join_heads);


select count(*) from _._0_statregistr_license_branches_number
---
create materialized view _._1_statregistr_join_filials_dop as

  with filials1 as (
    select replace(okpo, '''', '')  as "1",
           replace(inn2, '''', '')  as inn,
           replace(ogrn2, '''', '') as ogrn,
           replace(kpp2, '''', '')  as kpp,
           fullname,
           shortname
    from get_google_table_v2(
             'https://docs.google.com/spreadsheets/d/e/2PACX-1vRD4RejyrjcnZ0R7-wCzoRZZ6JrC17UsUrO3WfkuR8dqBb_vUK8c7c0W_0GRfiYXegs810IdF9iUy_8/pub?gid=112002731&single=true&output=csv'::text) a ("1" text,
                                                                                                                                                                                                  fullname text,
                                                                                                                                                                                                  shortname text,
                                                                                                                                                                                                  inn text,
                                                                                                                                                                                                  ogrn text,
                                                                                                                                                                                                  kpp text,
                                                                                                                                                                                                  okpo text,
                                                                                                                                                                                                  inn2 text,
                                                                                                                                                                                                  ogrn2 text,
                                                                                                                                                                                                  kpp2 text)
    ),

    filials2 as (
    select replace(okpo, '''', '')  as "1",
           replace(inn2, '''', '')  as inn,
           replace(ogrn2, '''', '') as ogrn,
           replace(kpp2, '''', '')  as kpp,
           fullname,
           shortname
    from get_google_table_v2(
             'https://docs.google.com/spreadsheets/d/e/2PACX-1vRD4RejyrjcnZ0R7-wCzoRZZ6JrC17UsUrO3WfkuR8dqBb_vUK8c7c0W_0GRfiYXegs810IdF9iUy_8/pub?gid=1593286949&single=true&output=csv'::text) a ("1" text,
                                                                                                                                                                                                  fullname text,
                                                                                                                                                                                                  shortname text,
                                                                                                                                                                                                  inn text,
                                                                                                                                                                                                  ogrn text,
                                                                                                                                                                                                  kpp text,
                                                                                                                                                                                                  okpo text,
                                                                                                                                                                                                  inn2 text,
                                                                                                                                                                                                  ogrn2 text,
                                                                                                                                                                                                  kpp2 text)
    )

select *
from (
       select *
       from _.statregistr_statregistr_plus1
       where ("9" in ('2', '3') or (length("3") > 1 and right("3", 4) != '0001'))
         and "1" not in (select "1" from _._0_statregistr_second_head2)
     ) a
       inner join
     (select *
      from _.statregistr_licenses
      where branch = '1'
     ) b on ((a."8" = b.inn or a."27" = b.ogrn) and (a."7" = b.fullname or a."6" = b.shortname))

union

select a.*,
  source             ,
  fullname           ,
  shortname          ,
  branch             ,
  org_type           ,
  inn                ,
  ogrn               ,
  kpp                ,
  region             ,
  address            ,
  license_status     ,
  license_authority  ,
  license_number     ,
  license_issue_date ,
  validity           ,
  edu_level
from (
       select *
       from _.statregistr_statregistr_plus1
       where ("9" in ('2', '3') or (length("3") > 1 and right("3", 4) != '0001'))
         and "1" not in (select "1" from _._0_statregistr_second_head2)
     ) a
       inner join
     (select a.*, b."1"
      from _.statregistr_licenses a
     join (
       select * from filials1
       union
       select * from filials2
        ) b on a.inn = b.inn and a.ogrn = b.ogrn and a.kpp = b.kpp and a.fullname = b.fullname
      where branch = '1'
     ) b on a."1" = b."1"
;

select * from _._0_statregistr_licenses_edited
CREATE MATERIALIZED VIEW _._2_statregistr_join_stats
AS 

 SELECT 'license'::text AS source,
    count(DISTINCT (_._0_statregistr_licenses_edited.inn || _._0_statregistr_licenses_edited.kpp) || lower(_._0_statregistr_licenses_edited.fullname)) AS total,
    NULL::bigint AS heads_okpo,
    ( SELECT count(DISTINCT (inn || kpp) || lower(fullname)) AS heads
           FROM _._0_statregistr_licenses_edited sl
          WHERE branch <> 1::text) AS heads_inn,
          
    ( SELECT count(DISTINCT inn) AS count
           FROM _._0_statregistr_license_branches_number sl) AS heads_with_branches,
           
    ( SELECT sum(count) AS branches
           FROM _._0_statregistr_license_branches_number) AS matched_branches_number,
          
    ( SELECT count(DISTINCT inn || kpp || lower(fullname)) AS branches
           FROM _._0_statregistr_licenses_edited  sl
          WHERE branch = 1::text) AS branches
   FROM _._0_statregistr_licenses_edited
   
UNION

 SELECT 'statreg'::text AS source,
    count(DISTINCT lower("1")) AS total,
    ( SELECT count(DISTINCT lower("1")) AS count
           FROM _.statregistr_statregistr a
          WHERE "9" = '1') AS heads_okpo,
    ( SELECT count(DISTINCT lower("8")) AS count
           FROM _.statregistr_statregistr b
          WHERE "9" = '1') AS heads_inn,
    ( SELECT count(DISTINCT "8") AS count
           FROM _._0_statregistr_statregistr_branches_number a) AS heads_with_branches,
    ( SELECT sum(count) AS count
           FROM _._0_statregistr_statregistr_branches_number a) AS matched_branches_number,
    ( SELECT count(DISTINCT lower("1")) AS count
           FROM _.statregistr_statregistr ss
          WHERE "9" in ('2', '3')) AS branches
   FROM _.statregistr_statregistr
   
UNION

 SELECT 'matched'::text AS source,
    NULL::bigint AS total,
    ( SELECT count(DISTINCT "1") AS count
           FROM _._0_stratregistr_join_heads a) AS heads_okpo,
    ( SELECT count(DISTINCT inn) AS count
           FROM _._0_stratregistr_join_heads b) AS heads_inn,
    (  SELECT count(DISTINCT inn) AS orgs_with_matched_branches_number
   from _._1_stratregistr_join_number_branches x WHERE x.c1 = x.c2) AS heads_with_branches,
    (  SELECT sum(x.c1) AS matched_branches_number
   from _._1_stratregistr_join_number_branches x WHERE x.c1 = x.c2) AS matched_branches_number,
    count(DISTINCT lower(fullname)) AS branches
   FROM _._0_stratregistr_join_branches
order by source

select count(distinct inn || fullname)
from _._2_statregist_join_filials_to_check


create materialized view _._2_statregist_join_filials_to_check as
with matched_filials as (
  select *, replace(okpo, '''', '') as okpo_new
  from get_google_table_v2(
           'https://docs.google.com/spreadsheets/d/e/2PACX-1vRD4RejyrjcnZ0R7-wCzoRZZ6JrC17UsUrO3WfkuR8dqBb_vUK8c7c0W_0GRfiYXegs810IdF9iUy_8/pub?gid=112002731&single=true&output=csv'::text) a ("1" text,
                                                                                                                                                                                                fullname text,
                                                                                                                                                                                                shortname text,
                                                                                                                                                                                                inn text,
                                                                                                                                                                                                ogrn text,
                                                                                                                                                                                                kpp text,
																																																address text,
                                                                                                                                                                                                okpo text,
																																																inn2 text,
                                                                                                                                                                                                ogrn2 text,
                                                                                                                                                                                                kpp2 text
																																																)
)
select y.*, x.*
from (
       select a.*
       from (
              select string_agg(a."1", '; ') as "1",
                     a."2",
                     a."3",
                     a."4",
                     a."9",
                     string_agg(a."6", '; ') as "6",
                     string_agg(a."7", '; ') as "7",
                     a."8",
                     a."27",
                     b."40",
                     b."41"
              from (
                     select distinct "1",
                                     "2",
                                     a."3",
                                     a."4",
                                     a."9",
                                     a."6",
                                     a."7",
                                     a."8",
                                     a."27"
                     from _.statregistr_statregistr5 a
                   ) a
                     join
                   (
                     select distinct "1", "7", "40", "41"
                     from _.statregistr_statregistr5_plus1
                   ) b on a."1" = b."1" and a."7" = b."7"
              where a."1" not in (select "1" from _._0_statregistr_second_head)
                and (a."9" in ('2', '3') or right(a."3", 3) != '001')
              group by a."2", a."3", a."4", a."9", a."8", a."27", b."40", b."41"
            ) a
              left join
              (select okpo_new as okpo from matched_filials) b on a."1" = b.okpo
       where b.okpo is null
     ) x
       inner join
     (
       select distinct a.fullname, a.shortname, a.inn, a.ogrn, a.kpp, a.region, a.address
       from _.statregistr_licenses a
              left join matched_filials b on a.inn = b.inn and a.ogrn = b.ogrn and a.fullname = b.fullname
       where a.branch = '1'
         and b.inn is null
     ) y on x."8" = y.inn or x."27" = y.ogrn
order by inn, ogrn, fullname, "7"
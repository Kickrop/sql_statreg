--select count(distinct a."1")
--from  _._1_statregistr_join_filials a
--inner join _._0_statregistr_statregistr7_plus1 b on a."1" = b."1"
--where b."50" = '1';
select count(*)
from _._1_statregistr_join_filials_


create materialized view _._1_statregistr_join_filials_ as
--select * from
  with filials1 as (
    select replace(okpo, '''', '')  as "1",
           replace(inn2, '''', '')  as inn,
           replace(ogrn2, '''', '') as ogrn,
           replace(kpp2, '''', '')  as kpp,
           address,
           fullname,
           shortname
    from get_google_table(
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
                                                                                                                                                                                                  kpp2 text)
    where length(inn2) > 1
    ),
    filials2 as (
      select replace(okpo, '''', '')  as "1",
             replace(inn2, '''', '')  as inn,
             replace(ogrn2, '''', '') as ogrn,
             replace(kpp2, '''', '')  as kpp,
             replace(address,'nan','') address,
             replace(fullname,'nan','') fullname,
             replace(shortname,'nan','') shortname
             --fullname,shortname
      from get_google_table(
               'https://docs.google.com/spreadsheets/d/e/2PACX-1vRD4RejyrjcnZ0R7-wCzoRZZ6JrC17UsUrO3WfkuR8dqBb_vUK8c7c0W_0GRfiYXegs810IdF9iUy_8/pub?gid=1593286949&single=true&output=csv'::text) a ("1" text,
                                                                                                                                                                                                     fullname text,
                                                                                                                                                                                                     shortname text,
                                                                                                                                                                                                     inn text,
                                                                                                                                                                                                     ogrn text,
                                                                                                                                                                                                     kpp text,
                 region text,
                 address text,
                                                                                                                                                                                                     okpo text,
                                                                                                                                                                                                     inn2 text,
                                                                                                                                                                                                     ogrn2 text,
                                                                                                                                                                                                     kpp2 text)
      where length(inn2) > 1
      )
      select a.*,
           source,
                 fullname,
                 shortname,
                 branch,
                 org_type,
                 inn,
                 ogrn,
                 kpp,
                 region,
                 address,
                 license_status,
                 license_authority,
                 license_number,
                 license_issue_date,
                 validity,
                 edu_level
    from (
           select *
           from _._0_statregistr_statregistr7
           where ("9" in ('2', '3') or (length("3") > 1 and right("3", 4) != '0001'))
             and "1" not in (select "1" from _._0_statregistr_second_head)
         ) a
           inner join
         (select source,
                 fullname,
                 shortname,
                 branch,
                 org_type,
                 inn,
                 ogrn,
                 kpp,
                 region,
                 address,
                 license_status,
                 license_authority,
                 license_number,
                 license_issue_date,
                 validity,
                 edu_level,
                 fullname_old
          from _._0_statregistr_licenses_edited
          where branch = '1' and is_deleted = '0'
         ) b on ((a."8" = b.inn or a."27" = b.ogrn) and (a."7" = b.fullname_old or a."7" = b.fullname or a."6" = b.shortname)
           and a."1" not in ('44383835', '44538396', '73482343360002'))

    union

    select a.*,
           source,
           fullname,
           shortname,
           branch,
           org_type,
           inn,
           ogrn,
           kpp,
           region,
           address,
           license_status,
           license_authority,
           license_number,
           license_issue_date,
           validity,
           edu_level
    from (
           select *
           from _._0_statregistr_statregistr7
           where ("9" in ('2', '3') or (length("3") > 1 and right("3", 4) != '0001'))
             and "1" not in (select "1" from _._0_statregistr_second_head)
         ) a
           inner join
         (select a.*, b."1"
          from _._0_statregistr_licenses_edited a
                 join (
            select *
            from filials1
            union
            select *
            from filials2
          ) b on a.inn = b.inn and a.ogrn = b.ogrn and a.kpp = b.kpp and
                 (a.fullname = b.fullname or a.fullname_old = b.fullname) and
                 a.address = b.address
          where branch = '1' and is_deleted = '0'
         ) b on a."1" = b."1"
;


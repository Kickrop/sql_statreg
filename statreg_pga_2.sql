--drop table statregistr_dop2
select distinct a."1", a."2", a."3", a."4", a."8", a."27", a."6", a."7", a."9",
                  a."21", a."22", a."16", a."17", a."18", a."19", a."78", a."79", b."81", b."82",
                  "117", "118", "119", "120", "67", "50" into temp table statregistr from _._0_statregistr_statregistr7 a
                  inner join _._0_statregistr_statregistr7_plus1 b on a."1" = b."1"
where a."1" not in (select "1" from _._0_statregistr_second_head) and "50" != '1';


--drop table statregistr

with vyborka as (
  select replace(okpo, '_', '') as "1"
  from get_google_table_v2(
           'https://docs.google.com/spreadsheets/d/e/2PACX-1vQQCEZiYuzvJzqqzlVVPfru9NMukwDhO-S2vtk3yLWSD4NaSHoRZgRjJ4cBReSv0Mpmq4M2MomyQRlU/pub?gid=2026021521&single=true&output=csv'::text) a(okpo text)
)
select a."1", "2", "3", "4", "7", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53", "54",
              "66", "75", "80", "81", "82", "83", "93", "94", "97", "106", "112", "115",
       case when b."1" is null then '0' else '1' end as "121"
       from _._0_statregistr_statregistr7_plus1 a
left join vyborka b on a."1" = b."1";

select count(distinct b."1") from _._0_statregistr_statregistr7_plus1 as a inner join
_._0_statregistr_statregistr7 as b on a."1" = b."1"
where a."1" not in (select "1" from _._0_statregistr_second_head) and "50" != '1'; 

select distinct a."1", a."2", a."3", a."4", a."8", a."27", a."6", a."7", a."9",
                   a."21", a."22", a."16", a."17", a."18", a."19", a."78", a."79", a."81", a."82",
                   "117", "118", "119", "120", "67", "50" into temp table statregistr from _.statregistr_main a
where a."1" not in (select "1" from _._0_statregistr_second_head) and "50" != '1';


select distinct a."1", a."2", a."3", a."4", a."8", a."27", a."6", a."7", a."9",
                  a."21", a."22", a."16", a."17", a."18", a."19", a."78", a."79", b."81", b."82",
                  "117", "118", "119", "120", "67", "50" into temp table statregistr from _._0_statregistr_statregistr7 a
                  inner join _._0_statregistr_statregistr7_plus1 b on a."1" = b."1"
where a."1" not in (select "1" from _._0_statregistr_second_head) and "50" != '1';

select count(distinct "1") from statregistr;
select count(distinct "1") from statregistr where (("21" like '%85.41%' and "21" is not null) or ("22" like '%85.41%' and "22" is not null));

select count(distinct "1") from _._1_statregistr_join_heads
where "1" in (select "1" from statregistr6) or "1" in (select "1" from statregistr7);

select count(distinct "1") from _._1_statregistr_join_heads
where "1" not in (select "1" from statregistr6) and "1" not in (select "1" from statregistr7) and
      "1" in (select distinct "1" from _._0_statregistr_statregistr7_plus1 where "50" != '1');

select "1" into temp table vyborka17
 from _._0_statregistr_statregistr7
where "1" in (
  select distinct "1"
  from _._1_statregistr_join_heads
  where "1" not in (select "1" from statregistr6)
    and "1" not in (select "1" from statregistr7)
    and "1" in (select distinct "1" from _._0_statregistr_statregistr7_plus1 where "50" != '1')
);
select "1" into temp table vyborka28
 from _._0_statregistr_statregistr7
where  "1" in (
select distinct "1" from _._1_statregistr_join_filials
where "1" not in (select "1" from statregistr6) and "1" not in (select "1" from statregistr7) and
      "1" in (select distinct "1" from _._0_statregistr_statregistr7_plus1 where "50" != '1'));

select distinct "1" into temp table vyborka_heads_from_filials from _._2_statregistr_heads_for_unjoined_filials
where "1" not in (select "1" from statregistr6) and "1" not in (select "1" from statregistr7) and
      "1" in (select distinct "1" from _._0_statregistr_statregistr7_plus1 where "50" != '1')
and inn not in (
  select replace(inn, '_', '') as inn
  from get_google_table_v2(
           'https://docs.google.com/spreadsheets/d/e/2PACX-1vRD4RejyrjcnZ0R7-wCzoRZZ6JrC17UsUrO3WfkuR8dqBb_vUK8c7c0W_0GRfiYXegs810IdF9iUy_8/pub?gid=1798315107&single=true&output=csv') a (inn text)
);

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

select a."1", b.*, c."50"
from vyborka_okpo a inner join _._0_statregistr_statregistr7 b on a."1" = b."1"
inner join _._0_statregistr_statregistr7_plus1 c on a."1" = c."1"


select count(*) from (
	select inn, branch, fullname, array_agg(edu_level) from _.statregistr_licenses
	where branch = '0' 
	group by inn, branch, fullname
	) x
	
where inn = '1909050709'          


select * from get_google_table_v2('https://docs.google.com/spreadsheets/d/e/2PACX-1vRD4RejyrjcnZ0R7-wCzoRZZ6JrC17UsUrO3WfkuR8dqBb_vUK8c7c0W_0GRfiYXegs810IdF9iUy_8/pub?gid=384335732&single=true&output=csv'::text) a (source text,fullname text,shortname text,branch text,org_type text,inn text,ogrn text,kpp text,region text,address text,license_status text,license_authority text,license_number text,license_issue_date text,validity text,edu_level text)
--where inn = '1909050709'
where inn || fullname in (select inn || fullname from _._0_statregistr_licenses_edited where branch = '')
--			 
  with licenses_edit as (
    select fullname,
           case when length(shortname) < 2 then null else shortname end                   as shortname,
           case when branch not in ('1','0') then null else branch end as branch,
	  		--branch,
           case when length(org_type) < 2 then null else org_type end                     as org_type,
           case when length(inn) < 4 then null else inn end as inn,
           case when length(ogrn) < 4 then null else ogrn end as ogrn,
           case when length(kpp) < 4 then null else kpp end                               as kpp,
           case when length(region) < 2 then null else region end                         as region,
           case when length(address) < 2 then null else address end                       as address,
           case when length(license_status) < 2 then null else license_status end         as license_status,
           case when length(license_authority) < 2 then null else license_authority end   as license_authority,
           case when length(license_number) < 2 then null else license_number end   as license_number,
           case when length(license_issue_date) < 2 then null else license_issue_date end as license_issue_date,
           case when length(validity) < 2 then null else validity end   as validity,
           case when length(edu_level) < 2 then null else edu_level end                   as edu_level
    --select * 
	  		from get_google_table_v2('https://docs.google.com/spreadsheets/d/e/2PACX-1vRD4RejyrjcnZ0R7-wCzoRZZ6JrC17UsUrO3WfkuR8dqBb_vUK8c7c0W_0GRfiYXegs810IdF9iUy_8/pub?gid=384335732&single=true&output=csv'::text) a (source text,
                                                                                                                                                                                                  fullname text,
                                                                                                                                                                                                  shortname text,
                                                                                                                                                                                                  branch text,
                                                                                                                                                                                                  org_type text,
                                                                                                                                                                                                  inn text,
                                                                                                                                                                                                  ogrn text,
                                                                                                                                                                                                  kpp text,
                                                                                                                                                                                                  region text,
                                                                                                                                                                                                  address text,
                                                                                                                                                                                                  license_status text,
                                                                                                                                                                                                  license_authority text,
                                                                                                                                                                                                  license_number text,
                                                                                                                                                                                                  license_issue_date text,
                                                                                                                                                                                                  validity text,
                                                                                                                                                                                                  edu_level text)
    )
	select * from licenses_edit
	where branch = '1'
			 
---
---
---
select * from _.statregistr_licenses
where inn = '6153005840'
--filials
select count(*)
from (
     select distinct inn, fullname, ogrn, address
      from _._0_statregistr_licenses_edited
where branch = '1' and is_deleted = '0'
--   group by inn
--   having count(distinct ogrn) > 1
       ) x;
--heads
select count(*)
from (
     select distinct inn, fullname, ogrn, address
      from _._0_statregistr_licenses_edited
where branch = '0' and is_deleted = '0'
       ) x;
--all
select count(*) from (
select distinct "1","8"
from _._0_statregistr_statregistr7) x

select count(*) from (
select distinct "1"
from _._0_statregistr_statregistr7_plus1
where "50" <> '1') x

select count(*)
from (
     select distinct inn, fullname, ogrn, address
      from _._0_statregistr_licenses_edited
where is_deleted = '0'
       ) x;

select count(*) from (select distinct inn,ogrn,fullname,address from _._1_statregistr_join_filials) x
--
with pam as (
select distinct inn,ogrn,fullname from _._0_statregistr_licenses_edited_
where --inn = '8906005757' --and branch = '0'
	--branch = '0' and 
	is_deleted = '1'
)
select * from pam
---
drop materialized view _._0_statregistr_licenses_edited_
create materialized view _._0_statregistr_licenses_edited_ as
  with licenses_edit as (
    select fullname,
           case when length(shortname) < 2 then null else shortname end                   as shortname,
           case when branch not in ('1','0') then null else branch end as branch,
	  		--branch,
           case when length(org_type) < 2 then null else org_type end                     as org_type,
           case when length(inn) < 4 then null else inn end as inn,
           case when length(ogrn) < 4 then null else ogrn end as ogrn,
           case when length(kpp) < 4 then null else kpp end                               as kpp,
           case when length(region) < 2 then null else region end                         as region,
           case when length(address) < 2 then null else address end                       as address,
           case when length(license_status) < 2 then null else license_status end         as license_status,
           case when length(license_authority) < 2 then null else license_authority end   as license_authority,
           case when length(license_number) < 2 then null else license_number end   as license_number,
           case when length(license_issue_date) < 2 then null else license_issue_date end as license_issue_date,
           case when length(validity) < 2 then null else validity end   as validity,
           case when length(edu_level) < 2 then null else edu_level end                   as edu_level
    from get_google_table_v2(
             'https://docs.google.com/spreadsheets/d/e/2PACX-1vRD4RejyrjcnZ0R7-wCzoRZZ6JrC17UsUrO3WfkuR8dqBb_vUK8c7c0W_0GRfiYXegs810IdF9iUy_8/pub?gid=384335732&single=true&output=csv'::text) a (source text,
                                                                                                                                                                                                  fullname text,
                                                                                                                                                                                                  shortname text,
                                                                                                                                                                                                  branch text,
                                                                                                                                                                                                  org_type text,
                                                                                                                                                                                                  inn text,
                                                                                                                                                                                                  ogrn text,
                                                                                                                                                                                                  kpp text,
                                                                                                                                                                                                  region text,
                                                                                                                                                                                                  address text,
                                                                                                                                                                                                  license_status text,
                                                                                                                                                                                                  license_authority text,
                                                                                                                                                                                                  license_number text,
                                                                                                                                                                                                  license_issue_date text,
                                                                                                                                                                                                  validity text,
                                                                                                                                                                                                  edu_level text)
    ),
    change_name_by_inn as (
      select replace(inn, '_', '')::text as inn, fullname, branch
      from get_google_table_v2(
               'https://docs.google.com/spreadsheets/d/e/2PACX-1vRD4RejyrjcnZ0R7-wCzoRZZ6JrC17UsUrO3WfkuR8dqBb_vUK8c7c0W_0GRfiYXegs810IdF9iUy_8/pub?gid=1119580414&single=true&output=csv'::text) a (inn text, fullname text, branch text)
      ),
    delete_by_fullname as (
      select fullname, '1'::text as is_deleted
      from get_google_table_v2(
               'https://docs.google.com/spreadsheets/d/e/2PACX-1vRD4RejyrjcnZ0R7-wCzoRZZ6JrC17UsUrO3WfkuR8dqBb_vUK8c7c0W_0GRfiYXegs810IdF9iUy_8/pub?gid=146207773&single=true&output=csv'::text) a (fullname text)
      ),
    change_ogrn_by_inn as (
      select replace(inn, '_', '') as inn, ogrn
      from get_google_table_v2(
               'https://docs.google.com/spreadsheets/d/e/2PACX-1vRD4RejyrjcnZ0R7-wCzoRZZ6JrC17UsUrO3WfkuR8dqBb_vUK8c7c0W_0GRfiYXegs810IdF9iUy_8/pub?gid=149956506&single=true&output=csv'::text) a(inn text, ogrn text)
      ),
    change_inn_by_ogrn as (
      select ogrn, inn
      from get_google_table_v2(
               'https://docs.google.com/spreadsheets/d/e/2PACX-1vRD4RejyrjcnZ0R7-wCzoRZZ6JrC17UsUrO3WfkuR8dqBb_vUK8c7c0W_0GRfiYXegs810IdF9iUy_8/pub?gid=378069560&single=true&output=csv'::text) a(ogrn text, inn text)
      ),
    change_inn_ogrn as (
      select replace(inn_old, '_', '') as inn_old, ogrn_old, replace(a.inn, '_', '') as inn, coalesce(b."27", c.ogrn, a.ogrn) as ogrn
      from (
      select replace(inn_old, '_', '') as inn_old, ogrn_old, replace(a.inn, '_', '') as inn, ogrn
      from get_google_table_v2('https://docs.google.com/spreadsheets/d/e/2PACX-1vRD4RejyrjcnZ0R7-wCzoRZZ6JrC17UsUrO3WfkuR8dqBb_vUK8c7c0W_0GRfiYXegs810IdF9iUy_8/pub?gid=948897933&single=true&output=csv'::text) a(inn_old text, ogrn_old text, inn text, ogrn text)
      ) a
      left join (select distinct "8", "27" from _.statregistr_statregistr6) b on a.inn = b."8"
      left join (select distinct inn, ogrn from _.statregistr_licenses) c on a.inn = c.inn
      ),
    change_one_org as (
      select 'Дополнительное образование детей и взрослых'::text                                                                  as edu_level,
             '2282002430'::text                                                                                                   as inn_old,
             '2281003022'::text                                                                                                   as inn,
             '1022202192980'::text                                                                                                as ogrn,
             '1'::text                                                                                                            as branch,
             'Зеленополянская основная общеобразовательная школа» - филиал Троицкой средней общеобразовательной школы № 2'::text  as fullname,
             'Зеленополянская основная общеобразовательная школа» - филиал Троицкой средней общеобразовательной школы № 2 '::text as shortname
      )
    select a.source,
           replace(coalesce(c.fullname, e.fullname, a.fullname),
                   '  ',
                   ' ')                                         as fullname,
           --            coalesce(c.fullname, a.fullname)                     as fullname,
           coalesce(b.shortname, e.shortname, a.shortname)      as shortname,
           coalesce(b.branch, e.branch, a.branch)               as branch,
           coalesce(b.org_type, a.org_type)                     as org_type,
           coalesce(b.inn, h.inn, e.inn, g.inn, a.inn)          as inn,
           coalesce(b.ogrn, h.ogrn, e.ogrn, f.ogrn, a.ogrn)     as ogrn,
           coalesce(b.kpp, a.kpp)                               as kpp,
           coalesce(b.region, a.region)                         as region,
           case
             when a.inn = '0237002114' and a.branch = '0'
               then '452331, Республика Башкортостан, Мишкинский район, с. Камеево, ул.Орсаево, д.18'
             else coalesce(b.address, a.address) end            as address,
           coalesce(b.license_status, a.license_status)         as license_status,
           coalesce(b.license_authority, a.license_authority)   as license_authority,
           coalesce(b.license_number, a.license_number)         as license_number,
           coalesce(b.license_issue_date, a.license_issue_date) as license_issue_date,
           coalesce(b.validity, a.validity)                     as validity,
           coalesce(b.edu_level, a.edu_level)                   as edu_level,
           case
             when a.ogrn = '1031700536642' then '1'::text
             else coalesce(d.is_deleted, '0'::text) end         as is_deleted,
           a.fullname                                           as fullname_old,
           a.shortname                                          as shortname_old,
           a.branch                                             as branch_old,
           a.org_type                                           as org_type_old,
           a.inn                                                as inn_old,
           a.ogrn                                               as ogrn_old,
           a.kpp                                                as kpp_old,
           a.region                                             as region_old,
           a.address                                            as address_old,
           a.license_status                                     as license_status_old,
           a.license_authority                                  as license_authority_old,
           a.license_number                                     as license_number_old,
           a.license_issue_date                                 as license_issue_date_old,
           a.validity                                           as validity_old,
           a.edu_level                                          as edu_level_old
    from _.statregistr_licenses a
           left join licenses_edit b on a.fullname = b.fullname
           left join change_name_by_inn c on (a.inn = c.inn or b.inn = c.inn) and a.branch = c.branch
           left join delete_by_fullname d on a.fullname = d.fullname or replace(a.fullname, '  ', ' ') = d.fullname
           left join change_one_org e on a.inn = e.inn_old and a.edu_level = e.edu_level
           left join change_ogrn_by_inn f on a.inn = f.inn
           left join change_inn_by_ogrn g on a.ogrn = g.ogrn
           left join change_inn_ogrn h on a.inn = h.inn_old and a.ogrn = h.ogrn_old
;
			 
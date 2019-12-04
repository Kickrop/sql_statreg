create materialized view _._0_statregistr_licenses_edited as
  with licenses_edit as (
    select fullname,
           case when length(shortname) < 2 then null else shortname end                   as shortname,
           branch,
           case when length(org_type) < 2 then null else org_type end                     as org_type,
           inn,
           ogrn,
           case when length(kpp) < 4 then null else kpp end                               as kpp,
           case when length(region) < 2 then null else region end                         as region,
           case when length(address) < 2 then null else address end                       as address,
           case when length(license_status) < 2 then null else license_status end         as license_status,
           case when length(license_authority) < 2 then null else license_authority end   as license_authority,
           license_number,
           case when length(license_issue_date) < 2 then null else license_issue_date end as license_issue_date,
           validity,
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
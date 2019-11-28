select count(distinct inn)
from _._0_statregistr_licenses_edited_
where branch = '' and 
is_deleted = '0';

--36045+1993+101

select inn,fullname,count(*)--, case when lower(fullname) like '%филиал%' then 1 else 0 end branch_new
from (
     select distinct inn, ogrn,fullname --, branch--, address
      from _._0_statregistr_licenses_edited_
where branch = '' --and lower(fullname) like '%филиал%' --or  branch = '' --or branch = ''--and is_deleted = '0'
       ) x
group by inn,fullname
order by count desc
 --4857+36057+123   
      
select count(*)
from (
     select distinct inn, ogrn,fullname--, address
      from statregistr_licenses--_._0_statregistr_licenses_edited_
where branch = '1' --and is_deleted = '0'
       ) x;      
       
      
select count(distinct inn)
from _._0_statregistr_licenses_edited
where branch = '0' and is_deleted = '0'
and inn not in (select distinct inn from _._1_statregistr_join_heads);

select distinct a."1", a."2", a."3", a."4", a."8", a."27", a."6", a."7", a."9",
                  a."21", a."22", a."16", a."17", a."18", a."19", a."78", a."79", b."81", b."82",
                  "117", "118", "119", "120", "67", "50" into temp table statregistr from _._0_statregistr_statregistr7 a
                  inner join _._0_statregistr_statregistr7_plus1 b on a."1" = b."1"
where a."1" not in (select "1" from _._0_statregistr_second_head) and "50" != '1';

select count(distinct "1") from statregistr where (("16" like '%80.10.3%' and "16" is not null)
                                                     or ("17" like '%80.10.3%' and "17" is not null)
                                               or ("18" like '%80.10.3%' and "18" is not null)
                                                     or ("19" like '%80.10.3%' and "19" is not null))
or (("21" like '%85.41%' and ("21" is not null))
           or ("22" like '%85.41%' and ("22" is not null)));
           
select "6", "9", "8"
from _0_statregistr_statregistr7
where "8" = '1706004062' --length("8") < 10 --left("8",1) = '0'

select count(*)
from _0_statregistr_licenses_edited
where left(inn,1) = '0' --length("1") < 8

select count(distinct inn)
from _0_statregistr_licenses_edited_
where length(inn) = 10 and branch = '0'

select *
from _0_statregistr_licenses_edited_
where inn = '5103070023'

select count(distinct x.inn) from (
select source,fullname,replace(shortname,'nan','') shortname
    ,replace(replace(branch, '.0',''),'nan','') branch
    ,replace(replace(org_type, '.0',''),'nan','') org_type
    ,replace(replace(inn, '.0',''),'nan','') inn
    ,replace(replace(ogrn, '.0',''),'nan','') ogrn
    ,replace(replace(kpp, '.0',''),'nan','') kpp
    ,replace(region, 'nan','') region
    ,replace(address, 'nan','') address
    ,replace(replace(license_status, '.0',''),'nan','') license_status
    ,replace(replace(license_authority, '.0',''),'nan','') license_authority
    ,replace(replace(license_number, '.0',''),'nan','') license_number
    ,replace(replace(license_issue_date, '.0',''),'nan','') license_issue_date
    ,replace(replace(validity, '.0',''),'nan','') validity
    ,replace(replace(edu_level, '.0',''),'nan','') edu_level 
    from get_google_table(
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
                                                                                                                                                                                                 ) x
join _._0_statregistr_licenses_edited_ on x.inn=_._0_statregistr_licenses_edited_.inn

select * from (
select source,fullname,replace(shortname,'nan','') shortname
    ,replace(replace(branch, '.0',''),'nan','') branch
    ,replace(replace(org_type, '.0',''),'nan','') org_type
    ,replace(replace(inn, '.0',''),'nan','') inn
    ,replace(replace(ogrn, '.0',''),'nan','') ogrn
    ,replace(replace(kpp, '.0',''),'nan','') kpp
    ,replace(region, 'nan','') region
    ,replace(address, 'nan','') address
    ,replace(replace(license_status, '.0',''),'nan','') license_status
    ,replace(replace(license_authority, '.0',''),'nan','') license_authority
    ,replace(replace(license_number, '.0',''),'nan','') license_number
    ,replace(replace(license_issue_date, '.0',''),'nan','') license_issue_date
    ,replace(replace(validity, '.0',''),'nan','') validity
    ,replace(replace(edu_level, '.0',''),'nan','') edu_level 
from get_google_table(
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
                                                                                                                                                                                                 ) x
 
select count(distinct inn)
from (
select a.inn,a.fullname,case when a.branch='' then b.branch end--b.branch--inn,ogrn,fullname
from (select distinct inn,ogrn, fullname,branch from _0_statregistr_licenses_edited_) a
join 
(select replace(inn,'-','0') inn, ogrn, fullname, branch from 
get_google_table('https://docs.google.com/spreadsheets/d/e/2PACX-1vS2HQbhMYCqQ6hEtrphR-7cE85SaWXiv4h77rAklcoSYT0AZGnNg2S4tlGzmUziOFIhfoLSloJ3n9dZ/pub?gid=322880575&single=true&output=csv'::text) a (inn text, ogrn text, fullname text, branch text)
) b
on a.inn=b.inn or a.fullname=b.fullname
) x 
where branch='1'
select count(*)
from (
select distinct inn,fullname --,ogrn_old,fullname_old,address_old--inn,ogrn,fullname, address, inn_old--,address --inn_old,ogrn_old,fullname_old
from _0_statregistr_licenses_edited_
--where branch = '1' and lower(fullname) not like '%филиал%'
where branch='0'--length(inn) < 2
) x

select * from _0_statregistr_licenses_edited_
where inn='0237002114'
--fullname='Общество с ограниченной ответственностью «УМС Рус»'

select count(inn)--source,fullname,shortname,branch,org_type,inn,ogrn,kpp,region,address,license_status,license_authority,license_number,license_issue_date,validity,is_deleted,
from (select distinct inn, fullname
	from (
		select source,fullname,shortname,branch,org_type,inn,ogrn,kpp,region,address,license_status,license_authority,license_number,license_issue_date,validity,is_deleted
		,array_agg(edu_level) edu_level
		from _0_statregistr_licenses_edited_
		--where  is_deleted='0' and branch='0'
		group by source,fullname,shortname,branch,org_type,inn,ogrn,kpp,region,address,license_status,license_authority,license_number,license_issue_date,validity,is_deleted
	) x
) y


select count(*)
from (
select fullname, count(*) pam--,address --inn_old,ogrn_old,fullname_old
from _0_statregistr_licenses_edited_
--where branch = '1' and lower(fullname) not like '%филиал%'
group by fullname
having count(*) > 1
order by pam desc
) x
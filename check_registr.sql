with check_registr as (
select 'org_tip' name_field,org_tip::text "value",count(*) as col
from registr
group by name_field,org_tip
UNION
select '1_dop_15-18' name_field,"1dop_2015-2018"::text,count(*)
from registr
group by name_field,"1dop_2015-2018"
UNION
select '1_dop_2016' name_field,"1dop_2016"::text,count(*)
from registr
group by name_field,"1dop_2016"
UNION
select '1_dop_2017' name_field,"1dop_2017"::text,count(*)
from registr
group by name_field,"1dop_2017"
UNION
select '1_dop_2018' name_field,"1dop_2018"::text,count(*)
from registr
group by name_field,"1dop_2018"
UNION
select 'lic_o' name_field,lic_o::text,count(*)
from registr
group by name_field,lic_o
UNION
select 'lic_dop' name_field,lic_dop::text,count(*)
from registr
group by name_field,lic_dop
UNION
select 'lic_do' name_field,lic_do::text,count(*)
from registr
group by name_field,lic_do
UNION
select 'lic_no' name_field,lic_no::text,count(*)
from registr
group by name_field,lic_no
UNION
select 'lic_oo' name_field,lic_oo::text,count(*)
from registr
group by name_field,lic_oo
UNION
select 'lic_so' name_field,lic_so::text,count(*)
from registr
group by name_field,lic_so
UNION
select 'lic_spo' name_field,lic_spo::text,count(*)
from registr
group by name_field,lic_spo
UNION
select 'lic_vo_b' name_field,lic_vo_b::text,count(*)
from registr
group by name_field,lic_vo_b
UNION
select 'lic_vo_s' name_field,lic_vo_s::text,count(*)
from registr
group by name_field,lic_vo_s
UNION
select 'lic_vo_m' name_field,lic_vo_m::text,count(*)
from registr
group by name_field,lic_vo_m
UNION
select 'lic_vo_kvk' name_field,lic_vo_kvk::text,count(*)
from registr
group by name_field,lic_vo_kvk
UNION
select 'lic_vo_po' name_field,lic_po::text,count(*)
from registr
group by name_field,lic_po
UNION
select 'status_lic_o' name_field,status_lic_o::text,count(*)
from registr
group by name_field,status_lic_o
UNION
select 'status_lic_dop' name_field,status_lic_dop::text,count(*)
from registr
group by name_field,status_lic_dop
UNION
select 'predpr_type' name_field,predpr_type,count(*)
from registr
group by name_field,predpr_type
UNION
select 'org_type' name_field,org_type,count(*)
from registr
group by name_field,org_type
UNION
select 'dop_dod' name_field,dop_dod::text,count(*)
from registr
group by name_field,dop_dod
UNION
select 'dop_ad' name_field,dop_ad::text,count(*)
from registr
group by name_field,dop_ad
UNION
select 'dop_dod_raz' name_field,dop_dod_raz::text,count(*)
from registr
group by name_field,dop_dod_raz
UNION
select 'dop_dod_is' name_field,dop_dod_is::text,count(*)
from registr
group by name_field,dop_dod_is
UNION
select 'dop_dod_fs' name_field,dop_dod_fs::text,count(*)
from registr
group by name_field,dop_dod_fs
UNION
select 'dop_dod_tn' name_field,dop_dod_tn::text,count(*)
from registr
group by name_field,dop_dod_tn
UNION
select 'dop_dod_en' name_field,dop_dod_en::text,count(*)
from registr
group by name_field,dop_dod_en
UNION
select 'dop_dod_fn' name_field,dop_dod_fn::text,count(*)
from registr
group by name_field,dop_dod_fn
UNION
select 'dop_dod_artn' name_field,dop_dod_artn::text,count(*)
from registr
group by name_field,dop_dod_artn
UNION
select 'dop_dod_turn' name_field,dop_dod_turn::text,count(*)
from registr
group by name_field,dop_dod_turn
UNION
select 'dop_dod_socn' name_field,dop_dod_socn::text,count(*)
from registr
group by name_field,dop_dod_socn
UNION
select 'org_sost' name_field,org_sost::text,count(*)
from registr
group by name_field,org_sost
UNION
select 'org_ovz' name_field,org_ovz::text,count(*)
from registr
group by name_field,org_ovz
UNION
select 'dop_dod_adap_raz' name_field,dop_dod_adap_raz::text,count(*)
from registr
group by name_field,dop_dod_adap_raz
UNION
select 'dop_dod_adap_is' name_field,dop_dod_adap_is::text,count(*)
from registr
group by name_field,dop_dod_adap_is
UNION
select 'dop_dod_adap_fs' name_field,dop_dod_adap_fs::text,count(*)
from registr
group by name_field,dop_dod_adap_fs
UNION
select 'org_izm' name_field,org_izm::text,count(*)
from registr
group by name_field,org_izm
UNION
select 'included_in_fsn' name_field,included_in_fsn::text,count(*)
from registr
group by name_field,included_in_fsn
UNION
select 'lic_ron' name_field,lic_ron::text,count(*)
from registr
group by name_field,lic_ron
)
select check_registr.name_field,value,col,round(col/vsego*100,2) percent,vsego
from check_registr
--group by name_field
join (select name_field,sum(col) vsego from check_registr group by name_field) x on check_registr.name_field = x.name_field
ORDER BY check_registr.name_field


--select * from registr where predpr_type = '4'
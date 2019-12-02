select * --count(r.kod_okpo)
from registr r
where 
okved_main_reg is null
--status_lic_dop is not null
--and 
r.included_in_fsn in (1,2)

select count(tel)
from registr r
where r.included_in_fsn in (1,0,3)

select count(*) from registr 
where 
lic_no is null


select count(*) from registr 
where 
lic_dop is null

select count(*) from (
	select 
	--count(oi.okpo)
	case when pole_42 is not null and length(pole_42) > 2 then pole_42 else r11.tel end as tel
	from statregistr7 s
	join org_inf oi on oi.okpo=s.pole_1 or oi.okpo=s.pole_3 
	left join razdel_1_1 r11 on r11.okpo=oi.okpo
	where length(pole_42) > 2
	and oi.included_in_registr=1
	) x
	where x.tel is null
	
select tel
from razdel_1_1 r --where tel =''
--join org_inf oi on oi.okpo=r.okpo
--join noreg_org noo on oi.okpo=noo.okpo
where okpo = '00035106400002'

select *
from statregistr7 s --where tel =''
--join org_inf oi on oi.okpo=r.okpo
--join noreg_org noo on oi.okpo=noo.okpo
where pole_1 = '52186865' --and pole_9::int = 1

select count(distinct s.okpo)
from org_inf s --where tel =''
--join org_inf oi on oi.okpo=r.okpo
--join noreg_org noo on oi.okpo=noo.okpo
join additional_okved ad on s.okpo=ad.okpo
where --okpo = '52186865'
	ad.gr4_okved_add is not null
	and s.included_in_registr=1
	and ad.str_n::int = 2

select *
from razdel_1_1 r --where tel =''
--join org_inf oi on oi.okpo=r.okpo
--join noreg_org noo on oi.okpo=noo.okpo
where okpo = '52186865'6660017442
04650456            
52186865            
33889595            
39422740            
53250273   

6660017442	85.14
7807016202	85.14
7807027733	85.11
6609002284	85.13 dop reg 85.41
7811022978	85.14 dop reg 85.41

with pam as (
select --* --count(org_inf.okpo)
	org_inf.okpo
	,case 
		when is_dod = 1 and r2.str_n::int = 1 and (r2.gr3::int = 0 or r2.gr3 is null) then max_gr3 
		when is_dod = 1 and r2.str_n::int = 1 and r2.gr3::int > 0 then r2.gr3
	end as deti_dod	
from org_inf 
	left join razdel_2 r2
		on org_inf.okpo = r2.okpo
	left join deti_dod on org_inf.okpo=deti_dod.okpo
where r2.str_n::int = 1
)
select count(*)--okpo, deti_dod
from pam
where deti_dod is not null	
--


with pum as (
select --count(distinct s.okpo)
	s.okpo,sum(gr3)
from org_inf s --where tel =''
join razdel_2 r2 on s.okpo=r2.okpo
where s.included_in_registr in (1,2) --str_n = 1
group by s.okpo 
having sum(gr3)=0
)
select count(*) from pum

--str <> 1: 66713
--str all 66758
--sum gr3=0

with pum as (
select count(distinct s.okpo)
	--s.okpo,sum(gr3)
from org_inf s 
join razdel_2 r2 on s.okpo=r2.okpo
where s.included_in_registr in (1) and gr3 is not null
	--and str_n =1 --
	and str_n between 1 and 10
	and is_dod = 1
group by s.okpo 
having sum(gr3)<>0
)
select count(*) from pum

	--r2.str_n::int = 1 and 
	--(r2.gr3::numeric=0 or r2.gr3 is null)
	--sum(gr3) >0
--join org_inf oi on oi.okpo=r.okpo
--join noreg_org noo on oi.okpo=noo.okpo
--join additional_okved ad on s.okpo=ad.okpo

---
select count(*)
from razdel_1_2_2 r122
join org_inf oi on oi.okpo=r122.okpo
where r122.str_n = 6 and r122.gr3::int=1 and r122.gr4::int<>2 and included_in_registr = 1
and r122.okpo not in (select distinct oi.okpo
						from statreg7_ron_matched srm 
						join org_inf oi on oi.okpo = srm.okpo_id
						join statreg7_ron_matched_edu_level el on srm.okpo_id=el.okpo_id
						where included_in_registr = 1 and edu_level in ('Среднее профессиональное образование','Начальное профессиональное образование') and license_status <> 'Не действует'
)
--

select distinct oi.okpo
from statreg7_ron_matched srm 
join org_inf oi on oi.okpo = srm.okpo_id
join statreg7_ron_matched_edu_level el on srm.okpo_id=el.okpo_id
where included_in_registr = 1 and edu_level in ('Среднее профессиональное образование','Начальное профессиональное образование') and license_status <> 'Не действует'

select okpo,pam from (
select --count(distinct oi.okpo)
oi.okpo,
case when included_in_registr = 1 and (edu_level like '%Среднее профессиональное образование%' or edu_level like '%Начальное профессиональное образование%') and license_status <> 'Не действует' then 1 end pam
from statreg7_ron_matched srm 
join org_inf oi on oi.okpo = srm.okpo_id
--join statreg7_ron_matched_edu_level el on srm.okpo_id=el.okpo_id
left join 
	(
		select okpo_id,array_agg(edu_level)::text as edu_level 
		from statreg7_ron_matched_edu_level
		group by okpo_id
	) as aokv 
	on srm.okpo_id= aokv.okpo_id
--where included_in_registr = 1 and (edu_level like '%Среднее профессиональное образование%' or edu_level like '%Начальное профессиональное образование%') and license_status <> 'Не действует'
) x
where pam = 1 and okpo not in (select okpo from razdel_1_2_2 r)
--

select count(*) from org_inf oi where oi.included_in_registr in (1,2)
select * from registr
select distinct okved_main_reg
from registr


select --distinct org_tip
	'org_tip = 1'
	,count(case when org_tip=1 then 1 end) org_tip_1
	--,count(case when org_tip=2 then 2 end) org_tip_2
from registr
union select --distinct org_tip
	'org_tip = 2'
	,count(case when org_tip=2 then 2 end) org_tip_2
	--,count(case when org_tip=2 then 2 end) org_tip_2
from registr

select
	okved_add
	,count(kod_okpo) okved_add
from registr
group by okved_add

select left(okved_main_reg,5) okved_main_reg_5_symb,count(kod_okpo)
from registr
group by left(okved_main_reg,5)
order by count desc

select okfs,count(kod_okpo)
from registr
group by okfs
order by count desc


SELECT 
	count(kod_okpo) kod_okpo
	,count(id_n) id_n
	,count(okpo) okpo
	,count(okpo_head) okpo_head
	,count(short_name) short_name
	,count(full_name) full_name
	,count(inn) inn
	,count(org_tip) org_tip
	,count(ur_address) ur_address
	,count(phys_address) phys_address
	,count(tel) tel
	,count(mail) mail
	,count(fax) fax
	,count(okato_reg) okato_reg
	,count(oktmo_reg) oktmo_reg
	,count(oktmo_fact) oktmo_fact
	,count(okogu) okogu
	,count(okfs) okfs
	,count(okopf) okopf
	,count(ogrn) ogrn
	,count(okved_main_reg) okved_main_reg
	,count(okved_add) okved_add
	,count("1dop_2015-2018") dop_2015_2018
	,count("1dop_2016") dop_2016
	,count("1dop_2017") dop_2017
	,count("1dop_2018") dop_2018
	,count(lic_o) lic_o
	,count(lic_dop) lic_dop
	,count(lic_do) lic_do
	,count(lic_no) lic_no
	,count(lic_oo) lic_oo
	,count(lic_so) lic_so
	,count(lic_spo) lic_spo
	,count(lic_vo_b) lic_vo_b
	,count(lic_vo_s) lic_vo_s
	,count(lic_vo_m) lic_vo_m
	,count(lic_vo_kvk) lic_vo_kvk
	,count(lic_po) lic_po
	,count(lic_dpo) lic_dpo
	,count(status_lic_o) status_lic_o
	,count(status_lic_dop) status_lic_dop
	,count(predpr_type) predpr_type
	,count(okved_main_fact) okved_main_fact
	,count(okved_add_fact) okved_add_fact
	,count(ped_rab) ped_rab
	,count(deti_dod) deti_dod
	,count(org_type) org_type
	,count(dop_dod) dop_dod
	,count(dop_ad) dop_ad
	,count(dop_dod_raz) dop_dod_raz
	,count(dop_dod_is) dop_dod_is
	,count(dop_dod_fs) dop_dod_fs
	,count(dop_dod_tn) dop_dod_tn
	,count(dop_dod_en) dop_dod_en
	,count(dop_dod_fn) dop_dod_fn
	,count(dop_dod_artn) dop_dod_artn
	,count(dop_dod_turn) dop_dod_turn
	,count(dop_dod_socn) dop_dod_socn
	,count(org_sost) org_sost
	,count(org_ovz) org_ovz
	,count(dop_dod_adap_raz) dop_dod_adap_raz
	,count(dop_dod_adap_is) dop_dod_adap_is
	,count(dop_dod_adap_fs) dop_dod_adap_fs
	,count(org_izm) org_izm
	,count(lic_ron) lic_ron
	,count(included_in_fsn) included_in_fsn
FROM registr
--


--


--tab 1
select --count(pole_1)
	pole_1 kod_okpo
	,pole_6 short_name
	,pole_7 full_name
	,pole_8 inn
	,pole_27 ogrn
	,pole_9 org_tip	
from statregistr7 s
where in_vyborka ='1'
--

--tab 3 75525
--short_registr
select 
	kod_okpo
	,short_name
	,full_name
	,inn
	,ogrn
	,case when org_tip = 1 then 'Юридическое лицо' 
		when org_tip = 2 then 'Филиал/ТОСП'
	end org_tip	
	,case when included_in_fsn = 1 then 1 end as is_dod
from registr
--join org_inf oi on oi.okpo = registr.kod_okpo or oi.okpo = registr.okpo
where --kod_okpo in (select okpo from org_inf oi)
	included_in_fsn in (1,2)	
--

	
--tab 4 75525
--short_registr
select count(*)
--	kod_okpo
--	,short_name
--	,full_name
--	,inn
--	,ogrn
--	,case when org_tip = 1 then 'Юридическое лицо' 
--		when org_tip = 2 then 'Филиал/ТОСП'
--	end org_tip	
--	,case when included_in_fsn = 1 then 1 end as is_dod
from registr r 
--join statreg7_ron_matched ron on r.kod_okpo=ron.pole_1
--join org_inf oi on oi.okpo = registr.kod_okpo or oi.okpo = registr.okpo
where --kod_okpo in (select okpo from org_inf oi)
	included_in_fsn in (1,2) and 
	kod_okpo not in (select pole_1 from statreg7_ron_matched)

	
	
select --count(*)
	registr.full_name
	,kod_okpo
	,registr.inn
	,registr.ogrn
	,registr.org_tip
	,r121.gr4
	,r121.gr5
	,r121.gr6
	,r122.*	
from org_inf oi
join razdel_1_2_1 r121 on oi.okpo=r121.okpo
join 
(select 
	okpo
	,sum(case when str_n = 1 then gr3::int end) r122_gr3_1 
	,sum(case when str_n = 2 then gr3::int end) r122_gr3_2 
	,sum(case when str_n = 3 then gr3::int end) r122_gr3_3
	,sum(case when str_n = 4 then gr3::int end) r122_gr3_4 
	,sum(case when str_n = 5 then gr3::int end) r122_gr3_5 
	,sum(case when str_n = 6 then gr3::int end) r122_gr3_6 
	,sum(case when str_n = 7 then gr3::int end) r122_gr3_7 
	,sum(case when str_n = 8 then gr3::int end) r122_gr3_8 
	,sum(case when str_n = 9 then gr3::int end) r122_gr3_9
	,sum(case when str_n = 10 then gr3::int end) r122_gr3_10 
	,sum(case when str_n = 11 then gr3::int end) r122_gr3_11 
	,sum(case when str_n = 12 then gr3::int end) r122_gr3_12 
from razdel_1_2_2 r
group by okpo) r122
	on oi.okpo=r122.okpo
join razdel_1_1 r11
	on r11.okpo = oi.okpo
join registr on oi.okpo = registr.okpo
--join razdel_1_2_2 r122 on oi.okpo=r122.okpo
where included_in_registr = 1 and oi.okpo not in (select trim(okpo_id) from statreg7_ron_matched)
--


select 
	okpo
	,sum(case when str_n = 1 then gr3::int end) r122_gr3_1 
	,sum(case when str_n = 2 then gr3::int end) r122_gr3_2 
	,sum(case when str_n = 3 then gr3::int end) r122_gr3_3
	,sum(case when str_n = 4 then gr3::int end) r122_gr3_4 
	,sum(case when str_n = 5 then gr3::int end) r122_gr3_5 
	,sum(case when str_n = 6 then gr3::int end) r122_gr3_6 
	,sum(case when str_n = 7 then gr3::int end) r122_gr3_7 
	,sum(case when str_n = 8 then gr3::int end) r122_gr3_8 
	,sum(case when str_n = 9 then gr3::int end) r122_gr3_9
	,sum(case when str_n = 10 then gr3::int end) r122_gr3_10 
	,sum(case when str_n = 11 then gr3::int end) r122_gr3_11 
	,sum(case when str_n = 12 then gr3::int end) r122_gr3_12 
from razdel_1_2_2 r
group by okpo
--

select *
from razdel_1_2_2 r
where okpo='00007396'

	
select count(*)
	kod_okpo
	,short_name
	,full_name
	,inn
	,ogrn
	,case when org_tip = 1 then 'Юридическое лицо' 
		when org_tip = 2 then 'Филиал/ТОСП'
	end org_tip	
from registr
join org_inf oi on oi.okpo = registr.kod_okpo or oi.okpo = registr.okpo
where kod_okpo in (select okpo from org_inf oi)










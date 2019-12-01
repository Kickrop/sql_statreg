select * from razdel_2
where okpo = '36780717055003'

--drop table org_inf
ALTER TABLE statregistr.razdel_2 ALTER COLUMN gr3 TYPE text USING str_n::text

select count(org_inf.okpo)
from org_inf 
join razdel_1_2_2 on org_inf.okpo=razdel_1_2_2.okpo
join razdel_2 on org_inf.okpo=razdel_2.okpo
where razdel_1_2_2.str_n='1'
and razdel_2.str_n='1'
and razdel_2.gr3 > '0.00'
and (razdel_1_2_2.gr3<>'1' or razdel_1_2_2.gr3 is null)

select sum(str_n) from razdel_2 

select *
			from
			get_google_table_v2('https://docs.google.com/spreadsheets/d/e/2PACX-1vTpS21aePHnIRGZLK4bkhrkRag5okNIHGr7w9Xw7o5c-u3-P4SBvhSxUyfOzkJkZiG4eEaoJfg0w8rE/pub?gid=1025667544&single=true&output=csv'::text) a(id text, razdel text, str_num text, x3 text, x4 text, x5 text, x6 text, x7 text, x8 text, x9 text, x10 text)
			

drop materialized view _._0_statregistr_statregistr7

--drop table s_status_okpo
drop table s_pr_tobj

select max(length(okpo)) from razdel_2
ALTER TABLE statregistr.razdel_2 ALTER COLUMN okpo TYPE varchar(14) --USING str_n::integer
--varchar(8)

--custom updates 01.11.19
select * from razdel_1_1
update razdel_1_1
set okato_reg = '45277571000'
where okpo = '40258820400002'

update razdel_1_1
set okato_fact = '45277584000'
where okpo = '40258820400002'

update razdel_1_1
set oktmo_reg = '45338000000'
where okpo = '40258820400002'

update razdel_1_1
set oktmo_fact = '45343000000'
where okpo = '40258820400002'

update org_inf
set phys_address = '196210, „. —‡ÌÍÚ-œÂÚÂ·Û„, ÛÎ. œËÎÓÚÓ‚, ‰ÓÏ 18, ÍÓ.4'
where okpo = '40258820400002'

update razdel_1_2_2
set gr3 = '2'
where okpo = '40258820400002' and str_n = 1

update razdel_1_2_2
set gr4 = '9999'
where okpo = '40258820400002' and str_n = 1

--update razdel_1_2_2
--set gr5 = ''
--where okpo = '40258820400002' and str_n = 1

update razdel_2
set gr3 = 0
--select * from razdel_2
where okpo = '40258820400002' and str_n = 14

update razdel_2
set gr3 = 0
--select * from razdel_2
where okpo = '40258820400002' and str_n = 14

update razdel_1_2_1
set gr3 = '2'
where okpo = '34816291' and str_n = 1

update razdel_1_2_1
set gr4 = '9999'
where okpo = '34816291' and str_n = 1

update razdel_1_2_1
set gr5 = '9999'
where okpo = '34816291' and str_n = 1

--second org
update org_inf
set phys_address = '446205, –ÓÒÒËˇ, —‡Ï‡ÒÍ‡ˇ Ó·Î‡ÒÚ¸,„. ÕÓ‚ÓÍÛÈ·˚¯Â‚ÒÍ, ÛÎ. ≈„ÓÓ‚‡, ‰. 10·'
--select * from org_inf
where okpo = '40988406360002'

update org_inf
set full_name = '—ÚÛÍÚÛÌÓÂ ÔÓ‰‡Á‰ÂÎÂÌËÂ ƒÂÚÒÍËÈ Ò‡‰ "¬‡ÒËÎÂÍ" √Œ—”ƒ¿–—“¬≈ÕÕŒ√Œ ¡ﬁƒ∆≈“ÕŒ√Œ Œ¡Ÿ≈Œ¡–¿«Œ¬¿“≈À‹ÕŒ√Œ ”◊–≈∆ƒ≈Õ»ﬂ —¿Ã¿–— Œ… Œ¡À¿—“» Œ—ÕŒ¬Õ¿ﬂ Œ¡Ÿ≈Œ¡–¿«Œ¬¿“≈À‹Õ¿ﬂ ÿ ŒÀ¿ π 20 »Ã≈Õ» ¬.‘.√–”ÿ»Õ¿ √Œ–Œƒ¿ ÕŒ¬Œ ”…¡€ÿ≈¬— ¿ √Œ–Œƒ— Œ√Œ Œ –”√¿ ÕŒ¬Œ ”…¡€ÿ≈¬— '
--select * from org_inf
where okpo = '40988406360002'

update org_inf
set short_name = '—œ ƒÂÚÒÍËÈ Ò‡‰ "¬‡ÒËÎÂÍ" √¡Œ” ŒŒÿ π 20 „. ÕÓ‚ÓÍÛÈ·˚¯Â‚ÒÍ‡'
--select * from org_inf
where okpo = '40988406360002'

--updates control 16 01.11.19
select * from razdel_1_1
where okpo IN ('40258820400002','40988406360002')

https://docs.google.com/spreadsheets/d/e/2PACX-1vQPySSCjZOFC9cHdkeMdcxcdAGw7EAGGS_ulp_KXGDfPJOEeBW-eA3GiXH7Yd5jbP0Q_BUyIHNutW43/pub?gid=2087297296&single=true&output=csv

--updates 07.11.19
--delete
--select * from razdel_1_1
delete from razdel_1_1
select * from razdel_2
where okpo = '63092902000002'
--
delete from razdel_2
--select * from razdel_2
where okpo = '63092902000002'
--
delete from razdel_1_2_2
--select * from razdel_1_2_2
where okpo = '63092902000002'
--
delete from razdel_1_2_1
--select * from razdel_1_2_1
where okpo = '63092902000002'
--
delete from org_inf
--select * from org_inf
where okpo = '63092902000002'
--
--delete from razdel_1_3
----select * from razdel_1_3
--where okpo_branch = '63092902000002'
--
--
select * from razdel_1_1
--delete from razdel_1_1
where okpo = '63421760000002'
--
delete from razdel_2
--select * from razdel_2
where okpo = '63421760000002'
--
delete from razdel_1_2_2
--select * from razdel_1_2_2
where okpo = '63421760000002'
--
delete from razdel_1_2_1
--select * from razdel_1_2_1
where okpo = '63421760000002'
--
delete from org_inf
--select * from org_inf
where okpo = '63421760000002'
--
--update 1	
update razdel_1_1
set okato_fact=x.okato_fact_n
--,org_ovz=x.org_ovz
--select * --length(oktmo_fact_n)
from (select replace(okpo,'_','') okpo
,case 
	when length(okato_fact_n) = 10 then '0' || okato_fact_n else okato_fact_n
 end as okato_fact_n
,case
	when length(oktmo_fact_n) = 10 then '0' || oktmo_fact_n else oktmo_fact_n
end as oktmo_fact_n, org_status_n, okpo_head_n from get_google_table_v2('https://docs.google.com/spreadsheets/d/e/2PACX-1vSKKg596QTogmAnBfqWtPToR-Q7jwJLlnu0nGPgxTHS-BfJWZi29ZKt2QqpC4hyzXl9iZDFfws_v0Dr/pub?gid=810155244&single=true&output=csv'::text) a(okpo text, okato_fact_n text, oktmo_fact_n text, org_status_n text, okpo_head_n text)) x
--where okpo in (select okpo from razdel_1_1)
where x.okato_fact_n <> '' and razdel_1_1.okpo=x.okpo

--update 2	
update razdel_1_1
set oktmo_fact=x.oktmo_fact_n
--,org_ovz=x.org_ovz
--select * --length(oktmo_fact_n)
from (select replace(okpo,'_','') okpo
,case 
	when length(okato_fact_n) = 10 then '0' || okato_fact_n else okato_fact_n
 end as okato_fact_n
,case
	when length(oktmo_fact_n) = 10 then '0' || oktmo_fact_n else oktmo_fact_n
end as oktmo_fact_n, org_status_n, okpo_head_n from get_google_table_v2('https://docs.google.com/spreadsheets/d/e/2PACX-1vSKKg596QTogmAnBfqWtPToR-Q7jwJLlnu0nGPgxTHS-BfJWZi29ZKt2QqpC4hyzXl9iZDFfws_v0Dr/pub?gid=810155244&single=true&output=csv'::text) a(okpo text, okato_fact_n text, oktmo_fact_n text, org_status_n text, okpo_head_n text)) x
--where okpo in (select okpo from razdel_1_1)
where x.oktmo_fact_n <> '' and razdel_1_1.okpo=x.okpo

--update 3	
update razdel_1_1
set org_status=x.org_status_n
--,org_ovz=x.org_ovz
--select * --length(oktmo_fact_n)
from (select replace(okpo,'_','') okpo
,case 
	when length(okato_fact_n) = 10 then '0' || okato_fact_n else okato_fact_n
 end as okato_fact_n
,case
	when length(oktmo_fact_n) = 10 then '0' || oktmo_fact_n else oktmo_fact_n
end as oktmo_fact_n, org_status_n, okpo_head_n from get_google_table_v2('https://docs.google.com/spreadsheets/d/e/2PACX-1vSKKg596QTogmAnBfqWtPToR-Q7jwJLlnu0nGPgxTHS-BfJWZi29ZKt2QqpC4hyzXl9iZDFfws_v0Dr/pub?gid=810155244&single=true&output=csv'::text) a(okpo text, okato_fact_n text, oktmo_fact_n text, org_status_n text, okpo_head_n text)) x
--where okpo in (select okpo from razdel_1_1)
where x.org_status_n <> '' and razdel_1_1.okpo=x.okpo

--update 4	
update razdel_1_1
set okpo_head=x.okpo_head_n
--,org_ovz=x.org_ovz
--select * --length(oktmo_fact_n)
from (select replace(okpo,'_','') okpo
,case 
	when length(okato_fact_n) = 10 then '0' || okato_fact_n else okato_fact_n
 end as okato_fact_n
,case
	when length(oktmo_fact_n) = 10 then '0' || oktmo_fact_n else oktmo_fact_n
end as oktmo_fact_n, org_status_n, okpo_head_n from get_google_table_v2('https://docs.google.com/spreadsheets/d/e/2PACX-1vSKKg596QTogmAnBfqWtPToR-Q7jwJLlnu0nGPgxTHS-BfJWZi29ZKt2QqpC4hyzXl9iZDFfws_v0Dr/pub?gid=810155244&single=true&output=csv'::text) a(okpo text, okato_fact_n text, oktmo_fact_n text, org_status_n text, okpo_head_n text)) x
--where okpo in (select okpo from razdel_1_1)
where x.okpo_head_n <> '' and razdel_1_1.okpo=x.okpo


select * from razdel_1_1
where okpo in (select replace(okpo,'_','') okpo from get_google_table_v2('https://docs.google.com/spreadsheets/d/e/2PACX-1vSKKg596QTogmAnBfqWtPToR-Q7jwJLlnu0nGPgxTHS-BfJWZi29ZKt2QqpC4hyzXl9iZDFfws_v0Dr/pub?gid=810155244&single=true&output=csv'::text) a(okpo text, okato_fact_n text, oktmo_fact_n text, org_status_n text, okpo_head_n text))


select report, count(okpo)
from org_inf
group by report
--where report = '6'

select *
from razdel_1_2_1
where okpo = '93943208'

ALTER TABLE statregistr.org_inf RENAME COLUMN _1dop2018 TO "1dop2018"

--updates 13/11/2019
--1_2_1
'https://docs.google.com/spreadsheets/d/e/2PACX-1vQPySSCjZOFC9cHdkeMdcxcdAGw7EAGGS_ulp_KXGDfPJOEeBW-eA3GiXH7Yd5jbP0Q_BUyIHNutW43/pub?gid=1882989199&single=true&output=csv'
select * from razdel_1_2_1
where okpo in (select replace(okpo,'_','') okpo from get_google_table_v2('https://docs.google.com/spreadsheets/d/e/2PACX-1vQPySSCjZOFC9cHdkeMdcxcdAGw7EAGGS_ulp_KXGDfPJOEeBW-eA3GiXH7Yd5jbP0Q_BUyIHNutW43/pub?gid=1882989199&single=true&output=csv'::text) a(okpo text, str_n text, gr3 text, gr4 text, gr5 text, gr6 text, gr7 text))
--
update razdel_1_2_1
set gr3=x.gr3
from 
(select replace(okpo,'_','') okpo,str_n,gr3,gr4,gr5,gr6,gr7 from get_google_table_v2('https://docs.google.com/spreadsheets/d/e/2PACX-1vQPySSCjZOFC9cHdkeMdcxcdAGw7EAGGS_ulp_KXGDfPJOEeBW-eA3GiXH7Yd5jbP0Q_BUyIHNutW43/pub?gid=1882989199&single=true&output=csv'::text) a(okpo text, str_n text, gr3 text, gr4 text, gr5 text, gr6 text, gr7 text)) x
where razdel_1_2_1.okpo=x.okpo and razdel_1_2_1.str_n=x.str_n::int and x.gr3 <> ''
--
update razdel_1_2_1
set gr4=x.gr4
from 
(select replace(okpo,'_','') okpo,str_n,gr3,gr4,gr5,gr6,gr7 from get_google_table_v2('https://docs.google.com/spreadsheets/d/e/2PACX-1vQPySSCjZOFC9cHdkeMdcxcdAGw7EAGGS_ulp_KXGDfPJOEeBW-eA3GiXH7Yd5jbP0Q_BUyIHNutW43/pub?gid=1882989199&single=true&output=csv'::text) a(okpo text, str_n text, gr3 text, gr4 text, gr5 text, gr6 text, gr7 text)) x
where razdel_1_2_1.okpo=x.okpo and razdel_1_2_1.str_n=x.str_n::int and x.gr4 <> ''
--
update razdel_1_2_1
set gr5=x.gr5
from 
(select replace(okpo,'_','') okpo,str_n,gr3,gr4,gr5,gr6,gr7 from get_google_table_v2('https://docs.google.com/spreadsheets/d/e/2PACX-1vQPySSCjZOFC9cHdkeMdcxcdAGw7EAGGS_ulp_KXGDfPJOEeBW-eA3GiXH7Yd5jbP0Q_BUyIHNutW43/pub?gid=1882989199&single=true&output=csv'::text) a(okpo text, str_n text, gr3 text, gr4 text, gr5 text, gr6 text, gr7 text)) x
where razdel_1_2_1.okpo=x.okpo and razdel_1_2_1.str_n=x.str_n::int and x.gr5 <> ''
--
update razdel_1_2_1
set gr6=x.gr6
from 
(select replace(okpo,'_','') okpo,str_n,gr3,gr4,gr5,gr6,gr7 from get_google_table_v2('https://docs.google.com/spreadsheets/d/e/2PACX-1vQPySSCjZOFC9cHdkeMdcxcdAGw7EAGGS_ulp_KXGDfPJOEeBW-eA3GiXH7Yd5jbP0Q_BUyIHNutW43/pub?gid=1882989199&single=true&output=csv'::text) a(okpo text, str_n text, gr3 text, gr4 text, gr5 text, gr6 text, gr7 text)) x
where razdel_1_2_1.okpo=x.okpo and razdel_1_2_1.str_n=x.str_n::int and x.gr6 <> ''

--122
'https://docs.google.com/spreadsheets/d/e/2PACX-1vTAxVRO8eoORRe4MlIkaHsoizpERFKVZWkvBmRXNVRrnNX5H1g4RnRd0VTAlPpadiKjNK5aFy2eU5k4/pub?gid=1823488709&single=true&output=csv'
select * from razdel_1_2_2
where okpo in (select replace(okpo,'_','') okpo from get_google_table_v2('https://docs.google.com/spreadsheets/d/e/2PACX-1vTAxVRO8eoORRe4MlIkaHsoizpERFKVZWkvBmRXNVRrnNX5H1g4RnRd0VTAlPpadiKjNK5aFy2eU5k4/pub?gid=1823488709&single=true&output=csv'::text) a(okpo text, str_n text, gr3 text, gr4 text, gr5 text))
--and str_n::int in (select str_n::int from get_google_table_v2('https://docs.google.com/spreadsheets/d/e/2PACX-1vTAxVRO8eoORRe4MlIkaHsoizpERFKVZWkvBmRXNVRrnNX5H1g4RnRd0VTAlPpadiKjNK5aFy2eU5k4/pub?gid=1823488709&single=true&output=csv'::text) a(okpo text, str_n text, gr3 text, gr4 text, gr5 text))
--
--razdel 1_2_2 dop gr3
update razdel_1_2_2
set gr3=x.gr3
from 
(select replace(okpo,'_','') okpo,str_n,gr3,gr4,gr5 from get_google_table_v2('https://docs.google.com/spreadsheets/d/e/2PACX-1vTAxVRO8eoORRe4MlIkaHsoizpERFKVZWkvBmRXNVRrnNX5H1g4RnRd0VTAlPpadiKjNK5aFy2eU5k4/pub?gid=1823488709&single=true&output=csv'::text) a(okpo text, str_n text, gr3 text, gr4 text, gr5 text)) x
where razdel_1_2_2.okpo=x.okpo and razdel_1_2_2.str_n=x.str_n::int and x.gr3 <> '' and x.str_n <> ''
--
update razdel_1_2_2
set gr4=x.gr4
from 
(select replace(okpo,'_','') okpo,str_n,gr3,gr4,gr5 from get_google_table_v2('https://docs.google.com/spreadsheets/d/e/2PACX-1vTAxVRO8eoORRe4MlIkaHsoizpERFKVZWkvBmRXNVRrnNX5H1g4RnRd0VTAlPpadiKjNK5aFy2eU5k4/pub?gid=1823488709&single=true&output=csv'::text) a(okpo text, str_n text, gr3 text, gr4 text, gr5 text)) x
where razdel_1_2_2.okpo=x.okpo and razdel_1_2_2.str_n=x.str_n::int and x.gr4 <> '' and x.str_n <> ''
--
select * from razdel_1_2_2
where okpo='76946369' and str_n = '1'
--


--updates 01/12/2019
--update razdel_1_1
--set okved_main_reg = '85.14'
--select *
from razdel_1_1
where okpo = '04650456'
--

update razdel_1_1
set okved_main_reg = '85.14'
where okpo = '52186865'
--insert into razdel_1_1 values ('52186865',null)
select *
delete
from razdel_1_1
where okpo = '52186865'


update statregistr7
set pole_21 = '85.14'
--select * from statregistr7 s
where pole_1 = '52186865'
--

update razdel_1_1
set okved_main_reg = '85.14'
--select *
--from razdel_1_1 r
where okpo = '33889595'
--

update razdel_1_1
set okved_main_reg = '85.11'
--select *
--from razdel_1_1 r
where okpo = '39422740'
--

update razdel_1_1
set okved_main_reg = '85.11'
--select *
--from razdel_1_1 r
where okpo = '53250273'
--

update additional_okved
set gr4_okved_add = '85.41'
--select *
from additional_okved r
where okpo = '39422740' and str_n = '2' and n_okved_add = '1'
--

insert into additional_okved values ('53250273','2','2','85.41')
--select *
from additional_okved r
where okpo = '53250273' and str_n = '2' and n_okved_add = '1'



select *--okpo,str_n, gr3 --replace(org_ovz,'3','4') 
from razdel_2
where okpo = '09034684'

update razdel_1_2_2 --104rows
set gr5=x.gr5
from
(select replace(gr5,'пусто','') gr5 from razdel_1_2_2) x
where razdel_1_2_2.gr5 = 'пусто'

--select replace(gr5,'пусто','') gr5 from razdel_1_2_2
--where razdel_1_2_2.gr5 = 'пусто'
--
--<UPDATES FIRST ROUND>
--
--count duplicates r2
select okpo || str_n from get_google_table_v2('https://docs.google.com/spreadsheets/d/e/2PACX-1vT9eQMiEcStvsgYRfYrFZGhSfTUwV2sBdgCVKLN2ApDrwZJLYme1UdJg_uu0lKgJRyF3E7QCOdYNHJC/pub?gid=1647012416&single=true&output=csv'::text) a(okpo text, str_n text, gr3 text, gr4 text, gr5 text,gr6 text,gr7 text)
group by okpo || str_n 
having count(okpo || str_n) >1
--count duplicates r1_2_2
select okpo || str_n from get_google_table_v2('https://docs.google.com/spreadsheets/d/e/2PACX-1vTAxVRO8eoORRe4MlIkaHsoizpERFKVZWkvBmRXNVRrnNX5H1g4RnRd0VTAlPpadiKjNK5aFy2eU5k4/pub?gid=1679603870&single=true&output=csv'::text) a(okpo text, str_n text, gr3 text, gr4 text, gr5 text)
group by okpo || str_n 
having count(okpo || str_n) >1 
--count r1_2_2
select replace(okpo,'_','') okpo,str_n,gr3,gr4,gr5 from get_google_table_v2('https://docs.google.com/spreadsheets/d/e/2PACX-1vTAxVRO8eoORRe4MlIkaHsoizpERFKVZWkvBmRXNVRrnNX5H1g4RnRd0VTAlPpadiKjNK5aFy2eU5k4/pub?gid=1679603870&single=true&output=csv'::text) a(okpo text, str_n text, gr3 text, gr4 text, gr5 text)
where 
--gr3<>'' and str_n <> '' 
replace(okpo,'_','') not in (
select distinct okpo from razdel_1_2_2)

and replace(okpo,'_','') in (
select distinct okpo from razdel_2)
--count duplicates r1_2_1
select okpo || str_n from get_google_table_v2('https://docs.google.com/spreadsheets/d/e/2PACX-1vQPySSCjZOFC9cHdkeMdcxcdAGw7EAGGS_ulp_KXGDfPJOEeBW-eA3GiXH7Yd5jbP0Q_BUyIHNutW43/pub?gid=311768045&single=true&output=csv'::text) a(okpo text, str_n text, gr3 text, gr4 text, gr5 text, gr6 text, gr7 text)
--where gr3 <> ''
--where gr3 <> '' 
group by okpo || str_n 
having count(okpo || str_n) >1 

select * from get_google_table_v2('https://docs.google.com/spreadsheets/d/e/2PACX-1vQPySSCjZOFC9cHdkeMdcxcdAGw7EAGGS_ulp_KXGDfPJOEeBW-eA3GiXH7Yd5jbP0Q_BUyIHNutW43/pub?gid=311768045&single=true&output=csv'::text) a(okpo text, str_n text, gr3 text, gr4 text, gr5 text, gr6 text, gr7 text)
where replace(okpo,'_','') not in (
select distinct okpo from razdel_1_2_1)
--razdel 1_2_1 dop insert (14 org)
--insert into razdel_1_2_1 
select replace(okpo,'_','') okpo,str_n::int,gr3,gr4,gr5,gr6,gr7 from get_google_table_v2('https://docs.google.com/spreadsheets/d/e/2PACX-1vQPySSCjZOFC9cHdkeMdcxcdAGw7EAGGS_ulp_KXGDfPJOEeBW-eA3GiXH7Yd5jbP0Q_BUyIHNutW43/pub?gid=311768045&single=true&output=csv'::text) a(okpo text, str_n text, gr3 text, gr4 text, gr5 text, gr6 text, gr7 text)
where replace(okpo,'_','') not in (
select distinct okpo from razdel_1_2_1)
--
--</UPDATES FIRST ROUND>
--<UPDATES SECOND ROUND>
--upd razdel 1_2_1 dop gr3
update razdel_1_2_1
set gr3=x.gr3
from 
(select replace(okpo,'_','') okpo,str_n,gr3,gr4,gr5,gr6,gr7 from get_google_table_v2('https://docs.google.com/spreadsheets/d/e/2PACX-1vQPySSCjZOFC9cHdkeMdcxcdAGw7EAGGS_ulp_KXGDfPJOEeBW-eA3GiXH7Yd5jbP0Q_BUyIHNutW43/pub?gid=311768045&single=true&output=csv'::text) a(okpo text, str_n text, gr3 text, gr4 text, gr5 text, gr6 text, gr7 text)) x
where razdel_1_2_1.okpo=x.okpo and razdel_1_2_1.str_n=x.str_n::int and x.gr3 <> '' --and x.str_n <> ''
--upd razdel 1_2_1 dop gr4
update razdel_1_2_1
set gr4=x.gr4
from 
(select replace(okpo,'_','') okpo,str_n,gr3,gr4,gr5,gr6,gr7 from get_google_table_v2('https://docs.google.com/spreadsheets/d/e/2PACX-1vQPySSCjZOFC9cHdkeMdcxcdAGw7EAGGS_ulp_KXGDfPJOEeBW-eA3GiXH7Yd5jbP0Q_BUyIHNutW43/pub?gid=311768045&single=true&output=csv'::text) a(okpo text, str_n text, gr3 text, gr4 text, gr5 text, gr6 text, gr7 text)) x
where razdel_1_2_1.okpo=x.okpo and razdel_1_2_1.str_n=x.str_n::int and x.gr4 <> '' --and x.str_n <> ''
--upd razdel 1_2_1 dop gr5
update razdel_1_2_1
set gr5=x.gr5
from 
(select replace(okpo,'_','') okpo,str_n,gr3,gr4,gr5,gr6,gr7 from get_google_table_v2('https://docs.google.com/spreadsheets/d/e/2PACX-1vQPySSCjZOFC9cHdkeMdcxcdAGw7EAGGS_ulp_KXGDfPJOEeBW-eA3GiXH7Yd5jbP0Q_BUyIHNutW43/pub?gid=311768045&single=true&output=csv'::text) a(okpo text, str_n text, gr3 text, gr4 text, gr5 text, gr6 text, gr7 text)) x
where razdel_1_2_1.okpo=x.okpo and razdel_1_2_1.str_n=x.str_n::int and x.gr5 <> ''
--upd razdel 1_2_1 dop gr6
update razdel_1_2_1
set gr6=x.gr6
from 
(select replace(okpo,'_','') okpo,str_n,gr3,gr4,gr5,gr6,gr7 from get_google_table_v2('https://docs.google.com/spreadsheets/d/e/2PACX-1vQPySSCjZOFC9cHdkeMdcxcdAGw7EAGGS_ulp_KXGDfPJOEeBW-eA3GiXH7Yd5jbP0Q_BUyIHNutW43/pub?gid=311768045&single=true&output=csv'::text) a(okpo text, str_n text, gr3 text, gr4 text, gr5 text, gr6 text, gr7 text)) x
where razdel_1_2_1.okpo=x.okpo and razdel_1_2_1.str_n=x.str_n::int and x.gr6 <> ''
--upd razdel 1_2_1 dop gr7
update razdel_1_2_1
set gr7=x.gr7
from 
(select replace(okpo,'_','') okpo,str_n,gr3,gr4,gr5,gr6,gr7 from get_google_table_v2('https://docs.google.com/spreadsheets/d/e/2PACX-1vQPySSCjZOFC9cHdkeMdcxcdAGw7EAGGS_ulp_KXGDfPJOEeBW-eA3GiXH7Yd5jbP0Q_BUyIHNutW43/pub?gid=311768045&single=true&output=csv'::text) a(okpo text, str_n text, gr3 text, gr4 text, gr5 text, gr6 text, gr7 text)) x
where razdel_1_2_1.okpo=x.okpo and razdel_1_2_1.str_n=x.str_n::int and x.gr7 <> ''
--
select *
--delete 
from razdel_1_2_2
where okpo ='37457734'
--
ALTER TABLE statregistr.razdel_1_2_1 ALTER COLUMN str_n TYPE int USING str_n::integer
--razdel 1_2_2 dop insert (10 org)
	insert into razdel_1_2_2 
	select replace(okpo,'_','') okpo,str_n::int,gr3,gr4,gr5 from get_google_table_v2('https://docs.google.com/spreadsheets/d/e/2PACX-1vTAxVRO8eoORRe4MlIkaHsoizpERFKVZWkvBmRXNVRrnNX5H1g4RnRd0VTAlPpadiKjNK5aFy2eU5k4/pub?gid=1679603870&single=true&output=csv'::text) a(okpo text, str_n text, gr3 text, gr4 text, gr5 text)
	where 
	replace(okpo,'_','') not in (
	select distinct okpo from razdel_1_2_2)
--razdel 1_2_2 dop gr3
update razdel_1_2_2
set gr3=x.gr3
from 
(select replace(okpo,'_','') okpo,str_n,gr3,gr4,gr5 from get_google_table_v2('https://docs.google.com/spreadsheets/d/e/2PACX-1vTAxVRO8eoORRe4MlIkaHsoizpERFKVZWkvBmRXNVRrnNX5H1g4RnRd0VTAlPpadiKjNK5aFy2eU5k4/pub?gid=1679603870&single=true&output=csv'::text) a(okpo text, str_n text, gr3 text, gr4 text, gr5 text)) x
where razdel_1_2_2.okpo=x.okpo and razdel_1_2_2.str_n=x.str_n::int and x.gr3 <> '' and x.str_n <> ''
--razdel 1_2_2 dop gr4
update razdel_1_2_2
set gr4=x.gr4
from 
(select replace(okpo,'_','') okpo,str_n,gr3,gr4,gr5 from get_google_table_v2('https://docs.google.com/spreadsheets/d/e/2PACX-1vTAxVRO8eoORRe4MlIkaHsoizpERFKVZWkvBmRXNVRrnNX5H1g4RnRd0VTAlPpadiKjNK5aFy2eU5k4/pub?gid=1679603870&single=true&output=csv'::text) a(okpo text, str_n text, gr3 text, gr4 text, gr5 text)) x
where razdel_1_2_2.okpo=x.okpo and razdel_1_2_2.str_n=x.str_n::int and x.gr4 <> '' and x.str_n <> ''
--razdel 1_2_2 dop gr5
update razdel_1_2_2
set gr5=x.gr5
from 
(select replace(okpo,'_','') okpo,str_n,gr3,gr4,gr5 from get_google_table_v2('https://docs.google.com/spreadsheets/d/e/2PACX-1vTAxVRO8eoORRe4MlIkaHsoizpERFKVZWkvBmRXNVRrnNX5H1g4RnRd0VTAlPpadiKjNK5aFy2eU5k4/pub?gid=1679603870&single=true&output=csv'::text) a(okpo text, str_n text, gr3 text, gr4 text, gr5 text)) x
where razdel_1_2_2.okpo=x.okpo and razdel_1_2_2.str_n=x.str_n::int and x.gr5 <> '' and x.str_n <> ''
--
--razdel 2 dop gr3
update razdel_2
set gr3=x.gr3
from 
(select replace(okpo,'_','') okpo,str_n,gr3,gr4,gr5,gr6,gr7 from get_google_table_v2('https://docs.google.com/spreadsheets/d/e/2PACX-1vT9eQMiEcStvsgYRfYrFZGhSfTUwV2sBdgCVKLN2ApDrwZJLYme1UdJg_uu0lKgJRyF3E7QCOdYNHJC/pub?gid=1647012416&single=true&output=csv'::text) a(okpo text, str_n text, gr3 text, gr4 text, gr5 text,gr6 text,gr7 text)) x
where razdel_2.okpo=x.okpo and razdel_2.str_n=x.str_n::int and x.gr3 <> ''
--razdel 2 dop gr4
update razdel_2
set gr4=x.gr4
from 
(select replace(okpo,'_','') okpo,str_n,gr3,gr4,gr5,gr6,gr7 from get_google_table_v2('https://docs.google.com/spreadsheets/d/e/2PACX-1vT9eQMiEcStvsgYRfYrFZGhSfTUwV2sBdgCVKLN2ApDrwZJLYme1UdJg_uu0lKgJRyF3E7QCOdYNHJC/pub?gid=1647012416&single=true&output=csv'::text) a(okpo text, str_n text, gr3 text, gr4 text, gr5 text,gr6 text,gr7 text)) x
where razdel_2.okpo=x.okpo and razdel_2.str_n=x.str_n::int and x.gr4 <> ''
--razdel 2 dop gr5
update razdel_2
set gr5=x.gr5
from 
(select replace(okpo,'_','') okpo,str_n,gr3,gr4,gr5,gr6,gr7 from get_google_table_v2('https://docs.google.com/spreadsheets/d/e/2PACX-1vT9eQMiEcStvsgYRfYrFZGhSfTUwV2sBdgCVKLN2ApDrwZJLYme1UdJg_uu0lKgJRyF3E7QCOdYNHJC/pub?gid=1647012416&single=true&output=csv'::text) a(okpo text, str_n text, gr3 text, gr4 text, gr5 text,gr6 text,gr7 text)) x
where razdel_2.okpo=x.okpo and razdel_2.str_n=x.str_n::int and x.gr5 <> ''
--razdel 2 dop gr6
update razdel_2
set gr6=x.gr6
from 
(select replace(okpo,'_','') okpo,str_n,gr3,gr4,gr5,gr6,gr7 from get_google_table_v2('https://docs.google.com/spreadsheets/d/e/2PACX-1vT9eQMiEcStvsgYRfYrFZGhSfTUwV2sBdgCVKLN2ApDrwZJLYme1UdJg_uu0lKgJRyF3E7QCOdYNHJC/pub?gid=1647012416&single=true&output=csv'::text) a(okpo text, str_n text, gr3 text, gr4 text, gr5 text,gr6 text,gr7 text)) x
where razdel_2.okpo=x.okpo and razdel_2.str_n=x.str_n::int and x.gr6 <> ''
--razdel 2 dop gr7
update razdel_2
set gr7=x.gr7
from 
(select replace(okpo,'_','') okpo,str_n,gr3,gr4,gr5,gr6,gr7 from get_google_table_v2('https://docs.google.com/spreadsheets/d/e/2PACX-1vT9eQMiEcStvsgYRfYrFZGhSfTUwV2sBdgCVKLN2ApDrwZJLYme1UdJg_uu0lKgJRyF3E7QCOdYNHJC/pub?gid=1647012416&single=true&output=csv'::text) a(okpo text, str_n text, gr3 text, gr4 text, gr5 text,gr6 text,gr7 text)) x
where razdel_2.okpo=x.okpo and razdel_2.str_n=x.str_n::int and x.gr7 <> ''
--

select * from razdel_1_1 join 
	(select okpo, web web_old, web_n web, replace(org_ovz_n,'.0','') org_ovz from get_google_table('https://docs.google.com/spreadsheets/d/e/2PACX-1vSKKg596QTogmAnBfqWtPToR-Q7jwJLlnu0nGPgxTHS-BfJWZi29ZKt2QqpC4hyzXl9iZDFfws_v0Dr/pub?gid=1898359295&single=true&output=csv'::text) a(okpo text, web text, web_n text, org_ovz_n text)) b
	on razdel_1_1.okpo=b.okpo

--update 1	
update razdel_1_1
set web=x.web
--,org_ovz=x.org_ovz
--select *
from (select okpo, web web_old, web_n web, replace(replace(org_ovz_n,'.0',''),'nan','') org_ovz from get_google_table('https://docs.google.com/spreadsheets/d/e/2PACX-1vSKKg596QTogmAnBfqWtPToR-Q7jwJLlnu0nGPgxTHS-BfJWZi29ZKt2QqpC4hyzXl9iZDFfws_v0Dr/pub?gid=1898359295&single=true&output=csv'::text) a(okpo text, web text, web_n text, org_ovz_n text)) x
--where web <> 'nan'
where x.web <> 'nan' and razdel_1_1.okpo=x.okpo
--update 2
update razdel_1_1
set org_ovz=x.org_ovz
--select *
from (select okpo, web web_old, web_n web, replace(replace(org_ovz_n,'.0',''),'nan','') org_ovz from get_google_table('https://docs.google.com/spreadsheets/d/e/2PACX-1vSKKg596QTogmAnBfqWtPToR-Q7jwJLlnu0nGPgxTHS-BfJWZi29ZKt2QqpC4hyzXl9iZDFfws_v0Dr/pub?gid=1898359295&single=true&output=csv'::text) a(okpo text, web text, web_n text, org_ovz_n text)) x
--where x.org_ovz <> ''
where x.org_ovz <> '' and razdel_1_1.okpo=x.okpo
--</UPDATES SECOND ROUND>
--<UPDATES THIRD ROUND>
url: https://docs.google.com/spreadsheets/d/e/2PACX-1vT9eQMiEcStvsgYRfYrFZGhSfTUwV2sBdgCVKLN2ApDrwZJLYme1UdJg_uu0lKgJRyF3E7QCOdYNHJC/pub?gid=1566680203&single=true&output=csv
--count duplicates r2
select okpo || str_n from get_google_table_v2('https://docs.google.com/spreadsheets/d/e/2PACX-1vT9eQMiEcStvsgYRfYrFZGhSfTUwV2sBdgCVKLN2ApDrwZJLYme1UdJg_uu0lKgJRyF3E7QCOdYNHJC/pub?gid=1566680203&single=true&output=csv'::text) a(okpo text, str_n text, gr3 text, gr4 text, gr5 text,gr6 text,gr7 text)
group by okpo || str_n 
having count(okpo || str_n) >1

--razdel 2 231019 gr3
update 
	razdel_2
set 
	gr3=x.gr3
from 
(select replace(okpo,'_','') okpo,str_n,gr3,gr4,gr5,gr6,gr7 from get_google_table_v2('https://docs.google.com/spreadsheets/d/e/2PACX-1vT9eQMiEcStvsgYRfYrFZGhSfTUwV2sBdgCVKLN2ApDrwZJLYme1UdJg_uu0lKgJRyF3E7QCOdYNHJC/pub?gid=1566680203&single=true&output=csv'::text) a(okpo text, str_n text, gr3 text, gr4 text, gr5 text,gr6 text,gr7 text)) x
where razdel_2.okpo=x.okpo and razdel_2.str_n=x.str_n::int and x.gr3 <> ''

--razdel 2 231019 gr7
update 
	razdel_2
set 
	gr7=x.gr7
from 
(select replace(okpo,'_','') okpo,str_n,gr3,gr4,gr5,gr6,gr7 from get_google_table_v2('https://docs.google.com/spreadsheets/d/e/2PACX-1vT9eQMiEcStvsgYRfYrFZGhSfTUwV2sBdgCVKLN2ApDrwZJLYme1UdJg_uu0lKgJRyF3E7QCOdYNHJC/pub?gid=1566680203&single=true&output=csv'::text) a(okpo text, str_n text, gr3 text, gr4 text, gr5 text,gr6 text,gr7 text)) x
where razdel_2.okpo=x.okpo and razdel_2.str_n=x.str_n::int and x.gr7 <> ''

--razdel 121 231019 gr3 url 'https://docs.google.com/spreadsheets/d/e/2PACX-1vQPySSCjZOFC9cHdkeMdcxcdAGw7EAGGS_ulp_KXGDfPJOEeBW-eA3GiXH7Yd5jbP0Q_BUyIHNutW43/pub?gid=93519445&single=true&output=csv'
update razdel_1_2_1
set gr3=x.gr3
from 
(select replace(okpo,'_','') okpo,str_n,gr3,gr4,gr5,gr6,gr7 from get_google_table_v2('https://docs.google.com/spreadsheets/d/e/2PACX-1vQPySSCjZOFC9cHdkeMdcxcdAGw7EAGGS_ulp_KXGDfPJOEeBW-eA3GiXH7Yd5jbP0Q_BUyIHNutW43/pub?gid=93519445&single=true&output=csv'::text) a(okpo text, str_n text, gr3 text, gr4 text, gr5 text, gr6 text, gr7 text)) x
where razdel_1_2_1.okpo=x.okpo and razdel_1_2_1.str_n=x.str_n::int and x.gr3 <> ''

--razdel 121 231019 gr4
update razdel_1_2_1
set gr4=x.gr4
from 
(select replace(okpo,'_','') okpo,str_n,gr3,gr4,gr5,gr6,gr7 from get_google_table_v2('https://docs.google.com/spreadsheets/d/e/2PACX-1vQPySSCjZOFC9cHdkeMdcxcdAGw7EAGGS_ulp_KXGDfPJOEeBW-eA3GiXH7Yd5jbP0Q_BUyIHNutW43/pub?gid=93519445&single=true&output=csv'::text) a(okpo text, str_n text, gr3 text, gr4 text, gr5 text, gr6 text, gr7 text)) x
where razdel_1_2_1.okpo=x.okpo and razdel_1_2_1.str_n=x.str_n::int and x.gr4 <> ''

--razdel 121 231019 gr5
update razdel_1_2_1
set gr5=x.gr5
from 
(select replace(okpo,'_','') okpo,str_n,gr3,gr4,gr5,gr6,gr7 from get_google_table_v2('https://docs.google.com/spreadsheets/d/e/2PACX-1vQPySSCjZOFC9cHdkeMdcxcdAGw7EAGGS_ulp_KXGDfPJOEeBW-eA3GiXH7Yd5jbP0Q_BUyIHNutW43/pub?gid=93519445&single=true&output=csv'::text) a(okpo text, str_n text, gr3 text, gr4 text, gr5 text, gr6 text, gr7 text)) x
where razdel_1_2_1.okpo=x.okpo and razdel_1_2_1.str_n=x.str_n::int and x.gr5 <> ''

--razdel 121 231019 gr6
update razdel_1_2_1
set gr6=x.gr6
from 
(select replace(okpo,'_','') okpo,str_n,gr3,gr4,gr5,gr6,gr7 from get_google_table_v2('https://docs.google.com/spreadsheets/d/e/2PACX-1vQPySSCjZOFC9cHdkeMdcxcdAGw7EAGGS_ulp_KXGDfPJOEeBW-eA3GiXH7Yd5jbP0Q_BUyIHNutW43/pub?gid=93519445&single=true&output=csv'::text) a(okpo text, str_n text, gr3 text, gr4 text, gr5 text, gr6 text, gr7 text)) x
where razdel_1_2_1.okpo=x.okpo and razdel_1_2_1.str_n=x.str_n::int and x.gr6 <> ''

--razdel 121 231019 gr7
update razdel_1_2_1
set gr7=x.gr7
from 
(select replace(okpo,'_','') okpo,str_n,gr3,gr4,gr5,gr6,gr7 from get_google_table_v2('https://docs.google.com/spreadsheets/d/e/2PACX-1vQPySSCjZOFC9cHdkeMdcxcdAGw7EAGGS_ulp_KXGDfPJOEeBW-eA3GiXH7Yd5jbP0Q_BUyIHNutW43/pub?gid=93519445&single=true&output=csv'::text) a(okpo text, str_n text, gr3 text, gr4 text, gr5 text, gr6 text, gr7 text)) x
where razdel_1_2_1.okpo=x.okpo and razdel_1_2_1.str_n=x.str_n::int and x.gr7 <> ''

--url 'https://docs.google.com/spreadsheets/d/e/2PACX-1vTAxVRO8eoORRe4MlIkaHsoizpERFKVZWkvBmRXNVRrnNX5H1g4RnRd0VTAlPpadiKjNK5aFy2eU5k4/pub?gid=1118663169&single=true&output=csv'
--count duplicates r122
select okpo || str_n from get_google_table_v2('https://docs.google.com/spreadsheets/d/e/2PACX-1vTAxVRO8eoORRe4MlIkaHsoizpERFKVZWkvBmRXNVRrnNX5H1g4RnRd0VTAlPpadiKjNK5aFy2eU5k4/pub?gid=1118663169&single=true&output=csv'::text) a(okpo text, str_n text, gr3 text, gr4 text, gr5 text)
group by okpo || str_n 
having count(okpo || str_n) > 1

--razdel 1_2_2 dop gr3
update razdel_1_2_2
set gr3=x.gr3
from 
(select replace(okpo,'_','') okpo,str_n,gr3,gr4,gr5 from get_google_table_v2('https://docs.google.com/spreadsheets/d/e/2PACX-1vTAxVRO8eoORRe4MlIkaHsoizpERFKVZWkvBmRXNVRrnNX5H1g4RnRd0VTAlPpadiKjNK5aFy2eU5k4/pub?gid=1118663169&single=true&output=csv'::text) a(okpo text, str_n text, gr3 text, gr4 text, gr5 text)) x
where razdel_1_2_2.okpo=x.okpo and razdel_1_2_2.str_n=x.str_n::int and x.gr3 <> '' and x.str_n <> ''

--razdel 1_2_2 dop gr4
update razdel_1_2_2
set gr4=x.gr4
from 
(select replace(okpo,'_','') okpo,str_n,gr3,gr4,gr5 from get_google_table_v2('https://docs.google.com/spreadsheets/d/e/2PACX-1vTAxVRO8eoORRe4MlIkaHsoizpERFKVZWkvBmRXNVRrnNX5H1g4RnRd0VTAlPpadiKjNK5aFy2eU5k4/pub?gid=1118663169&single=true&output=csv'::text) a(okpo text, str_n text, gr3 text, gr4 text, gr5 text)) x
where razdel_1_2_2.okpo=x.okpo and razdel_1_2_2.str_n=x.str_n::int and x.gr4 <> '' and x.str_n <> ''

--razdel 1_2_2 dop gr5
update razdel_1_2_2
set gr5=x.gr5
from 
(select replace(okpo,'_','') okpo,str_n,gr3,gr4,gr5 from get_google_table_v2('https://docs.google.com/spreadsheets/d/e/2PACX-1vTAxVRO8eoORRe4MlIkaHsoizpERFKVZWkvBmRXNVRrnNX5H1g4RnRd0VTAlPpadiKjNK5aFy2eU5k4/pub?gid=1118663169&single=true&output=csv'::text) a(okpo text, str_n text, gr3 text, gr4 text, gr5 text)) x
where razdel_1_2_2.okpo=x.okpo and razdel_1_2_2.str_n=x.str_n::int and x.gr5 <> '' and x.str_n <> ''

--check for missing okpo
select distinct okpo
from 
(select replace(okpo,'_','') okpo,str_n,gr3,gr4,gr5,gr6,gr7 from get_google_table_v2('https://docs.google.com/spreadsheets/d/e/2PACX-1vT9eQMiEcStvsgYRfYrFZGhSfTUwV2sBdgCVKLN2ApDrwZJLYme1UdJg_uu0lKgJRyF3E7QCOdYNHJC/pub?gid=1566680203&single=true&output=csv'::text) a(okpo text, str_n text, gr3 text, gr4 text, gr5 text,gr6 text,gr7 text)) x
where okpo not in (select distinct okpo from razdel_2)
--check organization
select * from razdel_1_2_2
where okpo = '37457734'

--delete from razdel_1_2_2
where okpo = '37457734'

ALTER TABLE statregistr.razdel_2 ALTER COLUMN gr7 TYPE numeric USING gr7::numeric
--</UPDATES THIRD ROUND>

--inn update 31.10.19 from shugal
select *
--update licenses_edited
--set inn = '0243002747'
----from licenses_edited
--where inn = '243002747'
--
--update vyborka_lic
--set inn = '0243002747'
--where inn = '243002747'

--update vyborka_lic
--set inn = '2912003570'
--where inn = '2912291200'

--update licenses_edited
--set inn = '2912003570'
--where inn = '2912291200'

select *
	from 
		licenses_edited as a join vyborka_lic as b on a.fullname = b.fullname
		--statregistr7 --as b on a.inn = b.pole_8 and a.ogrn = b.pole_27 and a.fullname = b.pole_7
	where
		b.inn = '0243002747'
		
select * from statregistr7 --statreg7_ron_matched	
where
		pole_8 = '2912003570'
		
select * from licenses_edited --statreg7_ron_matched	
where
		inn = '2912003570'		
		
--insert into ron_matched 31.10.19
--insert into statreg7_ron_matched		
select 'F' as head,pole_1, a.*, in_vyborka
from
	(select *
	from 
		vyborka_lic --as a join 
		--statregistr7 --as b on a.inn = b.pole_8 and a.ogrn = b.pole_27 and a.fullname = b.pole_7
	where
		--inn = '0243002747' --and
		--fullname like '%Буль-Кайпаново%' 
		--fullname like '%Беляшево%' 
		fullname like '%Кашкаково%'
		) as a
join 
	statregistr7 as b on (a.inn = b.pole_8 or a.ogrn = b.pole_27) --and a.fullname = b.pole_7 --or a.address = b.	
where
	b.pole_9 in ('2','3') and 
	--lower(pole_7) like '%буль-кайпаново%' --
	--lower(pole_7) like '%беляшево%' --or 
	lower(pole_7) like '%кашкаково%'
--
--insert into statreg7_ron_matched_edu_level		
select pole_1, edu_level
from
	(select *
	from 
		vyborka_lic --as a join 
		--statregistr7 --as b on a.inn = b.pole_8 and a.ogrn = b.pole_27 and a.fullname = b.pole_7
	where
		--inn = '0243002747' --and
		fullname like '%Буль-Кайпаново%' 
		--fullname like '%Беляшево%' 
		--fullname like '%Кашкаково%'
		) as a
join 
	statregistr7 as b on (a.inn = b.pole_8 or a.ogrn = b.pole_27) --and a.fullname = b.pole_7 --or a.address = b.	
where
	b.pole_9 in ('2','3') and 
	lower(pole_7) like '%буль-кайпаново%' --
	--lower(pole_7) like '%беляшево%' --or 
	--lower(pole_7) like '%кашкаково%'	
--
--insert into statreg7_ron_matched		
select pole_1, edu_level--'F' as head,pole_1, a.*, in_vyborka
from
	(select *
	from 
		vyborka_lic --as a join 
		--statregistr7 --as b on a.inn = b.pole_8 and a.ogrn = b.pole_27 and a.fullname = b.pole_7
	where
		--inn = '0243002747' --and
		--fullname like '%Буль-Кайпаново%' 
		--fullname like '%Беляшево%' 
		fullname = 'филиал муниципального бюджетного общеобразовательного учреждения "Климовская средняя школа" - детский сад "Земляничка"'
		) as a
join 
	statregistr7 as b on (a.inn = b.pole_8 or a.ogrn = b.pole_27) --and a.fullname = b.pole_7 --or a.address = b.	
where
	b.pole_9 in ('2','3') and pole_1 = '51772098110002'
	--lower(pole_7) like '%буль-кайпаново%' --
	--lower(pole_7) like '%беляшево%' --or 
	--lower(pole_7) like '%кашкаково%'	
	
--new org (4) 011119	
select *
from statreg7_ron_matched
where --lower(pole_7) like '%буль-кайпаново%' and 
	pole_1 = '51772098110002' --okpo 51772098110002      
	--pole_1 = '51772098110002'
	--lower(pole_7) like '%буль-кайпаново%' --okpo03916567800016
	--lower(pole_7) like '%кашкаково%' --okpo 03916567800024 
	--lower(pole_7) like '%беляшево%' --okpo 03916567800008      
--Филиал Муниципального бюджетного дошкольного образовательного учреждения детский сад №5 с.Верхние Татышлы муниципального района Татышлинский район Республики Башкортостан - детский сад с. Буль-Кайпаново муниципального района Татышлинский район Республики Башкортостан
--Филиал Муниципального бюджетного дошкольного образовательного учреждения детский сад №5 с.Верхние Татышлы муниципального района Татышлинский район Республики Башкортостан - детский сад с.Беляшево муниципального района Татышлинский район Республики Башкортостан
--Филиал Муниципального бюджетного дошкольного образовательного учреждения детский сад №5 с.Верхние Татышлы муниципального района Татышлинский район Республики Башкортостан - детский сад д.Кашкаково муниципального района Татышлинский  район Республики Башкортостан
--update statregistr7
--set in_vyborka = '3'
--where pole_1 in ('51772098110002','03916567800016','03916567800024','03916567800008')
--update statreg7_ron_matched
--set in_vyborka = '3'
--where pole_1 in ('51772098110002','03916567800016','03916567800024','03916567800008')

	
--alter table org_inf	alter column report TYPE numeric USING report::numeric
--alter table org_inf	alter column status TYPE numeric USING status::numeric
--alter table org_inf	alter column _1dop2018 TYPE numeric USING _1dop2018::numeric
--alter table org_inf	alter column change_okpo TYPE numeric USING change_okpo::numeric
--alter table org_inf	alter column okpo TYPE varchar(20) USING okpo::varchar(20)
--alter table org_inf	alter column okpo_otch TYPE varchar(20) USING okpo_otch::varchar(20)
	
select count(*)
from samodvizh_1
where 
	pole_9 in ('2','3')

select count(*)
from org_inf a
--right join (select case when pole_9 = '1' then pole_1 else pole_3 end as okpo from samodvizh_1) b on a.okpo=b.okpo
--where a is null
where status = '2' and okpo not in (select case when pole_9 = '1' then pole_1 else pole_3 end as okpo from samodvizh_1) --where pole_1 ='91536769')

select case when pole_9 = '1' then pole_1 else pole_3 end as okpo from samodvizh_1
where pole_1 = '91536769'

--лишний самовыдвиженец
select * from samodvizh_1 where pole_1 = '91536769'
--delete from samodvizh_1 where pole_1 = '91536769'

--delete from samodvizh_1
--where pole_1 is null
	
select count(*)
from _._0_statregistr_statregistr7
where 
	"9" = '2' and in_vyborka = ''	

	
--update control 16 01.11.19	
--razdel 121 231019 gr6
update razdel_1_2_1
set gr6=x.gr6
from 
(select replace(okpo,'_','') okpo,str_n,gr3,gr4,gr5,gr6,gr7 from get_google_table_v2('https://docs.google.com/spreadsheets/d/e/2PACX-1vQPySSCjZOFC9cHdkeMdcxcdAGw7EAGGS_ulp_KXGDfPJOEeBW-eA3GiXH7Yd5jbP0Q_BUyIHNutW43/pub?gid=2087297296&single=true&output=csv'::text) a(okpo text, str_n text, gr3 text, gr4 text, gr5 text, gr6 text, gr7 text)) x
where razdel_1_2_1.okpo=x.okpo and razdel_1_2_1.str_n=x.str_n::int and x.gr6 <> ''

--razdel 121 231019 gr3
update razdel_1_2_1
set gr3=x.gr3
from 
(select replace(okpo,'_','') okpo,str_n,gr3,gr4,gr5,gr6,gr7 from get_google_table_v2('https://docs.google.com/spreadsheets/d/e/2PACX-1vQPySSCjZOFC9cHdkeMdcxcdAGw7EAGGS_ulp_KXGDfPJOEeBW-eA3GiXH7Yd5jbP0Q_BUyIHNutW43/pub?gid=2087297296&single=true&output=csv'::text) a(okpo text, str_n text, gr3 text, gr4 text, gr5 text, gr6 text, gr7 text)) x
where razdel_1_2_1.okpo=x.okpo and razdel_1_2_1.str_n=x.str_n::int and x.gr3 <> ''

--razdel 121 231019 gr4
update razdel_1_2_1
set gr4=x.gr4
from 
(select replace(okpo,'_','') okpo,str_n,gr3,gr4,gr5,gr6,gr7 from get_google_table_v2('https://docs.google.com/spreadsheets/d/e/2PACX-1vQPySSCjZOFC9cHdkeMdcxcdAGw7EAGGS_ulp_KXGDfPJOEeBW-eA3GiXH7Yd5jbP0Q_BUyIHNutW43/pub?gid=2087297296&single=true&output=csv'::text) a(okpo text, str_n text, gr3 text, gr4 text, gr5 text, gr6 text, gr7 text)) x
where razdel_1_2_1.okpo=x.okpo and razdel_1_2_1.str_n=x.str_n::int and x.gr4 <> ''

--razdel 121 231019 gr5
update razdel_1_2_1
set gr5=x.gr5
from 
(select replace(okpo,'_','') okpo,str_n,gr3,gr4,gr5,gr6,gr7 from get_google_table_v2('https://docs.google.com/spreadsheets/d/e/2PACX-1vQPySSCjZOFC9cHdkeMdcxcdAGw7EAGGS_ulp_KXGDfPJOEeBW-eA3GiXH7Yd5jbP0Q_BUyIHNutW43/pub?gid=2087297296&single=true&output=csv'::text) a(okpo text, str_n text, gr3 text, gr4 text, gr5 text, gr6 text, gr7 text)) x
where razdel_1_2_1.okpo=x.okpo and razdel_1_2_1.str_n=x.str_n::int and x.gr5 <> ''

select * from razdel_1_2_1
where okpo in (select replace(okpo,'_','') okpo from get_google_table_v2('https://docs.google.com/spreadsheets/d/e/2PACX-1vQPySSCjZOFC9cHdkeMdcxcdAGw7EAGGS_ulp_KXGDfPJOEeBW-eA3GiXH7Yd5jbP0Q_BUyIHNutW43/pub?gid=2087297296&single=true&output=csv'::text) a(okpo text, str_n text, gr3 text, gr4 text, gr5 text, gr6 text, gr7 text))
	
select * from razdel_1_1
where okpo = '63092902000002'

--create table statreg7_ron_matched_2 as 
--select 
--	case
--		when head = 'F' then pole_3 else statregistr7.pole_1
--	end as okpo_id,statreg7_ron_matched.*
--from statreg7_ron_matched join statregistr7 on statreg7_ron_matched.pole_1 = statregistr7.pole_1

--drop table statreg7_ron_matched

--create table statreg7_ron_matched_edu_level_2 as
--select okpo_id,statreg7_ron_matched_edu_level.*
--from statreg7_ron_matched_edu_level join statreg7_ron_matched on statreg7_ron_matched.pole_1=statreg7_ron_matched_edu_level.pole_1

--old updates
--I update r1_2_1
--update razdel_1_2_1
--set gr3=x.gr3
--from 
--(select replace(replace(okpo,'.0',''),'-','') okpo,replace(str_n,'.0','') str_n,replace(gr3,'.0','') gr3,replace(gr4,'.0','') gr4,replace(gr5,'.0','') gr5,replace(gr6,'.0','') gr6,replace(gr7,'.0','') gr7 from get_google_table('https://docs.google.com/spreadsheets/d/e/2PACX-1vQPySSCjZOFC9cHdkeMdcxcdAGw7EAGGS_ulp_KXGDfPJOEeBW-eA3GiXH7Yd5jbP0Q_BUyIHNutW43/pub?gid=1847265233&single=true&output=csv'::text) a(okpo text, str_n text, gr3 text, gr4 text, gr5 text,gr6 text,gr7 text)) x
--where razdel_1_2_1.okpo=x.okpo and razdel_1_2_1.str_n=x.str_n and x.gr3 <> 'nan'
--II update r1_2_1
--update razdel_1_2_1
--set gr4=x.gr4
--from 
--(select replace(replace(okpo,'.0',''),'-','') okpo,replace(str_n,'.0','') str_n,replace(gr3,'.0','') gr3,replace(gr4,'.0','') gr4,replace(gr5,'.0','') gr5,replace(gr6,'.0','') gr6,replace(gr7,'.0','') gr7 from get_google_table('https://docs.google.com/spreadsheets/d/e/2PACX-1vQPySSCjZOFC9cHdkeMdcxcdAGw7EAGGS_ulp_KXGDfPJOEeBW-eA3GiXH7Yd5jbP0Q_BUyIHNutW43/pub?gid=1847265233&single=true&output=csv'::text) a(okpo text, str_n text, gr3 text, gr4 text, gr5 text,gr6 text,gr7 text)) x
--where razdel_1_2_1.okpo=x.okpo and razdel_1_2_1.str_n=x.str_n and x.gr4 <> 'nan'
--
--select str_n,gr4,gr5 from razdel_1_2_2 where okpo = '00042493455003'
--
--select count(*) from razdel_1_2_1 left join (select replace(replace(okpo,'.0',''),'-','') okpo,replace(str_n,'.0','') str_n,replace(gr3,'.0','') gr3,replace(gr4,'.0','') gr4,replace(gr5,'.0','') gr5,replace(gr6,'.0','') gr6,replace(gr7,'.0','') gr7 from get_google_table('https://docs.google.com/spreadsheets/d/e/2PACX-1vQPySSCjZOFC9cHdkeMdcxcdAGw7EAGGS_ulp_KXGDfPJOEeBW-eA3GiXH7Yd5jbP0Q_BUyIHNutW43/pub?gid=1847265233&single=true&output=csv'::text) a(okpo text, str_n text, gr3 text, gr4 text, gr5 text,gr6 text,gr7 text)) b
--on razdel_1_2_1.okpo=b.okpo
--where razdel_1_2_1.okpo is null
--
--III update r1_2_1
--update razdel_1_2_1
--set gr6=x.gr6
--from 
--(select replace(replace(okpo,'.0',''),'-','') okpo,replace(str_n,'.0','') str_n,replace(gr3,'.0','') gr3,replace(gr4,'.0','') gr4,replace(gr5,'.0','') gr5,replace(gr6,'.0','') gr6,replace(gr7,'.0','') gr7 from get_google_table('https://docs.google.com/spreadsheets/d/e/2PACX-1vQPySSCjZOFC9cHdkeMdcxcdAGw7EAGGS_ulp_KXGDfPJOEeBW-eA3GiXH7Yd5jbP0Q_BUyIHNutW43/pub?gid=1847265233&single=true&output=csv'::text) a(okpo text, str_n text, gr3 text, gr4 text, gr5 text,gr6 text,gr7 text)) x
--where razdel_1_2_1.okpo=x.okpo and razdel_1_2_1.str_n=x.str_n and x.gr6 <> 'nan'
--IV update r1_2_1
--update razdel_1_2_1
--set gr7=x.gr7
--from 
--(select replace(replace(okpo,'.0',''),'-','') okpo,replace(str_n,'.0','') str_n,replace(gr3,'.0','') gr3,replace(gr4,'.0','') gr4,replace(gr5,'.0','') gr5,replace(gr6,'.0','') gr6,replace(gr7,'.0','') gr7 from get_google_table('https://docs.google.com/spreadsheets/d/e/2PACX-1vQPySSCjZOFC9cHdkeMdcxcdAGw7EAGGS_ulp_KXGDfPJOEeBW-eA3GiXH7Yd5jbP0Q_BUyIHNutW43/pub?gid=1847265233&single=true&output=csv'::text) a(okpo text, str_n text, gr3 text, gr4 text, gr5 text,gr6 text,gr7 text)) x
--where razdel_1_2_1.okpo=x.okpo and razdel_1_2_1.str_n=x.str_n and x.gr7 <> 'nan'
--V update r1_2_1
--update razdel_1_2_1
--set gr5=x.gr5
--from 
--(select replace(replace(okpo,'.0',''),'-','') okpo,replace(str_n,'.0','') str_n,replace(gr3,'.0','') gr3,replace(gr4,'.0','') gr4,replace(gr5,'.0','') gr5,replace(gr6,'.0','') gr6,replace(gr7,'.0','') gr7 from get_google_table('https://docs.google.com/spreadsheets/d/e/2PACX-1vQPySSCjZOFC9cHdkeMdcxcdAGw7EAGGS_ulp_KXGDfPJOEeBW-eA3GiXH7Yd5jbP0Q_BUyIHNutW43/pub?gid=1847265233&single=true&output=csv'::text) a(okpo text, str_n text, gr3 text, gr4 text, gr5 text,gr6 text,gr7 text)) x
--where razdel_1_2_1.okpo=x.okpo and razdel_1_2_1.str_n=x.str_n and x.gr5 <> 'nan'
--
--
--I update r2
--update razdel_2
--set gr3=x.gr3
--from 
--(select replace(replace(okpo,'.0',''),'-','') okpo,replace(str_n,'.0','') str_n,replace(gr3,'.0','') gr3,replace(gr4,'.0','') gr4,replace(gr5,'.0','') gr5,replace(gr6,'.0','') gr6,replace(gr7,'.0','') gr7 from get_google_table('https://docs.google.com/spreadsheets/d/e/2PACX-1vT9eQMiEcStvsgYRfYrFZGhSfTUwV2sBdgCVKLN2ApDrwZJLYme1UdJg_uu0lKgJRyF3E7QCOdYNHJC/pub?gid=780990320&single=true&output=csv'::text) a(okpo text, str_n text, gr3 text, gr4 text, gr5 text,gr6 text,gr7 text)) x
--where razdel_2.okpo=x.okpo and razdel_2.str_n=x.str_n and x.gr3 <> 'nan'
--II update r2
--update razdel_2
--set gr4=x.gr4
--from 
--(select replace(replace(okpo,'.0',''),'-','') okpo,replace(str_n,'.0','') str_n,replace(gr3,'.0','') gr3,replace(gr4,'.0','') gr4,replace(gr5,'.0','') gr5,replace(gr6,'.0','') gr6,replace(gr7,'.0','') gr7 from get_google_table('https://docs.google.com/spreadsheets/d/e/2PACX-1vT9eQMiEcStvsgYRfYrFZGhSfTUwV2sBdgCVKLN2ApDrwZJLYme1UdJg_uu0lKgJRyF3E7QCOdYNHJC/pub?gid=780990320&single=true&output=csv'::text) a(okpo text, str_n text, gr3 text, gr4 text, gr5 text,gr6 text,gr7 text)) x
--where razdel_2.okpo=x.okpo and razdel_2.str_n=x.str_n and x.gr4 <> 'nan'
--III update r2
--update razdel_2
--set gr5=x.gr5
--from 
--(select replace(replace(okpo,'.0',''),'-','') okpo,replace(str_n,'.0','') str_n,replace(gr3,'.0','') gr3,replace(gr4,'.0','') gr4,replace(gr5,'.0','') gr5,replace(gr6,'.0','') gr6,replace(gr7,'.0','') gr7 from get_google_table('https://docs.google.com/spreadsheets/d/e/2PACX-1vT9eQMiEcStvsgYRfYrFZGhSfTUwV2sBdgCVKLN2ApDrwZJLYme1UdJg_uu0lKgJRyF3E7QCOdYNHJC/pub?gid=780990320&single=true&output=csv'::text) a(okpo text, str_n text, gr3 text, gr4 text, gr5 text,gr6 text,gr7 text)) x
--where razdel_2.okpo=x.okpo and razdel_2.str_n=x.str_n and x.gr5 <> 'nan'
--IV update r2
--update razdel_2
--set gr6=x.gr6
--from 
--(select replace(replace(okpo,'.0',''),'-','') okpo,replace(str_n,'.0','') str_n,replace(gr3,'.0','') gr3,replace(gr4,'.0','') gr4,replace(gr5,'.0','') gr5,replace(gr6,'.0','') gr6,replace(gr7,'.0','') gr7 from get_google_table('https://docs.google.com/spreadsheets/d/e/2PACX-1vT9eQMiEcStvsgYRfYrFZGhSfTUwV2sBdgCVKLN2ApDrwZJLYme1UdJg_uu0lKgJRyF3E7QCOdYNHJC/pub?gid=780990320&single=true&output=csv'::text) a(okpo text, str_n text, gr3 text, gr4 text, gr5 text,gr6 text,gr7 text)) x
--where razdel_2.okpo=x.okpo and razdel_2.str_n=x.str_n and x.gr6 <> 'nan'
--V update r2
--update razdel_2
--set gr7=x.gr7
--from 
--(select replace(replace(okpo,'.0',''),'-','') okpo,replace(str_n,'.0','') str_n,replace(gr3,'.0','') gr3,replace(gr4,'.0','') gr4,replace(gr5,'.0','') gr5,replace(gr6,'.0','') gr6,replace(gr7,'.0','') gr7 from get_google_table('https://docs.google.com/spreadsheets/d/e/2PACX-1vT9eQMiEcStvsgYRfYrFZGhSfTUwV2sBdgCVKLN2ApDrwZJLYme1UdJg_uu0lKgJRyF3E7QCOdYNHJC/pub?gid=780990320&single=true&output=csv'::text) a(okpo text, str_n text, gr3 text, gr4 text, gr5 text,gr6 text,gr7 text)) x
--where razdel_2.okpo=x.okpo and razdel_2.str_n=x.str_n and x.gr7 <> 'nan'
--
--select str_n,gr4,gr5 from razdel_1_2_2 where okpo = '00042493455003'

--2
--select * from
--(select replace(replace(okpo,'.0',''),'-','') okpo,replace(str_n,'.0','') str_n,replace(gr3,'.0','') gr3,replace(gr4,'.0','') gr4,replace(gr5,'.0','') gr5,replace(gr6,'.0','') gr6,replace(gr7,'.0','') gr7 from get_google_table('https://docs.google.com/spreadsheets/d/e/2PACX-1vT9eQMiEcStvsgYRfYrFZGhSfTUwV2sBdgCVKLN2ApDrwZJLYme1UdJg_uu0lKgJRyF3E7QCOdYNHJC/pub?gid=780990320&single=true&output=csv'::text) a(okpo text, str_n text, gr3 text, gr4 text, gr5 text,gr6 text,gr7 text)) a
--left join razdel_2 on a.okpo=razdel_2.okpo and a.str_n=razdel_2.str_n
--where razdel_2.okpo is null and razdel_2.str_n is null
--
--1_2_1
--select * from
--(select replace(replace(okpo,'.0',''),'-','') okpo,replace(str_n,'.0','') str_n,replace(gr3,'.0','') gr3,replace(gr4,'.0','') gr4,replace(gr5,'.0','') gr5,replace(gr6,'.0','') gr6,replace(gr7,'.0','') gr7 from get_google_table('https://docs.google.com/spreadsheets/d/e/2PACX-1vQPySSCjZOFC9cHdkeMdcxcdAGw7EAGGS_ulp_KXGDfPJOEeBW-eA3GiXH7Yd5jbP0Q_BUyIHNutW43/pub?gid=1847265233&single=true&output=csv'::text) a(okpo text, str_n text, gr3 text, gr4 text, gr5 text,gr6 text,gr7 text)) a
--left join razdel_1_2_1 on a.okpo=razdel_1_2_1.okpo and a.str_n=razdel_1_2_1.str_n
--where razdel_1_2_1.okpo is null and razdel_1_2_1.str_n is null
--
--1_2_2
--select * from
--(select replace(replace(okpo,'.0',''),'-','') okpo,replace(str_n,'.0','') str_n,replace(gr3,'.0','') gr3,replace(gr4,'.0','') gr4,replace(gr5,'.0','') gr5 from get_google_table('https://docs.google.com/spreadsheets/d/e/2PACX-1vTAxVRO8eoORRe4MlIkaHsoizpERFKVZWkvBmRXNVRrnNX5H1g4RnRd0VTAlPpadiKjNK5aFy2eU5k4/pub?gid=796827103&single=true&output=csv'::text) a(okpo text, str_n text, gr3 text, gr4 text, gr5 text)) a
--left join razdel_1_2_2 on a.okpo=razdel_1_2_2.okpo and a.str_n=razdel_1_2_2.str_n
--where razdel_1_2_2.okpo is null and razdel_1_2_2.str_n is null
--okpo = '--00042493455003'

--select count(okpo || str_n) from (
--select replace(replace(okpo,'.0',''),'-','') okpo,replace(str_n,'.0','') str_n,replace(gr3,'.0','') gr3,replace(gr4,'.0','') gr4,replace(gr5,'.0','') gr5 from get_google_table('https://docs.google.com/spreadsheets/d/e/2PACX-1vTAxVRO8eoORRe4MlIkaHsoizpERFKVZWkvBmRXNVRrnNX5H1g4RnRd0VTAlPpadiKjNK5aFy2eU5k4/pub?gid=796827103&single=true&output=csv'::text) a(okpo text, str_n text, gr3 text, gr4 text, gr5 text)
--) x
--I update r1_2_2
--update razdel_1_2_2
--set gr3=x.gr3
--from 
--(select replace(replace(okpo,'.0',''),'-','') okpo,replace(str_n,'.0','') str_n,replace(gr3,'.0','') gr3,replace(gr4,'.0','') gr4,replace(gr5,'.0','') gr5 from get_google_table('https://docs.google.com/spreadsheets/d/e/2PACX-1vTAxVRO8eoORRe4MlIkaHsoizpERFKVZWkvBmRXNVRrnNX5H1g4RnRd0VTAlPpadiKjNK5aFy2eU5k4/pub?gid=796827103&single=true&output=csv'::text) a(okpo text, str_n text, gr3 text, gr4 text, gr5 text)) x
--where razdel_1_2_2.okpo=x.okpo and razdel_1_2_2.str_n=x.str_n::int and x.gr3 <> 'nan'
--II update r1_2_2
--update razdel_1_2_2
--set gr5=xx.gr5
--from (
--select okpo, str_n, gr3,gr4,replace(gr5,'пусто','') gr5 
--from --(
--(select replace(replace(okpo,'.0',''),'-','') okpo,replace(str_n,'.0','') str_n,replace(gr3,'.0','') gr3,replace(gr4,'.0','') gr4,replace(gr5,'.0','') gr5 from get_google_table('https://docs.google.com/spreadsheets/d/e/2PACX-1vTAxVRO8eoORRe4MlIkaHsoizpERFKVZWkvBmRXNVRrnNX5H1g4RnRd0VTAlPpadiKjNK5aFy2eU5k4/pub?gid=796827103&single=true&output=csv'::text) a(okpo text, str_n text, gr3 text, gr4 text, gr5 text)
--) x
--where okpo = '00042493455003'
--) xx
--where razdel_1_2_2.okpo=xx.okpo and razdel_1_2_2.str_n=xx.str_n::int and xx.gr5 <> 'nan'

--III update r1_2_2
--update razdel_1_2_2
--set gr4=x.gr4
--from 
--(select replace(replace(okpo,'.0',''),'-','') okpo,replace(str_n,'.0','') str_n,replace(gr3,'.0','') gr3,replace(gr4,'.0','') gr4,replace(gr5,'.0','') gr5 from get_google_table('https://docs.google.com/spreadsheets/d/e/2PACX-1vTAxVRO8eoORRe4MlIkaHsoizpERFKVZWkvBmRXNVRrnNX5H1g4RnRd0VTAlPpadiKjNK5aFy2eU5k4/pub?gid=796827103&single=true&output=csv'::text) a(okpo text, str_n text, gr3 text, gr4 text, gr5 text)) x
--where razdel_1_2_2.okpo=x.okpo and razdel_1_2_2.str_n=x.str_n::int and x.gr4 <> 'nan'
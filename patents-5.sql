--select count(*) --distinct date_part('year', appln_filing_date)
--from tls201_appln
--where date_part('year', appln_filing_date) = 2017 --2018 - 184k


--количество уникальных патентных за€вок по странам и годам (14-17)
select 
ctry_code
, sum(case when  date_part='2014' then count end) "2014"
, sum(case when  date_part='2015' then count end) "2015"
, sum(case when  date_part='2016' then count end) "2016"
, sum(case when  date_part='2017' then count end) "2017"
from (
select ctry_code, date_part('year', appln_filing_date), count(distinct t201.appln_id)
from tls201_appln t201 
join tls207_pers_appln t207 on t201.appln_id=t207.appln_id
join tls906_person t906 on t906.person_id=t207.person_id
join tls801_country t801 on t906.person_ctry_code=t801.ctry_code
where ctry_code in ('AU','BE','GB','DE','IL','ES','IT','CA','CN','HK','TW','NL','SG','US','FR','SE','KR','JP','RU') 
and date_part('year', appln_filing_date) in(2014,2015,2016,2017)
group by ctry_code, date_part('year', appln_filing_date)
) x
group by ctry_code


---- √орода
select appln_filing_year, count(distinct t201.appln_id)
from tls201_appln t201 
join tls207_pers_appln t207 on t201.appln_id=t207.appln_id
join tls906_person t906 on t906.person_id=t207.person_id
--join tls801_country t801 on t906.person_ctry_code=t801.ctry_code
where appln_filing_year in(2014,2015,2016,2017) --2010,2011,2012,2013,
--and (person_address like '%Beijing%' or person_address like '%BEIJING%') or (person_name like '%Beijing%' or person_name like '%BEIJING%') --or person_address like '%Brussels-Capital Region%')
and (person_address like '%Seul%' or person_address like '%Seoul%') --or (person_name like '%Amsterdam%' or person_name like '%AMSTERDAM%'))
and t207.applt_seq_nr  > 0 
group by appln_filing_year
---
--- Ѕостон
select appln_filing_year, count(distinct appln_id) 
from (
select appln_filing_year, t201.appln_id
from tls201_appln t201 
	join tls207_pers_appln t207 on t201.appln_id=t207.appln_id
	join tls906_person t906 on t906.person_id=t207.person_id
	join tls801_country t801 on t906.person_ctry_code=t801.ctry_code
where appln_filing_year in(2014,2015,2016,2017)
and --(person_address like '%Beijing%' or person_address like '%BEIJING%' or person_name like '%Beijing%' or person_name like '%BEIJING%')
--(person_address like '%Boston%') -- or person_address like '%BOSTON%' or person_name like '%Boston%' or person_name like '%BOSTON%')
(person_address like '%Massachusetts%' or person_address like '%Boston%' or person_address like '%BOSTON%' or person_address like '%MA %' or person_address like '%MASSACHUSETTS%'
)--or person_address like '%MA%')
--person_address like '%Boston,MA%' or person_address like '%Boston MA%' or person_address like '%MA %')
and t207.applt_seq_nr  > 0 
--and ctry_code in ('AU')
--and appln_auth = 'CN'
) x
group by appln_filing_year
--
--организации по городам
select person_name, person_address--count(distinct appln_id) 
from (
select appln_filing_year, t201.appln_id,person_name, person_address
from tls201_appln t201 
	join tls207_pers_appln t207 on t201.appln_id=t207.appln_id
	join tls906_person t906 on t906.person_id=t207.person_id
	join tls801_country t801 on t906.person_ctry_code=t801.ctry_code
where appln_filing_year in(2014,2015,2016,2017)
and --(person_address like '%Beijing%' or person_address like '%BEIJING%' or person_name like '%Beijing%' or person_name like '%BEIJING%')
(person_address like '%Boston%') -- or person_address like '%BOSTON%' or person_name like '%Boston%' or person_name like '%BOSTON%')
--(person_address like '%Massachusetts%' or person_address like '%Boston%' or person_address like '%BOSTON%') -- or person_address like '%MA%' or person_address like '%MASSACHUSETTS%'
--(person_address like '%Boston,MA%' or person_address like '%Boston MA%' or person_address like '%MA %')
and t207.applt_seq_nr  > 0 
--and ctry_code in ('AU')
--and appln_auth = 'CN'
) x
group by person_name, person_address
--тест
select appln_id,appln_filing_year, person_address,person_name--count(distinct appln_id) 
from (
---
CREATE MATERIALIZED VIEW year14_17_address_name
AS  
select t201.appln_id,appln_filing_year, person_address,person_name, t906.person_ctry_code
from tls201_appln t201 
	join tls207_pers_appln t207 on t201.appln_id=t207.appln_id
	join tls906_person t906 on t906.person_id=t207.person_id
	join tls801_country t801 on t906.person_ctry_code=t801.ctry_code
where appln_filing_year in(2014,2015,2016,2017)
and --(person_address like '%Beijing%' or person_address like '%BEIJING%' or person_name like '%Beijing%' or person_name like '%BEIJING%')
--(person_address like '%Boston%') -- or person_address like '%BOSTON%' or person_name like '%Boston%' or person_name like '%BOSTON%')
--(person_address like '%Massachusetts%' or person_address like '%Boston%' or person_address like '%BOSTON%') -- or person_address like '%MA%' or person_address like '%MASSACHUSETTS%'
--(person_address like '%MA%')
--(person_address like '%Boston,MA%' or person_address like '%Boston MA%' or person_address like '%MA %')
t207.applt_seq_nr  > 0 
WITH data;
CREATE INDEX idx_year14_17_address_name ON year14_17_address_name(appln_id);
CREATE INDEX idx_appln_filing_year ON year14_17_address_name(appln_filing_year);
CREATE INDEX idx_person_name ON year14_17_address_name(person_name);
CREATE INDEX idx_person_ctry_code ON year14_17_address_name(person_ctry_code);
--and ctry_code in ('AU')
--and appln_auth = 'CN'
) x
--boston
select appln_filing_year,count(distinct appln_id)
from year14_17_address_name
where 
(
person_address like '%Boston,MA%' 
or person_address like '%Massachusetts%'
or person_address like '%Boston MA%' 
or person_address like '%MA %'
or person_name like '%Boston%'
or person_name like '%BOSTON%'
or person_name like '%Massachusetts%'
)
group by appln_filing_year
--
--тест
CREATE INDEX idx_address ON tls906_person(person_address);
CREATE INDEX idx_address ON tls906_person(person_address);

---appl by offices & empty addresses
select 
appln_auth
, sum(case when  appln_filing_year='2014' then count end) "2014"
, sum(case when  appln_filing_year='2015' then count end) "2015"
, sum(case when  appln_filing_year='2016' then count end) "2016"
, sum(case when  appln_filing_year='2017' then count end) "2017"
from (
select appln_auth, appln_filing_year, count(distinct appln_id) 
from (
select appln_filing_year, t201.appln_id, appln_auth
from tls201_appln t201 
	join tls207_pers_appln t207 on t201.appln_id=t207.appln_id
	join tls906_person t906 on t906.person_id=t207.person_id
	join tls801_country t801 on t906.person_ctry_code=t801.ctry_code
where appln_filing_year in(2014,2015,2016,2017)
--and --(person_address like '%Beijing%' or person_address like '%BEIJING%' or person_name like '%Beijing%' or person_name like '%BEIJING%')
--(person_address like '%Eindhoven%' or person_address like '%EINDHOVEN%' or person_name like '%Eindhoven%' or person_name like '%EINDHOVEN%')
and t207.applt_seq_nr  > 0 
--and ctry_code in ('AU')
and appln_auth in ('AU','BE','GB','DE','IL','ES','IT','CA','CN','HK','TW','NL','SG','US','FR','SE','KR','JP','RU') 
--and person_address = ''
) x
group by appln_auth, appln_filing_year
) y
group by appln_auth
---

select appln_filing_year, count(distinct appln_id) 
from (
select appln_filing_year, person_name, person_address, t226.city, t201.appln_id --, appln_filing_year --, t201.appln_id, appln_auth
from tls201_appln t201 
	join tls207_pers_appln t207 on t201.appln_id=t207.appln_id
	join tls906_person t906 on t906.person_id=t207.person_id
	join tls801_country t801 on t906.person_ctry_code=t801.ctry_code
	join tls226_person_orig t226 on t226.person_id=t207.person_id
where appln_filing_year in(2014,2015,2016,2017)
--and --(person_address like '%Beijing%' or person_address like '%BEIJING%' or person_name like '%Beijing%' or person_name like '%BEIJING%')
--(person_address like '%Eindhoven%' or person_address like '%EINDHOVEN%' or person_name like '%Eindhoven%' or person_name like '%EINDHOVEN%')
and t207.applt_seq_nr  > 0 
--and ctry_code = ''
--and appln_auth in ('AU','BE','GB','DE','IL','ES','IT','CA','CN','HK','TW','NL','SG','US','FR','SE','KR','JP','RU') 
--and person_address = '' --like '%Melbourne%'
--and city like '%Beijing%'
and (city like '%Melbourne%' or person_address like '%Melbourne%' or address_freeform like '%Melbourne%' or person_name like '%Melbourne%' or person_address like 'MELBOURNE' or address_freeform like 'MELBOURNE') --,'Sydney','Brussels','London','Berlin','Cologne','Munich','Frankfurt Am Main','Hong Kong','Tel Aviv',	'Barcelona','Madrid','Milan','Toronto','Guangzhou','Beijing',	'Amsterdam','Eindhoven','Moscow','Singapore','Boston','Los Angeles',	'Minneapolis',	'New York','Raleigh','San Diego','San Francisco','Seattle','Philadelphia',	'Chicago','Taipei','Paris','Stockholm','Seoul','Daejeon','Kobe',	'Tokyo')
) x
group by appln_filing_year

----
select count(*)
from 
(select distinct t201.appln_id
from tls201_appln t201 
	join tls207_pers_appln t207 on t201.appln_id=t207.appln_id
	join tls906_person t906 on t906.person_id=t207.person_id
	join tls801_country t801 on t906.person_ctry_code=t801.ctry_code
where appln_filing_year in(2014,2015,2016,2017)
and (person_name like '%Beijing%' or person_name like '%BEIJING%')
--(person_address like '%Milano%' or person_address like '%Milan%' or person_address like '%MILAN%' or person_name like '%Milan%' or person_name like '%MILAN%' or person_name like '%Milano%')
and t207.applt_seq_nr  > 0 
) a
right join 
(select distinct t201.appln_id
from tls201_appln t201 
	join tls207_pers_appln t207 on t201.appln_id=t207.appln_id
	join tls906_person t906 on t906.person_id=t207.person_id
	join tls801_country t801 on t906.person_ctry_code=t801.ctry_code
where appln_filing_year in(2014,2015,2016,2017)
and (person_address like '%Beijing%' or person_address like '%BEIJING%')
--(person_address like '%Milano%' or person_address like '%Milan%' or person_address like '%MILAN%' or person_name like '%Milan%' or person_name like '%MILAN%' or person_name like '%Milano%')
and t207.applt_seq_nr  > 0 
) b
on a.appln_id = b.appln_id
where a.appln_id is null
--and ctry_code in ('AU')
--and appln_auth = 'CN'

select appln_filing_year, count(distinct t201.appln_id)
from tls201_appln t201 
	join tls207_pers_appln t207 on t201.appln_id=t207.appln_id
	join tls906_person t906 on t906.person_id=t207.person_id
	join tls801_country t801 on t906.person_ctry_code=t801.ctry_code
where appln_filing_year in(2014,2015,2016,2017)
and (person_address like '%Beijing%' or person_address like '%BEIJING%')
--(person_address like '%Milano%' or person_address like '%Milan%' or person_address like '%MILAN%' or person_name like '%Milan%' or person_name like '%MILAN%' or person_name like '%Milano%')
and t207.applt_seq_nr  > 0 
group by appln_filing_year
---


--- китай

select count(*) from (
select distinct person_name, appln_filing_year, person_address --, count(distinct t201.appln_id)
from tls201_appln t201 
join tls207_pers_appln t207 on t201.appln_id=t207.appln_id
join tls906_person t906 on t906.person_id=t207.person_id
join tls801_country t801 on t906.person_ctry_code=t801.ctry_code
where ctry_code in ('') 
and appln_filing_year in(2014,2015,2016,2017)
and (person_address like '%Beijing%' or person_address like '%BEIJING%' or person_name like '%Beijing%' or person_name like '%BEIJING%')
and t207.applt_seq_nr  > 0 
--and person_address not like '%Guangzhou%'
--group by person_name, person_address
) x
group by appln_filing_year
---
--ћосква

select appln_filing_year,count(distinct appln_id) from (
select appln_filing_year, t201.appln_id -- person_address --, count(distinct t201.appln_id)
from tls201_appln t201 
join tls207_pers_appln t207 on t201.appln_id=t207.appln_id
join tls906_person t906 on t906.person_id=t207.person_id
join tls801_country t801 on t906.person_ctry_code=t801.ctry_code
where 
appln_filing_year in(2010,2011,2012,2013,2014,2015,2016,2017)
--and (person_address like '%Beijing%' or person_address like '%BEIJING%' or person_name like '%Beijing%' or person_name like '%BEIJING%')
and t207.applt_seq_nr  > 0 
and person_ctry_code = 'RU'
and appln_auth <> 'RU'
--and (person_address like '%Moscow%'
--	or person_address like '%Moskva%'
--	or person_address like '%MOSKVA%'
--	or person_address like '%MOSCOW%'
--)
--group by person_name, person_address
) x
group by appln_filing_year

---
select count(distinct appln_id)
from tls201_appln
where appln_kind = 'U'

select count(distinct person_name)
from tls906_person t906
where person_ctry_code = ''

CREATE INDEX idx_lower_address ON year14_17_address_name(lower(person_address));
CREATE INDEX idx_lower_name ON year14_17_address_name(lower(person_name));
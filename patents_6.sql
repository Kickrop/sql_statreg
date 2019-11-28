--select count(id_front)
--from fronts.wos_papers
--where id_measurment = 14

--check duplicates
select * from fronts.cleaned_fronts_aug2019 
right join fronts.fronts_aug19 
on fronts.cleaned_fronts_aug2019.id_front = fronts.fronts_aug19.id
where fronts.cleaned_fronts_aug2019.id_front is null

--unique papers from 15
select a.accession_number  --row_number() over () as id,
from cleaned_fronts_aug2019 a 
left join wos_papers b on a.accession_number=b.wos_id where b.wos_id is null

select count(a.accession_number)
from cleaned_fronts_aug2019 a 
left join wos_papers b on a.accession_number=b.wos_id where b.wos_id is null


select accession_number, count(accession_number)
from fronts.cleaned_fronts_aug2019

--where id_measurment in ('14')
group by accession_number
having count(accession_number)>1

select count(distinct wos_id)
from fronts.wos_papers
where id_measurment = 14


--drop table fronts.cleaned_fronts_aug2019

--select count(*) from fronts.cleaned_data_2

--select count(distinct article_name) from fronts.cleaned_data

select  count(accession_number) from fronts.cleaned_data_2
--group by front_name
order by count desc

select front_name, round(avg((publication_date)::int),5) from fronts.cleaned_data_2
where id_front in ('321','322','323','330','335','336','338','343','344')
group by front_name--front_name='OPTIMAL ARTIFICIAL NEURAL NETWORK BASED,NON-NEWTONIAN NANOFLUID FLOW,FE3O4-AG/EG HYBRID NANOFLUID,ZNO-TIO2/EG HYBRID NANOFLUID,SIO2-MWCNTS/SAE40 HYBRID NANOFLUID'


/*select * from (
select (round - mean_year::numeric)<>0 equal, round, mean_year, Research_Fronts,id
from
(select id_front, round(avg((publication_date)::int),1) 
from fronts.cleaned_data_2
group by id_front
order by id_front::int asc) a
join
(select Research_Fronts,id, mean_year::numeric from fronts.jan2019) b
on (a.id_front = b.id)
) x
where equal=true*/

--уникальные статьи 14 среза count|-----|11966|
select count(*) from (
select *
from
--fronts.wos_measurements_papers
	(select distinct accession_number from fronts.cleaned_data_2) a
	left join
	(select wos_id from fronts.wos_measurements_papers where id_measurment not in ('14')) b
	on a.accession_number=b.wos_id
	where b.wos_id is null
) x
right join 
(select distinct wos_id, id_measurment
from fronts.wos_papers
) c
on x.wos_id = c.wos_id
where x.wos_id is null and id_measurment = '14'


--insert into fronts.wos_papers
--select *
--(
--  id_measurement,
--  id,
--  id_front,
--  title,
--  id_source,
--  citation_count,
--  citation_date,
--  num_vol_pages,
--  is_russian,
--  id_field,
--  wos_id,
--  wos_id_int,
--  volume,
--  issue,
--  pages,
--  doi,
--  published_day,
--  published_month,
--  published_year,
--  id_document_type,
--  id_language,
--  "IDS",
--  ref_count,
--  reprint_address,
--  email,
--  abstract,
--  is_loaded,
--  is_loaded_abs
--) 
(
select 
  14,
  id_paper,
  id_front::int,
  title,
  0,--id_source,
  a.citation_count::int,
  '2019-08-21',
  ji || so, --replace(replace(replace(upper(replace(ji,'.','')), 'ADV ', 'ADVANCED ') || ' ', ''), so || ' ',''),
  0,-- COALESCE(is_russian,0),
  0,--id_field,
  a.wos_id,
  a.wos_id_int::bigint,
  volume,
  issue,
  pn || ' ' || bp || '-' || ep,
  doi,
  0,
  substr(pd,1,3),
  published_year::int,
  0, --id_document_type,
  1, --id_language,
  '',
  ref_count::int,
  reprint_address,
  email,
  abstract,
  1,
  1
from
fronts.cleaned_new_papers a join fronts.wos_measurements_papers b on a.wos_id=b.wos_id
where id_paper in (8825,10026,25133)
)

select * --id_paper, replace(wos_id,'000427532100012', '000457338500001')--, replace(wos_id_int,427532100012,457338500001) 
from fronts.wos_measurements_papers
where wos_id in ('000427532100012','000419907500008','000445569900001')
where id_paper in (8825,10026,25133) and id_measurment = 14
--
--select id_measurment, id_front, id_paper, a.wos_id, wos_id_int, citation_count from
--(select '14' as id_measurment,id_front, '' as id_paper, accession_number as wos_id,accession_number::bigint as wos_id_int, times_cited as citation_count from fronts.cleaned_data_2) a
--left join
--(select distinct wos_id from fronts.wos_measurements_papers where id_measurment in ('14')) b
--on a.wos_id=b.wos_id
--where b.wos_id is null

--insert into fronts.wos_measurements_papers
--(id_measurment, id_front, id_paper, wos_id, wos_id_int, citation_count)
--select id_measurment::int, id_front::int, id_paper::int, a.wos_id, wos_id_int, citation_count::int from
--(select '14' as id_measurment,id_front, '999999'::int as id_paper, accession_number as wos_id,accession_number::bigint as wos_id_int, times_cited as citation_count from fronts.cleaned_data_2) a
--left join
--(select distinct wos_id from fronts.wos_measurements_papers where id_measurment in ('14')) b
--on a.wos_id=b.wos_id
--where b.wos_id is null

select count(*) from 
(select * from fronts.wos_measurements_papers where id_measurment in ('14')) a --and id_front = '362'
full join
(select * from fronts.cleaned_data_2) b
on a.wos_id=b.accession_number
where a.wos_id is null and b.accession_number is null

--check duplicates
select wos_id, count(wos_id)
from fronts.wos_papers
where id_measurment in ('14')
group by wos_id
having count(wos_id)>1

--delite duplicates
--delete
--from 
--	fronts.wos_papers a
--		using fronts.wos_papers b
--where 
--a.wos_id < b.wos_id
--and a.wos_id = b.wos_id
--and a.id_measurment in ('14') and b.id_measurment in ('14')



select avg(length(accession_number))
from fronts.cleaned_data_2

select count(distinct docid) from fronts.af
limit 100
select year,count(distinct pn)
from rospatent._1_kutsenko_foreign_patents
--where year between '2006' and '2015'-- and is_moscow = '1.0'
group by year
union
select 'sum',count(distinct pn)
from rospatent._1_kutsenko_foreign_patents
order by year desc

select count(distinct app_nr)
from rospatent._1_rus_app_rospatent
where app_year in ('2016','2017')

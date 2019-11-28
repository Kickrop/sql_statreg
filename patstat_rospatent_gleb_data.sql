--select distinct person_name, count(﻿appln_id)
--from patstat_foreign_rus_10_18
--where lower(person_address) not like '%moscow%' and 
--appln_filing_year in ('2016', '2017')
--and person_name not in 
--(select distinct org from "_1_kutsenko_foreign_patents"
--)
--group by person_name
--order by count desc


select distinct person_name,appln_auth || appln_nr
from patstat_foreign_rus_10_18
where lower(person_address) not like '%moscow%' and 
appln_filing_year in ('2016', '2017')
--and ((appln_auth || appln_nr) not in 
--(select distinct pn from "_1_kutsenko_foreign_patents")
and person_name not in (select distinct org from "_1_kutsenko_foreign_patents"
)
--)


select distinct org from "_1_kutsenko_foreign_patents"

select count(distinct person_name)
from patstat_foreign_rus_10_18
where lower(person_address) not like '%moscow%' and 
appln_filing_year in ('2016', '2017')
and ((appln_auth || appln_nr) not in 
(select distinct app_nr from _1_rus_app_rospatent)
--and person_name not in (select distinct org from "_1_kutsenko_foreign_patents"
)
select * from
(select * --replace(inn, '.0','') new_inn --max(length(inn))--
from licenses_edited
where right(ogrn,2) = '.0') a
join statregistr7 on a.inn=statregistr7.pole_8
--'0' || 

select '0' || inn
from licenses_edited
where length(inn) < 10 and length(inn) > 0 and inn <> 'nan' and inn <> '020000326'

select '0' || new_inn from (
select --count(*) 
--replace(inn, '.0','') new_inn, replace(ogrn, '.0','') new_ogrn --max(length(inn))--
inn, ogrn
from licenses_edited
where right(inn,2) = '.0' and length(inn) > 10 and inn <> 'nan'
) a
where length(new_inn) < 10 and length(new_inn) > 2

--UPDATE licenses_edited
SET inn = '0' || inn -- ogrn=new_ogrn
--FROM
--   (select replace(inn, '.0','') new_inn, replace(ogrn, '.0','') new_ogrn 
--   from licenses_edited
--   where right(inn,2) = '.0' and length(inn) > 10 and inn <> 'nan') x
where
	length(inn) < 10 and length(inn) > 0 and inn <> 'nan' and inn <> '020000326'
   
--licenses_edited.inn=x.new_inn --and licenses_edited.ogrn=x.new_ogrn

--тупое соединение, 43572
select --distinct pole_1, pole_3, pole_6, shortname
count(distinct pole_1) 
--(select replace(inn, '.0','') new_inn --max(length(inn))--
from (select inn, ogrn, 
lower(trim(fullname)) fullname, lower(trim(shortname)) shortname 
--fullname,shortname --,address
from licenses_edited
where fullname <> 'nan' and shortname <> 'nan' and length(shortname)>2 and length(fullname)>2) a
--where right(inn,2) = '.0') a
join 
( select pole_1,pole_3,pole_8, pole_27--, "40"
, lower(trim(pole_7)) pole_7,lower(trim(pole_6)) pole_6 
--,pole_7, pole_6--
from statregistr7 --join "_0_statregistr7_plus1" on statregistr7.pole_1="_0_statregistr7_plus1"."1"
where in_vyborka = '1'
) b 
on a.inn=b.pole_8 or b.pole_27=a.ogrn or b.pole_7=a.fullname or b.pole_6=a.shortname  
order by pole_6
---головы 40220, без trim lower 37234
select --distinct pole_1, pole_3, pole_6, shortname
count(pole_3) 
from (select distinct inn, ogrn, 
lower(trim(fullname)) fullname, lower(trim(shortname)) shortname 
--fullname,shortname --,address
from licenses_edited
where fullname <> 'nan' and shortname <> 'nan' and length(shortname)>2 and length(fullname)>2
and branch in ('1','1.0') and is_deleted = '0') a
join 
( select distinct pole_3,pole_8, pole_27--, "40"
, lower(trim(pole_7)) pole_7,lower(trim(pole_6)) pole_6 
--,pole_7, pole_6--
from statregistr7 --join "_0_statregistr7_plus1" on statregistr7.pole_1="_0_statregistr7_plus1"."1"
where in_vyborka = '1' and (pole_9 = '1' or right(pole_3,3) <> '001')
) b 
on a.inn=b.pole_8 or b.pole_27=a.ogrn or b.pole_7=a.fullname or b.pole_6=a.shortname  
--филиалы, 2106, без трим 2106
select --distinct pole_1, pole_3, pole_6, shortname
	count(distinct pole_1) 
from (select 
			inn, ogrn
			--, lower(trim(fullname)) fullname
			--, lower(trim(shortname)) shortname 
			,fullname,shortname --,address
				from licenses_edited
	  where fullname <> 'nan' and shortname <> 'nan' and length(shortname)>2 and length(fullname)>2
			and branch = '1'
		) a
	join 
	 (select pole_1,pole_3,pole_8, pole_27--, "40"
				--, lower(trim(pole_7)) pole_7,lower(trim(pole_6)) pole_6 
				,pole_7, pole_6--
				from statregistr7 --join "_0_statregistr7_plus1" on statregistr7.pole_1="_0_statregistr7_plus1"."1"
				where in_vyborka = '1' and pole_9 <> '1'
		) b 
on a.inn=b.pole_8 or b.pole_27=a.ogrn or b.pole_7=a.fullname or b.pole_6=a.shortname  

---
--branch = '0' and is_deleted = '0'
CREATE INDEX idx_vyborka ON statregistr7(in_vyborka);
CREATE INDEX idx_address_reg ON _0_statregistr7_plus1("40");
CREATE INDEX idx_address_lic ON licenses_edited(address);


select count(distinct pole_1) 
--(select replace(inn, '.0','') new_inn --max(length(inn))--
from vyborka_lic a
--where right(inn,2) = '.0') a
join 
( select pole_1,pole_8, pole_27, lower(trim(pole_7)) pole_7,lower(trim(pole_6)) pole_6 --pole_7, pole_6--
from statregistr7 join okpo_statreg_by_gleb on okpo_statreg_by_gleb.okpo=statregistr7.pole_1) b 
on a.inn=b.pole_8 or b.pole_27=a.ogrn or b.pole_7=a.fullname or b.pole_6=a.shortname
where branch = '0' and is_deleted = '0'

CREATE INDEX idx_inn ON vyborka_lic(inn);
CREATE INDEX idx_ogrn ON vyborka_lic(ogrn);
CREATE INDEX idx_shortname ON vyborka_lic(shortname);
CREATE INDEX idx_fullname_ ON vyborka_lic(fullname);
CREATE INDEX idx_edu_kpp ON vyborka_lic(kpp);

ALTER TABLE statregistr7
ADD COLUMN in_vyborka text;

select *
from statregistr7 --join okpo_statreg_by_gleb on okpo_statreg_by_gleb.okpo=statregistr7.pole_1) b
where 

select count(*)
from statregistr7
where in_vyborka is null

select count(*)
from okpo_statreg_by_gleb

UPDATE statregistr7
SET in_vyborka = '1'
FROM
   okpo_statreg_by_gleb
WHERE
   statregistr7.pole_1=okpo_statreg_by_gleb.okpo
--select count(*)
--from _._0_statregistr_licenses_edited
--where inn not in
--      (select distinct "8" from _._0_statregistr_statregistr7
-- where (length("3") < 2 or right("3", 4) = '0001' or "3" is null)
--  and "1" not in (select "1" from _._0_statregistr_second_head)
--  and "8" is not null
--  ) and
--      ogrn not in
--      (select distinct "27" from _._0_statregistr_statregistr7
-- where (length("3") < 2 or right("3", 4) = '0001' or "3" is null)
--  and "1" not in (select "1" from _._0_statregistr_second_head)
--  and "27" is not null
--  )

select *
--count(*)
from "_0_statregistr_licenses_edited"
--where right(inn,2) = '.0'
where length(inn)>10 and is_deleted = '0'
--with vyborka as (
--  select replace(okpo, '_', '') as "1"
--  from get_google_table(
--           'https://docs.google.com/spreadsheets/d/e/2PACX-1vQQCEZiYuzvJzqqzlVVPfru9NMukwDhO-S2vtk3yLWSD4NaSHoRZgRjJ4cBReSv0Mpmq4M2MomyQRlU/pub?gid=2026021521&single=true&output=csv'::text) a(okpo text)
--)

-- select a.*,
--        case when b."1" is null then '0' else '1' end as "121"
--        from _._0_statregistr_statregistr7 a
-- left join vyborka b on a."1" = b."1";

select a."1", "2", "3", "4", "7", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53", "54",
              "66", "75", "80", "81", "82", "83", "93", "94", "97", "106", "112", "115",
       case when b."1" is null then '0' else '1' end as "121"
       from _._0_statregistr_statregistr7_plus1 a
left join vyborka b on a."1" = b."1";
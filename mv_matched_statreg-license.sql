SELECT max(length("is_deleted")) FROM dblink('dbname=tmp_media',
                     'select "is_deleted" from _._1_statregistr_join_filials')
  AS t1("is_deleted" text) --WHERE proname LIKE 'bytea%';

select count(*) from (
select *
from (select inn,ogrn, lower(trim(fullname)) fullname from vyborka_lic where branch = '1') a
join 
(select inn,ogrn, lower(trim(full_name)) full_name --, ogrn, lower(trim(full_name)) 
from razdel_1_1 join org_inf on razdel_1_1.okpo=org_inf.okpo 
where org_status in ('2','3') 
--okpo_head <> '9999'
) b 
on (a.inn=b.inn or a.ogrn=b.ogrn) and lower(trim(a.fullname))=lower(trim(b.full_name))
order by fullname
) x

select * from (
select distinct inn,ogrn,lower(fullname) from vyborka_lic where branch = '1' order by inn) y

select * from (
select distinct inn, ogrn, lower(trim(full_name)) 
from razdel_1_1 join org_inf on razdel_1_1.okpo=org_inf.okpo 
where org_status in ('2','3') 
order by inn
) x


CREATE INDEX idx_r11_inn ON razdel_1_1(inn);
CREATE INDEX idx_vyb_lic_inn ON vyborka_lic(inn);
CREATE INDEX idx_org_inf_fullname_lower ON org_inf(lower(trim(full_name)));
CREATE INDEX idx_vyb_lic_fullname_lower ON vyborka_lic(lower(trim(fullname)));
 
ALTER TABLE razdel_1_1 ALTER COLUMN inn TYPE varchar(20) USING pr_code_upd::integer

select *
from vyborka_lic
where branch = '0'

--CREATE INDEX idx_pole27 ON statreg7_ron_matched(pole_27);
--CREATE INDEX idx_pole1 ON statreg7_ron_matched(pole_1);
--CREATE INDEX idx_pole6 ON statreg7_ron_matched(pole_6);
--CREATE INDEX idx_license_status ON statreg7_ron_matched(license_status);
--CREATE INDEX idx_edu_level ON statreg7_ron_matched(edu_level);
--CREATE INDEX idx_inn_lic ON statreg7_ron_matched(inn);
--CREATE INDEX idx_ogrn_lic ON statreg7_ron_matched(ogrn);
--CREATE INDEX idx_fullname_lic ON statreg7_ron_matched(fullname);
--CREATE INDEX idx_shortname_lic ON statreg7_ron_matched(shortname);

--drop MATERIALIZED VIEW statreg7_ron_matched
CREATE MATERIALIZED VIEW statreg7_ron_matched
as
select 
	'H' head,
	"1" pole_1,
    "2" pole_2,
    "3" pole_3,
    "4" pole_4,
    "5" pole_5,
    "6" pole_6,
    "7" pole_7,
    "8" pole_8,
    "9" pole_9,
    "10" pole_10,
    "11" pole_11,
    "12" pole_12,
    "13" pole_13,
    "14" pole_14,
    "15" pole_15,
    "16" pole_16,
    "17" pole_17,
    "18" pole_18,
    "19" pole_19,
    "20" pole_20,
    "21" pole_21,
    "22" pole_22,
    "23" pole_23,
    "24" pole_24,
    "25" pole_25,
    "26" pole_26,
    "27" pole_27,
    "67" pole_67,
    "74" pole_74,
    "78" pole_78,
    "79" pole_79,
    "95" pole_95,
    "105" pole_105,
    "113" pole_113,
    "116" pole_116,
    "117" pole_117,
    "118" pole_118,
    "119" pole_119,
    "120" pole_120,
    "source",
    fullname,
    shortname,
    branch,
    org_type,
    inn,
    ogrn,
    kpp,
    region,
    address,
    license_status,
    license_authority,
    license_number,
    license_issue_date,
    validity,
    edu_level,
    is_deleted
           FROM dblink('dbname=tmp_media',
                     'select  "1",
            "2",
            "3",
            "4",
            "5",
            "6",
            "7",
            "8",
            "9",
            "10",
            "11",
            "12",
            "13",
            "14",
            "15",
            "16",
            "17",
            "18",
            "19",
            "20",
            "21",
            "22",
            "23",
            "24",
            "25",
            "26",
            "27",
            "67",
            "74",
            "78",
            "79",
            "95",
            "105",
            "113",
            "116",
            "117",
            "118",
            "119",
            "120",
	"source",
    fullname,
    shortname ,
    branch ,
    org_type ,
    inn ,
    ogrn ,
    kpp ,
    region ,
    address ,
    license_status ,
    license_authority ,
    license_number ,
    license_issue_date ,
    validity ,
    edu_level ,
    is_deleted 
 from _._1_statregistr_join_heads')
 as sjh7("1" varchar(20), "2" varchar(20),"3" varchar(20),"4" text,"5" text,"6" text,"7" text,"8" varchar(20),"9" text,"10" text,"11" text,	"12" text,	"13" text,	"14" text,	"15" text,	"16" text,	"17" text,	"18" text,	"19" text,	"20" text,	"21" text,	"22" text,	"23" text,	"24" text,	"25" text,	"26" text,	"27" varchar(20),	"67" varchar(100),	"74" text,	"78" text,	"79" text,	"95" text,	"105" text,	"113" text,	"116" text,	"117" text,	"118" text,	"119" text,	"120" text,	"source" text,fullname text,shortname	text,branch text,org_type text,inn varchar(20),ogrn varchar(20),	kpp	text,region text,address text,license_status text,	license_authority text,	license_number text,license_issue_date	text,validity text,	edu_level text,	is_deleted text)
union all
select 
	'F' head,
	"1" pole_1,
    "2" pole_2,
    "3" pole_3,
    "4" pole_4,
    "5" pole_5,
    "6" pole_6,
    "7" pole_7,
    "8" pole_8,
    "9" pole_9,
    "10" pole_10,
    "11" pole_11,
    "12" pole_12,
    "13" pole_13,
    "14" pole_14,
    "15" pole_15,
    "16" pole_16,
    "17" pole_17,
    "18" pole_18,
    "19" pole_19,
    "20" pole_20,
    "21" pole_21,
    "22" pole_22,
    "23" pole_23,
    "24" pole_24,
    "25" pole_25,
    "26" pole_26,
    "27" pole_27,
    "67" pole_67,
    "74" pole_74,
    "78" pole_78,
    "79" pole_79,
    "95" pole_95,
    "105" pole_105,
    "113" pole_113,
    "116" pole_116,
    "117" pole_117,
    "118" pole_118,
    "119" pole_119,
    "120" pole_120,
    "source",
    fullname,
    shortname,
    branch,
    org_type,
    inn,
    ogrn,
    kpp,
    region,
    address,
    license_status,
    license_authority,
    license_number,
    license_issue_date,
    validity,
    edu_level,
    '0' is_deleted
           FROM dblink('dbname=tmp_media',
                     'select  "1",
            "2",
            "3",
            "4",
            "5",
            "6",
            "7",
            "8",
            "9",
            "10",
            "11",
            "12",
            "13",
            "14",
            "15",
            "16",
            "17",
            "18",
            "19",
            "20",
            "21",
            "22",
            "23",
            "24",
            "25",
            "26",
            "27",
            "67",
            "74",
            "78",
            "79",
            "95",
            "105",
            "113",
            "116",
            "117",
            "118",
            "119",
            "120",
	"source",
    fullname,
    shortname ,
    branch ,
    org_type ,
    inn ,
    ogrn ,
    kpp ,
    region ,
    address ,
    license_status ,
    license_authority ,
    license_number ,
    license_issue_date ,
    validity ,
    edu_level 
 from _._1_statregistr_join_filials')
 as sjh7("1" varchar(20), "2" varchar(20),"3" varchar(20),"4" text,"5" text,"6" text,"7" text,"8" varchar(20),"9" text,"10" text,"11" text,	"12" text,	"13" text,	"14" text,	"15" text,	"16" text,	"17" text,	"18" text,	"19" text,	"20" text,	"21" text,	"22" text,	"23" text,	"24" text,	"25" text,	"26" text,	"27" varchar(20),	"67" varchar(100),	"74" text,	"78" text,	"79" text,	"95" text,	"105" text,	"113" text,	"116" text,	"117" text,	"118" text,	"119" text,	"120" text,	"source" text,fullname text,shortname	text,branch text,org_type text,inn varchar(20),ogrn varchar(20),	kpp	text,region text,address text,license_status text,	license_authority text,	license_number text,license_issue_date	text,validity text,	edu_level text)

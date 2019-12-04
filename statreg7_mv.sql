drop materialized view _._0_statregistr_statregistr7;
create materialized view _._0_statregistr_statregistr7 as
with osn1 as (
  select replace("1", '_', '') as "1",
         replace("2", '_', '') as "2",
         replace("3", '_', '') as "3",
         replace("4", '_', '') as "4",
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
         "120"
  from get_google_table_v2(
           'https://docs.google.com/spreadsheets/d/e/2PACX-1vS8doFQwdiRxuCn7si-QnJ5y8DA7S_DwYXOnruuu0Sl5cp1EUdOg1GoUtaMekYBUkp1sUs8qE9t30F-/pub?gid=1449501708&single=true&output=csv'::text) a ("1" text,
                                                                                                                                                                                                 "2" text,
                                                                                                                                                                                                 "3" text,
                                                                                                                                                                                                 "4" text,
                                                                                                                                                                                                 "5" text,
                                                                                                                                                                                                 "6" text,
                                                                                                                                                                                                 "7" text,
                                                                                                                                                                                                 "8" text,
                                                                                                                                                                                                 "9" text,
                                                                                                                                                                                                 "10" text,
                                                                                                                                                                                                 "11" text,
                                                                                                                                                                                                 "12" text,
                                                                                                                                                                                                 "13" text,
                                                                                                                                                                                                 "14" text,
                                                                                                                                                                                                 "15" text,
                                                                                                                                                                                                 "16" text,
                                                                                                                                                                                                 "17" text,
                                                                                                                                                                                                 "18" text,
                                                                                                                                                                                                 "19" text,
                                                                                                                                                                                                 "20" text,
                                                                                                                                                                                                 "21" text,
                                                                                                                                                                                                 "22" text,
                                                                                                                                                                                                 "23" text,
                                                                                                                                                                                                 "24" text,
                                                                                                                                                                                                 "25" text,
                                                                                                                                                                                                 "26" text,
                                                                                                                                                                                                 "27" text,
                                                                                                                                                                                                 "67" text,
                                                                                                                                                                                                 "74" text,
                                                                                                                                                                                                 "78" text,
                                                                                                                                                                                                 "79" text,
                                                                                                                                                                                                 "95" text,
                                                                                                                                                                                                 "105" text,
                                                                                                                                                                                                 "113" text,
                                                                                                                                                                                                 "116" text,
                                                                                                                                                                                                 "117" text,
                                                                                                                                                                                                 "118" text,
                                                                                                                                                                                                 "119" text,
                                                                                                                                                                                                 "120" text)
)

select * from _.statregistr_statregistr6 where "1" != '08014734'
union
select * from osn1;

create index statregistr_statregistr7_fullname
  on _._0_statregistr_statregistr7 ("7");

create index "_statregistr_statregistr7_id"
  on _._0_statregistr_statregistr7 ("3");

create index "_statregistr_statregistr7_inn"
  on _._0_statregistr_statregistr7 ("8");

create index "_statregistr_statregistr7_ogrn"
  on _._0_statregistr_statregistr7 ("27");

create index "_statregistr_statregistr7_okpo"
  on _._0_statregistr_statregistr7 ("1");

create index "_statregistr_statregistr7_shortname"
  on _._0_statregistr_statregistr7 ("6");

create index "_statregistr_statregistr7_9"
  on _._0_statregistr_statregistr7 ("9");

create index "_statregistr_statregistr7_2"
  on _._0_statregistr_statregistr7 ("2");

drop materialized view _._0_statregistr_statregistr7_plus1;
create materialized view _._0_statregistr_statregistr7_plus1 as
with  osn2 as (
       select replace("1", '_', '') as "1",
              replace("2", '_', '') as "2",
              replace("3", '_', '') as "3",
              replace("4", '_', '') as "4",
              "7",
              "28",
              "29",
              "30",
              "31",
              "32",
              "33",
              "34",
              "35",
              "36",
              "37",
              "38",
              "39",
              "40",
              "41",
              "42",
              "43",
              "44",
              "45",
              "46",
              "47",
              "48",
              "49",
              "50",
              "51",
              "52",
              "53",
              "54",
              "55",
              "66",
              "75",
              "80",
              "81",
              "82",
              "83",
              "93",
              "94",
              "97",
              "106",
              "112",
              "115"
       from get_google_table_v2(
                'https://docs.google.com/spreadsheets/d/e/2PACX-1vS8doFQwdiRxuCn7si-QnJ5y8DA7S_DwYXOnruuu0Sl5cp1EUdOg1GoUtaMekYBUkp1sUs8qE9t30F-/pub?gid=1225779298&single=true&output=csv'::text) a ("1" text,
                                                                                                                                                                                                      "2" text,
                                                                                                                                                                                                      "3" text,
                                                                                                                                                                                                      "4" text,
                                                                                                                                                                                                      "7" text,
                                                                                                                                                                                                      "28" text,
                                                                                                                                                                                                      "29" text,
                                                                                                                                                                                                      "30" text,
                                                                                                                                                                                                      "31" text,
                                                                                                                                                                                                      "32" text,
                                                                                                                                                                                                      "33" text,
                                                                                                                                                                                                      "34" text,
                                                                                                                                                                                                      "35" text,
                                                                                                                                                                                                      "36" text,
                                                                                                                                                                                                      "37" text,
                                                                                                                                                                                                      "38" text,
                                                                                                                                                                                                      "39" text,
                                                                                                                                                                                                      "40" text,
                                                                                                                                                                                                      "41" text,
                                                                                                                                                                                                      "42" text,
                                                                                                                                                                                                      "43" text,
                                                                                                                                                                                                      "44" text,
                                                                                                                                                                                                      "45" text,
                                                                                                                                                                                                      "46" text,
                                                                                                                                                                                                      "47" text,
                                                                                                                                                                                                      "48" text,
                                                                                                                                                                                                      "49" text,
                                                                                                                                                                                                      "50" text,
                                                                                                                                                                                                      "51" text,
                                                                                                                                                                                                      "52" text,
                                                                                                                                                                                                      "53" text,
                                                                                                                                                                                                      "54" text,
                                                                                                                                                                                                      "55" text,
                                                                                                                                                                                                      "66" text,
                                                                                                                                                                                                      "75" text,
                                                                                                                                                                                                      "80" text,
                                                                                                                                                                                                      "81" text,
                                                                                                                                                                                                      "82" text,
                                                                                                                                                                                                      "83" text,
                                                                                                                                                                                                      "93" text,
                                                                                                                                                                                                      "94" text,
                                                                                                                                                                                                      "97" text,
                                                                                                                                                                                                      "106" text,
                                                                                                                                                                                                      "112" text,
                                                                                                                                                                                                      "115" text)
     )
select * from _.statregistr_statregistr6_plus1 where "1" != '08014734'
union
select * from osn2;
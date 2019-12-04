--drop table statregistr.statregistr7

create table statregistr.statregistr7
as 
select case when statregistr.okpo_statreg_by_gleb.okpo is not null then '1' else '' end as in_vyborka,statregistr._0_statregistr7.pole_1,	statregistr._0_statregistr7.pole_2,	statregistr._0_statregistr7.pole_3,	statregistr._0_statregistr7.pole_4,	pole_5,	pole_6,	statregistr._0_statregistr7.pole_7,	pole_8,	pole_9,	pole_10,	pole_11,	pole_12,	pole_13,	pole_14,	pole_15,	pole_16,	pole_17,	pole_18,	pole_19,	pole_20,	pole_21,	pole_22,	pole_23,	pole_24,	pole_25,	pole_26,	pole_27,	pole_28,	pole_29,	pole_30,	pole_31,	pole_32,	pole_33,	pole_34,	pole_35,	pole_36,	pole_37,	pole_38,	pole_39,	pole_40,	pole_41,	pole_42,	pole_43,	pole_44,	pole_45,	pole_46,	pole_47,	pole_48,	pole_49,	pole_50,	pole_51,	pole_52,	pole_53,	pole_54,	pole_55,	pole_66,	pole_67,	pole_74,	pole_75,	pole_78,	pole_79,	pole_80,	pole_81,	pole_82,	pole_83,	pole_93,	pole_94,	pole_95,	pole_97,	pole_105,	pole_106,	pole_112,	pole_113,	pole_115
from 
	statregistr._0_statregistr7 join statregistr._0_statregistr7_plus1
	on statregistr._0_statregistr7.pole_1 = statregistr._0_statregistr7_plus1.pole_1
	left join statregistr.okpo_statreg_by_gleb on statregistr._0_statregistr7.pole_1 = statregistr.okpo_statreg_by_gleb.okpo
--limit 10
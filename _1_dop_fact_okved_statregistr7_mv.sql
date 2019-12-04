 SELECT c.okpo,
    btrim(c.pole_79_unnested) AS pole_79_trimed
   FROM ( SELECT a.okpo,
            b.pole_79_ed,
            unnest(b.pole_79_ed) AS pole_79_unnested
           FROM ( SELECT okpo_statreg_by_gleb.okpo
                   FROM statregistr.okpo_statreg_by_gleb) a
             JOIN ( SELECT _0_statregistr7.pole_1,
                    string_to_array(_0_statregistr7.pole_79, ';'::text) AS pole_79_ed
                   FROM statregistr._0_statregistr7) b ON a.okpo = b.pole_1) c;
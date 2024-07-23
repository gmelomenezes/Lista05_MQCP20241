**Mainwaring, Scott, and Yen-Pin Su. 2021. “Electoral Volatility in Latin America, 1932-2018.” Studies in Comparative International Development. https://doi.org/10.1007/s12116-021-09340-x 
**Stata Commands for replication analyses

***Table 2 (Model 1, Model 2, Model 3)
xtset regimeid regime_elec
xtgee volatility avg_polar conc_elec runoff termlength enp ln_birthyear ln_age_demo ln_gdp2 gdp_growth1 ln_infl1 indig_pop, vce(robust) corr(ar1) force
xtgee newparties avg_polar conc_elec runoff termlength enp ln_birthyear ln_age_demo ln_gdp2 gdp_growth1 ln_infl1 indig_pop, vce(robust) corr(ar1) force
xtgee withinsv avg_polar conc_elec runoff termlength enp ln_birthyear ln_age_demo ln_gdp2 gdp_growth1 ln_infl1 indig_pop, vce(robust) corr(ar1) force

***Table 3 (Model 4, Model 5, Model 6)
xtset regimeid regime_elec
xtgee volatility avg_polar conc_elec runoff termlength enp ln_birthyear ln_age_demo ln_gdp2 gdp_growth1 ln_infl1 indig_pop party_id con_corruption, vce(robust) corr(ar1) force
xtgee newparties avg_polar conc_elec runoff termlength enp ln_birthyear ln_age_demo ln_gdp2 gdp_growth1 ln_infl1 indig_pop party_id con_corruption, vce(robust) corr(ar1) force
xtgee withinsv avg_polar conc_elec runoff termlength enp ln_birthyear ln_age_demo ln_gdp2 gdp_growth1 ln_infl1 indig_pop party_id con_corruption, vce(robust) corr(ar1) force

=====================================

***Online Appendices

*Appendix 3:
sum volatility newparties withinsv avg_polar conc_elec runoff termlength enp ln_birthyear ln_age_demo ln_gdp2 gdp_growth1 ln_infl1 indig_pop party_id con_corruption

***Robustness checks

*Appendix 5: Models with incumbent running reelection
xtset regimeid regime_elec
xtgee volatility incumb_run avg_polar conc_elec runoff termlength enp ln_birthyear ln_age_demo ln_gdp2 gdp_growth1 ln_infl1 indig_pop, vce(robust) corr(ar1) force
xtgee newparties incumb_run avg_polar conc_elec runoff termlength enp ln_birthyear ln_age_demo ln_gdp2 gdp_growth1 ln_infl1 indig_pop, vce(robust) corr(ar1) force
xtgee withinsv incumb_run avg_polar conc_elec runoff termlength enp ln_birthyear ln_age_demo ln_gdp2 gdp_growth1 ln_infl1 indig_pop, vce(robust) corr(ar1) force

*Appendix 6: (PCSE with AR1)
xtpcse volatility avg_polar conc_elec runoff termlength enp ln_birthyear ln_age_demo ln_gdp2 gdp_growth1 ln_infl1 indig_pop, corr(ar1) pairwise
xtpcse newparties avg_polar conc_elec runoff termlength enp ln_birthyear ln_age_demo ln_gdp2 gdp_growth1 ln_infl1 indig_pop, corr(ar1) pairwise
xtpcse withinsv avg_polar conc_elec runoff termlength enp ln_birthyear ln_age_demo ln_gdp2 gdp_growth1 ln_infl1 indig_pop, corr(ar1) pairwise

*Appendix 7: (RE with AR1)
xtregar volatility avg_polar conc_elec runoff termlength enp ln_birthyear ln_age_demo ln_gdp2 gdp_growth1 ln_infl1 indig_pop
xtregar newparties avg_polar conc_elec runoff termlength enp ln_birthyear ln_age_demo ln_gdp2 gdp_growth1 ln_infl1 indig_pop
xtregar withinsv avg_polar conc_elec runoff termlength enp ln_birthyear ln_age_demo ln_gdp2 gdp_growth1 ln_infl1 indig_pop

*Appendix 8: (Multilevel modeling with fixed effects)
set maxiter 50
xtmixed volatility conc_elec runoff termlength ln_birthyear indig_pop gr_ln_age_demo gr_avg_polar gr_ln_gdp2 gr_gdp_growth1 gr_enp gr_ln_infl1 dm_ln_age_demo dm_avg_polar dm_ln_gdp2 dm_gdp_growth1 dm_enp dm_ln_infl1 || regimeid:, || regime_elec: dm_ln_age_demo dm_avg_polar dm_ln_gdp2 dm_gdp_growth1 dm_enp dm_ln_infl1, cov(identity)
xtmixed newparties conc_elec runoff termlength ln_birthyear indig_pop gr_ln_age_demo gr_avg_polar gr_ln_gdp2 gr_gdp_growth1 gr_enp gr_ln_infl1 dm_ln_age_demo dm_avg_polar dm_ln_gdp2 dm_gdp_growth1 dm_enp dm_ln_infl1 || regimeid:, || regime_elec: dm_ln_age_demo dm_avg_polar dm_ln_gdp2 dm_gdp_growth1 dm_enp dm_ln_infl1, cov(identity)
xtmixed withinsv conc_elec runoff termlength ln_birthyear indig_pop gr_ln_age_demo gr_avg_polar gr_ln_gdp2 gr_gdp_growth1 gr_enp gr_ln_infl1 dm_ln_age_demo dm_avg_polar dm_ln_gdp2 dm_gdp_growth1 dm_enp dm_ln_infl1 || regimeid:, || regime_elec: dm_ln_age_demo dm_avg_polar dm_ln_gdp2 dm_gdp_growth1 dm_enp dm_ln_infl1, cov(identity)

*Appendix 9: Dropping outliers
*Check outliers for total volatility
**1.Detecting unusual studentized residuals (larger than 2 or smaller than -2)
reg volatility avg_polar conc_elec runoff termlength enp ln_birthyear ln_age_demo ln_gdp2 gdp_growth1 ln_infl1 indig_pop, beta
predict r, rstudent
hilo r obsid

****Tests for observations with influence for total volatility
**2.Cook's D(The lowest value that Cook’s D can assume is zero, and the higher the Cook’s D is, the more influential the point. The convention cut-off point is 4/n.)
reg volatility avg_polar conc_elec runoff termlength enp ln_birthyear ln_age_demo ln_gdp2 gdp_growth1 ln_infl1 indig_pop, beta
predict d, cooksd
list obsid d if d>4/144

**3.DFITS(The cut-off point for DFITS is 2*sqrt(k/n). DFITS can be either positive or negative, with numbers close to zero corresponding to the points with small or zero influence. )
reg volatility avg_polar conc_elec runoff termlength enp ln_birthyear ln_age_demo ln_gdp2 gdp_growth1 ln_infl1 indig_pop, beta
predict dfit, dfits
list obsid dfit if abs(dfit)>2*sqrt(11/144)

********Drop the ouliters for total volatility
drop if obsid==4
drop if obsid==35
drop if obsid==47
drop if obsid==142
xtset regimeid regime_elec
xtgee volatility avg_polar conc_elec runoff termlength enp ln_birthyear ln_age_demo ln_gdp2 gdp_growth1 ln_infl1 indig_pop, vce(robust) corr(ar1) force


***=================================***
*Check outliers for extra-system volatility
**1.Detecting unusual studentized residuals (larger than 2 or smaller than -2)
drop r lev d dfit
reg newparties avg_polar conc_elec runoff termlength enp ln_birthyear ln_age_demo ln_gdp2 gdp_growth1 ln_infl1 indig_pop, beta
predict r, rstudent
hilo r obsid

****Tests for observations with influence for extra-system volatility
**2.Cook's D(The lowest value that Cook’s D can assume is zero, and the higher the Cook’s D is, the more influential the point. The convention cut-off point is 4/n.)
reg newparties avg_polar conc_elec runoff termlength enp ln_birthyear ln_age_demo ln_gdp2 gdp_growth1 ln_infl1 indig_pop, beta
predict d, cooksd
list obsid d if d>4/144

**3.DFITS(The cut-off point for DFITS is 2*sqrt(k/n). DFITS can be either positive or negative, with numbers close to zero corresponding to the points with small or zero influence. )
reg newparties avg_polar conc_elec runoff termlength enp ln_birthyear ln_age_demo ln_gdp2 gdp_growth1 ln_infl1 indig_pop, beta
predict dfit, dfits
list obsid dfit if abs(dfit)>2*sqrt(11/144)

********Drop the ouliters for extra-system volatility
drop if obsid==4
drop if obsid==121
drop if obsid==142
xtset regimeid regime_elec
xtgee newparties avg_polar conc_elec runoff termlength enp ln_birthyear ln_age_demo ln_gdp2 gdp_growth1 ln_infl1 indig_pop, vce(robust) corr(ar1) force

***=================================***

*Check outliers for within-system volatility
**1.Detecting unusual studentized residuals (larger than 2 or smaller than -2)
drop r lev d dfit
reg withinsv avg_polar conc_elec runoff termlength enp ln_birthyear ln_age_demo ln_gdp2 gdp_growth1 ln_infl1 indig_pop, beta
predict r, rstudent
hilo r obsid

****Tests for observations with influence for within-system volatility
**2.Cook's D(The lowest value that Cook’s D can assume is zero, and the higher the Cook’s D is, the more influential the point. The convention cut-off point is 4/n.)
reg withinsv avg_polar conc_elec runoff termlength enp ln_birthyear ln_age_demo ln_gdp2 gdp_growth1 ln_infl1 indig_pop, beta
predict d, cooksd
list obsid d if d>4/144

**3.DFITS(The cut-off point for DFITS is 2*sqrt(k/n). DFITS can be either positive or negative, with numbers close to zero corresponding to the points with small or zero influence. )
reg withinsv avg_polar conc_elec runoff termlength enp ln_birthyear ln_age_demo ln_gdp2 gdp_growth1 ln_infl1 indig_pop, beta
predict dfit, dfits
list obsid dfit if abs(dfit)>2*sqrt(11/144)

********Drop the ouliters for within-system volatility
drop if obsid==18
drop if obsid==35
drop if obsid==105
drop if obsid==123
xtset regimeid regime_elec
xtgee withinsv avg_polar conc_elec runoff termlength enp ln_birthyear ln_age_demo ln_gdp2 gdp_growth1 ln_infl1 indig_pop, vce(robust) corr(ar1) force

*Appendix 10 Models with incumbent running reelection
xtset regimeid regime_elec
xtgee volatility incumb_run avg_polar conc_elec runoff termlength enp ln_birthyear ln_age_demo ln_gdp2 gdp_growth1 ln_infl1 indig_pop party_id con_corruption, vce(robust) corr(ar1) force
xtgee newparties incumb_run avg_polar conc_elec runoff termlength enp ln_birthyear ln_age_demo ln_gdp2 gdp_growth1 ln_infl1 indig_pop party_id con_corruption, vce(robust) corr(ar1) force
xtgee withinsv incumb_run avg_polar conc_elec runoff termlength enp ln_birthyear ln_age_demo ln_gdp2 gdp_growth1 ln_infl1 indig_pop party_id con_corruption, vce(robust) corr(ar1) force

*Appendix 11 (PCSE with AR1)
xtpcse volatility avg_polar conc_elec runoff termlength enp ln_birthyear ln_age_demo ln_gdp2 gdp_growth1 ln_infl1 indig_pop party_id con_corruption, corr(ar1) pairwise
xtpcse newparties avg_polar conc_elec runoff termlength enp ln_birthyear ln_age_demo ln_gdp2 gdp_growth1 ln_infl1 indig_pop party_id con_corruption, corr(ar1) pairwise
xtpcse withinsv avg_polar conc_elec runoff termlength enp ln_birthyear ln_age_demo ln_gdp2 gdp_growth1 ln_infl1 indig_pop party_id con_corruption, corr(ar1) pairwise

*Appendix 12 (RE with AR1)
xtregar volatility avg_polar conc_elec runoff termlength enp ln_birthyear ln_age_demo ln_gdp2 gdp_growth1 ln_infl1 indig_pop party_id con_corruption
xtregar newparties avg_polar conc_elec runoff termlength enp ln_birthyear ln_age_demo ln_gdp2 gdp_growth1 ln_infl1 indig_pop party_id con_corruption
xtregar withinsv avg_polar conc_elec runoff termlength enp ln_birthyear ln_age_demo ln_gdp2 gdp_growth1 ln_infl1 indig_pop party_id con_corruption

*Appendix 13 (Multilevel modeling with fixed effects)
set maxiter 50
xtmixed volatility conc_elec runoff termlength ln_birthyear indig_pop gr_ln_age_demo gr_avg_polar gr_ln_gdp2 gr_gdp_growth1 gr_enp gr_ln_infl1 gr_party_id gr_con_corruption dm_ln_age_demo dm_avg_polar dm_ln_gdp2 dm_gdp_growth1 dm_enp dm_ln_infl1 dm_party_id dm_con_corruption || regimeid:, || regime_elec: dm_ln_age_demo dm_avg_polar dm_ln_gdp2 dm_gdp_growth1 dm_enp dm_ln_infl1, cov(identity)
xtmixed newparties conc_elec runoff termlength ln_birthyear indig_pop gr_ln_age_demo gr_avg_polar gr_ln_gdp2 gr_gdp_growth1 gr_enp gr_ln_infl1 gr_party_id gr_con_corruption dm_ln_age_demo dm_avg_polar dm_ln_gdp2 dm_gdp_growth1 dm_enp dm_ln_infl1 dm_party_id dm_con_corruption || regimeid:, || regime_elec: dm_ln_age_demo dm_avg_polar dm_ln_gdp2 dm_gdp_growth1 dm_enp dm_ln_infl1, cov(identity)
xtmixed withinsv conc_elec runoff termlength ln_birthyear indig_pop gr_ln_age_demo gr_avg_polar gr_ln_gdp2 gr_gdp_growth1 gr_enp gr_ln_infl1 gr_party_id gr_con_corruption dm_ln_age_demo dm_avg_polar dm_ln_gdp2 dm_gdp_growth1 dm_enp dm_ln_infl1 dm_party_id dm_con_corruption || regimeid:, || regime_elec: dm_ln_age_demo dm_avg_polar dm_ln_gdp2 dm_gdp_growth1 dm_enp dm_ln_infl1, cov(identity)

*Appendix 14 Dropping outliers
*Check outliers for total volatility
**1.Detecting unusual studentized residuals (larger than 2 or smaller than -2)
drop r lev d dfit
reg volatility avg_polar conc_elec runoff termlength enp ln_birthyear ln_age_demo ln_gdp2 gdp_growth1 ln_infl1 indig_pop party_id con_corruption, beta
predict r, rstudent
hilo r obsid

****Tests for observations with influence for total volatility
**2.Cook's D(The lowest value that Cook’s D can assume is zero, and the higher the Cook’s D is, the more influential the point. The convention cut-off point is 4/n.)
reg volatility avg_polar conc_elec runoff termlength enp ln_birthyear ln_age_demo ln_gdp2 gdp_growth1 ln_infl1 indig_pop party_id con_corruption, beta
predict d, cooksd
list obsid d if d>4/75

**3.DFITS(The cut-off point for DFITS is 2*sqrt(k/n). DFITS can be either positive or negative, with numbers close to zero corresponding to the points with small or zero influence. )
reg volatility avg_polar conc_elec runoff termlength enp ln_birthyear ln_age_demo ln_gdp2 gdp_growth1 ln_infl1 indig_pop party_id con_corruption, beta
predict dfit, dfits
list obsid dfit if abs(dfit)>2*sqrt(13/75)

********Drop the ouliters for total volatility
drop if obsid==103
drop if obsid==118
drop if obsid==142
xtset regimeid regime_elec
xtgee volatility avg_polar conc_elec runoff termlength enp ln_birthyear ln_age_demo ln_gdp2 gdp_growth1 ln_infl1 indig_pop party_id con_corruption, vce(robust) corr(ar1) force


***=================================***
*Check outliers for extra-system volatility
**1.Detecting unusual studentized residuals (larger than 2 or smaller than -2)
drop r lev d dfit
reg newparties avg_polar conc_elec runoff termlength enp ln_birthyear ln_age_demo ln_gdp2 gdp_growth1 ln_infl1 indig_pop party_id con_corruption, beta
predict r, rstudent
hilo r obsid

****Tests for observations with influence for extra-system volatility
**2.Cook's D(The lowest value that Cook’s D can assume is zero, and the higher the Cook’s D is, the more influential the point. The convention cut-off point is 4/n.)
reg newparties avg_polar conc_elec runoff termlength enp ln_birthyear ln_age_demo ln_gdp2 gdp_growth1 ln_infl1 indig_pop party_id con_corruption, beta
predict d, cooksd
list obsid d if d>4/75

**3.DFITS(The cut-off point for DFITS is 2*sqrt(k/n). DFITS can be either positive or negative, with numbers close to zero corresponding to the points with small or zero influence. )
reg newparties avg_polar conc_elec runoff termlength enp ln_birthyear ln_age_demo ln_gdp2 gdp_growth1 ln_infl1 indig_pop party_id con_corruption, beta
predict dfit, dfits
list obsid dfit if abs(dfit)>2*sqrt(13/75)

********Drop the ouliters for extra-system volatility
drop if obsid==142
drop if obsid==89
drop if obsid==4
drop if obsid==24
xtset regimeid regime_elec
xtgee newparties avg_polar conc_elec runoff termlength enp ln_birthyear ln_age_demo ln_gdp2 gdp_growth1 ln_infl1 indig_pop party_id con_corruption, vce(robust) corr(ar1) force

***=================================***

*Check outliers for within-system volatility
**1.Detecting unusual studentized residuals (larger than 2 or smaller than -2)
drop r lev d dfit
reg withinsv avg_polar conc_elec runoff termlength enp ln_birthyear ln_age_demo ln_gdp2 gdp_growth1 ln_infl1 indig_pop party_id con_corruption, beta
predict r, rstudent
hilo r obsid

****Tests for observations with influence for within-system volatility
**2.Cook's D(The lowest value that Cook’s D can assume is zero, and the higher the Cook’s D is, the more influential the point. The convention cut-off point is 4/n.)
reg withinsv avg_polar conc_elec runoff termlength enp ln_birthyear ln_age_demo ln_gdp2 gdp_growth1 ln_infl1 indig_pop party_id con_corruption, beta
predict d, cooksd
list obsid d if d>4/75

**3.DFITS(The cut-off point for DFITS is 2*sqrt(k/n). DFITS can be either positive or negative, with numbers close to zero corresponding to the points with small or zero influence. )
reg withinsv avg_polar conc_elec runoff termlength enp ln_birthyear ln_age_demo ln_gdp2 gdp_growth1 ln_infl1 indig_pop party_id con_corruption, beta
predict dfit, dfits
list obsid dfit if abs(dfit)>2*sqrt(13/75)

********Drop the ouliters for within-system volatility
drop if obsid==24
drop if obsid==46
drop if obsid==104
drop if obsid==118
xtset regimeid regime_elec
xtgee withinsv avg_polar conc_elec runoff termlength enp ln_birthyear ln_age_demo ln_gdp2 gdp_growth1 ln_infl1 indig_pop party_id con_corruption, vce(robust) corr(ar1) force

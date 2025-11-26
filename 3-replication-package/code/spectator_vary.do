////////////////////////////////////////////////////////////VK
cap log close
////////////////////////////////////////////////////////////VK	
		

		log using $folder/code/log_2spectator_vary, replace
		
		
*------------------------------------	
*-> Table 3: structural estimation 
*------------------------------------	
		use $folder/data/processed/spectator_vary.dta , clear
		drop if (luck00 >= 3 | luck100 == 0) & treatment=="luckXX"
		drop if (edu15v15 >= 3 | edu15v0 == 0) & treatment=="eduXX"
		drop if (emp15v15 >= 3 | emp15v0 == 0) & treatment=="empXX"
		save "$folder/data/temp/temp.dta", replace
		clear
		set obs 7
		gen id=_n
		cross using "$folder/data/temp/temp.dta"
		gen temp1 = luck100 if id==1 & treatment=="luckXX"
		replace temp1 = luck99 if id==2 & treatment=="luckXX"
		replace temp1 = luck90 if id==3 & treatment=="luckXX"
		replace temp1 = luck50 if id==4 & treatment=="luckXX"
		replace temp1 = luck10 if id==5 & treatment=="luckXX"
		replace temp1 = luck01 if id==6 & treatment=="luckXX"
		replace temp1 = luck00 if id==7 & treatment=="luckXX"
		replace temp1 = edu15v0 if id==1 & treatment=="eduXX"
		replace temp1 = edu15v1 if id==2 & treatment=="eduXX"
		replace temp1 = edu15v4 if id==3 & treatment=="eduXX"
		replace temp1 = edu15v7 if id==4 & treatment=="eduXX"
		replace temp1 = edu15v11 if id==5 & treatment=="eduXX"
		replace temp1 = edu15v14 if id==6 & treatment=="eduXX"
		replace temp1 = edu15v15 if id==7 & treatment=="eduXX"
		replace temp1 = emp15v0 if id==1 & treatment=="empXX"
		replace temp1 = emp15v1 if id==2 & treatment=="empXX"
		replace temp1 = emp15v4 if id==3 & treatment=="empXX"
		replace temp1 = emp15v7 if id==4 & treatment=="empXX"
		replace temp1 = emp15v11 if id==5 & treatment=="empXX"
		replace temp1 = emp15v14 if id==6 & treatment=="empXX"
		replace temp1 = emp15v15 if id==7 & treatment=="empXX"
		replace temp1 = temp1/6
		
		gen temp2 = luck00 if treatment=="luckXX"
		replace temp2 = edu15v15 if treatment=="eduXX"
		replace temp2 = emp15v15 if treatment=="empXX"
		replace temp2 = temp2/6
		
		gen temp3 = 0.5 if id==1 & treatment=="luckXX"
		replace temp3 = 0.505 if id==2 & treatment=="luckXX"
		replace temp3 = 0.55 if id==3 & treatment=="luckXX"
		replace temp3 = 0.75 if id==4 & treatment=="luckXX"
		replace temp3 = 0.90 if id==5 & treatment=="luckXX"
		replace temp3 = 0.99 if id==6 & treatment=="luckXX"
		replace temp3 = 1 if id==7 & treatment=="luckXX"
		egen mean_edu15v0 = mean(eduB15v0/100) if treatment=="eduXX"
		egen mean_edu15v1 = mean(eduB15v1/100) if treatment=="eduXX"
		egen mean_edu15v4 = mean(eduB15v4/100) if treatment=="eduXX"
		egen mean_edu15v7 = mean(eduB15v7/100) if treatment=="eduXX"
		egen mean_edu15v11 = mean(eduB15v11/100) if treatment=="eduXX"
		egen mean_edu15v14 = mean(eduB15v14/100) if treatment=="eduXX"
		egen mean_edu15v15 = mean(eduB15v15/100) if treatment=="eduXX"
		replace temp3 = 1 - (mean_edu15v15 - mean_edu15v0) if id==1 & treatment=="eduXX"
		replace temp3 = 1 - (mean_edu15v15 - mean_edu15v1) if id==2 & treatment=="eduXX"
		replace temp3 = 1 - (mean_edu15v15 - mean_edu15v4) if id==3 & treatment=="eduXX"
		replace temp3 = 1 - (mean_edu15v15 - mean_edu15v7) if id==4 & treatment=="eduXX"
		replace temp3 = 1 - (mean_edu15v15 - mean_edu15v11) if id==5 & treatment=="eduXX"
		replace temp3 = 1 - (mean_edu15v15 - mean_edu15v14) if id==6 & treatment=="eduXX"
		replace temp3 = 1 if id==7 & treatment=="eduXX"
		egen mean_emp15v0 = mean(empB15v0/100) if treatment=="empXX"
		egen mean_emp15v1 = mean(empB15v1/100) if treatment=="empXX"
		egen mean_emp15v4 = mean(empB15v4/100) if treatment=="empXX"
		egen mean_emp15v7 = mean(empB15v7/100) if treatment=="empXX"
		egen mean_emp15v11 = mean(empB15v11/100) if treatment=="empXX"
		egen mean_emp15v14 = mean(empB15v14/100) if treatment=="empXX"
		egen mean_emp15v15 = mean(empB15v15/100) if treatment=="empXX"
		replace temp3 = 1 - (mean_emp15v15 - mean_emp15v0) if id==1 & treatment=="empXX"
		replace temp3 = 1 - (mean_emp15v15 - mean_emp15v1) if id==2 & treatment=="empXX"
		replace temp3 = 1 - (mean_emp15v15 - mean_emp15v4) if id==3 & treatment=="empXX"
		replace temp3 = 1 - (mean_emp15v15 - mean_emp15v7) if id==4 & treatment=="empXX"
		replace temp3 = 1 - (mean_emp15v15 - mean_emp15v11) if id==5 & treatment=="empXX"
		replace temp3 = 1 - (mean_emp15v15 - mean_emp15v14) if id==6 & treatment=="empXX"
		replace temp3 = 1 if id==7 & treatment=="empXX"

		egen subject= group(connectID)
		xtset subject id 

		eststo: menl temp1 = 1 - temp2 + (2*temp2 - 1)/(1 + (1/temp3 - 1)^(1/({alpha} - 1))) if treatment=="luckXX"
		
		eststo: menl temp1 = 1 - temp2 + (2*temp2 - 1)/(1 + (1/temp3 - 1)^(1/({alpha} - 1))) if treatment=="eduXX" 
		
		eststo: menl temp1 = 1 - temp2 + (2*temp2 - 1)/(1 + (1/temp3 - 1)^(1/({alpha} - 1))) if treatment=="empXX"
		esttab, b(%6.3f) se star(* 0.10 ** 0.05 *** 0.01) brackets
		esttab using $folder/output/tables/table3.tex, replace b(%6.3f) se star(* 0.10 ** 0.05 *** 0.01) booktabs
		eststo clear 
		
		
*------------------------------------	
*-> Table 4: Spectators’ opinions about workers’ efforts and their redistributed shares
*------------------------------------			

		use $folder/data/processed/spectator_vary.dta, clear
		// first column
		quietly{
		gen edu_both = (survey_opinion_educ == "Both Worker A and Worker B put a similar amount of effort into reading the tutorial materials." ///
		& survey_opinion_employ == "Both Worker A and Worker B put a similar amount of effort into answering the multiple-choice questions." ///
		& treatment == "eduXX")

		gen edu_either = ((survey_opinion_educ != "Both Worker A and Worker B put a similar amount of effort into reading the tutorial materials." ///
		| survey_opinion_employ != "Both Worker A and Worker B put a similar amount of effort into answering the multiple-choice questions.") ///
		& treatment == "eduXX")

		gen edu_reading = (survey_opinion_educ != "Both Worker A and Worker B put a similar amount of effort into reading the tutorial materials." ///
		& treatment == "eduXX")

		gen edu_test = (survey_opinion_employ != "Both Worker A and Worker B put a similar amount of effort into answering the multiple-choice questions." ///
		& treatment == "eduXX")

		replace edu15v4 = edu15v4/6		
		sum edu15v4 if edu_both == 1
		matrix a1 = r(mean), r(sd), r(N)
		sum edu15v4 if edu_either == 1
		matrix a2 = r(mean), r(sd), r(N)
		sum edu15v4 if edu_reading == 1
		matrix a3 = r(mean), r(sd), r(N)
		sum edu15v4 if edu_test == 1
		matrix a4 = r(mean), r(sd), r(N)

		
		//second column
		gen emp_both = (survey_opinion_educ == "Both Worker A and Worker B put a similar amount of effort into reading the tutorial materials." ///
		& survey_opinion_employ == "Both Worker A and Worker B put a similar amount of effort into answering the multiple-choice questions." ///
		& treatment == "empXX")

		gen emp_either = ((survey_opinion_educ != "Both Worker A and Worker B put a similar amount of effort into reading the tutorial materials." ///
		| survey_opinion_employ != "Both Worker A and Worker B put a similar amount of effort into answering the multiple-choice questions.") ///
		& treatment == "empXX")

		gen emp_reading = (survey_opinion_educ != "Both Worker A and Worker B put a similar amount of effort into reading the tutorial materials." ///
		& treatment == "empXX")

		gen emp_test = (survey_opinion_employ != "Both Worker A and Worker B put a similar amount of effort into answering the multiple-choice questions." ///
		& treatment == "empXX")

		replace emp15v4 = emp15v4/6		
		sum emp15v4 if emp_both == 1
		matrix b1 = r(mean), r(sd), r(N)
		sum emp15v4 if emp_either == 1
		matrix b2 = r(mean), r(sd), r(N)
		sum emp15v4 if emp_reading == 1
		matrix b3 = r(mean), r(sd), r(N)
		sum emp15v4 if emp_test == 1
		matrix b4 = r(mean), r(sd), r(N)

		matrix column1 = a1 \ a2 \ a3 \ a4
		matrix column2 = b1 \ b2 \ b3 \ b4
		matrix table4 = column1, column2
		matrix colnames table4 = edu15v4_mean edu15v4_sd edu15v4_N emp15v4_mean emp15v4_sd emp15v4_N
		matrix rownames table4 = SimilarEffort DoubtEffortEither DoubtEffortReading DoubtEffortAnswering
		}
		
		matlist table4
		esttab matrix(table4) using $folder/output/tables/table4.tex, replace b(%6.3f) se star(* 0.10 ** 0.05 *** 0.01) booktabs
*------------------------------------	
*-> Figure 2: Share redistributed
*------------------------------------		
		
		use $folder/data/processed/spectator_vary.dta, clear
		
		*sum luck* edu15* emp15*
		
		keep if treatment=="luckXX"
				
		collapse luck* (semean) se_luck100=luck100 (semean) se_luck99=luck99 (semean) se_luck90=luck90 ///
		(semean) se_luck50=luck50 (semean) se_luck10=luck10 (semean) se_luck01=luck01 (semean) se_luck00=luck00
		save "$folder/data/temp/temp.dta", replace
		clear
		set obs 7
		gen id=_n + 1
		cross using "$folder/data/temp/temp.dta"
		gen luck = luck100 if id==2
		replace luck = luck99 if id==3
		replace luck = luck90 if id==4
		replace luck = luck50 if id==5
		replace luck = luck10 if id==6
		replace luck = luck01 if id==7
		replace luck = luck00 if id==8
		replace luck = luck / 6
		gen c_u = luck100 + se_luck100 if id==2
		gen c_l = luck100 - se_luck100 if id==2
		replace c_u = luck99 + se_luck99 if id==3
		replace c_l = luck99 - se_luck99 if id==3
		replace c_u = luck90 + se_luck90 if id==4
		replace c_l = luck90 - se_luck90 if id==4
		replace c_u = luck50 + se_luck50 if id==5
		replace c_l = luck50 - se_luck50 if id==5
		replace c_u = luck10 + se_luck10 if id==6
		replace c_l = luck10 - se_luck10 if id==6
		replace c_u = luck01 + se_luck01 if id==7
		replace c_l = luck01 - se_luck01 if id==7
		replace c_u = luck00 + se_luck00 if id==8
		replace c_l = luck00 - se_luck00 if id==8
		replace c_u = c_u / 6
		replace c_l = c_l / 6
		gen mean_string = string(luck, "%3.2f")

		twoway (connect luck id) ///
		       (rcap c_u c_l id, lcolor("black")) ///
			   (scatter luck id, msym(none) mlab(mean_string) mlabsize(medium) mlabpos(1) mlabcolor(black)), ///
			   xtitle("") xlabel(1.5 "." 2 "100% luck" 3 "99% luck" 4 "90% luck" 5 "50% luck" 6 "10% luck" 7 "1% luck" 8 "0% luck" 8.5 ".", noticks) ///
			   scheme(s1mono) ytitle("Share Redistributed") ylabel(0(0.1)0.5, ang(0)) title("Vary-Probability (n=207)") ///
			   legend(off)

		Graph save Graph "$folder/data/temp/1.gph", replace
		
		use $folder/data/processed/spectator_vary.dta, clear
		
		*sum luck* edu15* emp15*
				
		keep if treatment=="eduXX"
////////////////////////////////////////////////////////////VK
//		replace eduB15v0 = 0 if eduB15v0 ==.
//		replace eduB15v1 = 0 if eduB15v1 ==.
//		replace eduB15v4 = 0 if eduB15v4 ==.
//		replace eduB15v7 = 0 if eduB15v7 ==.
//		replace eduB15v11 = 0 if eduB15v11 ==.
//		replace eduB15v14 = 0 if eduB15v14 ==.
//		replace eduB15v15 = 0 if eduB15v15 ==.
////////////////////////////////////////////////////////////VK
				
		
		collapse edu15* eduB15* (semean) se_edu15v0=edu15v0 (semean) se_edu15v1=edu15v1 (semean) se_edu15v4=edu15v4 ///
		(semean) se_edu15v7=edu15v7 (semean) se_edu15v11=edu15v11 (semean) se_edu15v14=edu15v14 (semean) se_edu15v15=edu15v15 ///
		(semean) se_eduB15v0 = eduB15v0 (semean) se_eduB15v1 = eduB15v1 (semean) se_eduB15v4 = eduB15v4 ///
		(semean) se_eduB15v7 = eduB15v7 (semean) se_eduB15v11 = eduB15v11 (semean) se_eduB15v14 = eduB15v14 ///
		(semean) se_eduB15v15 = eduB15v15
		
		save "$folder/data/temp/temp.dta", replace
		clear
		set obs 7
		gen id=_n + 1
		cross using "$folder/data/temp/temp.dta"
		gen edu = edu15v0 if id==2
		replace edu = edu15v1 if id==3
		replace edu = edu15v4 if id==4
		replace edu = edu15v7 if id==5
		replace edu = edu15v11 if id==6
		replace edu = edu15v14 if id==7
		replace edu = edu15v15 if id==8
		replace edu = edu / 6
		gen c_u = edu15v0 + se_edu15v0 if id==2
		gen c_l = edu15v0 - se_edu15v0 if id==2
		replace c_u = edu15v1 + se_edu15v1 if id==3
		replace c_l = edu15v1 - se_edu15v1 if id==3
		replace c_u = edu15v4 + se_edu15v4 if id==4
		replace c_l = edu15v4 - se_edu15v4 if id==4
		replace c_u = edu15v7 + se_edu15v7 if id==5
		replace c_l = edu15v7 - se_edu15v7 if id==5
		replace c_u = edu15v11 + se_edu15v11 if id==6
		replace c_l = edu15v11 - se_edu15v11 if id==6
		replace c_u = edu15v14 + se_edu15v14 if id==7
		replace c_l = edu15v14 - se_edu15v14 if id==7
		replace c_u = edu15v15 + se_edu15v15 if id==8
		replace c_l = edu15v15 - se_edu15v15 if id==8
		replace c_u = c_u / 6
		replace c_l = c_l / 6
		gen mean_string = string(edu, "%3.2f")
		
		gen belief = eduB15v0 if id==2
		replace belief = eduB15v1 if id==3
		replace belief = eduB15v4 if id==4
		replace belief = eduB15v7 if id==5
		replace belief = eduB15v11 if id==6
		replace belief = eduB15v14 if id==7
		replace belief = eduB15v15 if id==8
		replace belief = belief / 100
		gen belief_u = eduB15v0 + se_eduB15v0 if id==2
		gen belief_l = eduB15v0 - se_eduB15v0 if id==2
		replace belief_u = eduB15v1 + se_eduB15v1 if id==3
		replace belief_l = eduB15v1 - se_eduB15v1 if id==3
		replace belief_u = eduB15v4 + se_eduB15v4 if id==4
		replace belief_l = eduB15v4 - se_eduB15v4 if id==4
		replace belief_u = eduB15v7 + se_eduB15v7 if id==5
		replace belief_l = eduB15v7 - se_eduB15v7 if id==5
		replace belief_u = eduB15v11 + se_eduB15v11 if id==6
		replace belief_l = eduB15v11 - se_eduB15v11 if id==6
		replace belief_u = eduB15v14 + se_eduB15v14 if id==7
		replace belief_l = eduB15v14 - se_eduB15v14 if id==7
		replace belief_u = eduB15v15 + se_eduB15v15 if id==8
		replace belief_l = eduB15v15 - se_eduB15v15 if id==8
		replace belief_u = belief_u / 100
		replace belief_l = belief_l / 100
		gen mean_string_b = string(belief, "%3.2f")

		twoway (connect edu id) (connect belief id, mlcolor(gs7)) ///
		       (rcap c_u c_l id, lcolor(black)) (rcap belief_u belief_l id, lcolor(gs7)) ///
			   (scatter edu id, msym(none) mlab(mean_string) mlabsize(medium) mlabpos(1) mlabcolor(black)) ///
			   (scatter belief id, msym(none) mlab(mean_string_b) mlabsize(medium) mlabpos(5) mlabcolor(black)), ///
			   xtitle("") xlabel(1.5 "." 2 "15 vs. 0" 3 "15 vs. 1" 4 "15 vs. 4" 5 "15 vs. 7" 6 "15 vs. 11" 7 "15 vs. 14" 8 "15 vs. 15" 8.5 ".", noticks) ///
			   scheme(s1mono) ytitle("Share Redistributed / Belief") ylabel(0(0.1)0.5, ang(0)) title("Vary-Education (n=193)") ///
			   legend(row(2) pos(4) ring(0) order(1 "Share redistributed to the disadvantaged worker" 2 "Belief about disadvantaged worker's winning probability"))

		Graph save Graph "$folder/data/temp/2.gph", replace
		
		use $folder/data/processed/spectator_vary.dta, clear
		
		keep if treatment=="empXX"

 ////////////////////////////////////////////////////////////VK
//			replace empB15v0 = 0 if empB15v0 ==.
//			replace empB15v1 = 0 if empB15v1 ==.
//			replace empB15v4 = 0 if empB15v4 ==.
//			replace empB15v7 = 0 if empB15v7 ==.
//			replace empB15v11 = 0 if empB15v11 ==.
//			replace empB15v14 = 0 if empB15v14 ==.
//			replace empB15v15 = 0 if empB15v15 ==.
////////////////////////////////////////////////////////////VK


		collapse emp15* empB15* (semean) se_emp15v0=emp15v0 (semean) se_emp15v1=emp15v1 (semean) se_emp15v4=emp15v4 ///
		(semean) se_emp15v7=emp15v7 (semean) se_emp15v11=emp15v11 (semean) se_emp15v14=emp15v14 (semean) se_emp15v15=emp15v15 ///
		(semean) se_empB15v0 = empB15v0 (semean) se_empB15v1 = empB15v1 (semean) se_empB15v4 = empB15v4 ///
		(semean) se_empB15v7 = empB15v7 (semean) se_empB15v11 = empB15v11 (semean) se_empB15v14 = empB15v14 ///
		(semean) se_empB15v15 = empB15v15

		save "$folder/data/temp/temp.dta", replace
		clear
		set obs 7
		gen id=_n + 1
		cross using "$folder/data/temp/temp.dta"
		gen emp = emp15v0 if id==2
		replace emp = emp15v1 if id==3
		replace emp = emp15v4 if id==4
		replace emp = emp15v7 if id==5
		replace emp = emp15v11 if id==6
		replace emp = emp15v14 if id==7
		replace emp = emp15v15 if id==8
		replace emp = emp / 6
		gen c_u = emp15v0 + se_emp15v0 if id==2
		gen c_l = emp15v0 - se_emp15v0 if id==2
		replace c_u = emp15v1 + se_emp15v1 if id==3
		replace c_l = emp15v1 - se_emp15v1 if id==3
		replace c_u = emp15v4 + se_emp15v4 if id==4
		replace c_l = emp15v4 - se_emp15v4 if id==4
		replace c_u = emp15v7 + se_emp15v7 if id==5
		replace c_l = emp15v7 - se_emp15v7 if id==5
		replace c_u = emp15v11 + se_emp15v11 if id==6
		replace c_l = emp15v11 - se_emp15v11 if id==6
		replace c_u = emp15v14 + se_emp15v14 if id==7
		replace c_l = emp15v14 - se_emp15v14 if id==7
		replace c_u = emp15v15 + se_emp15v15 if id==8
		replace c_l = emp15v15 - se_emp15v15 if id==8
		replace c_u = c_u / 6
		replace c_l = c_l / 6
		gen mean_string = string(emp, "%3.2f")

		gen belief = empB15v0 if id==2
		replace belief = empB15v1 if id==3
		replace belief = empB15v4 if id==4
		replace belief = empB15v7 if id==5
		replace belief = empB15v11 if id==6
		replace belief = empB15v14 if id==7
		replace belief = empB15v15 if id==8
		replace belief = belief / 100
		gen belief_u = empB15v0 + se_empB15v0 if id==2
		gen belief_l = empB15v0 - se_empB15v0 if id==2
		replace belief_u = empB15v1 + se_empB15v1 if id==3
		replace belief_l = empB15v1 - se_empB15v1 if id==3
		replace belief_u = empB15v4 + se_empB15v4 if id==4
		replace belief_l = empB15v4 - se_empB15v4 if id==4
		replace belief_u = empB15v7 + se_empB15v7 if id==5
		replace belief_l = empB15v7 - se_empB15v7 if id==5
		replace belief_u = empB15v11 + se_empB15v11 if id==6
		replace belief_l = empB15v11 - se_empB15v11 if id==6
		replace belief_u = empB15v14 + se_empB15v14 if id==7
		replace belief_l = empB15v14 - se_empB15v14 if id==7
		replace belief_u = empB15v15 + se_empB15v15 if id==8
		replace belief_l = empB15v15 - se_empB15v15 if id==8
		replace belief_u = belief_u / 100
		replace belief_l = belief_l / 100
		gen mean_string_b = string(belief, "%3.2f")

		twoway (connect emp id) (connect belief id, mlcolor(gs7)) ///
			   (rcap c_u c_l id, lcolor(black)) (rcap belief_u belief_l id, lcolor(gs7)) ///
			   (scatter emp id, msym(none) mlab(mean_string) mlabsize(medium) mlabpos(11) mlabcolor(black)) ///
			   (scatter belief id, msym(none) mlab(mean_string_b) mlabsize(medium) mlabpos(5) mlabcolor(black)), ///
			   xtitle("") xlabel(1.5 "." 2 "15 vs. 0" 3 "15 vs. 1" 4 "15 vs. 4" 5 "15 vs. 7" 6 "15 vs. 11" 7 "15 vs. 14" 8 "15 vs. 15" 8.5 ".", noticks) ///
			   scheme(s1mono) ytitle("Share Redistributed / Belief") ylabel(0(0.1)0.5, ang(0)) title("Vary-Employment (n=198)") ///
			   legend(row(2) pos(4) ring(0) order(1 "Share redistributed to the disadvantaged worker" 2 "Belief about disadvantaged worker's winning probability"))
	
		Graph save Graph "$folder/data/temp/3.gph", replace
		
		grc1leg2 "$folder/data/temp/1.gph""$folder/data/temp/2.gph""$folder/data/temp/3.gph", legendfrom($folder/data/temp/2.gph) ///
		scheme(s1mono) cols(1) lcols(1) pos(6) labsize(small) ytol1title xsize(1) ysize(2) scale(0.9)
		
		graph export $folder/output/figures/figure2.pdf, replace

		
*------------------------------------	
*-> Figure 3: Share redistributed  by meritocrats
*------------------------------------		
		
		use $folder/data/processed/spectator_vary.dta, clear
		
		*sum luck* edu15* emp15*
		
		keep if treatment=="luckXX"
		
		keep if luck00 < 3 & luck100 > 0
		
		collapse luck* (semean) se_luck100=luck100 (semean) se_luck99=luck99 (semean) se_luck90=luck90 ///
		(semean) se_luck50=luck50 (semean) se_luck10=luck10 (semean) se_luck01=luck01 (semean) se_luck00=luck00
		save "$folder/data/temp/temp.dta", replace
		clear
		set obs 7
		gen id=_n + 1
		cross using "$folder/data/temp/temp.dta"
		gen luck = luck100 if id==2
		replace luck = luck99 if id==3
		replace luck = luck90 if id==4
		replace luck = luck50 if id==5
		replace luck = luck10 if id==6
		replace luck = luck01 if id==7
		replace luck = luck00 if id==8
		replace luck = luck / 6
		gen c_u = luck100 + se_luck100 if id==2
		gen c_l = luck100 - se_luck100 if id==2
		replace c_u = luck99 + se_luck99 if id==3
		replace c_l = luck99 - se_luck99 if id==3
		replace c_u = luck90 + se_luck90 if id==4
		replace c_l = luck90 - se_luck90 if id==4
		replace c_u = luck50 + se_luck50 if id==5
		replace c_l = luck50 - se_luck50 if id==5
		replace c_u = luck10 + se_luck10 if id==6
		replace c_l = luck10 - se_luck10 if id==6
		replace c_u = luck01 + se_luck01 if id==7
		replace c_l = luck01 - se_luck01 if id==7
		replace c_u = luck00 + se_luck00 if id==8
		replace c_l = luck00 - se_luck00 if id==8
		replace c_u = c_u / 6
		replace c_l = c_l / 6
		gen mean_string = string(luck, "%3.2f")

		twoway (connect luck id)  ///
		       (rcap c_u c_l id, lcolor("black")) ///
			   (scatter luck id, msym(none) mlab(mean_string) mlabsize(medium) mlabpos(1) mlabcolor(black)), ///
			   xtitle("") xlabel(1.5 "." 2 "100% luck" 3 "99% luck" 4 "90% luck" 5 "50% luck" 6 "10% luck" 7 "1% luck" 8 "0% luck" 8.5 ".", noticks) ///
			   scheme(s1mono) ytitle("Share Redistributed") ylabel(0(0.1)0.5, ang(0)) title("Vary-Probability (n=170)") ///
			   legend(row(2) pos(4) ring(0) order(1 "Share redistributed to the disadvantaged worker" 2 "Belief about disadvantaged worker's winning probability"))

		Graph save Graph "$folder/data/temp/1.gph", replace
		
		use $folder/data/processed/spectator_vary.dta, clear
		
		*sum luck* edu15* emp15*
				
		keep if treatment=="eduXX"
		
		keep if edu15v15 < 3 & edu15v0 > 0

////////////////////////////////////////////////////////////VK
//		replace eduB15v0 = 0 if eduB15v0 ==.
//		replace eduB15v1 = 0 if eduB15v1 ==.
//		replace eduB15v4 = 0 if eduB15v4 ==.
//		replace eduB15v15 = 0 if eduB15v15 ==.
//		replace eduB15v7 = 0 if eduB15v7 ==.
//		replace eduB15v11 = 0 if eduB15v11 ==.
//		replace eduB15v14 = 0 if eduB15v14 ==.
////////////////////////////////////////////////////////////VK
		
		
		collapse edu15* eduB15* (semean) se_edu15v0=edu15v0 (semean) se_edu15v1=edu15v1 (semean) se_edu15v4=edu15v4 ///
		(semean) se_edu15v7=edu15v7 (semean) se_edu15v11=edu15v11 (semean) se_edu15v14=edu15v14 (semean) se_edu15v15=edu15v15 ///
		(semean) se_eduB15v0 = eduB15v0 (semean) se_eduB15v1 = eduB15v1 (semean) se_eduB15v4 = eduB15v4 ///
		(semean) se_eduB15v7 = eduB15v7 (semean) se_eduB15v11 = eduB15v11 (semean) se_eduB15v14 = eduB15v14 ///
		(semean) se_eduB15v15 = eduB15v15
		
		save "$folder/data/temp/temp.dta", replace
		clear
		set obs 7
		gen id=_n + 1
		cross using "$folder/data/temp/temp.dta"
		gen edu = edu15v0 if id==2
		replace edu = edu15v1 if id==3
		replace edu = edu15v4 if id==4
		replace edu = edu15v7 if id==5
		replace edu = edu15v11 if id==6
		replace edu = edu15v14 if id==7
		replace edu = edu15v15 if id==8
		replace edu = edu / 6
		gen c_u = edu15v0 + se_edu15v0 if id==2
		gen c_l = edu15v0 - se_edu15v0 if id==2
		replace c_u = edu15v1 + se_edu15v1 if id==3
		replace c_l = edu15v1 - se_edu15v1 if id==3
		replace c_u = edu15v4 + se_edu15v4 if id==4
		replace c_l = edu15v4 - se_edu15v4 if id==4
		replace c_u = edu15v7 + se_edu15v7 if id==5
		replace c_l = edu15v7 - se_edu15v7 if id==5
		replace c_u = edu15v11 + se_edu15v11 if id==6
		replace c_l = edu15v11 - se_edu15v11 if id==6
		replace c_u = edu15v14 + se_edu15v14 if id==7
		replace c_l = edu15v14 - se_edu15v14 if id==7
		replace c_u = edu15v15 + se_edu15v15 if id==8
		replace c_l = edu15v15 - se_edu15v15 if id==8
		replace c_u = c_u / 6
		replace c_l = c_l / 6
		gen mean_string = string(edu, "%3.2f")
		
		gen belief = eduB15v0 if id==2
		replace belief = eduB15v1 if id==3
		replace belief = eduB15v4 if id==4
		replace belief = eduB15v7 if id==5
		replace belief = eduB15v11 if id==6
		replace belief = eduB15v14 if id==7
		replace belief = eduB15v15 if id==8
		replace belief = belief / 100
		gen belief_u = eduB15v0 + se_eduB15v0 if id==2
		gen belief_l = eduB15v0 - se_eduB15v0 if id==2
		replace belief_u = eduB15v1 + se_eduB15v1 if id==3
		replace belief_l = eduB15v1 - se_eduB15v1 if id==3
		replace belief_u = eduB15v4 + se_eduB15v4 if id==4
		replace belief_l = eduB15v4 - se_eduB15v4 if id==4
		replace belief_u = eduB15v7 + se_eduB15v7 if id==5
		replace belief_l = eduB15v7 - se_eduB15v7 if id==5
		replace belief_u = eduB15v11 + se_eduB15v11 if id==6
		replace belief_l = eduB15v11 - se_eduB15v11 if id==6
		replace belief_u = eduB15v14 + se_eduB15v14 if id==7
		replace belief_l = eduB15v14 - se_eduB15v14 if id==7
		replace belief_u = eduB15v15 + se_eduB15v15 if id==8
		replace belief_l = eduB15v15 - se_eduB15v15 if id==8
		replace belief_u = belief_u / 100
		replace belief_l = belief_l / 100
		gen mean_string_b = string(belief, "%3.2f")

		twoway (connect edu id) (connect belief id, mlcolor(gs7)) ///
		       (rcap c_u c_l id, lcolor(black)) (rcap belief_u belief_l id, lcolor(gs7)) ///
			   (scatter edu id, msym(none) mlab(mean_string) mlabsize(medium) mlabpos(1) mlabcolor(black)) ///
			   (scatter belief id, msym(none) mlab(mean_string_b) mlabsize(medium) mlabpos(10) mlabcolor(black)), ///
			   xtitle("") xlabel(1.5 "." 2 "15 vs. 0" 3 "15 vs. 1" 4 "15 vs. 4" 5 "15 vs. 7" 6 "15 vs. 11" 7 "15 vs. 14" 8 "15 vs. 15" 8.5 ".", noticks) ///
			   scheme(s1mono) ytitle("Share Redistributed / Belief") ylabel(0(0.1)0.5, ang(0)) title("Vary-Education (n=82)") ///
			   legend(row(2) pos(4) ring(0) order(1 "Share redistributed to the disadvantaged worker" 2 "Belief about disadvantaged worker's winning probability"))

		Graph save Graph "$folder/data/temp/2.gph", replace
		
		use $folder/data/processed/spectator_vary.dta, clear
		
		keep if treatment=="empXX"
		
		keep if emp15v15 < 3 & emp15v0 > 0

////////////////////////////////////////////////////////////VK
//		replace empB15v0 = 0 if empB15v0 ==.
//		replace empB15v1 = 0 if empB15v1 ==.
//		replace empB15v4 = 0 if empB15v4 ==.
//		replace empB15v7 = 0 if empB15v7 ==.
//		replace empB15v11 = 0 if empB15v11 ==.
//		replace empB15v14 = 0 if empB15v14 ==.
//		replace empB15v15 = 0 if empB15v15 ==.
////////////////////////////////////////////////////////////VK


		collapse emp15* empB15* (semean) se_emp15v0=emp15v0 (semean) se_emp15v1=emp15v1 (semean) se_emp15v4=emp15v4 ///
		(semean) se_emp15v7=emp15v7 (semean) se_emp15v11=emp15v11 (semean) se_emp15v14=emp15v14 (semean) se_emp15v15=emp15v15 ///
		(semean) se_empB15v0 = empB15v0 (semean) se_empB15v1 = empB15v1 (semean) se_empB15v4 = empB15v4 ///
		(semean) se_empB15v7 = empB15v7 (semean) se_empB15v11 = empB15v11 (semean) se_empB15v14 = empB15v14 ///
		(semean) se_empB15v15 = empB15v15

		save "$folder/data/temp/temp.dta", replace
		clear
		set obs 7
		gen id=_n + 1
		cross using "$folder/data/temp/temp.dta"
		gen emp = emp15v0 if id==2
		replace emp = emp15v1 if id==3
		replace emp = emp15v4 if id==4
		replace emp = emp15v7 if id==5
		replace emp = emp15v11 if id==6
		replace emp = emp15v14 if id==7
		replace emp = emp15v15 if id==8
		replace emp = emp / 6
		gen c_u = emp15v0 + se_emp15v0 if id==2
		gen c_l = emp15v0 - se_emp15v0 if id==2
		replace c_u = emp15v1 + se_emp15v1 if id==3
		replace c_l = emp15v1 - se_emp15v1 if id==3
		replace c_u = emp15v4 + se_emp15v4 if id==4
		replace c_l = emp15v4 - se_emp15v4 if id==4
		replace c_u = emp15v7 + se_emp15v7 if id==5
		replace c_l = emp15v7 - se_emp15v7 if id==5
		replace c_u = emp15v11 + se_emp15v11 if id==6
		replace c_l = emp15v11 - se_emp15v11 if id==6
		replace c_u = emp15v14 + se_emp15v14 if id==7
		replace c_l = emp15v14 - se_emp15v14 if id==7
		replace c_u = emp15v15 + se_emp15v15 if id==8
		replace c_l = emp15v15 - se_emp15v15 if id==8
		replace c_u = c_u / 6
		replace c_l = c_l / 6
		gen mean_string = string(emp, "%3.2f")

		gen belief = empB15v0 if id==2
		replace belief = empB15v1 if id==3
		replace belief = empB15v4 if id==4
		replace belief = empB15v7 if id==5
		replace belief = empB15v11 if id==6
		replace belief = empB15v14 if id==7
		replace belief = empB15v15 if id==8
		replace belief = belief / 100
		gen belief_u = empB15v0 + se_empB15v0 if id==2
		gen belief_l = empB15v0 - se_empB15v0 if id==2
		replace belief_u = empB15v1 + se_empB15v1 if id==3
		replace belief_l = empB15v1 - se_empB15v1 if id==3
		replace belief_u = empB15v4 + se_empB15v4 if id==4
		replace belief_l = empB15v4 - se_empB15v4 if id==4
		replace belief_u = empB15v7 + se_empB15v7 if id==5
		replace belief_l = empB15v7 - se_empB15v7 if id==5
		replace belief_u = empB15v11 + se_empB15v11 if id==6
		replace belief_l = empB15v11 - se_empB15v11 if id==6
		replace belief_u = empB15v14 + se_empB15v14 if id==7
		replace belief_l = empB15v14 - se_empB15v14 if id==7
		replace belief_u = empB15v15 + se_empB15v15 if id==8
		replace belief_l = empB15v15 - se_empB15v15 if id==8
		replace belief_u = belief_u / 100
		replace belief_l = belief_l / 100
		gen mean_string_b = string(belief, "%3.2f")

		twoway (connect emp id) (connect belief id, mlcolor(gs7)) ///
			   (rcap c_u c_l id, lcolor(black)) (rcap belief_u belief_l id, lcolor(gs7)) ///
			   (scatter emp id, msym(none) mlab(mean_string) mlabsize(medium) mlabpos(1) mlabcolor(black)) ///
			   (scatter belief id, msym(none) mlab(mean_string_b) mlabsize(medium) mlabpos(5) mlabcolor(black)), ///
			   xtitle("") xlabel(1.5 "." 2 "15 vs. 0" 3 "15 vs. 1" 4 "15 vs. 4" 5 "15 vs. 7" 6 "15 vs. 11" 7 "15 vs. 14" 8 "15 vs. 15" 8.5 ".", noticks) ///
			   scheme(s1mono) ytitle("Share Redistributed / Belief") ylabel(0(0.1)0.5, ang(0)) title("Vary-Employment (n=56)") ///
			   legend(row(2) pos(4) ring(0) order(1 "Share redistributed to the disadvantaged worker" 2 "Belief about disadvantaged worker's winning probability"))
	
		Graph save Graph "$folder/data/temp/3.gph", replace
		
		grc1leg2 "$folder/data/temp/1.gph""$folder/data/temp/2.gph""$folder/data/temp/3.gph", legendfrom($folder/data/temp/2.gph) ///
		scheme(s1mono) cols(1) lcols(1) pos(6) labsize(small) ytol1title xsize(1) ysize(2) scale(0.9)

		graph export $folder/output/figures/figure3.pdf, replace

		
*------------------------------------	
*-> Figure A3: Distribution of share (labels manually added)
*------------------------------------	
		use $folder/data/processed/spectator_vary.dta, clear
		
		keep if treatment == "luckXX"
		
		save "$folder/data/temp/temp.dta", replace
		
		clear
		set obs 7
		gen id=_n
		cross using "$folder/data/temp/temp.dta"
		
		gen temp1 = luck100 if id==1
		replace temp1 = luck99 if id==2
		replace temp1 = luck90 if id==3
		replace temp1 = luck50 if id==4
		replace temp1 = luck10 if id==5
		replace temp1 = luck01 if id==6
		replace temp1 = luck00 if id==7
				
		hist temp1, ///
			discrete frac xlabel(0(1)6) ///
			by(id,col(1) title("Vary-Probability") note("")) scheme(s1mono) ///
			ytitle(Fraction) ylabel(0(0.2)0.8) ///
			xtitle(Distribution) ///
			xlabel(0 "(0,6)" 1 "(1,5)" 2 "(2,4)" 3"(3,3)" 4"(4,2)" 5"(5,1)" 6"(6,0)", ang(90)) ///
			xsize(1) ysize(4) 
	
		Graph save Graph "$folder/data/temp/1.gph", replace
	

		use $folder/data/processed/spectator_vary.dta, clear
		
		keep if treatment == "eduXX"
		
		save "$folder/data/temp/temp.dta", replace
		
		clear
		set obs 7
		gen id=_n
		cross using "$folder/data/temp/temp.dta"
		
		gen temp1 = edu15v0 if id==1
		replace temp1 = edu15v1 if id==2
		replace temp1 = edu15v4 if id==3
		replace temp1 = edu15v7 if id==4
		replace temp1 = edu15v11 if id==5
		replace temp1 = edu15v14 if id==6
		replace temp1 = edu15v15 if id==7
		
		hist temp1, ///
			discrete frac xlabel(0(1)6) ///
			by(id,col(1) title("Vary-Education") note("")) scheme(s1mono) ///
			ytitle(Fraction) ylabel(0(0.2)0.8) ///
			xtitle(Distribution) ///
			xlabel(0 "(0,6)" 1 "(1,5)" 2 "(2,4)" 3"(3,3)" 4"(4,2)" 5"(5,1)" 6"(6,0)", ang(90)) ///
			xsize(1) ysize(4) 
	
		Graph save Graph "$folder/data/temp/2.gph", replace
		
		
		use $folder/data/processed/spectator_vary.dta, clear
		
		keep if treatment == "empXX"
		
		save "$folder/data/temp/temp.dta", replace
		
		clear
		set obs 7
		gen id=_n
		cross using "$folder/data/temp/temp.dta"
		
		gen temp1 = emp15v0 if id==1
		replace temp1 = emp15v1 if id==2
		replace temp1 = emp15v4 if id==3
		replace temp1 = emp15v7 if id==4
		replace temp1 = emp15v11 if id==5
		replace temp1 = emp15v14 if id==6
		replace temp1 = emp15v15 if id==7
		
		hist temp1, ///
			discrete frac xlabel(0(1)6) ///
			by(id,col(1) title("Vary-Employment") note("")) scheme(s1mono) ///
			ytitle(Fraction) ylabel(0(0.2)0.8) ///
			xtitle(Distribution) ///
			xlabel(0 "(0,6)" 1 "(1,5)" 2 "(2,4)" 3"(3,3)" 4"(4,2)" 5"(5,1)" 6"(6,0)", ang(90)) ///
			xsize(1) ysize(4) 
	
		Graph save Graph "$folder/data/temp/3.gph", replace
		
		graph combine "$folder/data/temp/1.gph""$folder/data/temp/2.gph""$folder/data/temp/3.gph", ///
		scheme(s1mono) cols(3) xsize(3) ysize(4)

		graph export $folder/output/figures/figureA3.pdf, replace

		
*------------------------------------	
*-> Table A6: Balance table 
*------------------------------------			
		
		use $folder/data/processed/spectator_vary.dta, clear
		matrix drop _all
		foreach treatment in eduXX empXX luckXX {
		quietly {
			summarize female1 if treatment == "`treatment'"
			 scalar female1 = r(mean)
			 summarize age1 if treatment == "`treatment'"
			 scalar age1 = r(mean) 
			 summarize highEdu if treatment == "`treatment'"
			 scalar highEdu = r(mean)
			 summarize income1 if treatment == "`treatment'"
			 scalar income1 = r(mean)
			 summarize conservative if treatment == "`treatment'"
			 scalar conservative = r(mean)
			 matrix results`treatment' = female1, age1, highEdu, income1, conservative,r(N)
		}
		}
		
		
		matrix result_table = resultsluckXX', resultseduXX', resultsempXX'
		matrix colnames result_table = v-prob v-educ v-emp
		matrix rownames result_table = female age_years high_education individual_yearly_income conservative obs
	
		matrix list result_table, format(%9.3f)
		esttab matrix(result_table) using $folder/output/tables/tableA6.tex, replace b(%6.3f) se star(* 0.10 ** 0.05 *** 0.01) booktabs

*------------------------------------	
*-> Table A7 & A8: regression analysis
*------------------------------------			

		use $folder/data/processed/spectator_vary.dta, clear
		save "$folder/data/temp/temp.dta", replace

		clear
		set obs 7
		gen id=_n
		cross using "$folder/data/temp/temp.dta"
		gen luck = luck100 if id==1
		replace luck = luck99 if id==2
		replace luck = luck90 if id==3
		replace luck = luck50 if id==4
		replace luck = luck10 if id==5
		replace luck = luck01 if id==6
		replace luck = luck00 if id==7
		replace luck = luck / 6
		gen edu2 = edu15v0 if id==1
		replace edu2 = edu15v1 if id==2
		replace edu2 = edu15v4 if id==3
		replace edu2 = edu15v7 if id==4
		replace edu2 = edu15v11 if id==5
		replace edu2 = edu15v14 if id==6
		replace edu2 = edu15v15 if id==7
		replace edu2 = edu2 / 6
		gen emp = emp15v0 if id==1
		replace emp = emp15v1 if id==2
		replace emp = emp15v4 if id==3
		replace emp = emp15v7 if id==4
		replace emp = emp15v11 if id==5
		replace emp = emp15v14 if id==6
		replace emp = emp15v15 if id==7
		replace emp = emp / 6
		
		// run this code for Table A7
		eststo: reg luck i.id if treatment=="luckXX", cluster(connectID)
		eststo: reg edu2 i.id if treatment=="eduXX", cluster(connectID)
		eststo: reg emp i.id if treatment=="empXX", cluster(connectID)
		esttab, b(%6.3f) se star(* 0.10 ** 0.05 *** 0.01) brackets
		esttab using $folder/output/tables/tableA7.tex, replace b(%6.3f) se star(* 0.10 ** 0.05 *** 0.01) booktabs
		eststo clear 
		
		//run this code for Table A8
		eststo: reg luck i.id if treatment=="luckXX" & luck00 < 3, cluster(connectID)
		eststo: reg edu2 i.id if treatment=="eduXX" & edu15v15 < 3, cluster(connectID)
		eststo: reg emp i.id if treatment=="empXX" & emp15v15 < 3, cluster(connectID)
		esttab, b(%6.3f) se star(* 0.10 ** 0.05 *** 0.01) brackets
		esttab using $folder/output/tables/tableA8.tex, replace b(%6.3f) se star(* 0.10 ** 0.05 *** 0.01) booktabs
		eststo clear 
		
		
		log close
		
		



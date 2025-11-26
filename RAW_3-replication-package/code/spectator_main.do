		
		
		log using $folder/code/log_2spectator_main, replace
*------------------------------------	
*-> Table 2: Balance table 
*------------------------------------			
		
		use $folder/data/processed/spectator_main.dta, clear
		keep if inlist(treatment, "1luck", "2merit", "3edu", "4emp")
		
		matrix drop _all
		foreach treatment in 1luck 2merit 3edu 4emp {
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
		
		
		matrix result_table = results1luck', results2merit', results3edu', results4emp'
		matrix colnames result_table = luck merit random-education random-employment
		matrix rownames result_table = female age_years high_education individual_yearly_income conservative obs
	
		matrix list result_table, format(%9.3f)
		
		esttab matrix(result_table) using $folder/output/tables/table2.tex , replace b(%9.3f)
		
		
	
		

*------------------------------------	
*-> Figure 1: Share redistributed 
*------------------------------------		
		use $folder/data/processed/spectator_main.dta, clear
		gen no = _n
		
		gen temp0 = redistribution/6
		collapse y = temp0 (semean) b = temp0, by(treatment)
		gen temp1 = 1 if treatment == "1luck"
		replace temp1 = 2 if treatment == "2merit"
		replace temp1 = 3 if treatment == "3edu"
		replace temp1 = 4 if treatment == "4emp"
		gen x = 2*temp1 -1
		gen y_u = y + b
		gen y_l = y - b
		gen mean_string = string(y, "%3.2f")
	
		twoway (bar y x) ///
			(rcap y_u y_l x,lcolor("black")) ///
			(scatter y x, msym(none) mlab(mean_string) mlabsize(mediumlarge) mlabpos(1) mlabcolor(black)), ///
			ytitle("Share Redistributed",margin(small)) ///
			ylabel(0(0.1)0.5) ///
			xlabel(1 "Luck" 3 "Merit" 5 "Random-Education" 7"Random-Employment" 8 ".", notick) ///
			xtitle("") scheme(s1mono) legend(off) scale(0.9)
		
		graph export $folder/output/figures/figure1.pdf, replace
		
*------------------------------------	
*-> Figure A1: Distribution of share (labels manually added)
*------------------------------------	

		use $folder/data/processed/spectator_main.dta, clear
		gen no = _n
		gen temp0 = redistribution
		gen temp1 = 1 if treatment == "1luck"
		replace temp1 = 4 if treatment == "2merit"
		replace temp1 = 2 if treatment == "3edu"
		replace temp1 = 5 if treatment == "4emp"
		hist temp0, ///
			discrete frac xlabel(0(1)6) ///
			by(temp1,col(2) note("")) scheme(s1mono) ///
			ytitle(Fraction) ylabel(0(0.2)0.8) ///
			xtitle(Distribution) ///
			xlabel(0 "(0,6)" 1 "(1,5)" 2 "(2,4)" 3"(3,3)" 4"(4,2)" 5"(5,1)" 6"(6,0)", ang(90)) ///
			xsize(3) ysize(3)
		
		graph export $folder/output/figures/figureA1.pdf, replace

	

*------------------------------------	
*-> Figure A2: Share redistributed for subgroups
*------------------------------------		
		
		use $folder/data/processed/spectator_main.dta, clear
		gen no = _n
				
		gen temp0 = redistribution/6
		collapse y = temp0 (semean) b = temp0, by(treatment female)
		gen temp1 = 1 if treatment == "1luck"
		replace temp1 = 2 if treatment == "2merit"
		replace temp1 = 3 if treatment == "3edu"
		replace temp1 = 4 if treatment == "4emp"
		gen x1 = 3*temp1 - 0.6
		gen x2 = 3*temp1 + 0.6
		gen y_u = y + b
		gen y_l = y - b
			gen mean_string = string(y, "%3.2f")

	twoway (bar y x1 if female1==0, bcol(gs2)) ///
		    (bar y x2 if female1==1, bcol(gs12)) ///
			(rcap y_u y_l x1 if female1==0,lcolor("black")) ///
			(rcap y_u y_l x2 if female1==1,lcolor("black")) ///
			(scatter y x1 if female1==0, msym(none) mlab(mean_string) mlabsize(mediumlarge) mlabpos(1) mlabcolor(black)) ///
			(scatter y x2 if female1==1, msym(none) mlab(mean_string) mlabsize(mediumlarge) mlabpos(1) mlabcolor(black)), ///
			ytitle("Share Redistributed",margin(small)) ///
			ylabel(0(0.1)0.5) ///
			xlabel(3 "Luck" 6 "Merit" 9 "Random-Education" 12 "Random-Employment") ///
			xtitle("") scheme(s1mono) legend(order(1 "Male" 2 "Female") ring(0) pos(12)) xsize(2.5) ysize(1) title("Gender") scale(1.3)
		
		Graph save Graph "$folder/data/temp/1.gph", replace
			
		use $folder/data/processed/spectator_main.dta, clear
		gen no = _n
		
		gen temp0 = redistribution/6
		collapse y = temp0 (semean) b = temp0, by(treatment highEdu)
		gen temp1 = 1 if treatment == "1luck"
		replace temp1 = 2 if treatment == "2merit"
		replace temp1 = 3 if treatment == "3edu"
		replace temp1 = 4 if treatment == "4emp"
		gen x1 = 3*temp1 - 0.6
		gen x2 = 3*temp1 + 0.6
		gen y_u = y + b
		gen y_l = y - b
			gen mean_string = string(y, "%3.2f")

		twoway (bar y x1 if highEdu==0, bcol(gs2)) ///
		    (bar y x2 if highEdu==1, bcol(gs12)) ///
			(rcap y_u y_l x1 if highEdu==0,lcolor("black")) ///
			(rcap y_u y_l x2 if highEdu==1,lcolor("black")) ///
			(scatter y x1 if highEdu==0, msym(none) mlab(mean_string) mlabsize(mediumlarge) mlabpos(1) mlabcolor(black)) ///
			(scatter y x2 if highEdu==1, msym(none) mlab(mean_string) mlabsize(mediumlarge) mlabpos(1) mlabcolor(black)), ///
			ytitle("Share Redistributed",margin(small)) ///
			ylabel(0(0.1)0.5) ///
			xlabel(3 "Luck" 6 "Merit" 9 "Random-Education" 12 "Random-Employment" ) ///
			xtitle("") scheme(s1mono) legend(order(1 "Low education" 2 "High education") ring(0) pos(12)) xsize(2.5) ysize(1) title("Education") scale(1.3)
		
		Graph save Graph "$folder/data/temp/2.gph", replace

		use $folder/data/processed/spectator_main.dta, clear
		gen no = _n
		gen temp0 = redistribution/6
		collapse y = temp0 (semean) b = temp0, by(treatment highIncome)
		gen temp1 = 1 if treatment == "1luck"
		replace temp1 = 2 if treatment == "2merit"
		replace temp1 = 3 if treatment == "3edu"
		replace temp1 = 4 if treatment == "4emp"
		gen x1 = 3*temp1 - 0.6
		gen x2 = 3*temp1 + 0.6
		gen y_u = y + b
		gen y_l = y - b
			gen mean_string = string(y, "%3.2f")

		twoway (bar y x1 if highIncome==0, bcol(gs2)) ///
		    (bar y x2 if highIncome==1, bcol(gs12)) ///
			(rcap y_u y_l x1 if highIncome==0,lcolor("black")) ///
			(rcap y_u y_l x2 if highIncome==1,lcolor("black")) ///
			(scatter y x1 if highIncome==0, msym(none) mlab(mean_string) mlabsize(mediumlarge) mlabpos(1) mlabcolor(black)) ///
			(scatter y x2 if highIncome==1, msym(none) mlab(mean_string) mlabsize(mediumlarge) mlabpos(1) mlabcolor(black)), ///
			ytitle("Share Redistributed",margin(small)) ///
			ylabel(0(0.1)0.5) ///
			xlabel(3 "Luck" 6 "Merit" 9 "Random-Education" 12 "Random-Employment" ) ///
			xtitle("") scheme(s1mono) legend(order(1 "Low income" 2 "High income") ring(0) pos(12)) xsize(2.5) ysize(1) title("Income") scale(1.3)
		
		Graph save Graph "$folder/data/temp/3.gph", replace
		
		use $folder/data/processed/spectator_main.dta, clear
		gen no = _n
		gen temp0 = redistribution/6
		collapse y = temp0 (semean) b = temp0, by(treatment conservative)
		gen temp1 = 1 if treatment == "1luck"
		replace temp1 = 2 if treatment == "2merit"
		replace temp1 = 3 if treatment == "3edu"
		replace temp1 = 4 if treatment == "4emp"
		gen x1 = 3*temp1 - 0.6
		gen x2 = 3*temp1 + 0.6
		gen y_u = y + b
		gen y_l = y - b
	
////////////////////////////////////////////////////////////VK	
// label markers added
////////////////////////////////////////////////////////////VK	

		gen mean_string = string(y, "%3.2f")
		
		twoway (bar y x1 if conservative==0, bcol(gs2)) ///
		    (bar y x2 if conservative==1, bcol(gs12)) ///
			(rcap y_u y_l x1 if conservative==0,lcolor("black")) ///
			(rcap y_u y_l x2 if conservative==1,lcolor("black")) ///
			(scatter y x1 if conservative==0, msym(none) mlab(mean_string) mlabsize(mediumlarge) mlabpos(1) mlabcolor(black)) ///
			(scatter y x2 if conservative==1, msym(none) mlab(mean_string) mlabsize(mediumlarge) mlabpos(1) mlabcolor(black)), ///
			ytitle("Share Redistributed",margin(small)) ///
			ylabel(0(0.1)0.5) ///
			xlabel(3 "Luck" 6 "Merit" 9 "Random-Education" 12 "Random-Employment" ) ///
			xtitle("") scheme(s1mono) legend(order(1 "Non-conservative" 2 "Conservative") ring(0) pos(12)) xsize(2.5) ysize(1) title("Political") scale(1.3)
		
		Graph save Graph "$folder/data/temp/4.gph", replace
		
		graph combine "$folder/data/temp/1.gph""$folder/data/temp/2.gph""$folder/data/temp/3.gph""$folder/data/temp/4.gph", ///
		scheme(s1mono) cols(1) xsize(1) ysize(2) scale(0.6)
		
		graph export $folder/output/figures/figureA2.pdf, replace


		
*------------------------------------	
*-> Table A1: regression analysis
*------------------------------------			

		use $folder/data/processed/spectator_main.dta, clear

		egen temp1 = group(treatment)
		gen luck2 = (temp1==1)
		gen merit2 = (temp1==2)
		gen rEdu = (temp1==3)
		gen rEm = (temp1==4)

		gen temp0 = redistribution/6
		
		keep if temp1 <= 4

		eststo: reg temp0 merit2 rEdu rEm, vce(robust)
		test merit2 = rEdu
		test merit2 = rEm
		test rEdu = rEm
		eststo: reg temp0 merit2 rEdu rEm female1 age1 highEdu highIncome conservative, vce(robust)
		test merit2 = rEdu
		test merit2 = rEm
		test rEdu = rEm
		esttab, b(%6.3f) se star(* 0.10 ** 0.05 *** 0.01) brackets
		esttab using $folder/output/tables/tableA1.tex, replace b(%6.3f) se star(* 0.10 ** 0.05 *** 0.01) booktabs
		eststo clear 

		
*------------------------------------	
*-> Table A2: regression analysis, multiple hypothesis test
*------------------------------------			

		use $folder/data/processed/spectator_main.dta, clear

		egen temp1 = group(treatment)
		gen luck2 = (temp1==1)
		gen merit2 = (temp1==2)
		gen rEdu = (temp1==3)
		gen rEm = (temp1==4)

		gen temp0 = redistribution/6
		
		keep if temp1 <= 4

		gen no = _n
		
		//ssc install mhtreg
		//ssc install moremata
		
		mhtreg (temp0 merit2 rEdu rEm) ///
				(temp0 rEdu merit2 rEm ) ///
				(temp0 rEm merit2 rEdu ) ///
				(temp0 rEdu luck2 rEm ) ///
				(temp0 rEm luck2 rEdu ) ///
				(temp0 rEdu merit2 luck2 ) ///
				, cluster(no) robust seed($seed)		
		
				
*------------------------------------	
*-> Table A3: heterogeneity analysis, multiple hypothesis test
*------------------------------------			
		
		use $folder/data/processed/spectator_main.dta, clear

		egen temp1 = group(treatment)
		gen luck2 = (temp1==1)
		gen merit2 = (temp1==2)
		gen rEdu = (temp1==3)
		gen rEm = (temp1==4)

		gen temp0 = redistribution/6
		
		keep if temp1 <= 4

		gen no = _n
		mhtreg (temp0 female1 merit2 rEdu rEm  age1 highEdu highIncome conservative) ///
				(temp0 highEdu merit2 rEdu rEm female1 age1  highIncome conservative) ///
				(temp0 highIncome merit2 rEdu rEm female1 age1 highEdu  conservative) ///
				(temp0 conservative merit2 rEdu rEm female1 age1 highEdu highIncome ) ///
				, cluster(no) robust seed($seed)

*------------------------------------	
*-> Table A4: Heterogeneity analysis 
*------------------------------------		

		use $folder/data/processed/spectator_main.dta, clear

		gen temp0 = redistribution/6
		egen temp1 = group(treatment)
		gen luck2 = (temp1==1)
		gen merit2 = (temp1==2)
		gen rEdu = (temp1==3)
		gen rEm = (temp1==4)
		
		keep if temp1 <= 4

		gen merit_female = merit2 * female1
		gen rEdu_female = rEdu * female1
		gen rEm_female = rEm * female1

		gen merit_highEdu = merit2 * highEdu
		gen rEdu_highEdu = rEdu * highEdu
		gen rEm_highEdu = rEm * highEdu

		gen merit_highIncome = merit2 * highIncome
		gen rEdu_highIncome = rEdu * highIncome
		gen rEm_highIncome = rEm * highIncome
		
		gen merit_conservative = merit2 * conservative
		gen rEdu_conservative = rEdu * conservative
		gen rEm_conservative = rEm * conservative

		eststo: reg temp0 merit2 rEdu rEm merit_female rEdu_female rEm_female female1, vce(robust)
		lincom merit2 + merit_female
		lincom rEdu + rEdu_female
		lincom rEm + rEm_female

		eststo: reg temp0 merit2 rEdu rEm merit_highEdu rEdu_highEdu rEm_highEdu highEdu, vce(robust)
		lincom merit2 + merit_highEdu
		lincom rEdu + rEdu_highEdu
		lincom rEm + rEm_highEdu

		eststo: reg temp0 merit2 rEdu rEm merit_highIncome rEdu_highIncome rEm_highIncome highIncome, vce(robust)
		lincom merit2 + merit_highIncome
		lincom rEdu + rEdu_highIncome
		lincom rEm + rEm_highIncome

		eststo: reg temp0 merit2 rEdu rEm merit_conservative rEdu_conservative rEm_conservative conservative, vce(robust)
		lincom merit2 + merit_conservative
		lincom rEdu + rEdu_conservative
		lincom rEm + rEm_conservative

		esttab, b(%6.3f) se star(* 0.10 ** 0.05 *** 0.01) brackets
		esttab using $folder/output/tables/tableA4.tex, replace b(%6.3f) se star(* 0.10 ** 0.05 *** 0.01) booktabs
		eststo clear	
*------------------------------------	
*-> Table A5: heterogeneity analysis, multiple hypothesis test
*------------------------------------			
		
		use $folder/data/processed/spectator_main.dta, clear

		egen temp1 = group(treatment)
		gen luck2 = (temp1==1)
		gen merit2 = (temp1==2)
		gen rEdu = (temp1==3)
		gen rEm = (temp1==4)

		gen temp0 = redistribution/6
		
		keep if temp1 <= 4
	
		gen no = _n

		mhtreg (temp0 merit2 rEdu rEm if female1==1) ///
		(temp0 rEdu merit2 rEm if female1==1) ///
		(temp0 rEm merit2 rEdu if female1==1) ///
		(temp0 rEdu luck2 rEm if female1==1) ///
		(temp0 rEm luck2 rEdu if female1==1) ///
		(temp0 rEdu merit2 luck2 if female1==1) ///
		(temp0 merit2 rEdu rEm if female1==0) ///
		(temp0 rEdu merit2 rEm if female1==0) ///
		(temp0 rEm merit2 rEdu if female1==0) ///
		(temp0 rEdu luck2 rEm if female1==0) ///
		(temp0 rEm luck2 rEdu if female1==0) ///
		(temp0 rEdu merit2 luck2 if female1==0) ///
		(temp0 merit2 rEdu rEm if highEdu==1) ///
		(temp0 rEdu merit2 rEm if highEdu==1) ///
		(temp0 rEm merit2 rEdu if highEdu==1) ///
		(temp0 rEdu luck2 rEm if highEdu==1) ///
		(temp0 rEm luck2 rEdu if highEdu==1) ///
		(temp0 rEdu merit2 luck2 if highEdu==1) ///
		(temp0 merit2 rEdu rEm if highEdu==0) ///
		(temp0 rEdu merit2 rEm if highEdu==0) ///
		(temp0 rEm merit2 rEdu if highEdu==0) ///
		(temp0 rEdu luck2 rEm  if highEdu==0) ///
		(temp0 rEm luck2 rEdu if highEdu==0) ///
		(temp0 rEdu merit2 luck2 if highEdu==0) ///
		(temp0 merit2 rEdu rEm if highIncome==1) ///
		(temp0 rEdu merit2 rEm if highIncome==1) ///
		(temp0 rEm merit2 rEdu if highIncome==1) ///
		(temp0 rEdu luck2 rEm if highIncome==1) ///
		(temp0 rEm luck2 rEdu if highIncome==1) ///
		(temp0 rEdu merit2 luck2 if highIncome==1) ///
		(temp0 merit2 rEdu rEm if highIncome==0) ///
		(temp0 rEdu merit2 rEm if highIncome==0) ///
		(temp0 rEm merit2 rEdu if highIncome==0) ///
		(temp0 rEdu luck2 rEm if highIncome==0) ///
		(temp0 rEm luck2 rEdu if highIncome==0) ///
		(temp0 rEdu merit2 luck2 if highIncome==0) ///
		(temp0 merit2 rEdu rEm if conservative==1) ///
		(temp0 rEdu merit2 rEm if conservative==1) ///
		(temp0 rEm merit2 rEdu if conservative==1) ///
		(temp0 rEdu luck2 rEm if conservative==1) ///
		(temp0 rEm luck2 rEdu if conservative==1) ///
		(temp0 rEdu merit2 luck2 if conservative==1) ///
		(temp0 merit2 rEdu rEm if conservative==0) ///
		(temp0 rEdu merit2 rEm if conservative==0) ///
		(temp0 rEm merit2 rEdu if conservative==0) ///
		(temp0 rEdu luck2 rEm if conservative==0) ///
		(temp0 rEm luck2 rEdu if conservative==0) ///
		(temp0 rEdu merit2 luck2 if conservative==0) ///
		, cluster(no) robust seed($seed)
			



*------------------------------------	
*-> Table B1: Information effect
*------------------------------------	

		use $folder/data/processed/spectator_main.dta, clear

		egen temp1 = group(treatment)
		gen rEdu = (temp1==3)
		gen rEm = (temp1==4)
		gen infoEdu = (temp1==5)
		gen infoEm = (temp1==6)
		keep if temp1 > 2
		gen temp0 = redistribution/6

		gen isTick = (tickYN_educ == "Go to the 3-digit code task to try to learn the information")
		replace isTick = 1 if tickYN_employ == "Go to the 3-digit code task to try to learn the information"
		gen uninform = (tickNum < 20 & infoEdu==1)
		replace uninform = 1 if tickNum < 20 & infoEm==1

		bys treatment: sum isTick uninform


		eststo: reg temp0 infoEdu uninform if rEdu==1 | infoEdu==1, vce(robust)
		eststo: reg temp0 infoEdu uninform female1 age1 highEdu highIncome conservative if rEdu==1 | infoEdu==1, vce(robust)
		eststo: reg temp0 infoEm uninform if rEm==1 | infoEm==1, vce(robust)
		eststo: reg temp0 infoEm uninform female1 age1 highEdu highIncome conservative if rEm==1 | infoEm==1, vce(robust)
		esttab, b(%6.3f) se star(* 0.10 ** 0.05 *** 0.01) brackets
		esttab using $folder/output/tables/tableB1.tex, replace b(%6.3f) se star(* 0.10 ** 0.05 *** 0.01) booktabs
		eststo clear

*------------------------------------	
*-> Table B2: Information effect, multiple hypothesis test
*------------------------------------	
		use $folder/data/processed/spectator_main.dta, clear

		egen temp1 = group(treatment)
		gen rEdu = (temp1==3)
		gen rEm = (temp1==4)
		gen infoEdu = (temp1==5)
		gen infoEm = (temp1==6)
		keep if temp1 > 2
		gen temp0 = redistribution/6
		
		gen inform = (tickNum >= 20)
		replace inform = 0 if rEdu==1 | rEm==1
		
		gen uninform = (tickNum < 20 & infoEdu==1)
		replace uninform = 1 if tickNum < 20 & infoEm==1
		
		gen no = _n

		mhtreg (temp0 inform uninform if rEdu==1 | infoEdu==1) ///
		(temp0 uninform inform if rEdu==1 | infoEdu==1) ///
		(temp0 inform uninform if rEm==1 | infoEm==1) ///
		(temp0 uninform inform if rEm==1 | infoEm==1) ///
		, cluster(no) robust seed($seed)



		log close


		
		log using $folder/code/log_2worker_main, replace	
		
		
		
		
*---------------------------------------------------------------		
*-> Figure 4: Rating of factors contributing to socio-economic inequality
*---------------------------------------------------------------		
	use $folder/data/processed/worker_main.dta, clear
	
	keep q171*
	gen i = _n 
	reshape long q171_, i(i) j(j)
	destring q171_, replace
	

	collapse (mean) y = q171_ (semean) b = q171_, by(j)	
		gen x = 2*j - 1
		gen y_u = y + b
		gen y_l = y - b
		gen mean_string = string(y, "%3.2f")

	twoway (bar y x) ///
			(rcap y_u y_l x,lcolor("black") ) ///
			(scatter y x, msym(none) mlab(mean_string) mlabsize(mediumlarge) mlabpos(1) mlabcolor(black)), ///
			ytitle("Rating",margin(small) size(large)) ///
			ylabel(0(2)10, labsize(large) ang(0)) ///
			xlabel(1 "Education" 3 "Job" 5 "Effort" 7 "Luck" 9 "Inherit", labsize(large) notick ang(0)) ///
			xtitle("") scheme(s1mono) legend(off) ///
			xsize(4.5) ysize(3)
	
	graph export $folder/output/figures/figure4.pdf, replace	

*------------------------------------	
*-> Table C1
*   Note: "IE": Info-Department
*	      "IO": Info-Training
*	      "ME": Merit-Department
*	      "MO": Merit-Training
*	      "RE": Random-Department
*	      "RO": Random-Training
*------------------------------------	
		use $folder/data/processed/worker_main.dta, clear
	
	matrix drop _all
		foreach treatment in IE IO ME MO RE RO {
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
		
		
		matrix result_table = resultsMO', resultsRO',  resultsME', resultsRE', resultsIO', resultsIE'
		matrix colnames result_table = Merit-Training Random-Training Merit-Department Random-Department Info-Training Info-Department
		matrix rownames result_table = female age_years high_education individual_yearly_income conservative obs
	
		matrix list result_table, format(%9.3f)
		esttab matrix(result_table) using $folder/output/tables/tableC1.tex , replace b(%9.3f)
*------------------------------------	
*-> Figure C1: Share redistributed 
*------------------------------------		
		
		use $folder/data/processed/worker_main.dta, clear
		gen no = _n
		
		*keep if age == "18 to 22" |age == "23 to 29" |age == "30 to 39" 
		
		gen temp0 = redistribution/6
		collapse y = temp0 (semean) b = temp0, by(treatment)
		gen temp1 = 1 if treatment == "MO"
		replace temp1 = 2 if treatment == "RO"
		replace temp1 = 3 if treatment == "ME"
		replace temp1 = 4 if treatment == "RE"
		gen x = 2*temp1 -1
		gen y_u = y + b
		gen y_l = y - b
		gen mean_string = string(y, "%3.2f")
	
		twoway (bar y x) ///
			(rcap y_u y_l x,lcolor("black")) ///
			(scatter y x, msym(none) mlab(mean_string) mlabsize(mediumlarge) mlabpos(1) mlabcolor(black)), ///
			ytitle("Share Redistributed",margin(small)) ///
			ylabel(0(0.1)0.5) ///
			xlabel(1 "Merit-Training" 3 "Random-Traininig" 5 "Merit-Department" 7"Random-Department") ///
			xtitle("") scheme(s1mono) legend(off) scale(0.9)
		
		graph export $folder/output/figures/figureC1.pdf, replace
		
		
*------------------------------------	
*-> Figure C2: Distribution of share (labels manually added)
*------------------------------------	
	use $folder/data/processed/worker_main.dta, clear
	gen no = _n
	gen temp0 = redistribution
	gen temp1 = 1 if treatment == "MO"
	replace temp1 = 2 if treatment == "RO"
	replace temp1 = 3 if treatment == "ME"
	replace temp1 = 4 if treatment == "RE"
	hist temp0, ///
		discrete frac xlabel(0(1)6) ///
		by(temp1,col(2) note("")) scheme(s1mono) ///
		ytitle(Fraction) ylabel(0(0.2)0.8) ///
		xtitle(Distribution) ///
		xlabel(0 "(0,6)" 1 "(1,5)" 2 "(2,4)" 3"(3,3)" 4"(4,2)" 5"(5,1)" 6"(6,0)", ang(90)) ///
		xsize(2) ysize(2)
	
	graph export $folder/output/figures/figureC2.pdf, replace
	
	
*---------------------------------------------------------------		
*-> Figure C3: Distribution of information-seeking rate (labels manually added)
*---------------------------------------------------------------		
	use $folder/data/processed/worker_main.dta, clear
	gen no = _n
	gen temp0 = rate
	gen temp1 = 1 if treatment == "IO"
	replace temp1 = 2 if treatment == "IE"
	hist temp0, ///
		discrete frac xlabel(0(1)6) ///
		by(temp1,col(2) note("")) scheme(s1mono) ///
		ytitle(Fraction) ylabel(0(0.1)0.4) ///
		xtitle(Distribution) ///
		xlabel(0 "0%" 20 "0-20%" 40 "20-40%" 60 "40-60%" 80 "60-80%" 100 "80-100%", ang(90)) 
	
	graph export $folder/output/figures/figureC3.pdf, replace

	log close

	

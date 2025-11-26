////////////////////////////////////////////////////////////VK
cap log close
////////////////////////////////////////////////////////////VK
				
		log using $folder/code/log_1DataClean_Worker, replace
		use $folder/data/raw/worker_main_raw.dta, clear
		
*===========================
		* clean clean clean 
*===========================
		
		keep if finished == "TRUE"
		drop startdate enddate status progress recordeddate responseid ///
		recipientlastname recipientfirstname recipientemail externalreference ///
		distributionchannel userlanguage q11 
////////////////////////////////////////////////////////////VK
drop finished
////////////////////////////////////////////////////////////VK
  
		
		destring durationinseconds, replace
		
		gen treatment = "IE" if fl_39_do == "Vignette-InfoEmployment"
		replace treatment = "IO" if fl_39_do == "Vignette-InfoOpportunity"
		replace treatment = "ME" if fl_39_do == "Vignette-MeritEmployment"
		replace treatment = "MO" if fl_39_do == "Vignette-MeritOpportunity"
		replace treatment = "RE" if fl_39_do == "Vignette-RandomEmployment"
		replace treatment = "RO" if fl_39_do == "Vignette-RandomOpportunity"
		
	
		local var1 MO
		local var2 q41
		gen `var1' = 0 if `var2' == "Jim is awarded a bonus of $600 and Bill is awarded a bonus of $0"
		replace `var1' = 1 if `var2' == "Jim is awarded a bonus of $500 and Bill is awarded a bonus of $100"
		replace `var1' = 2 if `var2' == "Jim is awarded a bonus of $400 and Bill is awarded a bonus of $200"
		replace `var1' = 3 if `var2' == "Jim is awarded a bonus of $300 and Bill is awarded a bonus of $300"
		replace `var1' = 4 if `var2' == "Jim is awarded a bonus of $200 and Bill is awarded a bonus of $400"
		replace `var1' = 5 if `var2' == "Jim is awarded a bonus of $100 and Bill is awarded a bonus of $500"
		replace `var1' = 6 if `var2' == "Jim is awarded a bonus of $0 and Bill is awarded a bonus of $600"
		
		local var1 RO
		local var2 q51
		gen `var1' = 0 if `var2' == "Jim is awarded a bonus of $600 and Bill is awarded a bonus of $0"
		replace `var1' = 1 if `var2' == "Jim is awarded a bonus of $500 and Bill is awarded a bonus of $100"
		replace `var1' = 2 if `var2' == "Jim is awarded a bonus of $400 and Bill is awarded a bonus of $200"
		replace `var1' = 3 if `var2' == "Jim is awarded a bonus of $300 and Bill is awarded a bonus of $300"
		replace `var1' = 4 if `var2' == "Jim is awarded a bonus of $200 and Bill is awarded a bonus of $400"
		replace `var1' = 5 if `var2' == "Jim is awarded a bonus of $100 and Bill is awarded a bonus of $500"
		replace `var1' = 6 if `var2' == "Jim is awarded a bonus of $0 and Bill is awarded a bonus of $600"
		
		
		
		local var1 ME
		local var2 q61
		gen `var1' = 0 if `var2' == "Jim is awarded a bonus of $600 and Bill is awarded a bonus of $0"
		replace `var1' = 1 if `var2' == "Jim is awarded a bonus of $500 and Bill is awarded a bonus of $100"
		replace `var1' = 2 if `var2' == "Jim is awarded a bonus of $400 and Bill is awarded a bonus of $200"
		replace `var1' = 3 if `var2' == "Jim is awarded a bonus of $300 and Bill is awarded a bonus of $300"
		replace `var1' = 4 if `var2' == "Jim is awarded a bonus of $200 and Bill is awarded a bonus of $400"
		replace `var1' = 5 if `var2' == "Jim is awarded a bonus of $100 and Bill is awarded a bonus of $500"
		replace `var1' = 6 if `var2' == "Jim is awarded a bonus of $0 and Bill is awarded a bonus of $600"
		
		local var1 RE
		local var2 q71
		gen `var1' = 0 if `var2' == "Jim is awarded a bonus of $600 and Bill is awarded a bonus of $0"
		replace `var1' = 1 if `var2' == "Jim is awarded a bonus of $500 and Bill is awarded a bonus of $100"
		replace `var1' = 2 if `var2' == "Jim is awarded a bonus of $400 and Bill is awarded a bonus of $200"
		replace `var1' = 3 if `var2' == "Jim is awarded a bonus of $300 and Bill is awarded a bonus of $300"
		replace `var1' = 4 if `var2' == "Jim is awarded a bonus of $200 and Bill is awarded a bonus of $400"
		replace `var1' = 5 if `var2' == "Jim is awarded a bonus of $100 and Bill is awarded a bonus of $500"
		replace `var1' = 6 if `var2' == "Jim is awarded a bonus of $0 and Bill is awarded a bonus of $600"
		
		gen redistribution = MO if treatment == "MO"
		replace redistribution = RO if treatment == "RO"
		replace redistribution = ME if treatment == "ME"
		replace redistribution = RE if treatment == "RE"
		
		
		
		gen rate = 0 if q81 == "0 percent of managers" |q91 == "0 percent of managers" 
		replace rate = 20 if q81 == "Above 0 percent but below 20% of managers"|q91 == "Above 0 percent but below 20% of managers"
		replace rate = 40 if q81 == "At least 20% but below 40% of managers"|q91 == "At least 20% but below 40% of managers"
		replace rate = 60 if q81 == "At least 40% but below 60% of managers"|q91 == "At least 40% but below 60% of managers"
		replace rate = 80 if q81 == "At least 60% but below 80% of managers"|q91 == "At least 60% but below 80% of managers"
		replace rate = 100 if q81 == "At least 80% of managers"|q91 == "At least 80% of managers"
		
		
		drop q41 q51 q61 q71 q81 q91
		drop q16*
		drop q12*
		
	*-DEMOGRAPHICS
		rename q172 male
		rename q173 age
		rename q174 edu
		rename q175 income
		rename q176 party
		rename q177 attitude
		
		gen female1 = (male == "Female")


		gen age1 = 20 if age == "18 to 22"
		replace age1 = 26 if age == "23 to 29"
		replace age1 = 35 if age == "30 to 39"
		replace age1 = 45 if age == "40 to 49"
		replace age1 = 55 if age == "50 to 59"
		replace age1 = 65 if age == "60 to 69"
		replace age1 = 75 if age == "70 or above"
		
		gen edu1 = 2 if edu == "completed high school"
		replace edu1 = 4 if edu == "graduated from a 4 year college"
		replace edu1 = 1 if edu == "have not completed high school"
		replace edu1 = 3 if edu == "some college education, or 2 year college degree"
		replace edu1 = 5 if edu == "some graduate school attended or higher"
		
		gen income1 = 7500 if income == "$0 to $15,000"
		replace income1 = 22500 if income == "$15,001 to $30,000"
		replace income1 = 40000 if income == "$30,001 to $50,000"
		replace income1 = 60000 if income == "$50,001 to $70,000"
		replace income1 = 85000 if income == "$70,001 to $100,000"
		replace income1 = 115000 if income == "$100,001 to $130,000"
		replace income1 = 150000 if income == "$130,001 to $170,000"
		replace income1 = 200000 if income == "$170,001 or above"
		replace income1 = . if income == "I prefer not to answer"
		
		gen attitude1 = 1 if attitude == "The amount of inequality in society is very unacceptable."
		replace attitude1 = 2 if attitude == "The amount of inequality in society is somewhat unacceptable."
		replace attitude1 = 3 if attitude == "I feel neutral about the current degree of inequality in society."
		replace attitude1 = 4 if attitude == "The amount of inequality in society is moderately reasonable."
		replace attitude1 = 5 if attitude == "The amount of inequality in society is very reasonable."
		
		
		//tab party, gen(party_)
		
		gen highEdu = (edu1 > 3)
		gen highIncome = (income1 > 50000)
		gen conservative = (party == "Republican")
		
////////////////////////////////////////////////////////////VK

replace female1 = . if male == ""

tab party conservative, m

tab edu1 highEdu, m
replace highEdu = .   if edu1 == .	

tab income1 highIncome, m
replace highIncome = .   if income1 ==  .   // 18 missings


replace conservative = . if party == ""		 
////////////////////////////////////////////////////////////VK		
			
		order treatment redistribution rate durationinseconds male* age* edu* party* attitude*
	
		save $folder/data/processed/worker_main.dta, replace
		
		
		log close
		
		
		
		
		
		
		
		
		
		
		
		

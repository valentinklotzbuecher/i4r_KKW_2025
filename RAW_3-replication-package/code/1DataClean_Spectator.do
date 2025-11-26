
		
		
		log using $folder/code/log_1DataClean_Spectator, replace
*===========================
		* clean clean clean 
*===========================

		use $folder/data/raw/spectator_main_raw.dta, clear
		
	*-> Quiz
		drop startdate enddate progress
		drop finished recordeddate responseid recipient* external*
		drop q_recaptchascore passQuiz
		drop consent ready* distributionchannel userlanguage 
		
		gen passQuiz = 1 if quiz1_1 == "True" & quiz1_2 == "True" & quiz1_3 == "True"
		replace passQuiz = 1 if quiz2_1 == "True" & quiz2_2 == "True" & quiz2_3 == "True"
		replace passQuiz = 1 if quiz3_1 == "True" & quiz3_2 == "True" & quiz3_3 == "True"
		replace passQuiz = 1 if quiz4_1 == "True" & quiz4_2 == "True" & quiz4_3 == "True"
		replace passQuiz = 1 if quiz5_1 == "True" & quiz5_2 == "True" & quiz5_3 == "True"
		replace passQuiz = 1 if quiz6_1 == "True" & quiz6_2 == "True" & quiz6_3 == "True"
		
		drop quiz*
		
		
	*-> Amount of Allocation
		local var1 luck
		local var2 allocation_luck
		gen `var1' = 0 if `var2' == "Worker A is paid 6 USD and worker B is paid 0 USD."
		replace `var1' = 1 if `var2' == "Worker A is paid 5 USD and worker B is paid 1 USD."
		replace `var1' = 2 if `var2' == "Worker A is paid 4 USD and worker B is paid 2 USD."
		replace `var1' = 3 if `var2' == "Worker A is paid 3 USD and worker B is paid 3 USD."
		replace `var1' = 4 if `var2' == "Worker A is paid 2 USD and worker B is paid 4 USD."
		replace `var1' = 5 if `var2' == "Worker A is paid 1 USD and worker B is paid 5 USD."
		replace `var1' = 6 if `var2' == "Worker A is paid 0 USD and worker B is paid 6 USD."
		
		local var1 merit
		local var2 allocation_merit
		gen `var1' = 0 if `var2' == "Worker A is paid 6 USD and worker B is paid 0 USD."
		replace `var1' = 1 if `var2' == "Worker A is paid 5 USD and worker B is paid 1 USD."
		replace `var1' = 2 if `var2' == "Worker A is paid 4 USD and worker B is paid 2 USD."
		replace `var1' = 3 if `var2' == "Worker A is paid 3 USD and worker B is paid 3 USD."
		replace `var1' = 4 if `var2' == "Worker A is paid 2 USD and worker B is paid 4 USD."
		replace `var1' = 5 if `var2' == "Worker A is paid 1 USD and worker B is paid 5 USD."
		replace `var1' = 6 if `var2' == "Worker A is paid 0 USD and worker B is paid 6 USD."
		
	
		local var1 educ
		local var2 allocation_educ
		gen `var1' = 0 if `var2' == "Worker A is paid 6 USD and worker B is paid 0 USD."
		replace `var1' = 1 if `var2' == "Worker A is paid 5 USD and worker B is paid 1 USD."
		replace `var1' = 2 if `var2' == "Worker A is paid 4 USD and worker B is paid 2 USD."
		replace `var1' = 3 if `var2' == "Worker A is paid 3 USD and worker B is paid 3 USD."
		replace `var1' = 4 if `var2' == "Worker A is paid 2 USD and worker B is paid 4 USD."
		replace `var1' = 5 if `var2' == "Worker A is paid 1 USD and worker B is paid 5 USD."
		replace `var1' = 6 if `var2' == "Worker A is paid 0 USD and worker B is paid 6 USD."
		
		local var1 employ
		local var2 allocation_employ
		gen `var1' = 0 if `var2' == "Worker A is paid 6 USD and worker B is paid 0 USD."
		replace `var1' = 1 if `var2' == "Worker A is paid 5 USD and worker B is paid 1 USD."
		replace `var1' = 2 if `var2' == "Worker A is paid 4 USD and worker B is paid 2 USD."
		replace `var1' = 3 if `var2' == "Worker A is paid 3 USD and worker B is paid 3 USD."
		replace `var1' = 4 if `var2' == "Worker A is paid 2 USD and worker B is paid 4 USD."
		replace `var1' = 5 if `var2' == "Worker A is paid 1 USD and worker B is paid 5 USD."
		replace `var1' = 6 if `var2' == "Worker A is paid 0 USD and worker B is paid 6 USD."		

		
		local var1 info_educ
		local var2 allocation_info_educ_NoTick 
		local var3 allocation_info_educ_YesTick 
		gen `var1' = 0 if `var2' == "Worker A is paid 6 USD and worker B is paid 0 USD."|`var3' == "Worker A is paid 6 USD and worker B is paid 0 USD."
		replace `var1' = 1 if `var2' == "Worker A is paid 5 USD and worker B is paid 1 USD."|`var3' == "Worker A is paid 5 USD and worker B is paid 1 USD."
		replace `var1' = 2 if `var2' == "Worker A is paid 4 USD and worker B is paid 2 USD."|`var3' == "Worker A is paid 4 USD and worker B is paid 2 USD."
		replace `var1' = 3 if `var2' == "Worker A is paid 3 USD and worker B is paid 3 USD."|`var3' == "Worker A is paid 3 USD and worker B is paid 3 USD."
		replace `var1' = 4 if `var2' == "Worker A is paid 2 USD and worker B is paid 4 USD."|`var3' == "Worker A is paid 2 USD and worker B is paid 4 USD."
		replace `var1' = 5 if `var2' == "Worker A is paid 1 USD and worker B is paid 5 USD."|`var3' == "Worker A is paid 1 USD and worker B is paid 5 USD."
		replace `var1' = 6 if `var2' == "Worker A is paid 0 USD and worker B is paid 6 USD."|`var3' == "Worker A is paid 0 USD and worker B is paid 6 USD."
		
		
		local var1 info_employ
		local var2 allocation_info_employ_NoTick
		local var3 allocation_info_employ_YesTick
		gen `var1' = 0 if `var2' == "Worker A is paid 6 USD and worker B is paid 0 USD."|`var3' == "Worker A is paid 6 USD and worker B is paid 0 USD."
		replace `var1' = 1 if `var2' == "Worker A is paid 5 USD and worker B is paid 1 USD."|`var3' == "Worker A is paid 5 USD and worker B is paid 1 USD."
		replace `var1' = 2 if `var2' == "Worker A is paid 4 USD and worker B is paid 2 USD."|`var3' == "Worker A is paid 4 USD and worker B is paid 2 USD."
		replace `var1' = 3 if `var2' == "Worker A is paid 3 USD and worker B is paid 3 USD."|`var3' == "Worker A is paid 3 USD and worker B is paid 3 USD."
		replace `var1' = 4 if `var2' == "Worker A is paid 2 USD and worker B is paid 4 USD."|`var3' == "Worker A is paid 2 USD and worker B is paid 4 USD."
		replace `var1' = 5 if `var2' == "Worker A is paid 1 USD and worker B is paid 5 USD."|`var3' == "Worker A is paid 1 USD and worker B is paid 5 USD."
		replace `var1' = 6 if `var2' == "Worker A is paid 0 USD and worker B is paid 6 USD."|`var3' == "Worker A is paid 0 USD and worker B is paid 6 USD."
		
	*-> Treatments
		gen treatment = "1luck" if luck !=.
		replace treatment = "2merit" if merit !=.
		replace treatment = "3edu" if educ !=.
		replace treatment = "4emp" if employ !=.
		replace treatment = "5info_educ" if info_educ !=.
		replace treatment = "6info_emp" if info_employ !=.
		
		
	*-> Survey 
		gen survey_fair = 2 if survey_fair1 == "Very fair"
		replace survey_fair = 1 if survey_fair1 == "Fair"
		replace survey_fair = 0 if survey_fair1 == "Neutral"
		replace survey_fair = -1 if survey_fair1 == "Unfair"
		replace survey_fair = -2 if survey_fair1 == "Very unfair"	
		
		gen survey_redistr = 1 if survey_reason_text == "I did not redistribute because I believe the original rules of the reward scheme between the two workers was fair."
		replace survey_redistr = 2 if survey_reason_text == "I did not redistribute because I believe the original rules of the reward scheme between the two workers should be followed."
		replace survey_redistr = 3 if survey_reason_text == "I did not redistribute because I believe it is not my place to change the allocation of payments between the two workers."
		replace survey_redistr = 4 if survey_reason_text == "I redistributed the money based on what I believe is fair between the two workers."
		replace survey_redistr = 5 if survey_reason_text == "I redistributed the money based on what I believe is fair between the two workers as well as myself."
		replace survey_redistr = 6 if survey_reason_text == "I redistributed the money because of another motive (please specify)"
		
	*-> Ticking Task
		destring scoreopportunity, gen(tickNum_edu)
		destring scoreemploy, gen(tickNum_employ)
		
		
		gen tickNum = tickNum_edu if tickNum_edu != .
		replace tickNum = tickNum_employ if tickNum_employ != .
		
	
	*-> Demographics
		
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
		
		gen highEdu = (edu1 > 3)
		gen highIncome = (income1 > 50000)
		gen conservative = (party == "Republican")
	
	*-> Destrings
		
		destring durationinseconds, replace
		sum durationinseconds, detail
		destring tickNum, replace

	*-> Drop
		drop status allocation* 
		drop q91* tick241* q151* q182_4_text
		drop englishNative followup
		
		//drop if treatment=="3edu" & survey_fair1=="Fair" & durationinseconds==265
		
				
	*--- Drop inattention

	
		
		*-> Keep passQuiz
		tab passQuiz 
		keep if passQuiz == 1 //drop those who do not pass the quiz
		
		*-> Drop too fast
		destring durationinseconds, replace
		sum durationinseconds, detail	
		gen tooFast = (durationinseconds < 120)
		tab tooFast
		
		drop if tooFast == 1	
		
		
		
		
	*-> Generation
		gen redistribution = luck if treatment == "1luck"
		replace redistribution = merit if treatment == "2merit"
		replace redistribution = educ if treatment == "3edu"
		replace redistribution = employ if treatment == "4emp"
		replace redistribution = info_educ if treatment == "5info_educ"
		replace redistribution = info_employ if treatment == "6info_emp"		
		
		drop if redistribution == .
		drop if age == ""
		
		
	*-> Save Data
		
		save $folder/data/processed/spectator_main.dta, replace
		

		
*==============================================		
	*-> Load the data
	
		global mydata $folder/data/raw/spectator_vary_raw.dta
		
		
		use $mydata, clear

		
*============================
		* clean clean clean
*===========================	

		
	*-> Quiz
		drop startdate enddate progress
		drop finished recordeddate responseid recipient* external*
		drop q_recaptchascore 
		drop consent ready* distributionchannel userlanguage 
		
		gen passQuiz = 1 if quiz7_1 == "True" & quiz7_2 == "True" & quiz7_3 == "True"
		replace passQuiz = 1 if quiz8_1 == "True" & quiz8_2 == "True" & quiz8_3 == "True"
		replace passQuiz = 1 if quiz9_1 == "True" & quiz9_2 == "True" & quiz9_3 == "True"
		
		drop quiz*
		
		
	*-> Amount of Allocation
		
		foreach i in "00" "01" "10" "50" "90" "99" "100"{
		gen luck`i' = 0 if allocation_luck`i' == "Worker A is paid $6 USD and Worker B is paid $0 USD."
		replace luck`i' = 1 if allocation_luck`i' == "Worker A is paid $5 USD and Worker B is paid $1 USD."
		replace luck`i' = 2 if allocation_luck`i' == "Worker A is paid $4 USD and Worker B is paid $2 USD."
		replace luck`i' = 3 if allocation_luck`i' == "Worker A is paid $3 USD and Worker B is paid $3 USD."
		replace luck`i' = 4 if allocation_luck`i' == "Worker A is paid $2 USD and Worker B is paid $4 USD."
		replace luck`i' = 5 if allocation_luck`i' == "Worker A is paid $1 USD and Worker B is paid $5 USD."
		replace luck`i' = 6 if allocation_luck`i' == "Worker A is paid $0 USD and Worker B is paid $6 USD."
		}
	
		
		foreach i in "0" "1" "4" "7" "11" "14" "15"{
		gen edu15v`i' = 0 if edu_15v`i'_decision == "Worker A is paid $6 USD and Worker B is paid $0 USD."
		replace edu15v`i' = 1 if edu_15v`i'_decision == "Worker A is paid $5 USD and Worker B is paid $1 USD."
		replace edu15v`i' = 2 if edu_15v`i'_decision == "Worker A is paid $4 USD and Worker B is paid $2 USD."
		replace edu15v`i' = 3 if edu_15v`i'_decision == "Worker A is paid $3 USD and Worker B is paid $3 USD."
		replace edu15v`i' = 4 if edu_15v`i'_decision == "Worker A is paid $2 USD and Worker B is paid $4 USD."
		replace edu15v`i' = 5 if edu_15v`i'_decision == "Worker A is paid $1 USD and Worker B is paid $5 USD."
		replace edu15v`i' = 6 if edu_15v`i'_decision == "Worker A is paid $0 USD and Worker B is paid $6 USD."
		}
		
		foreach i in "0" "1" "4" "7" "11" "14" "15"{
		destring edu_15v`i'_belief, gen(eduB15v`i')
		}
		
		foreach i in "0" "1" "4" "7" "11" "14" "15"{
		gen emp15v`i' = 0 if emp_15v`i'_decision == "Worker A is paid $6 USD and Worker B is paid $0 USD."
		replace emp15v`i' = 1 if emp_15v`i'_decision == "Worker A is paid $5 USD and Worker B is paid $1 USD."
		replace emp15v`i' = 2 if emp_15v`i'_decision == "Worker A is paid $4 USD and Worker B is paid $2 USD."
		replace emp15v`i' = 3 if emp_15v`i'_decision == "Worker A is paid $3 USD and Worker B is paid $3 USD."
		replace emp15v`i' = 4 if emp_15v`i'_decision == "Worker A is paid $2 USD and Worker B is paid $4 USD."
		replace emp15v`i' = 5 if emp_15v`i'_decision == "Worker A is paid $1 USD and Worker B is paid $5 USD."
		replace emp15v`i' = 6 if emp_15v`i'_decision == "Worker A is paid $0 USD and Worker B is paid $6 USD."
		}
		
		foreach i in "0" "1" "4" "7" "11" "14" "15"{
		destring emp_15v`i'_belief, gen(empB15v`i')
		}
		
		
		
		
	*-> Treatments
		gen treatment = "luckXX" if luck00 !=.
		replace treatment = "eduXX" if edu15v1 !=.
		replace treatment = "empXX" if emp15v1 !=.
		
	
	
	*-> Demographics
		
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
		
		gen highEdu = (edu1 > 3)
		gen highIncome = (income1 > 50000)
		gen conservative = (party == "Republican")
	
	*--- Drop inattention
	
		
		*-> Keep passQuiz
		tab passQuiz 
		keep if passQuiz == 1 //drop those who do not pass the quiz
		
		*-> Drop too fast
		destring durationinseconds, replace
		sum durationinseconds, detail	
		gen tooFast = (durationinseconds < 180)
		tab tooFast
		
		drop if tooFast == 1	
		
		
		drop if treatment == ""
		drop if age == ""
		
		
	*-> Save Data
		
		save $folder/data/processed/spectator_vary.dta, replace
		
		log close

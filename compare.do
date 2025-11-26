////////////////////////////////////////////////////////////VK
clear all
cd "C:\Users\VK\Sync\Research\i4r_amsterdam_2025"
global raw ".\RAW_3-replication-package"
global rep ".\3-replication-package"
set varabbrev off
version 16.0
global seed 12345

est clear

		
*------------------------------------	
*-> Table 3: structural estimation 
*------------------------------------	

		use $raw/data/processed/spectator_vary.dta , clear
		drop if (luck00 >= 3 | luck100 == 0) & treatment=="luckXX"
		drop if (edu15v15 >= 3 | edu15v0 == 0) & treatment=="eduXX"
		drop if (emp15v15 >= 3 | emp15v0 == 0) & treatment=="empXX"
		save "$raw/data/temp/temp.dta", replace
		clear
		set obs 7
		gen id=_n
		cross using "$raw/data/temp/temp.dta"
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

		eststo orig_3_1: menl temp1 = 1 - temp2 + (2*temp2 - 1)/(1 + (1/temp3 - 1)^(1/({alpha} - 1))) if treatment=="luckXX"
		
		eststo orig_3_2: menl temp1 = 1 - temp2 + (2*temp2 - 1)/(1 + (1/temp3 - 1)^(1/({alpha} - 1))) if treatment=="eduXX" 
		
		eststo orig_3_3: menl temp1 = 1 - temp2 + (2*temp2 - 1)/(1 + (1/temp3 - 1)^(1/({alpha} - 1))) if treatment=="empXX"
		esttab, b(%6.3f) se star(* 0.10 ** 0.05 *** 0.01) brackets

		
		
		use $rep/data/processed/spectator_vary.dta , clear
		drop if (luck00 >= 3 | luck100 == 0) & treatment=="luckXX"
		drop if (edu15v15 >= 3 | edu15v0 == 0) & treatment=="eduXX"
		drop if (emp15v15 >= 3 | emp15v0 == 0) & treatment=="empXX"
		save "$rep/data/temp/temp.dta", replace
		clear
		set obs 7
		gen id=_n
		cross using "$rep/data/temp/temp.dta"
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

		eststo rep_3_1: menl temp1 = 1 - temp2 + (2*temp2 - 1)/(1 + (1/temp3 - 1)^(1/({alpha} - 1))) if treatment=="luckXX"
		 

		eststo rep_3_2: menl temp1 = 1 - temp2 + (2*temp2 - 1)/(1 + (1/temp3 - 1)^(1/({alpha} - 1))) if treatment=="eduXX" 
		
		eststo rep_3_3: menl temp1 = 1 - temp2 + (2*temp2 - 1)/(1 + (1/temp3 - 1)^(1/({alpha} - 1))) if treatment=="empXX"
		
		
		/*
i4results, original(orig_3_1) robustness("rep_3_1") ///
    out("./Report_KKW.xlsx") 
	
i4results, original(orig_3_2) robustness("rep_3_2") ///
    out("./Report_KKW.xlsx") append
i4results, original(orig_3_3) robustness("rep_3_3") ///
    out("./Report_KKW.xlsx") append
	 
		*/
		
		
		
		
		


*------------------------------------	
*-> Table A1: regression analysis
*------------------------------------			

		use $raw/data/processed/spectator_main.dta, clear

		egen temp1 = group(treatment)
		gen luck2 = (temp1==1)
		gen merit2 = (temp1==2)
		gen rEdu = (temp1==3)
		gen rEm = (temp1==4)

		gen temp0 = redistribution/6
		
		keep if temp1 <= 4

		eststo orig_a1_1: reg temp0 merit2 rEdu rEm, vce(robust)
		test merit2 = rEdu
		test merit2 = rEm
		test rEdu = rEm
		eststo orig_a1_2: reg temp0 merit2 rEdu rEm female1 age1 highEdu highIncome conservative, vce(robust)
		test merit2 = rEdu
		test merit2 = rEm
		test rEdu = rEm
		esttab, b(%6.3f) se star(* 0.10 ** 0.05 *** 0.01) brackets
//		esttab using $folder/output/tables/tableA1.tex, replace b(%6.3f) se star(* 0.10 ** 0.05 *** 0.01) booktabs
//		eststo clear 

		use $rep/data/processed/spectator_main.dta, clear

		egen temp1 = group(treatment)
		gen luck2 = (temp1==1)
		gen merit2 = (temp1==2)
		gen rEdu = (temp1==3)
		gen rEm = (temp1==4)

		gen temp0 = redistribution/6
		
		keep if temp1 <= 4

		eststo rep_a1_1: reg temp0 merit2 rEdu rEm, vce(robust)
		test merit2 = rEdu
		test merit2 = rEm
		test rEdu = rEm
		eststo rep_a1_2: reg temp0 merit2 rEdu rEm female1 age1 highEdu highIncome conservative, vce(robust)
		test merit2 = rEdu
		test merit2 = rEm
		test rEdu = rEm
		esttab, b(%6.3f) se star(* 0.10 ** 0.05 *** 0.01) brackets

i4results, original(orig_a1_1) robustness("rep_a1_1") ///
    out("./Report_KKW.xlsx") append

i4results, original(orig_a1_2) robustness("rep_a1_2") ///
    out("./Report_KKW.xlsx") append
	

*------------------------------------	
*-> Table A4: Heterogeneity analysis 
*------------------------------------		

		use $raw/data/processed/spectator_main.dta, clear

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

		eststo orig_a4_1: reg temp0 merit2 rEdu rEm merit_female rEdu_female rEm_female female1, vce(robust)
		lincom merit2 + merit_female
		lincom rEdu + rEdu_female
		lincom rEm + rEm_female

		eststo orig_a4_2: reg temp0 merit2 rEdu rEm merit_highEdu rEdu_highEdu rEm_highEdu highEdu, vce(robust)
		lincom merit2 + merit_highEdu
		lincom rEdu + rEdu_highEdu
		lincom rEm + rEm_highEdu

		eststo orig_a4_3: reg temp0 merit2 rEdu rEm merit_highIncome rEdu_highIncome rEm_highIncome highIncome, vce(robust)
		lincom merit2 + merit_highIncome
		lincom rEdu + rEdu_highIncome
		lincom rEm + rEm_highIncome

		eststo orig_a4_4: reg temp0 merit2 rEdu rEm merit_conservative rEdu_conservative rEm_conservative conservative, vce(robust)
		lincom merit2 + merit_conservative
		lincom rEdu + rEdu_conservative
		lincom rEm + rEm_conservative

		esttab, b(%6.3f) se star(* 0.10 ** 0.05 *** 0.01) brackets	
	
///

		use $rep/data/processed/spectator_main.dta, clear

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

		eststo rep_a4_1: reg temp0 merit2 rEdu rEm merit_female rEdu_female rEm_female female1, vce(robust)
		lincom merit2 + merit_female
		lincom rEdu + rEdu_female
		lincom rEm + rEm_female

		eststo rep_a4_2: reg temp0 merit2 rEdu rEm merit_highEdu rEdu_highEdu rEm_highEdu highEdu, vce(robust)
		lincom merit2 + merit_highEdu
		lincom rEdu + rEdu_highEdu
		lincom rEm + rEm_highEdu

		eststo rep_a4_3: reg temp0 merit2 rEdu rEm merit_highIncome rEdu_highIncome rEm_highIncome highIncome, vce(robust)
		lincom merit2 + merit_highIncome
		lincom rEdu + rEdu_highIncome
		lincom rEm + rEm_highIncome

		eststo rep_a4_4: reg temp0 merit2 rEdu rEm merit_conservative rEdu_conservative rEm_conservative conservative, vce(robust)
		lincom merit2 + merit_conservative
		lincom rEdu + rEdu_conservative
		lincom rEm + rEm_conservative

		esttab, b(%6.3f) se star(* 0.10 ** 0.05 *** 0.01) brackets	

i4results, original(orig_a4_1) robustness("rep_a4_1") ///
    out("./Report_KKW.xlsx") append
i4results, original(orig_a4_2) robustness("rep_a4_2") ///
    out("./Report_KKW.xlsx") append
i4results, original(orig_a4_3) robustness("rep_a4_3") ///
    out("./Report_KKW.xlsx") append
i4results, original(orig_a4_4) robustness("rep_a4_4") ///
    out("./Report_KKW.xlsx") append
	
	

*------------------------------------	
*-> Table A7 & A8: regression analysis
*------------------------------------			

		use $raw/data/processed/spectator_vary.dta, clear
		save "$raw/data/temp/temp.dta", replace

		clear
		set obs 7
		gen id=_n
		cross using "$raw/data/temp/temp.dta"
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
		eststo orig_a7_1: reg luck i.id if treatment=="luckXX", cluster(connectID)
		eststo orig_a7_2: reg edu2 i.id if treatment=="eduXX", cluster(connectID)
		eststo orig_a7_3: reg emp i.id if treatment=="empXX", cluster(connectID)
		esttab, b(%6.3f) se star(* 0.10 ** 0.05 *** 0.01) brackets
		
		//run this code for Table A8
		eststo orig_a8_1: reg luck i.id if treatment=="luckXX" & luck00 < 3, cluster(connectID)
		eststo orig_a8_2: reg edu2 i.id if treatment=="eduXX" & edu15v15 < 3, cluster(connectID)
		eststo orig_a8_3: reg emp i.id if treatment=="empXX" & emp15v15 < 3, cluster(connectID)
		esttab, b(%6.3f) se star(* 0.10 ** 0.05 *** 0.01) brackets

///
		
		use $rep/data/processed/spectator_vary.dta, clear
		save "$rep/data/temp/temp.dta", replace

		clear
		set obs 7
		gen id=_n
		cross using "$rep/data/temp/temp.dta"
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
		eststo rep_a7_1: reg luck i.id if treatment=="luckXX", cluster(connectID)
		eststo rep_a7_2: reg edu2 i.id if treatment=="eduXX", cluster(connectID)
		eststo rep_a7_3: reg emp i.id if treatment=="empXX", cluster(connectID)
		esttab, b(%6.3f) se star(* 0.10 ** 0.05 *** 0.01) brackets
		
		//run this code for Table A8
		eststo rep_a8_1: reg luck i.id if treatment=="luckXX" & luck00 < 3, cluster(connectID)
		eststo rep_a8_2: reg edu2 i.id if treatment=="eduXX" & edu15v15 < 3, cluster(connectID)
		eststo rep_a8_3: reg emp i.id if treatment=="empXX" & emp15v15 < 3, cluster(connectID)
		esttab, b(%6.3f) se star(* 0.10 ** 0.05 *** 0.01) brackets

	
i4results, original(orig_a7_1) robustness("rep_a7_1") ///
    out("./Report_KKW.xlsx") append
i4results, original(orig_a7_2) robustness("rep_a7_2") ///
    out("./Report_KKW.xlsx") append
i4results, original(orig_a7_3) robustness("rep_a7_3") ///
    out("./Report_KKW.xlsx") append
	
	
	
i4results, original(orig_a8_1) robustness("rep_a8_1") ///
    out("./Report_KKW.xlsx") append
i4results, original(orig_a8_2) robustness("rep_a8_2") ///
    out("./Report_KKW.xlsx") append
i4results, original(orig_a8_3) robustness("rep_a8_3") ///
    out("./Report_KKW.xlsx") append
	
*/
	
	
	
	
	
	
	
	
	
	
	
	
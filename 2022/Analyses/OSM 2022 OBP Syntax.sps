﻿* Encoding: UTF-8.
* Encoding: .
* Encoding: .
* Encoding: .
* Encoding: .

**OPEN THE FILE: Data_UOS_survey_OSmonitor2020.sav'


*In total 517 participants in the dataset
**apply filter to exclude participants: mimimum requirement: having max 50% missing on the practice awareness questions


USE ALL.

*Demographics 

FREQUENCIES VARIABLES=Nat Gen
  /ORDER=ANALYSIS.

FREQUENCIES VARIABLES = OSCU
    /ORDER = ANALYSIS.


FREQUENCIES VARIABLES=Fac_2.
    Execute.

* create variable indicating whether someone works at a faculty, UBD, or UB
    
RECODE Fac_2 (1,2,3,4,5,6,7,8,12 = 1) (9, 10 = 2) (ELSE = SYSMIS) INTO Fac_new.
EXECUTE.

ADD VALUE LABELS Fac_new 1 'Faculty' 2 'UBD/UB'.

* Add dummy variable indicating if they do research
    
RECODE QTimeSpent_Res (2, 3, 4, 5, 6 = 1) (1 = 0) (7 = SYSMIS) (ELSE = SYSMIS) INTO research.
EXECUTE.

FREQUENCIES VARIABLES = research.
EXECUTE.

ADD VALUE LABELS research 1 'Involved in Research' 0 'Not involved in research'.
EXECUTE.

**several crosstabs currently not in the report; good to use/add for an appendix to describe frequencies across demographics and work characteristics;
**demographics and work characteristics are not independent of each other** 

CROSSTABS
  /TABLES=OSCU BY Fac
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT EXPECTED ROW COLUMN TOTAL BPROP 
  /COUNT ROUND CELL.

CROSSTABS
  /TABLES=OSCU BY Human2
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT EXPECTED ROW COLUMN TOTAL BPROP 
  /COUNT ROUND CELL.
 
*frequency table awareness 

FREQUENCIES VARIABLES=Prac_Aw_1_1 TO Prac_Aw_1_12
  /ORDER=ANALYSIS.


*frequency table attitudes

FREQUENCIES VARIABLES=Prac_Att_1 TO Prac_Att_12
  /ORDER=ANALYSIS.


*frequency table behaviors

FREQUENCIES VARIABLES= Prac_Beh_1 TO Prac_Beh_12
  /ORDER=ANALYSIS.

**ook een driepuntsschaal van maken voor eenvoudigere frequentie interpretatie**

RECODE OppMat_1 (1=1) (2=1) (3=2) (4=3) (5=3) INTO Op3_1.
EXECUTE.
RECODE OppMat_2 (1=1) (2=1) (3=2) (4=3) (5=3) INTO Op3_2.
EXECUTE.
RECODE OppMat_3 (1=1) (2=1) (3=2) (4=3) (5=3) INTO Op3_3.
EXECUTE.
RECODE OppMat_4 (1=1) (2=1) (3=2) (4=3) (5=3) INTO Op3_4.
EXECUTE.
RECODE OppMat_5 (1=1) (2=1) (3=2) (4=3) (5=3) INTO Op3_5.
EXECUTE.
RECODE OppMat_6 (1=1) (2=1) (3=2) (4=3) (5=3) INTO Op3_6.
EXECUTE.
RECODE OppMat_7 (1=1) (2=1) (3=2) (4=3) (5=3) INTO Op3_7.
EXECUTE.
RECODE OppMat_8 (1=1) (2=1) (3=2) (4=3) (5=3) INTO Op3_8.
EXECUTE.
RECODE OppMat_9 (1=1) (2=1) (3=2) (4=3) (5=3) INTO Op3_9.
EXECUTE.
RECODE OppMat_10 (1=1) (2=1) (3=2) (4=3) (5=3) INTO Op3_10.
EXECUTE.

FREQUENCIES VARIABLES=Op3_1 TO Op3_10
  /ORDER=ANALYSIS.

RECODE BarMat_1 (1=1) (2=1) (3=2) (4=3) (5=3) INTO Bar3_1.
EXECUTE.
RECODE BarMat_2 (1=1) (2=1) (3=2) (4=3) (5=3) INTO Bar3_2.
EXECUTE.
RECODE BarMat_3 (1=1) (2=1) (3=2) (4=3) (5=3) INTO Bar3_3.
EXECUTE.
RECODE BarMat_4 (1=1) (2=1) (3=2) (4=3) (5=3) INTO Bar3_4.
EXECUTE.
RECODE BarMat_5 (1=1) (2=1) (3=2) (4=3) (5=3) INTO Bar3_5.
EXECUTE.
RECODE BarMat_6 (1=1) (2=1) (3=2) (4=3) (5=3) INTO Bar3_6.
EXECUTE.
RECODE BarMat_7 (1=1) (2=1) (3=2) (4=3) (5=3) INTO Bar3_7.
EXECUTE.
RECODE BarMat_8 (1=1) (2=1) (3=2) (4=3) (5=3) INTO Bar3_8.
EXECUTE.
RECODE BarMat_9 (1=1) (2=1) (3=2) (4=3) (5=3) INTO Bar3_9.
EXECUTE.
RECODE BarMat_10 (1=1) (2=1) (3=2) (4=3) (5=3) INTO Bar3_10.
EXECUTE.

FREQUENCIES VARIABLES=Bar3_1 TO Bar3_10
  /ORDER=ANALYSIS.

* Specify "I don't know" as missing for attitude, OppMat, and BarMat
  
MISSING VALUES Prac_Att_1 TO Prac_Att_12 (6).
    
MISSING VALUES OppMat_1 TO OppMat_10 (6).
    
MISSING VALUES BarMat_1 TO BarMat_10 (6).

**Repeated measures analysis: inspect attitude-behavior gap

GLM Prac_Att_1 Prac_Beh_1
  /WSFACTOR=OS1 2 Polynomial 
  /METHOD=SSTYPE(3)
  /EMMEANS=TABLES(OVERALL) 
  /EMMEANS=TABLES(OS1) 
  /PRINT=DESCRIPTIVE ETASQ 
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=OS1.

GLM Prac_Att_2 Prac_Beh_2
  /WSFACTOR=OS2 2 Polynomial 
  /METHOD=SSTYPE(3)
  /EMMEANS=TABLES(OVERALL) 
  /EMMEANS=TABLES(OS2) 
  /PRINT=DESCRIPTIVE ETASQ 
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=OS2.

GLM Prac_Att_3 Prac_Beh_3
  /WSFACTOR=OS3 2 Polynomial 
  /METHOD=SSTYPE(3)
  /EMMEANS=TABLES(OVERALL) 
  /EMMEANS=TABLES(OS3) 
  /PRINT=DESCRIPTIVE ETASQ 
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=OS3.

GLM Prac_Att_4 Prac_Beh_4
  /WSFACTOR=OS4 2 Polynomial 
  /METHOD=SSTYPE(3)
  /EMMEANS=TABLES(OVERALL) 
  /EMMEANS=TABLES(OS4) 
  /PRINT=DESCRIPTIVE ETASQ 
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=OS4.

GLM Prac_Att_5 Prac_Beh_5
  /WSFACTOR=OS5 2 Polynomial 
  /METHOD=SSTYPE(3)
  /EMMEANS=TABLES(OVERALL) 
  /EMMEANS=TABLES(OS5) 
  /PRINT=DESCRIPTIVE ETASQ 
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=OS5.

GLM Prac_Att_6 Prac_Beh_6
  /WSFACTOR=OS6 2 Polynomial 
  /METHOD=SSTYPE(3)
  /EMMEANS=TABLES(OVERALL) 
  /EMMEANS=TABLES(OS6) 
  /PRINT=DESCRIPTIVE ETASQ 
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=OS6.

GLM Prac_Att_7 Prac_Beh_7
  /WSFACTOR=OS7 2 Polynomial 
  /METHOD=SSTYPE(3)
  /EMMEANS=TABLES(OVERALL) 
  /EMMEANS=TABLES(OS7) 
  /PRINT=DESCRIPTIVE ETASQ 
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=OS7.

GLM Prac_Att_8 Prac_Beh_8
  /WSFACTOR=OS8 2 Polynomial 
  /METHOD=SSTYPE(3)
  /EMMEANS=TABLES(OVERALL) 
  /EMMEANS=TABLES(OS8) 
  /PRINT=DESCRIPTIVE ETASQ 
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=OS8.

GLM Prac_Att_9 Prac_Beh_9
  /WSFACTOR=OS9 2 Polynomial 
  /METHOD=SSTYPE(3)
  /EMMEANS=TABLES(OVERALL) 
  /EMMEANS=TABLES(OS9) 
  /PRINT=DESCRIPTIVE ETASQ 
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=OS9.

GLM Prac_Att_10 Prac_Beh_10
  /WSFACTOR=OS10 2 Polynomial 
  /METHOD=SSTYPE(3)
  /EMMEANS=TABLES(OVERALL) 
  /EMMEANS=TABLES(OS10) 
  /PRINT=DESCRIPTIVE ETASQ 
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=OS10.

GLM Prac_Att_11 Prac_Beh_11
  /WSFACTOR=OS11 2 Polynomial 
  /METHOD=SSTYPE(3)
  /EMMEANS=TABLES(OVERALL) 
  /EMMEANS=TABLES(OS11) 
  /PRINT=DESCRIPTIVE ETASQ 
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=OS11.
  
GLM Prac_Att_12 Prac_Beh_12
  /WSFACTOR=OS12 2 Polynomial 
  /METHOD=SSTYPE(3)
  /EMMEANS=TABLES(OVERALL) 
  /EMMEANS=TABLES(OS12) 
  /PRINT=DESCRIPTIVE ETASQ 
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=OS12.

** Attitude behavior gap and opportunities/barriers compare research vs not research
    
SORT CASES BY research.
SPLIT FILE LAYERED BY research.

GLM Prac_Att_1 Prac_Beh_1
  /WSFACTOR=OS1 2 Polynomial 
  /METHOD=SSTYPE(3)
  /EMMEANS=TABLES(OVERALL) 
  /EMMEANS=TABLES(OS1) 
  /PRINT=DESCRIPTIVE ETASQ 
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=OS1.

GLM Prac_Att_2 Prac_Beh_2
  /WSFACTOR=OS2 2 Polynomial 
  /METHOD=SSTYPE(3)
  /EMMEANS=TABLES(OVERALL) 
  /EMMEANS=TABLES(OS2) 
  /PRINT=DESCRIPTIVE ETASQ 
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=OS2.

GLM Prac_Att_3 Prac_Beh_3
  /WSFACTOR=OS3 2 Polynomial 
  /METHOD=SSTYPE(3)
  /EMMEANS=TABLES(OVERALL) 
  /EMMEANS=TABLES(OS3) 
  /PRINT=DESCRIPTIVE ETASQ 
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=OS3.

GLM Prac_Att_4 Prac_Beh_4
  /WSFACTOR=OS4 2 Polynomial 
  /METHOD=SSTYPE(3)
  /EMMEANS=TABLES(OVERALL) 
  /EMMEANS=TABLES(OS4) 
  /PRINT=DESCRIPTIVE ETASQ 
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=OS4.

GLM Prac_Att_5 Prac_Beh_5
  /WSFACTOR=OS5 2 Polynomial 
  /METHOD=SSTYPE(3)
  /EMMEANS=TABLES(OVERALL) 
  /EMMEANS=TABLES(OS5) 
  /PRINT=DESCRIPTIVE ETASQ 
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=OS5.

GLM Prac_Att_6 Prac_Beh_6
  /WSFACTOR=OS6 2 Polynomial 
  /METHOD=SSTYPE(3)
  /EMMEANS=TABLES(OVERALL) 
  /EMMEANS=TABLES(OS6) 
  /PRINT=DESCRIPTIVE ETASQ 
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=OS6.

GLM Prac_Att_7 Prac_Beh_7
  /WSFACTOR=OS7 2 Polynomial 
  /METHOD=SSTYPE(3)
  /EMMEANS=TABLES(OVERALL) 
  /EMMEANS=TABLES(OS7) 
  /PRINT=DESCRIPTIVE ETASQ 
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=OS7.

GLM Prac_Att_8 Prac_Beh_8
  /WSFACTOR=OS8 2 Polynomial 
  /METHOD=SSTYPE(3)
  /EMMEANS=TABLES(OVERALL) 
  /EMMEANS=TABLES(OS8) 
  /PRINT=DESCRIPTIVE ETASQ 
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=OS8.

GLM Prac_Att_9 Prac_Beh_9
  /WSFACTOR=OS9 2 Polynomial 
  /METHOD=SSTYPE(3)
  /EMMEANS=TABLES(OVERALL) 
  /EMMEANS=TABLES(OS9) 
  /PRINT=DESCRIPTIVE ETASQ 
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=OS9.

GLM Prac_Att_10 Prac_Beh_10
  /WSFACTOR=OS10 2 Polynomial 
  /METHOD=SSTYPE(3)
  /EMMEANS=TABLES(OVERALL) 
  /EMMEANS=TABLES(OS10) 
  /PRINT=DESCRIPTIVE ETASQ 
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=OS10.

GLM Prac_Att_11 Prac_Beh_11
  /WSFACTOR=OS11 2 Polynomial 
  /METHOD=SSTYPE(3)
  /EMMEANS=TABLES(OVERALL) 
  /EMMEANS=TABLES(OS11) 
  /PRINT=DESCRIPTIVE ETASQ 
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=OS11.
  
GLM Prac_Att_12 Prac_Beh_12
  /WSFACTOR=OS12 2 Polynomial 
  /METHOD=SSTYPE(3)
  /EMMEANS=TABLES(OVERALL) 
  /EMMEANS=TABLES(OS12) 
  /PRINT=DESCRIPTIVE ETASQ 
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=OS12.

FREQUENCIES VARIABLES=Op3_1 TO Op3_10
  /ORDER=ANALYSIS.

FREQUENCIES VARIABLES=Bar3_1 TO Bar3_10
  /ORDER=ANALYSIS.

SPLIT FILE OFF.

**Run analyses seperately for faculty vs UB/UBD

SORT CASES BY Fac_new.
SPLIT FILE LAYERED BY Fac_new.

FREQUENCIES VARIABLES Nat Gen OSCU.
EXECUTE.

FREQUENCIES VARIABLES=Prac_Aw_1_1 TO Prac_Aw_1_12
  /ORDER=ANALYSIS.

FREQUENCIES VARIABLES=Prac_Beh_1 TO Prac_Beh_12
  /ORDER=ANALYSIS.

GLM Prac_Att_1 Prac_Beh_1
  /WSFACTOR=OS1 2 Polynomial 
  /METHOD=SSTYPE(3)
  /EMMEANS=TABLES(OVERALL) 
  /EMMEANS=TABLES(OS1) 
  /PRINT=DESCRIPTIVE ETASQ 
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=OS1.

GLM Prac_Att_2 Prac_Beh_2
  /WSFACTOR=OS2 2 Polynomial 
  /METHOD=SSTYPE(3)
  /EMMEANS=TABLES(OVERALL) 
  /EMMEANS=TABLES(OS2) 
  /PRINT=DESCRIPTIVE ETASQ 
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=OS2.

GLM Prac_Att_3 Prac_Beh_3
  /WSFACTOR=OS3 2 Polynomial 
  /METHOD=SSTYPE(3)
  /EMMEANS=TABLES(OVERALL) 
  /EMMEANS=TABLES(OS3) 
  /PRINT=DESCRIPTIVE ETASQ 
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=OS3.

GLM Prac_Att_4 Prac_Beh_4
  /WSFACTOR=OS4 2 Polynomial 
  /METHOD=SSTYPE(3)
  /EMMEANS=TABLES(OVERALL) 
  /EMMEANS=TABLES(OS4) 
  /PRINT=DESCRIPTIVE ETASQ 
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=OS4.

GLM Prac_Att_5 Prac_Beh_5
  /WSFACTOR=OS5 2 Polynomial 
  /METHOD=SSTYPE(3)
  /EMMEANS=TABLES(OVERALL) 
  /EMMEANS=TABLES(OS5) 
  /PRINT=DESCRIPTIVE ETASQ 
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=OS5.

GLM Prac_Att_6 Prac_Beh_6
  /WSFACTOR=OS6 2 Polynomial 
  /METHOD=SSTYPE(3)
  /EMMEANS=TABLES(OVERALL) 
  /EMMEANS=TABLES(OS6) 
  /PRINT=DESCRIPTIVE ETASQ 
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=OS6.

GLM Prac_Att_7 Prac_Beh_7
  /WSFACTOR=OS7 2 Polynomial 
  /METHOD=SSTYPE(3)
  /EMMEANS=TABLES(OVERALL) 
  /EMMEANS=TABLES(OS7) 
  /PRINT=DESCRIPTIVE ETASQ 
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=OS7.

GLM Prac_Att_8 Prac_Beh_8
  /WSFACTOR=OS8 2 Polynomial 
  /METHOD=SSTYPE(3)
  /EMMEANS=TABLES(OVERALL) 
  /EMMEANS=TABLES(OS8) 
  /PRINT=DESCRIPTIVE ETASQ 
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=OS8.

GLM Prac_Att_9 Prac_Beh_9
  /WSFACTOR=OS9 2 Polynomial 
  /METHOD=SSTYPE(3)
  /EMMEANS=TABLES(OVERALL) 
  /EMMEANS=TABLES(OS9) 
  /PRINT=DESCRIPTIVE ETASQ 
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=OS9.

GLM Prac_Att_10 Prac_Beh_10
  /WSFACTOR=OS10 2 Polynomial 
  /METHOD=SSTYPE(3)
  /EMMEANS=TABLES(OVERALL) 
  /EMMEANS=TABLES(OS10) 
  /PRINT=DESCRIPTIVE ETASQ 
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=OS10.

GLM Prac_Att_11 Prac_Beh_11
  /WSFACTOR=OS11 2 Polynomial 
  /METHOD=SSTYPE(3)
  /EMMEANS=TABLES(OVERALL) 
  /EMMEANS=TABLES(OS11) 
  /PRINT=DESCRIPTIVE ETASQ 
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=OS11.
  
GLM Prac_Att_12 Prac_Beh_12
  /WSFACTOR=OS12 2 Polynomial 
  /METHOD=SSTYPE(3)
  /EMMEANS=TABLES(OVERALL) 
  /EMMEANS=TABLES(OS12) 
  /PRINT=DESCRIPTIVE ETASQ 
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=OS12.

FREQUENCIES VARIABLES=Op3_1 TO Op3_10
  /ORDER=ANALYSIS.

FREQUENCIES VARIABLES=Bar3_1 TO Bar3_10
  /ORDER=ANALYSIS.

SPLIT FILE OFF.



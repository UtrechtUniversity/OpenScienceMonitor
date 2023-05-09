* Encoding: UTF-8.


**OPEN THE FILE US WP_Open Science Monitor 2022.sav'


*In total 688 participants in the dataset
    
USE ALL.

* We want to compare the answers submitted by people who do only quantitative research, only qualitative, and only theoretical.
* Create lists for each of these three groups of "exclusive" researchers

COMPUTE DoesOnlyQualitative = missing(TypeofResearch_1) AND (TypeofResearch_2 = 1) AND missing(TypeofResearch_3) AND missing(TypeofResearch_4).
COMPUTE DoesOnlyQuantitative = (TypeofResearch_1 = 1) AND missing(TypeofResearch_2) AND missing(TypeofResearch_3) AND missing(TypeofResearch_4).
COMPUTE DoesOnlyTheoretical = missing(TypeofResearch_1) AND missing(TypeofResearch_2) AND (TypeofResearch_3 = 1) AND missing(TypeofResearch_4).
EXECUTE.

* Some basic frequencies

FREQUENCIES VARIABLES=Pos_2 Faculty_2 OSCU Gender Nationality
   /ORDER=ANALYSIS.

FREQUENCIES VARIABLES =DoesOnlyQualitative DoesOnlyQuantitative DoesOnlyTheoretical
    /ORDER = ANALYSIS.

*Frequencies of Awareness

FREQUENCIES VARIABLES = Prac_Aw_1_1 TO Prac_Aw_1_12
    /ORDER = ANALYSIS.

* Frequency analysis per Faculty

SORT CASES  BY Faculty_2.
SPLIT FILE LAYERED BY Faculty_2.

* Frequencies: Awareness
    
FREQUENCIES VARIABLES = Prac_Aw_1_1 TO Prac_Aw_1_12
 /ORDER=ANALYSIS.

* Frequencies : Attitudes

FREQUENCIES VARIABLES = Prac_Att_1 TO Prac_Att_12
    /ORDER=ANALYSIS.

* Frequencies: Behaviors
    
FREQUENCIES VARIABLES = Prac_Beh_1 TO Prac_Beh_12
/ORDER=ANALYSIS.

SPLIT FILE OFF.

* Frequency analysis per Position

SORT CASES  BY Pos_2.
SPLIT FILE LAYERED BY Pos_2.

* Frequencies: Awareness
    
FREQUENCIES VARIABLES = Prac_Aw_1_1 Prac_Aw_1_2 Prac_Aw_1_3 Prac_Aw_1_4 Prac_Aw_1_5 Prac_Aw_1_6 Prac_Aw_1_7 Prac_Aw_1_8 Prac_Aw_1_9 Prac_Aw_1_10 Prac_Aw_1_11 Prac_Aw_1_12
 /ORDER=ANALYSIS.

* Frequencies : Attitudes

FREQUENCIES VARIABLES = Prac_Att_1 Prac_Att_2 Prac_Att_3 Prac_Att_4 Prac_Att_5 Prac_Att_6 Prac_Att_7 Prac_Att_8 Prac_Att_9 Prac_Att_10 Prac_Att_11 Prac_Att_12
    /ORDER=ANALYSIS.

* Frequencies: Behaviors
    
FREQUENCIES VARIABLES = Prac_Beh_1 Prac_Beh_2 Prac_Beh_3 Prac_Beh_4 Prac_Beh_5 Prac_Beh_6 Prac_Beh_7 Prac_Beh_8 Prac_Beh_9 Prac_Beh_10 Prac_Beh_11 Prac_Beh_12
/ORDER=ANALYSIS.

SPLIT FILE OFF.

* specify "I don't know" as missing for at
MISSING VALUES Prac_Att_1 TO Prac_Att_12 (6).
        
MISSING VALUES OppMat_1 TO OppMat_10 (6).
    
MISSING VALUES BarMat_1 TO BarMat_10 (6).


CROSSTABS
  /TABLES=TypeOfResearch_1 TypeOfResearch_2 TypeOfResearch_3 TypeOfResearch_4  BY 
    Human
  /FORMAT=AVALUE TABLES
  /CELLS=COUNT EXPECTED ROW COLUMN TOTAL 
  /COUNT ROUND CELL.

IF  (TypeOfResearch_1 = 1) Empirical=1.
EXECUTE.
IF  (TypeOfResearch_2 = 1) Empirical=1.
EXECUTE.
IF  (TypeOfResearch_3 = 1) Empirical=1.
EXECUTE.
IF  (TypeOfResearch_4 = 1) Empirical=1.
EXECUTE.


FREQUENCIES VARIABLES=OSCU Empirical Human
  /ORDER=ANALYSIS.

* frequencies of strategic themes

FREQUENCIES VARIABLES = ST_themes_1 TO ST_themes_6
    /ORDER = ANALYSIS.

**several crosstabs currently not in the report; good to use/add for an appendix to describe frequencies across demographics and work characteristics;
**demographics and work characteristics are not independent of each other** 

CROSSTABS
  /TABLES=OSCU BY Faculty
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT EXPECTED ROW COLUMN TOTAL BPROP 
  /COUNT ROUND CELL.


CROSSTABS
  /TABLES=Empirical BY Human
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT EXPECTED ROW COLUMN TOTAL BPROP 
  /COUNT ROUND CELL.


CROSSTABS
  /TABLES=OSCU BY Human
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT EXPECTED ROW COLUMN TOTAL BPROP 
  /COUNT ROUND CELL.

*frequency table awareness 

FREQUENCIES VARIABLES=Prac_Aw_1_1 Prac_Aw_1_2 Prac_Aw_1_3 Prac_Aw_1_4 Prac_Aw_1_5 Prac_Aw_1_6 Prac_Aw_1_7 
    Prac_Aw_1_8 Prac_Aw_1_9 Prac_Aw_1_10 Prac_Aw_1_11 Prac_Aw_1_12
  /ORDER=ANALYSIS.


*frequency table attitudes

FREQUENCIES VARIABLES=Prac_Att_1 Prac_Att_2 Prac_Att_3 Prac_Att_4 Prac_Att_5 Prac_Att_6 Prac_Att_7 
    Prac_Att_8 Prac_Att_9 Prac_Att_10 Prac_Att_11 Prac_Att_12
  /ORDER=ANALYSIS.


*frequency table behaviors

FREQUENCIES VARIABLES=Prac_Beh_1 Prac_Beh_2 Prac_Beh_3 Prac_Beh_4 Prac_Beh_5 Prac_Beh_6 Prac_Beh_7 
    Prac_Beh_8 Prac_Beh_9 Prac_Beh_10 Prac_Beh_11 Prac_Beh_12
  /ORDER=ANALYSIS.



**Repeated measures analysis: inspect attitude-behavior gap
**Listwise deletions is used as pairwise is not possible in spss

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

*recode nationality

RECODE Nationality (1=1) (2=0) (MISSING=SYSMIS) INTO Nat.
EXECUTE.

ADD VALUE LABELS Nat 0 'Other' 1 'Dutch'.

FREQUENCIES VARIABLES=Nat Gen
  /ORDER=ANALYSIS.

*Recode contract type (fulltime/parttime)

 RECODE Contr (2=0) (3=0) (1=1) (MISSING=SYSMIS) INTO Contract.
  EXECUTE.

ADD VALUE LABELS Contract 0 'Not Permanent' 1 'Permanent'.

**make dummies for Faculty
*DF1

IF  (Faculty = 1) Fd1=0.
EXECUTE.
IF  (Faculty = 2) Fd1=1.
EXECUTE.
IF  (Faculty >2 ) Fd1=0.
EXECUTE.


*DF2

IF  (Faculty < 3) Fd2=0.
EXECUTE.
IF  (Faculty = 3) Fd2=1.
EXECUTE.
IF  (Faculty >3 ) Fd2=0.
EXECUTE.



*DF3

IF  (Faculty < 4) Fd3=0.
EXECUTE.
IF  (Faculty = 4) Fd3=1.
EXECUTE.
IF  (Faculty >4 ) Fd3=0.
EXECUTE.



*DF4

IF  (Faculty < 5) Fd4=0.
EXECUTE.
IF  (Faculty = 5) Fd4=1.
EXECUTE.
IF  (Faculty >5 ) Fd4=0.
EXECUTE.


*DF5

IF  (Faculty < 6) Fd5=0.
EXECUTE.
IF  (Faculty = 6) Fd5=1.
EXECUTE.
IF  (Faculty >6 ) Fd5=0.
EXECUTE.


*DF6

IF  (Faculty < 7) Fd6=0.
EXECUTE.
IF  (Faculty = 7) Fd6=1.
EXECUTE.


** Run Attitude Behavior Gap Analyses Seperately per position
** Split file According to Position

SORT CASES  BY Pos_2.
SPLIT FILE LAYERED BY Pos_2.

* run analyses

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

* turn split file off
    
SPLIT FILE OFF.

**Opportunities and barriers

FREQUENCIES VARIABLES=OppMat_1 TO OppMat_10
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


* Split file by faculty

SORT CASES  BY Faculty_2.
SPLIT FILE LAYERED BY Faculty_2.

* Demographics

FREQUENCIES VARIABLES=Pos_2 Faculty_2 OSCU Gender Nationality
   /ORDER=ANALYSIS.

*awareness frequencies

FREQUENCIES VARIABLES=Prac_Aw_1_1 Prac_Aw_1_2 Prac_Aw_1_3 Prac_Aw_1_4 Prac_Aw_1_5 Prac_Aw_1_6 Prac_Aw_1_7 
    Prac_Aw_1_8 Prac_Aw_1_9 Prac_Aw_1_10 Prac_Aw_1_11 Prac_Aw_1_12
  /ORDER=ANALYSIS.

* behavior frequencies

FREQUENCIES VARIABLES=Prac_Beh_1 Prac_Beh_2 Prac_Beh_3 Prac_Beh_4 Prac_Beh_5 Prac_Beh_6 Prac_Beh_7 
    Prac_Beh_8 Prac_Beh_9 Prac_Beh_10 Prac_Beh_11 Prac_Beh_12
  /ORDER=ANALYSIS.

* run analyses

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

* Opportunities and barriers

FREQUENCIES VARIABLES=Op3_1 TO Op3_10
  /ORDER=ANALYSIS.

FREQUENCIES VARIABLES=Bar3_1 TO Bar3_10
  /ORDER=ANALYSIS.

* turn split file off
    
SPLIT FILE OFF.


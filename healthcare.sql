use dialysis_of_patients;
show tables;
desc dialysis_one;
drop table dialysis_one;
select * from dialysis_one limit 5;
select * from dialysis_two limit 5;

# 1.Number of Patients across various summaries

SELECT
    sum(Numberofpatientsincludedinthetransfusionsummary)AS TransfusionPatients,
    SUM(Numberofpatientsinhypercalcemiasummary)AS HypercalcemiaPatients,
    SUM(NumberofpatientsinSerumphosphorussummary) AS SerumPhosphorusPatients,
    SUM(Numberofpatientsincludedinhospitalizationsummary) AS HospitalizationPatients,
    SUM(Numberofhospitalizationsincludedinhospitalreadmissionsummary)AS HospitalReadmissionPatients,
    SUM(NumberofPatientsincludedinsurvivalsummary) AS SurvivalPatients,
    SUM(NumberofPatientsincludedinfistulasummary)AS FistulaPatients,
    SUM(Numberofpatientsinlongtermcathetersummary) AS LongCatheterPatients,
    SUM(NumberofpatientsinnPCRsummary) AS nPCRPatients
FROM
    dialysis_one_co;
    
# 2.Profit Vs Non-Profit Stats

select State,
count(case when ProfitorNonProfit = 'Profit'then 1 else null end) as Profit,
count(case when ProfitorNonProfit= 'Non-Profit' then 1 else null end) as NonProfit,
count(ProfitorNonProfit) as profitornonprofit
from dialysis_one_co group by State order by ProfitorNonProfit desc ;

# 3.Chain Organizations w.r.t. Total Performance Score as No Score
select * from dialysis_one ;
SELECT ChainOrganization , count(TotalPerformanceScore)  as NoScore
FROM dialysis_one_co as d1 JOIN dialysis_two_co as d2 ON 
d1.FacilityName = d2.FacilityName 
group by ChainOrganization;

    
 # 4.Dialysis Stations Stats
 
 select State,count(NoofDialysisStations) as Dialysis_Stations from dialysis_one_co group by State order by Dialysis_Stations desc;
 
 # 5.# of Category Text  - As Expected
 
 SELECT
    count(CASE WHEN PatientTransfusioncategorytext = 'As Expected' tHEN 1 ELSE 0 END) AS TransfusionAsExpected,
    count(CASE WHEN Patienthospitalizationcategorytext = 'As Expected' THEN 1 ELSE 0 END) AS HospitalizationAsExpected,
    count(CASE WHEN PatientHospitalReadmissionCategory = 'As Expectedialysis_one_cod' THEN 1 ELSE 0 END) AS HospitalReadmissionsAsExpected,
    count(CASE WHEN PatientSurvivalCategoryText= 'As Expected' THEN 1 ELSE 0 END) AS SurvivalAsExpected,
    count(CASE WHEN PatientInfectioncategorytext = 'As Expected' THEN 1 ELSE 0 END) AS InfectionAsExpected,
    count(CASE WHEN FistulaCategoryText = 'As Expected' THEN 1 ELSE 0 END) AS FistulaAsExpected,
    count(CASE WHEN SWRcategorytext = 'As Expected' THEN 1 ELSE 0 END) AS SWRAsExpected,
    count(CASE WHEN PPPWcategorytext = 'As Expected' THEN 1 ELSE 0 END) AS PPPWAsExpected
FROM
    dialysis_one_co;

# 6. Average Payment Reduction Rate

SELECT
SUM(PY2020PaymentReductionPercentage) / COUNT(*) AS AveragePaymentReductionRate
FROM dialysis_two_co
WHERE PY2020PaymentReductionPercentage IS NOT NULL;



 
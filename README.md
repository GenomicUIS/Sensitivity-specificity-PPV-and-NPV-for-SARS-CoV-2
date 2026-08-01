Sensitivity, specificity, PPV, and NPV for SARS-CoV-2 detection by RT-qPCR
This repository contains the R code used to calculate the sensitivity, specificity, positive predictive value (PPV), and negative predictive value (NPV) of the singleplex and multiplex RT-qPCR assays evaluated in the article:
•	Cadena-Caballero CE, Vera-Cala LM, Barrios-Hernandez C et al. Denaturing and dNTPs reagents improve SARS-CoV-2 detection via single and multiplex RT-qPCR. F1000Research 2026, 11:331 (https://doi.org/10.12688/f1000research.109673.3)
The analysis compares the classifications obtained with the commercial RT-qPCR formulation and with the denaturing solution method. Calculations were performed separately for the singleplex and multiplex reactions. This repository supports the exploratory diagnostic performance calculations presented in Table 4 of the associated article.
Classification of RT-qPCR results
For the analyses reported in the article, Ct values between 18 and 35 were established as the positive operational range based on inspection of the amplification profiles.
A reaction was classified as positive when it met the following criteria:
1.	It had a Ct value within the operational range of 18 to 35.
2.	It showed a clearly defined sigmoidal amplification curve consistent with the expected amplification profile.
Results outside this Ct range, or those that did not show an appropriate amplification curve, were considered non-positive or indeterminate during the experimental review. Because diagnostic performance measures are calculated from binary 2 × 2 contingency tables, only the final positive and negative classifications included in each comparison were coded in the R script. The current script does not import Ct values, inspect amplification curves, or automatically apply the Ct range. Experimental results must be reviewed and classified beforehand, prior to entering the corresponding counts into the script.
Contingency table structure
The expected or reference classification and the classification obtained with the evaluated reaction were organized into 2 × 2 contingency tables:
Evaluated result	Positive reference	Negative reference
Positive	True positive (TP)	False positive (FP)
Negative	False negative (FN)	True negative (TN)

In the R script:
•	truth represents the expected or reference classification.
•	pred represents the classification obtained with the evaluated assay.
•	Event represents a positive result.
•	No Event represents a negative result.
The confusionMatrix() function from the caret package was used to calculate the diagnostic performance measures.


Diagnostic performance measures
Sensitivity
Sensitivity measures the proportion of reference-positive results that were correctly identified as positive by the evaluated assay.
$$
\frac{\mathrm{TP}}{\mathrm{TP}+\mathrm{FN}}
$$
Specificity
Specificity measures the proportion of reference-negative results that were correctly identified as negative by the evaluated assay.
$$
\frac{\mathrm{TN}}{\mathrm{TN}+\mathrm{FP}}
$$
Positive predictive value
Positive predictive value indicates the proportion of results classified as positive by the evaluated assay that were true positives.
$$
\frac{\mathrm{TP}}{\mathrm{TP}+\mathrm{FP}}
$$
Negative predictive value
Negative predictive value indicates the proportion of results classified as negative by the evaluated assay that were true negatives.
$$
\frac{\mathrm{TN}}{\mathrm{TN}+\mathrm{FN}}
$$
Where:
•	True positive (TP): the evaluated result was positive and the reference result was also positive.
•	False negative (FN): the evaluated result was negative, but the reference result was positive.
•	False positive (FP): the evaluated result was positive, but the reference result was negative.
•	True negative (TN): the evaluated result was negative and the reference result was also negative.
Analyses included
The script calculates performance measures for four comparisons:
1.	Singleplex RT-qPCR with the commercial formulation.
2.	Singleplex RT-qPCR with the denaturing solution.
3.	Multiplex RT-qPCR with the commercial formulation.
4.	Multiplex RT-qPCR with the denaturing solution.
The dNTP formulation was not included in these diagnostic performance calculations because the number and distribution of available positive and negative results did not allow a sufficiently informative 2 × 2 comparison.
Requirements
The analysis was implemented in R using the following packages:
library(caret)
library(ggplot2)
library(lattice)
The caret package performs the confusion matrix calculations. The ggplot2 and lattice packages are loaded as supporting dependencies within the original analytical environment.
The packages can be installed using:
install.packages(c("caret", "ggplot2", "lattice"))
Running the analysis
1.	Download or clone this repository.
2.	Open the file Calculate_sensitivity_specificity_v2.R in R or RStudio.
3.	Verify that the required packages are installed.
4.	Run the complete script.
The script generates a contingency table and a confusionMatrix result for each experimental comparison.
table(pred, truth)
confusionMatrix(table(pred, truth))
To analyze a different dataset, replace the counts used to construct the truth and pred factors while maintaining the correspondence between the reference classification and the classification obtained with the evaluated assay.
Interpretation
These calculations were performed as an exploratory comparison of the RT-qPCR formulations evaluated in the associated study. Therefore, the estimates should not be interpreted as an independent clinical validation of a diagnostic test.
Sensitivity and specificity depend on the composition and size of the evaluated dataset. Likewise, PPV and NPV are influenced by the proportion of positive and negative results included in the analysis.
A specificity value of zero indicates that, within that particular comparison, none of the reference-negative observations was classified as negative by the evaluated assay. This does not mean that the assay has zero specificity in all populations, experiments, or application conditions.
Data availability
The experimental data associated with the article are available in the corresponding Zenodo repository:
•	https://doi.org/10.5281/zenodo.6337537

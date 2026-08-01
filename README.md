# Sensitivity, Specificity, PPV, and NPV for SARS-CoV-2 Detection by RT-qPCR

This repository contains the **R code** used to calculate sensitivity, specificity, positive predictive value (**PPV**), and negative predictive value (**NPV**) for the singleplex and multiplex RT-qPCR assays evaluated in the following article:

> Cadena-Caballero CE, Vera-Cala LM, Barrios-Hernandez C, et al. **Denaturing and dNTPs reagents improve SARS-CoV-2 detection via single and multiplex RT-qPCR.** *F1000Research*. 2026;11:331.  
> https://doi.org/10.12688/f1000research.109673.3

The analysis compares the classifications obtained using the commercial RT-qPCR formulation and the denaturing solution method. Calculations were performed separately for the singleplex and multiplex reactions.

This repository supports the exploratory internal performance calculations presented in Table 4 of the associated article. These calculations were based on predefined operational Ct criteria and did not use an independent clinical reference standard.

---

## Contents

- [Classification of RT-qPCR results](#classification-of-rt-qpcr-results)
- [Contingency-table structure](#contingency-table-structure)
- [Diagnostic-performance measures](#diagnostic-performance-measures)
- [Analyses included](#analyses-included)
- [Requirements](#requirements)
- [Running the analysis](#running-the-analysis)
- [Interpretation](#interpretation)
- [Data availability](#data-availability)

---

## Classification of RT-qPCR results

For the analyses reported in the article, Ct values between **18 and 35** were established as the positive operational range based on inspection of the amplification profiles.

A reaction was classified as positive when it met both of the following criteria:

1. It showed a Ct value within the operational range of **18–35**.
2. It showed a clearly defined sigmoidal amplification curve compatible with the expected amplification profile.

Results outside this Ct range, or results without an appropriate amplification curve, were considered non-positive or indeterminate during the experimental review.

Because diagnostic-performance measures are calculated from binary **2 × 2 contingency tables**, the R script includes only the final positive and negative classifications used in each comparison.

> **Important:** The current script does not import Ct values, inspect amplification curves, or automatically apply the Ct interval. Experimental results must be reviewed and classified before the corresponding counts are entered into the script.

---

## Contingency-table structure

The expected or reference classification and the classification obtained with the evaluated reaction were organized into **2 × 2 contingency tables**.

| Evaluated result | Reference positive | Reference negative |
|---|---:|---:|
| Positive | True positive (TP) | False positive (FP) |
| Negative | False negative (FN) | True negative (TN) |

In the R script:

- `truth` represents the operational reference classification assigned internally using the predefined Ct range of 18–35 together with the presence of an appropriate sigmoidal amplification curve.
- `pred` represents the positive or negative classification obtained with the evaluated reaction in each experimental block.
- `Event` represents a positive result.
- `No Event` represents a negative result.

The `confusionMatrix()` function from the **caret** package was used to calculate the diagnostic-performance measures.

In this exploratory analysis, TP, TN, FP, and FN refer to agreements or disagreements relative to the internal operational reference classification. They should not be interpreted as classifications established against an independent clinical reference standard.

---

## Diagnostic-performance measures

### Sensitivity

Sensitivity measures the proportion of reference-positive results that were correctly identified as positive by the evaluated assay.

$$
\mathrm{Sensitivity} =
\frac{\mathrm{TP}}
{\mathrm{TP}+\mathrm{FN}}
$$

### Specificity

Specificity measures the proportion of reference-negative results that were correctly identified as negative by the evaluated assay.

$$
\mathrm{Specificity} =
\frac{\mathrm{TN}}
{\mathrm{TN}+\mathrm{FP}}
$$

### Positive predictive value

The positive predictive value indicates the proportion of results classified as positive by the evaluated assay that were true positives.

$$
\mathrm{PPV} =
\frac{\mathrm{TP}}
{\mathrm{TP}+\mathrm{FP}}
$$

### Negative predictive value

The negative predictive value indicates the proportion of results classified as negative by the evaluated assay that were true negatives.

$$
\mathrm{NPV} =
\frac{\mathrm{TN}}
{\mathrm{TN}+\mathrm{FN}}
$$

Where:

- **True positive (TP):** the evaluated result was positive and the reference result was also positive.
- **False negative (FN):** the evaluated result was negative, but the reference result was positive.
- **False positive (FP):** the evaluated result was positive, but the reference result was negative.
- **True negative (TN):** the evaluated result was negative and the reference result was also negative.

---

## Analyses included

The script calculates diagnostic-performance measures for four comparisons:

1. Singleplex RT-qPCR using the commercial formulation.
2. Singleplex RT-qPCR using the denaturing solution.
3. Multiplex RT-qPCR using the commercial formulation.
4. Multiplex RT-qPCR using the denaturing solution.

The aggregated contingency counts were as follows:

Singleplex commercial: TP = 6, FP = 2, FN = 8, TN = 1.
Singleplex denaturing: TP = 2, FP = 8, FN = 0, TN = 0.
Multiplex commercial: TP = 16, FP = 4, FN = 2, TN = 0.
Multiplex denaturing: TP = 15, FP = 2, FN = 5, TN = 0.

The dNTP formulation was not included in these diagnostic-performance calculations because the number and distribution of available positive and negative results did not allow a sufficiently informative **2 × 2 comparison**.

---

## Requirements

The analysis was implemented in **R** using the following packages:

```r
library(caret)
library(ggplot2)
library(lattice)
```

The **caret** package performs the confusion-matrix calculations. The **ggplot2** and **lattice** packages are loaded as supporting dependencies in the original analytical environment.

Install the required packages with:

```r
install.packages(c("caret", "ggplot2", "lattice"))
```

---

## Running the analysis

1. Download or clone this repository.
2. Open `Calculate_sensitivity_specificity_v2.R` in R or RStudio.
3. Verify that the required packages are installed.
4. Run the complete script.

The script generates a contingency table and a `confusionMatrix` result for each experimental comparison:

```r
table(pred, truth)
confusionMatrix(table(pred, truth))
```

To analyze a different dataset, replace the counts used to construct the `truth` and `pred` factors while maintaining the correspondence between the reference classification and the classification obtained with the evaluated assay.

---

## Interpretation

These calculations were performed as an exploratory comparison of the RT-qPCR formulations evaluated in the associated study. Therefore, the estimates should not be interpreted as an independent clinical validation of a diagnostic test.

Sensitivity and specificity depend on the composition and size of the evaluated dataset. PPV and NPV are also influenced by the proportion of positive and negative results included in the analysis.

A specificity value of zero indicates that, within that particular comparison, none of the reference-negative observations were classified as negative by the evaluated assay.

For the commercial multiplex condition, specificity was calculated as TN/(TN + FP) = 0/(0 + 4) = 0.0. For the denaturing multiplex condition, specificity was calculated as 0/(0 + 2) = 0.0. These values resulted from the absence of true-negative classifications relative to the operational reference in the evaluated subsets. They should not be interpreted as evidence of zero analytical or clinical specificity.

> This does not mean that the assay has zero specificity in every population, experiment, or application condition.

The analysis was limited by the small and imbalanced experimental subsets and was based on aggregated contingency counts. Accordingly, the reported sensitivity, specificity, PPV, and NPV values are exploratory internal estimates and should not be extrapolated to clinical diagnostic performance.

---

## Data availability

The analytical script and its supporting documentation are available in this GitHub repository. The experimental data associated with the article are available in the corresponding Zenodo repository:

https://doi.org/10.5281/zenodo.6337537

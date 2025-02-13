# **PAPER**: https://ascpt.onlinelibrary.wiley.com/doi/10.1002/psp4.13273

# Introduction

## What is this study about?

This study focuses on how Artificial Intelligence (AI) can be used to estimate a person's physiological age (PA) using biomarkers (measurable indicators in blood and urine).
Instead of just using chronological age (CA) (the number of years a person has lived), PA gives a better idea of someone's biological health.
The researchers wanted to understand how PA affects drug metabolism, meaning how the body processes medications.


## Why is this important?

Aging affects health, diseases, and how drugs work in the body.
Knowing a person’s true biological age could help in personalized medicine, where doctors prescribe treatments based on PA instead of CA.


## How was the study conducted?

The researchers used data from 22,307 people from the National Health and Nutrition Examination Survey (NHANES).

They created two AI models to estimate PA:
* PA-M1 Model: Uses body composition, blood and urine biomarkers, and disease history.
* PA-M2 Model: Uses only blood and urine biomarkers (no body composition or disease history).
  

## What data did they use?

* Biomarkers from blood and urine (e.g., cholesterol, sugar levels, kidney function markers).
* Body composition (e.g., fat percentage, lean mass, BMI).
* Disease status (e.g., diabetes, heart disease, kidney disease).
* Genetic factors (e.g., telomere length, which relates to aging at a cellular level).

  
## How did they build the AI models?

They used ensemble learning, a method in AI that combines multiple models to improve accuracy.
The models were trained on data from people aged 18 to 79.
They tested the models to ensure they worked correctly.


# Results

## How does PA compare to CA?

The AI models showed that PA is often different from CA:
Younger people sometimes had a PA higher than their CA if they had poor health habits.
Older adults with healthy habits sometimes had a PA lower than their CA.
PA was not biased by race or gender, meaning the AI models worked fairly for different groups.


## Key Factors Affecting PA

PA-M1 Top Factors:
* Klotho (a protein linked to aging and longevity)
* Lean body mass (muscle mass)
* Glycohemoglobin (blood sugar levels, related to diabetes)
* Systolic blood pressure (heart health indicator)

PA-M2 Top Factors:

* Glycohemoglobin
* Serum creatinine (kidney function marker)
* Total cholesterol (heart health marker)
* Urine creatinine (kidney function marker)

## How is PA linked to drug metabolism?

The study found that PA influences how well Phase 1 drug-metabolizing enzymes (like CYP2E1, CYP1A2, CYP2A6) function.
* Older PA = slower drug metabolism, meaning drugs may stay in the body longer, increasing side effects.

* Younger PA = faster metabolism, meaning drugs are broken down quickly and may require higher doses.

## Disease and PA

People with diabetes, heart disease, and kidney disease had a PA higher than their CA.
This suggests that chronic diseases accelerate aging.

## What does this study mean for medicine?

Doctors could use PA instead of CA to predict health risks and personalize treatments.
Drug dosages could be adjusted based on PA, making medications safer and more effective.
Early disease detection: If someone’s PA is much higher than their CA, it may indicate underlying health problems before symptoms appear.

## What’s next?

Future research should test how PA-based predictions affect real-world medical decisions.
More studies could combine PA with genetic data to improve accuracy.


# Conclusion

AI models can accurately estimate physiological age using biomarkers.
PA is linked to drug metabolism, mortality risk, and chronic diseases.
These findings could improve precision medicine, making healthcare more tailored to individual patients.


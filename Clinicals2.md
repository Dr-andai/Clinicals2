Clinical Trials Part 2
================
David Andai
11/30/2022

Clinical trials can be expensive to run. Due to the high cost of running
one, Big Pharma conduct most of the clinical trials. In a couple of
instances, Big Pharma has been in the spotlight for influencing the
results of clinical trials. A negative influence on clinical trial
results and outcomes may be dangerous to the population.

The scope of Clinical trial sponsors has actively changed over a couple
of years to include independent organizations and professionals,
following designs and protocols agreed upon by all parties and approved
by ethical review boards. Long-term phase 3 trials are vital to sponsors
and aimed at providing an adequate basis for a submission for marketing
approval. These studies have a long duration and are likely to show
long-term or rare side effects. Studies in phase 3 are conducted across
a large patient population and should include a population
representative of the intended target population that will use the drug.
Hence, phase 3 trials can be multicenter, occurring in different
countries. Here are some of the Sponsors of Phase 3 clinical trials that
are ongoing in Kenya. World Health Organization Title: Low dose
magnesium sulphate for treatment of seizures in pregnancy Target size:
Condition/Disease: Pre-Eclampsia Drug: Magnesium Sulphate Estimated
completion date: 2023 Global Network for Womens’ and Childrens’ Health
Title: Prevention of Iron Deficiency Anemia Post-delivery (PRIORITY)
Target size: Condition/Disease: Postpartum anemia Drug: Iv iron
infusion, Oral tablets Estimated completion date: December 1, 2025
Hoffman La Roche Title: Phase-III STUDY TO DETERMINE SAFETY AND EFFICACY
OF GIREDESTRANT COMPARED WITH PHYSICIANS CHOICE IN PATIENTS WITH
ESTROGEN RECEPTOR POSITIVE, HER2 NEGATIVE EARLY BREAST CANCER Study
Design: Randomized, Parallel Group, Active Controlled Trial
Condition/Disease: Breast Cancer Drug: Giredestrant, Endocrine Therapy
of Physician’s Choice, LHRH Agonist Estimated completion date: December
19, 2025

Academic Medical Centre at the University of Amsterdam Title: Evaluation
of a new and simple diagnostic test for malaria Target size: 4700
Condition/Disease: Malaria Drug: Rapid Diagnostic Test Estimated
completion date: 2023 Global Antibiotic Research and Development
Partnership Title: NeoSep1: a study to determine the ranking of existing
and new antibiotics combinations to treat newborn babies who are in
hospital with severe sepsis Target size: 3060 Condition/Disease:
Neonatal sepsis Drug: Amikacin, Flomoxef and Fosfomycin Estimated
completion date: 2023

``` r
#Data Visualization: Primary Sponsors of on going Phase 3 Clinical Trials in Kenya
plot1 <- ggplot(data = p3,
       aes((y = reorder(Primary_sponsor, -Target_size)), x = Target_size, fill = Target_size))+
  geom_bar(stat = "identity", show.legend = FALSE)+
  labs (title = "Phase 3 Clinical Trials in Kenya",
        subtitle = "In 01-01-2022 to 31-10-2022",
        y = "Primary Sponsors",
        x = "Population Target size")+
  theme_few()
```

``` r
plot1
```

![](Clinicals2_files/figure-gfm/unnamed-chunk-5-1.png)<!-- -->

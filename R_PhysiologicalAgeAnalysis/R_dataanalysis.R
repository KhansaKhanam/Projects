install.packages("readr")

library(dplyr)
library(readr)
library(nhanesA)
library(ggplot2)

# Function to retrieve nhanes demographic files 
demo <- function(files_demo) {
  for (year in names(files_demo)){
    assign(paste0("demo_", year), nhanes(files_demo[[year]]), envir = .GlobalEnv)
  }
}

# Function to retrieve nhanes mortality files 
mortality <- function(files_mort){
  for (year in names(files_mort)){
    assign(paste0("mort_",year), read_fwf(file=files_mort[[year]],
                                          col_types = "iiiiiiii",
                                          fwf_cols(SEQN = c(1,6),
                                                   ELIGSTAT = c(15,15),
                                                   MORTSTAT = c(16,16),
                                                   UCOD_LEADING = c(17,19),
                                                   DIABETES = c(20,20),
                                                   HYPERTEN = c(21,21),
                                                   PERMTH_INT = c(43,45),
                                                   PERMTH_EXM = c(46,48)
                                          ),
                                          na = c("", ".")
    ),envir = .GlobalEnv)
  }
}

# Function to retrieve nhanes diabetes files 
diabetes <- function(files_diab){
  for (year in names(files_diab)){
    assign(paste0("diab_",year), nhanes(files_diab[[year]]), envir = .GlobalEnv)
  }
}

# Function to retrieve nhanes hepatitis files 
hepatitis <- function(files_hep){
  for (year in names(files_hep)){
    assign(paste0("hep_",year), nhanes(files_hep[[year]]), envir = .GlobalEnv)
  }
}

# Function to retrieve nhanes kidney files 
kidney <- function(files_kidn){
  for (year in names(files_kidn)){
    assign(paste0("kidn_",year), nhanes(files_kidn[[year]]), envir = .GlobalEnv)
  }
}

# Function to retrieve nhanes medical conditions files 
medcond <- function(files_medc){
  for (year in names(files_medc)){
    assign(paste0("medc_",year), nhanes(files_medc[[year]]), envir = .GlobalEnv)
  }
}

# main fuction that passes year and filename to the fuctions
files_demo <- list("2009"="DEMO_F","2011"="DEMO_G","2013"="DEMO_H","2015"="DEMO_I","2017"="DEMO_J")
demo(files_demo)

files_mort <- list("2009"="NHANES_2009_2010_MORT_2019_PUBLIC.dat","2011"="NHANES_2011_2012_MORT_2019_PUBLIC.dat","2013"="NHANES_2013_2014_MORT_2019_PUBLIC.dat","2015"="NHANES_2015_2016_MORT_2019_PUBLIC.dat","2017"="NHANES_2017_2018_MORT_2019_PUBLIC.dat")
mortality(files_mort)

files_diab <- list("2009"="DIQ_F","2011"="DIQ_G","2013"="DIQ_H","2015"="DIQ_I","2017"="DIQ_J")
diabetes(files_diab)

files_hep <- list("2009"="HEQ_F","2011"="HEQ_G","2013"="HEQ_H","2015"="HEQ_I","2017"="HEQ_J")
hepatitis(files_diab)

files_kidn <- list("2009"="KIQ_U_F","2011"="KIQ_U_G","2013"="KIQ_U_H","2015"="KIQ_U_I","2017"="KIQ_U_J")
kidney(files_kidn)

files_medc <- list("2009"="MCQ_F","2011"="MCQ_G","2013"="MCQ_H","2015"="MCQ_I","2017"="MCQ_J")
medcond(files_medc)

# join all the tables on the primary key "SEQN"
# files = list("demo_",year,"diab_",year,"hep_",year,"kidn_",year,"medc_",year,"mort_",year)
join_tables <- function(years){
  for (year in years){
    demo <- get(paste0("demo_", year))
    diab <- get(paste0("diab_", year))
    hep <- get(paste0("hep_", year))
    kidn <- get(paste0("kidn_", year))
    medc <- get(paste0("medc_", year))
    mort <- get(paste0("mort_", year))
  
    joined_table <- demo %>%
      inner_join(diab, by="SEQN") %>%
      inner_join(hep, by="SEQN") %>%
      inner_join(kidn, by="SEQN") %>%
      inner_join(medc, by="SEQN") %>%
      inner_join(mort, by="SEQN")
  
    assign(paste0("table_",year),joined_table, envir = .GlobalEnv)
  }
}

years <- c("2009","2011","2013","2015","2017")
join_tables(years)

# removing duplicate columns in table_*year*
colnames(table_2009) <- make.names(colnames(table_2009), unique=TRUE)
colnames(table_2011) <- make.names(colnames(table_2011), unique=TRUE)
colnames(table_2013) <- make.names(colnames(table_2013), unique=TRUE)
colnames(table_2015) <- make.names(colnames(table_2015), unique=TRUE)
colnames(table_2017) <- make.names(colnames(table_2017), unique=TRUE)

# joining tables_list <- list(table_2009, table_2011, table_2013, table_2015, table_2017) into a single table
tables_list <- list(table_2009, table_2011, table_2013, table_2015, table_2017)
tables_list <- lapply(tables_list, function(df){
  df <- mutate_if(df,is.factor,as.integer)
  df <- mutate_if(df,is.numeric,as.integer)
  df <- mutate_if(df,is.character,as.integer)
  return(df) 
  })
combined_table <- bind_rows(tables_list)

# Data mutation of the table 
## Adding new columns to the table

# Function to create new variable with no diabetes or pre-diabetes, pre-diabetes, or diabetes
# Function to create new variable with no kidney disease, kidney disease, kidney disease with dialysis
# Function to create new variable with no heart disease, coronary artery disease, congestive heart failure and heart attack
# Function to create new variable with no current liver disease, current liver disease, active hepatitis B and active hepatitis C
# Function to create new variable with no diabetes or pre-diabetes, pre-diabetes, or diabetes
# Function to create new variable with no diabetes or pre-diabetes, pre-diabetes, diabetes with insulin, diabetes No insulin
# Function to create new variable with no kidney disease, kidney disease, kidney disease with dialysis
# Function to create new variable with no heart disease, coronary artery disease, congestive heart failure and heart attack
# Function to create new variable with no current liver disease, current liver disease, active hepatitis B and active hepatitis C

combined_table <- combined_table %>%
  mutate(DiabetesYesNo=case_when(
    DIQ010.x==1 ~ "Yes",
    DIQ010.x==2 ~ "No",
    DIQ010.x==3 ~ "No",
    TRUE ~ NA_character_),
    PreDiabetesOrDiabetesYesNo=case_when(
      DIQ160.x==1 ~ "Yes",
      DIQ010.x==3 ~ "Yes",
      DIQ010.x==1 ~ "Yes",
      DIQ160.x==2 ~ "No",
      DIQ010.x==2 ~ "No",
      TRUE ~ NA_character_),
    InsulinYesNo=case_when(
      DIQ050.x==1 ~ "Yes",
      DIQ050.x==2 ~ "No",
      DIQ010.x==2 ~ "No",
      TRUE ~ NA_character_),
    DialysisYesNo=case_when(
      KIQ025 == 1 ~ "Yes",
      KIQ025 == 2  ~ "No",
      KIQ022 == 1 ~ "No",
      KIQ022 == 2  ~ "No",
      TRUE ~ NA_character_),
    KidneyDiseaseYesNo=case_when(
      KIQ022 == 1  ~ "Yes",
      KIQ022 == 2  ~ "No",
      TRUE ~ NA_character_),
    HeartAttackYesNo=case_when(
      MCQ160E == 1 ~ "Yes", 
      MCQ160E == 2 ~ "No",
      TRUE ~ NA_character_),
    CongestiveHeartFailureYesNo=case_when(
      MCQ160B == 1 ~ "Yes", 
      MCQ160B == 2 ~ "No",
      TRUE ~ NA_character_),
    CoronaryHeartDiseaseYesNo=case_when(
      MCQ160C == 1 ~ "Yes", 
      MCQ160C == 2 ~ "No",
      TRUE ~ NA_character_),
    AnginaPectorisYesNo=case_when(
      MCQ160D == 1 ~ "Yes", 
      MCQ160D == 2 ~ "No",
      TRUE ~ NA_character_),
    ActiveLiverDiseaseYesNo=case_when(
      MCQ170L == 1  ~ "Yes",
      MCQ170L == 2  ~ "No",
      MCQ160L == 2  ~ "No",
      TRUE ~ NA_character_),
    PastLiverDiseaseYesNo=case_when(
      MCQ170L == 2  ~ "Yes",
      MCQ160L == 2  ~ "No",
      MCQ160L == 1  ~ "No",
      TRUE ~ NA_character_),
    HepatitisCYesNo=case_when(
      #HEPC_New == 1  ~ "Yes",
      #HEPC_New == 2   ~ "No",
      MCQ170L == 1  ~ "No",
      MCQ160L == 1  ~ "No",
      MCQ170L == 2  ~ "No",
      MCQ160L == 2  ~ "No",
      TRUE ~ NA_character_),
    HepatitisBYesNo=case_when(
      #HEPB_sAgNew == 1  ~ "Yes",
      #HEPB_sAgNew == 2   ~ "No",
      MCQ170L == 1   ~ "No",
      MCQ160L == 1   ~ "No",
      MCQ170L == 2  ~ "No",
      MCQ160L == 2  ~ "No",
      TRUE ~ NA_character_),
    StrokeYesNo=case_when(
      MCQ160F ==1 ~ "Yes", 
      MCQ160F == 2 ~ "No",
      TRUE ~ NA_character_),
    diabetesprediabetes=case_when(
      DIQ010.x==1 ~ "Diabetes", 
      DIQ010.x==3 ~ "PreDiabetes",
      DIQ160.x == 1  ~ "PreDiabetes", 
      DIQ160.x== 2 & DIQ010.x == 2 ~ "None",
      TRUE ~ NA),
    diabetes_cat=case_when(
      DIQ050.x == 1 ~ "DiabeteswithInsulin",
      diabetesprediabetes =="Diabetes"  ~ "DiabetesNoInsulin",
      diabetesprediabetes =="PreDiabetes"  ~ "PreDiabetes",
      diabetesprediabetes == "None"  ~ "None",
      TRUE ~ NA),
    kidney_cat=case_when(
      KIQ025 == 1 ~ "Dialysis",
      KIQ022 == 1  ~ "KidneyDisease",
      KIQ022 == 2  ~ "None",
      TRUE ~ NA),
    heart_cat=case_when(
      MCQ160E == 1 ~ "HeartAttack",
      MCQ160B == 1  ~ "CHF",
      MCQ160C == 1  ~ "CHD/AP",
      MCQ160D == 1  ~ "CHD/AP",
      MCQ160C == 2 & MCQ160B == 2 & MCQ160D == 2 & MCQ160E == 2   ~ "None",
      MCQ160C == 2 & MCQ160B == 2 & MCQ160E == 2   ~ "None",
      TRUE ~ NA),
    liver_cat=case_when(
      #HEPC_New == 1 ~ "HepC",
      #HEPB_sAgNew == 1  ~ "HepB",
      MCQ170L == 1  ~ "LiverDisease",
      MCQ170L == 2   ~ "None",
      MCQ160L == 2   ~ "None",
      TRUE ~ NA))

## Changing datatype 
combined_table$DiabetesYesNo <- as.factor(combined_table$DiabetesYesNo)
combined_table$PreDiabetesOrDiabetesYesNo <- as.factor(combined_table$PreDiabetesOrDiabetesYesNo)
combined_table$InsulinYesNo <- as.factor(combined_table$InsulinYesNo)
combined_table$DialysisYesNo <- as.factor(combined_table$DialysisYesNo)
combined_table$KidneyDiseaseYesNo <- as.factor(combined_table$KidneyDiseaseYesNo)
combined_table$HeartAttackYesNo <- as.factor(combined_table$HeartAttackYesNo)
combined_table$CongestiveHeartFailureYesNo <- as.factor(combined_table$CongestiveHeartFailureYesNo)
combined_table$CoronaryHeartDiseaseYesNo <- as.factor(combined_table$CoronaryHeartDiseaseYesNo)
combined_table$AnginaPectorisYesNo <- as.factor(combined_table$AnginaPectorisYesNo)
combined_table$ActiveLiverDiseaseYesNo <- as.factor(combined_table$ActiveLiverDiseaseYesNo)
combined_table$PastLiverDiseaseYesNo <- as.factor(combined_table$PastLiverDiseaseYesNo)
combined_table$HepatitisCYesNo <- as.factor(combined_table$HepatitisCYesNo)
combined_table$HepatitisBYesNo <- as.factor(combined_table$HepatitisBYesNo)
combined_table$StrokeYesNo <- as.factor(combined_table$StrokeYesNo)

# Ordering
combined_table$diabetes_cat <- ordered(combined_table$diabetes_cat, levels = c("None", "PreDiabetes", "DiabetesNoInsulin", "DiabeteswithInsulin"))
combined_table$kidney_cat <- ordered(combined_table$kidney_cat, levels = c("None", "KidneyDisease", "Dialysis"))
combined_table$heart_cat <- ordered(combined_table$heart_cat, levels = c("None", "CHD/AP", "CHF","HeartAttack"))
combined_table$liver_cat <- ordered(combined_table$liver_cat, levels = c("None", "LiverDisease", "HepB","HepC"))

# Saving the table
saveRDS(combined_table, "combined_table.rds")

# ggplot for ordered columns
ggplot(combined_table, aes(x=diabetes_cat)) + geom_bar() + labs(title="Diabetes Category", x="Diabetes Category", y="Count")
ggplot(combined_table, aes(x=kidney_cat)) + geom_bar() + labs(title="Kidney Category", x="Kidney Category", y="Count")
ggplot(combined_table, aes(x=heart_cat)) + geom_bar() + labs(title="Heart Category", x="Heart Category", y="Count")
ggplot(combined_table, aes(x=liver_cat)) + geom_bar() + labs(title="Liver Category", x="Liver Category", y="Count")

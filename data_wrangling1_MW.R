# Data Wrangling Assignment 1
library(dplyr)
library(tidyr)

# Load Data file
A <- read.csv("refine_orginal.csv")

# Convert all names in colummn company to lower case with the names philips, akzo, van houten and unilever

A$company <- gsub("^[[:alpha:]]+ps$", "philips", A$company, ignore.case = TRUE)
A$company <- gsub("(^a|^A)[[:alpha:]]+(o|0)$", "akzo", A$company, ignore.case = TRUE)
A$company <- gsub("ak zo", "akzo", A$company, ignore.case = TRUE)
A$company <- gsub("^[[:alpha:]]+(er)$", "unilver", A$company, ignore.case = TRUE)
A$company <- gsub(".*en", "van houten", A$company, ignore.case = TRUE)

# Separate the product code and product number into separate columns i.e. add two 
# new columns called product_code and product_number, containing the product code and number respectively

A <- separate(A, Product.code...number, c("product_code", "product_number"))
              
# 3: Add product categories
# You learn that the product codes actually represent the following product categories:
# p = Smartphone
# v = TV
# x = Laptop
# q = Tablet
# In order to make the data more readable, add a column with the product category for each record.

A$productCategory <- A$product_code %>% 
  + recode(p = "Smartphone", v = "TV", x = "Laptop", q = "Tablet")

# Change addresses to be in a form that can be easily geocoded. 
# Create a new column full_address that concatenates the 
# three address fields (address, city, country), separated by commas.
A <- unite(A, full_address, address, city, country, sep=", ", remove = TRUE)

# Add four binary (1 or 0) columns for company: 
# company_philips, company_akzo, company_van_houten and company_unilever
A <- mutate(A, company_philips = ifelse(company =="philips", 1, 0)) 
  A <- mutate(A, company_akzo = ifelse(company =="akzo", 1, 0))
  A <- mutate(A, company_van_houten = ifelse(company =="van houten", 1, 0)) 
  A <- mutate(A, company_unilever = ifelse(company =="unilever", 1, 0))

#  Add four binary (1 or 0) columns for product category: 
# product_smartphone, product_tv, product_laptop and product_tablet
  A <- mutate(A, product_smartphone = ifelse(productCategory =="Smartphone", 1, 0)) 
  A <- mutate(A, product_tv = ifelse(productCategory =="TV", 1, 0))
  A <- mutate(A, product_laptop = ifelse(productCategory =="Laptop", 1, 0)) 
  A <- mutate(A, product_tablet = ifelse(productCategory =="Tablet", 1, 0))
  
  # Safe new table to file refine_Clean.csv
 
   write.csv(A, "refine_Clean.csv")

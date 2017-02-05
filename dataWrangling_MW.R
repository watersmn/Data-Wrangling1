
rm(list=ls())
library(dplyr)
library(tidyr)
wDir <- '/home/goran/Work/_DataScienceActual/Springboard/MingWaters/'
setwd(wDir)

dataSet <- read.csv('refine_orginal.csv',
                    header = T,
                    check.names = F,
                    stringsAsFactors = F)

dataSet$company
dataSet$company <- gsub("^(ph|Ph)[[:alpha:]]+$", "Philips", dataSet$company)

# Step 2:

dataSet <- dataSet %>% 
  separate(`Product code / number`, 
           into = c("product_code", "product_number"), 
           sep = "-")

# 3: Add product categories
# You learn that the product codes actually represent the following product categories:
# p = Smartphone
# v = TV
# x = Laptop
# q = Tablet
# In order to make the data more readable, add a column with the product category for each record.

dataSet$productCategory <- dataSet$product_code %>% 
  recode(p = 'Smartphone',
         v = 'TV',
         x = 'Laptop',
         q = 'Tablet')
  





# Data Wrangling Exercise 1 - Basic Data Manipulation
library(tidyr)
library(dplyr)

#-----------------------------------------------
# 0: Load the data in RStudio.
#-----------------------------------------------
path_in <- file.path("Data", "refine_original.csv")
refine <- read.csv(path_in, stringsAsFactors=FALSE)

#Explore dataset.
#class(refine)       # verify data.frame
#dim(refine)         # check size
#names(refine)       # column names
#str(refine)         # structure
#glimpse(refine)     # structure
#summary(refine)     # summary of data
#head(refine, n=10)  # top of data
#tail(refine, n=10)  # bottom of data
#View(refine)        # examine in data viewer

#-----------------------------------------------
# 1: Clean up brand names.
#-----------------------------------------------
refine$company <- sub("^ph.*|^f.*", "philips",    refine$company, ignore.case=TRUE)
refine$company <- sub("^a.*[o0]$",  "akzo",       refine$company, ignore.case=TRUE)
refine$company <- sub("^van.*n$",   "van houten", refine$company, ignore.case=TRUE)
refine$company <- sub("^un.*ver$",  "unilever",   refine$company, ignore.case=TRUE)

#-----------------------------------------------
# 2: Separate product code and number.
#-----------------------------------------------
refine <- refine %>%
  separate("Product.code...number", c("product_code", "product_number"), sep="-")

#-----------------------------------------------
# 3: Add product categories.
#-----------------------------------------------
for (i in 1:nrow(refine)) {
  refine$product_category[i] = case_when(
    refine$product_code[i] == "p" ~ "Smartphone",
    refine$product_code[i] == "v" ~ "TV",
    refine$product_code[i] == "x" ~ "Laptop",
    refine$product_code[i] == "q" ~ "Tablet",
    TRUE ~ "NA"
  ) 
}

#-----------------------------------------------
# 4: Add full address for geocoding.
#-----------------------------------------------
refine <- refine %>%
  unite("full_address", "address", "city", "country", sep=",", remove=FALSE)

#-----------------------------------------------
# 5: Create dummy variables for company and product category.
#-----------------------------------------------
# Dynamically created company_{name} binary variable.
#   1 = observation contains this company name, 0 o.w.
for (item in unique(refine$company)) {
  # Create temporary column for new company_{name} variable and populate elements.
  temp_col<-rep(NA, nrow(refine))
  for (obs in 1:nrow(refine)) {
    temp_col[obs] <- if(refine$company[obs] == item) 1 else 0
  }
  # Attach data to data frame and rename variable.
  refine$temp_col <- temp_col
  names(refine)[length(names(refine))] <- paste("company_", sub("\\s", "_", item), sep="")
}

# Dynamically created product_{name} binary variable
#   1 = observation contains this product name, 0 o.w.
for (item in unique(refine$product_category)) {
  # Create temporary column for new product{name} variable and populate elements.
  temp_col<-rep(NA, nrow(refine))
  for (obs in 1:nrow(refine)) {
    temp_col[obs] <- if(refine$product_category[obs] == item) 1 else 0
  }
  # Attach data to data frame and rename variable.
  refine$temp_col <- temp_col
  names(refine)[length(names(refine))] <- paste("product_", sub("\\s", "_", tolower(item)), sep="")
}

#-----------------------------------------------
# 6: Submit the project on Github.
#-----------------------------------------------
path_out <- file.path("Data", "refine_clean.csv")
write.csv(refine, path_out, na = "NA")

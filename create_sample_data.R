# Libraries
library(tidyverse)
library(haven)

# Main data ---------------------------------------------------------------

# Set a seed for reproducibility
set.seed(20220504)

# Load the original data (.sav file)
df.paper3 <- read_spss("data/B2677_Barker_25Nov2021.sav")

# Convert to tibble
df.paper3 <- as_tibble(df.paper3)

# Shuffle the rows
df.paper3 <- df.paper3 %>%
  mutate(
    across(everything(), sample)
  ) %>% 
  arrange(cidB2677)

# Save the data (as .spss)
write_sav(df.paper3, "data/shuffled data.sav")


# Child genetic data ------------------------------------------------------

# Set a seed for reproducibility
set.seed(20220504)

# Load the original data (.sav file)
df.pgrChild <- read_csv("data/ALSPAC_PRS_Ted_corr.csv")

# Convert to tibble
df.pgrChild <- as_tibble(df.pgrChild)

# Shuffle the rows
df.pgrChild <- df.pgrChild %>%
  mutate(
    across(everything(), sample)
  ) %>% 
  arrange(cidB2677)

# Save the data (as .spss)
write_csv(df.pgrChild, "data/shuffled data pgrChild.csv")

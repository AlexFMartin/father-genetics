# Libraries
library(tidyverse)
library(haven)

# Child genetic data ------------------------------------------------------

# Set a seed for reproducibility
set.seed(20220504)

# Load the original data (.sav file)
df.pgrChild <- read_csv("data/ALSPAC_PRS_Ted_corr.csv")

# Convert to tibble
df.pgrChild <- as_tibble(df.pgrChild)

# Shuffle the columns
df.pgrChild <- df.pgrChild %>%
  mutate(
    across(everything(), sample)
  ) %>% 
  arrange(cidB2677)

# Save the data (as .spss)
write_csv(df.pgrChild, "data/shuffled data pgrChild.csv")


# Father genetic data ------------------------------------------------------

# Set a seed for reproducibility
set.seed(20220509)

# Load the original data (.sav file)
df.pgrFather <- read_csv("data/ALSPAC_PRS_Ted_corr.csv")

# Convert to tibble
df.pgrFather <- as_tibble(df.pgrFather)

# Shuffle the columns
df.pgrFather <- df.pgrFather %>%
  mutate(
    across(everything(), sample)
  ) %>% 
  arrange(cidB2677)

# Save the data (as .spss)
write_csv(df.pgrFather, "data/shuffled data pgrFather.csv")

# Mother genetic data ------------------------------------------------------

# Set a seed for reproducibility
set.seed(20220508)

# Load the original data (.sav file)
df.pgrMother <- read_csv("data/ALSPAC_PRS_Ted_corr.csv")

# Convert to tibble
df.pgrMother <- as_tibble(df.pgrMother)

# Shuffle the columns
df.pgrMother <- df.pgrMother %>%
  mutate(
    across(everything(), sample)
  ) %>% 
  arrange(cidB2677)

# Save the data (as .spss)
write_csv(df.pgrMother, "data/shuffled data pgrMother.csv")

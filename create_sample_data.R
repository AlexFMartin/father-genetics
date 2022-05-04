# Libraries
library(tidyverse)

# Set a seed for reproducibility
set.seed(20220504)

# Load the original data (.sav file)

# Convert to tibble

# Shuffle the rows
tibble(
  x = 1:5,
  y = 1:5,
  z = 1:5
) %>% 
  mutate(
    across(everything(), sample)
  ) %>% 
  arrange(x)

# Save the data (as .sav)

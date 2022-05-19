# Work out whether PROscorerTools::scoreScale accounts for missing values
library(tidyverse)
library(PROscorerTools)

df <- tribble(
  ~name, ~q1, ~q2, ~q3,
  'Matt', 5, 5, NA_integer_,
  'Alex', 5, 5, 5,
  'Ted', 1, NA_integer_, 7
)


scoreScale(df, items = 2:4, okmiss = 1/2, type = 'sum')

# Yes, it does.

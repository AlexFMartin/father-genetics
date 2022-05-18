# Tidy lavaan table
library(tidyverse)

df <- tibble(
  x = runif(100),
  y = rnorm(100),
  z = x * y + rnorm(100, mean = .1)
) %>%
  mutate(across(everything(), ~ round(., 3)))

models <- tribble(
  ~ model,
  'z ~ x',
  'z ~ y',
  'z ~ x + y'
)

models %>% 
  mutate(
    fit = map(model, ~ sem(., data = df, missing = 'FIML') %>% broom::tidy())
  ) %>% 
  unnest(fit)

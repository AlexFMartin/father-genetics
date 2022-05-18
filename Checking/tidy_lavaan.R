# Tidy lavaan table
library(tidyverse)
library(broom)

df <- tibble(
  x = runif(100),
  y = rnorm(100),
  z = x * y + rnorm(100, mean = .1),
  a = runif(100)
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
    fit = map(model, ~ sem(., data = df, missing = 'FIML')),
    tidy = map(fit, ~ tidy(.) %>% .[1, ]),  # only keep first row
    # tidy = map(fit, tidy),  # keep all results
    glance = map(fit, glance)
  ) %>% 
  select(-fit) %>%
  unnest(cols = c(tidy, glance))

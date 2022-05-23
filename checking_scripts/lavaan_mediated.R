# Lavaan mediation

library(tidyverse)
library(broom)

df <- tibble(
  id = factor(1:100),
  control1 = runif(100),
  control2 = runif(100),
  pred1 = rnorm(100),
  mediator = rnorm(100, sd = 0.1) + pred1 * .6,
  outcome = rnorm(100, sd = 0.1) + 
    pred1 * .2 +  # direct effect 
    mediator * .3 +  # mediated effect 
    control1 * .3
)


models <- tribble(
  ~ model,
  'outcome ~ pred1 + control1 + control2',  # combined
  'outcome ~ pred1 + mediator + control1 + control2'  # mediated
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

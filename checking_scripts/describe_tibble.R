# Summarise means and CIs of vars in a tibble
library(tidyverse)

df <- tibble(
  x = runif(100),
  y = rnorm(100),
  z = x * y + rnorm(100, mean = .1)
) %>%
  mutate(across(everything(), ~ round(., 3)))

head(df)

df %>% 
  select(x, y, z) %>%
  summarise(
    across(everything(), .fns = list(
      mean = ~ mean(., na.rm = T),
      sd = ~ sd(., na.rm = T),
      confint.low = ~ mean_cl_normal(., na.rm = T)$ymin,
      confint.high = ~ mean_cl_normal(., na.rm = T)$ymax
    ))
  ) %>%
  pivot_longer(
    everything(), 
    names_to = c("var", ".value"), 
    names_pattern = "(.+)_(.+)"
  )
  

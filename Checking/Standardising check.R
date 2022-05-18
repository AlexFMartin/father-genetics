# Test whether standardised is doing what we think it is
df <- data.frame(
  x = rnorm(10000, 7, 2),
  y = rnorm(10000, 0, 1)
)

df.std <- scale(df)
df.std2 <- scale(df.std)
round(head(df), 3)
round(head(df.std), 3)
round(head(df.std2), 3)
library(ggplot2)

load("../data/great.council.families.date.rda")

ggplot(great.council.families.date, aes(x=Start)) +
  geom_histogram(binwidth=1, fill="blue", color="black") +
  labs(title="Great Council Families Dates", x="Date", y="Count") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5))

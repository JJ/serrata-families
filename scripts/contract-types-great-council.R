library(dplyr)
library(ggplot2)

load("data/great.council.families.rda")
load("data/contract.data.families.rda")

contract.data.families$great.council <- contract.data.families$Family %in% great.council.families

print(contract.data.families[ contract.data.families$great.council == FALSE & contract.data.families$Role == "both", ])

ggplot( contract.data.families, aes(x=Role, y=Last.Year, shape=great.council, size=Total.Contracts)) +
  geom_jitter(aes(color=great.council)) +
  labs(title="Great Council Families in Contracts", x="Family", y="Year of last contract")

ggplot( contract.data.families, aes(x=Last.Year,y=Total.Contracts, shape=great.council,color=Role)) +
  geom_point(size=3,alpha=0.7) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  labs(title="Great Council Families in Contracts", x="Year of last contract", y="Total contracts")

ggplot( contract.data.families, aes(x=Role, y=Total.Contracts)) +
  geom_jitter(aes(shape=great.council)) + geom_boxplot() +
  labs(title="Great Council Families in Contracts", x="Role", y="Number of contracts") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

significant.differences.both.stan <- wilcox.test( contract.data.families[ contract.data.families$Role == "both", ]$Total.Contracts,
                                        contract.data.families[ contract.data.families$Role == "stan", ]$Total.Contracts, alternative="greater" )

significant.differences.both.tractor <- wilcox.test( contract.data.families[ contract.data.families$Role == "both", ]$Total.Contracts,
                                                  contract.data.families[ contract.data.families$Role == "tractor", ]$Total.Contracts, alternative="greater" )

significant.differences.tractor.stan <- wilcox.test( contract.data.families[ contract.data.families$Role == "tractor", ]$Total.Contracts,
                                                  contract.data.families[ contract.data.families$Role == "stan", ]$Total.Contracts )

ggplot( contract.data.families, aes(x=Role, y=Last.Year)) +
  geom_jitter(aes(shape=great.council)) + geom_boxplot(notch=T) +
  labs(title="Year of last contract", x="Role", y="Year") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

significant.differences.last.year.tractor.stan <- wilcox.test( contract.data.families[ contract.data.families$Role == "tractor", ]$Last.Year,
                                                  contract.data.families[ contract.data.families$Role == "stan", ]$Last.Year )

ggplot( contract.data.families, aes(x=great.council, y=Last.Year)) +
  geom_jitter(aes(shape=Role)) + geom_boxplot(notch=T) +
  labs(title="Great Council Families in Contracts", x="Great Council", y="Last year of contract") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

significant.differences.last.year.great.council <- wilcox.test( contract.data.families[ contract.data.families$great.council == TRUE, ]$Last.Year,
                                                  contract.data.families[ contract.data.families$great.council == FALSE, ]$Last.Year, alternative="greater" )

ggplot( contract.data.families, aes(x=great.council, y=Total.Contracts)) +
  geom_jitter(aes(shape=Role,color=Last.Year)) + geom_boxplot(notch=T) +
  labs(title="Great Council Families in Contracts", x="Great Council", y="Total number of contracts") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))


contract.data.families$great.council <- as.factor(contract.data.families$great.council)
contract.data.families$Role <- as.factor(contract.data.families$Role)

year.model <- lm( Last.Year ~ great.council + Role, data=contract.data.families)
summary(year.model)

contracts.model <- lm(Total.Contracts ~ great.council + Role , data=contract.data.families)
summary(contracts.model)

year.contracts.model <- lm( Total.Contracts ~  Last.Year  + Role, data=contract.data.families)
summary(year.contracts.model)

contracts.year.model <- lm( Last.Year ~ Total.Contracts + Role, data=contract.data.families)
summary(contracts.year.model)

ggplot( contract.data.families[contract.data.families$Total.Contracts > 1,], aes(x=Total.Contracts, y=Last.Year, color=Role)) +
  geom_point() + geom_smooth(method="lm") +
  labs(title="Year of last contract depending on role", x="Total Contracts", y="Year of last contract") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

ggplot( contract.data.families, aes(x=Total.Contracts, y=Span.Years, color=Role)) +
  geom_point() + geom_smooth(method="lm") +
  labs(title="Year of last contract depending on role", x="Total Contracts", y="Span.Years") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

ggplot( contract.data.families, aes(x=Role, y=Span.Years)) +
  geom_jitter(aes(shape=great.council)) + geom_boxplot() +
  labs(title="Contracts span per years", x="Role", y="Span Years") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

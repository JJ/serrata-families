library(dplyr)
library(ggplot2)


load("data/great.council.families.rda")
load("data/contract.data.families.rda")

contract.data.families$great.council <- contract.data.families$Family %in% great.council.families

print(contract.data.families[ contract.data.families$great.council == FALSE & contract.data.families$Role == "both", ])

ggplot( contract.data.families, aes(x=Role, y=Last.Year, shape=great.council, size=Total.Contracts)) +
  geom_jitter(aes(color=great.council)) +
  labs(title="Great Council Families in Contracts", x="Family", y="Count")

ggplot( contract.data.families, aes(x=Last.Year,y=Total.Contracts, shape=great.council,color=Role)) +
  geom_point(size=3,alpha=0.7) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  labs(title="Great Council Families in Contracts", x="Year", y="Count")

ggplot( contract.data.families, aes(x=Role, y=Total.Contracts)) +
  geom_jitter(aes(shape=great.council)) + geom_boxplot() +
  labs(title="Great Council Families in Contracts", x="Role", y="Count") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

ggplot( contract.data.families, aes(x=Role, y=Last.Year)) +
  geom_jitter(aes(shape=great.council)) + geom_boxplot(notch=T) +
  labs(title="Great Council Families in Contracts", x="Role", y="Count") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

ggplot( contract.data.families, aes(x=great.council, y=Last.Year)) +
  geom_jitter(aes(shape=Role)) + geom_boxplot(notch=T) +
  labs(title="Great Council Families in Contracts", x="Great Council", y="Count") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

ggplot( contract.data.families, aes(x=great.council, y=Total.Contracts)) +
  geom_jitter(aes(shape=Role,color=Last.Year)) + geom_boxplot(notch=T) +
  labs(title="Great Council Families in Contracts", x="Great Council", y="Count") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))


contract.data.families$great.council <- as.factor(contract.data.families$great.council)
contract.data.families$Role <- as.factor(contract.data.families$Role)

year.model <- lm( great.council ~ Last.Year + Role, data=contract.data.families)
summary(year.model)

contracts.model <- lm( great.council ~ Total.Contracts + Role , data=contract.data.families)
summary(contracts.model)

year.contracts.model <- lm( great.council ~ Last.Year + Total.Contracts + Role, data=contract.data.families)
summary(year.contracts.model)

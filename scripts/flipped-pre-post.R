
family.flips.pre <- read.csv("../data-raw/contract-family-flips-pre.csv",header=T)
family.flips.post <- read.csv("../data-raw/contract-family-flips-post.csv",header=T)

flipped.families.pre <- family.flips.pre[ family.flips.pre$Flips > 0,]$Family
flipped.families.post <- family.flips.post[ family.flips.post$Flips > 0,]$Family

flipped.only.post <- flipped.families.post[ !flipped.families.post %in% flipped.families.pre ]

# find families that are both in pre and in post
#
flipped.both <- flipped.families.post[ flipped.families.post %in% flipped.families.pre ]

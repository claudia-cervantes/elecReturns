dd <- "/home/eric/Desktop/MXelsCalendGovt/elecReturns/"
setwd(dd)

dat <- read.csv(file = "aymu1977-present.csv", stringsAsFactors = FALSE)

colnames(dat)

sel <- which(dat$pan>0 & dat$l01 == "pan")
length (sel)
dat.tmp <- dat[sel,] # subset
sel2 <- which(dat.tmp$pan==dat.tmp$v01)
length (sel2)
dat.tmp$pan[sel2] <- 0
dat[sel,] <- dat.tmp

write.csv(dat, file = "aymu1977-present.csv", row.names = FALSE)

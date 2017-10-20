dd <- "/home/eric/Desktop/MXelsCalendGovt/elecReturns/"
setwd(dd)

dat <- read.csv(file = "aymu1977-present.csv", stringsAsFactors = FALSE)

colnames(dat)

sel <- which(dat$oth3a>0)
length (sel)
dat.tmp <- dat[sel,] # subset

sel2 <- which(dat.tmp$alab == dat.tmp$l01)
dat.tmp[sel2, c("oth3a","alab","oth3b","blab","oth4on")] <- 0
sel2 <- which(dat.tmp$alab == dat.tmp$l02)
dat.tmp[sel2, c("oth3a","alab","oth3b","blab","oth4on")] <- 0
sel2 <- which(dat.tmp$alab == dat.tmp$l03)
dat.tmp[sel2, c("oth3a","alab","oth3b","blab","oth4on")] <- 0
sel2 <- which(dat.tmp$alab == dat.tmp$l04)
dat.tmp[sel2, c("oth3a","alab","oth3b","blab","oth4on")] <- 0
sel2 <- which(dat.tmp$alab == dat.tmp$l05)
dat.tmp[sel2, c("oth3a","alab","oth3b","blab","oth4on")] <- 0
sel2 <- which(dat.tmp$alab == dat.tmp$l06)
dat.tmp[sel2, c("oth3a","alab","oth3b","blab","oth4on")] <- 0
sel2 <- which(dat.tmp$alab == dat.tmp$l07)
dat.tmp[sel2, c("oth3a","alab","oth3b","blab","oth4on")] <- 0
sel2 <- which(dat.tmp$alab == dat.tmp$l08)
dat.tmp[sel2, c("oth3a","alab","oth3b","blab","oth4on")] <- 0
sel2 <- which(dat.tmp$alab == dat.tmp$l09)
dat.tmp[sel2, c("oth3a","alab","oth3b","blab","oth4on")] <- 0
sel2 <- which(dat.tmp$alab == dat.tmp$l10)
dat.tmp[sel2, c("oth3a","alab","oth3b","blab","oth4on")] <- 0
sel2 <- which(dat.tmp$alab == dat.tmp$l11)
dat.tmp[sel2, c("oth3a","alab","oth3b","blab","oth4on")] <- 0
sel2 <- which(dat.tmp$alab == dat.tmp$l12)
dat.tmp[sel2, c("oth3a","alab","oth3b","blab","oth4on")] <- 0
sel2 <- which(dat.tmp$alab == dat.tmp$l13)
dat.tmp[sel2, c("oth3a","alab","oth3b","blab","oth4on")] <- 0
sel2 <- which(dat.tmp$alab == dat.tmp$l14)
dat.tmp[sel2, c("oth3a","alab","oth3b","blab","oth4on")] <- 0
sel2 <- which(dat.tmp$alab == dat.tmp$l15)
dat.tmp[sel2, c("oth3a","alab","oth3b","blab","oth4on")] <- 0
sel2 <- which(dat.tmp$alab == dat.tmp$l16)
dat.tmp[sel2, c("oth3a","alab","oth3b","blab","oth4on")] <- 0
sel2 <- which(dat.tmp$alab == dat.tmp$l17)
dat.tmp[sel2, c("oth3a","alab","oth3b","blab","oth4on")] <- 0
sel2 <- which(dat.tmp$alab == dat.tmp$l18)
dat.tmp[sel2, c("oth3a","alab","oth3b","blab","oth4on")] <- 0

dat[sel,] <- dat.tmp


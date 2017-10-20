dd <- "/home/eric/Desktop/MXelsCalendGovt/elecReturns/"
setwd(dd)

dat <- read.csv(file = "aymu1977-present.csv", stringsAsFactors = FALSE)

colnames(dat)

# re-compute effective and total votes
sel <- grep("^v[0-9]{2}", colnames(dat))
v <- dat[,sel] # subset votes columns
head(v)
colSums(v)
v$efec <- round(rowSums(v), 0)
dat$efec <- v$efec
v$tot <- dat$efec + dat$nr + dat$nulos
dat$tot <- v$tot
rm(v)

## # datos faltantes y si tengo votos brutos
## col2012 no
## cua2013 sí por seccion
## dgo2013 sí pdf seccion
## oax2013 no
## pue2013 sí por seccion
## que2012 no
## qui2013 no
## san2012 no
## sin2013 no
## son2012 no
## tab2012 no
## tam2013 no
## tla2013 no
## ver2013 no
## zac2013 no

write.csv(dat, file = "aymu1977-present.csv", row.names = FALSE)

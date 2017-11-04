rm(list = ls())

dd <- "/home/eric/Desktop/MXelsCalendGovt/elecReturns/"
setwd(dd)

# read raw data file
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

## # julio: lista de datos faltantes y si tengo votos brutos que falta sistematizar.
## #        [4nov2017] No veo esfuerzo alguno de parte tuya...
## col2012 no
## dgo2013 no
## oax2013 no
## que2012 no
## qui2013 no
## san2012 no
## sin2013 no
## son2012 no
## tab2012 no
## tam2013 no
## tla2013 no
## ver2013 no


#####################################################
#####################################################
# identify coalition by searching for "-" in labels #
#####################################################
#####################################################
sel <- grep("^l[0-9]{2}", colnames(dat))
l <- dat[,sel] # subset label columns
sel <- grep("^v[0-9]{2}", colnames(dat))
v <- dat[,sel] # subset votes columns

ln1 <- v # duplicate votes
ln1[] <- 0 # will receive lengths
ln2 <- ln1 # duplicate
# replace each label with its character length
for (i in 1:ncol(ln1)){
    #i <- 18 # debug
    tmp <- l[,i] # pick ith column as vector
    ln1[,i] <- nchar(tmp) # replace items with num characters
}

# drop hyphens to count character difference
l.tmp <- l # duplicate
for (i in 1:ncol(l.tmp)){
    #i <- 1 # debug
    l.tmp[,i] <- gsub("-", "", l.tmp[,i]) # remove hyphens to count char dif
    ln2[,i] <- nchar(l.tmp[,i]) # replace items with num characters
}

npInCoal <- ln1 - ln2 + 1 # 1 means no coalition, single party
rm(i, ln1, ln2, l.tmp, sel, tmp)
ls()



write.csv(dat, file = "aymu1977-present.csv", row.names = FALSE)

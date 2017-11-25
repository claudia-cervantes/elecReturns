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
v[is.na(v)==TRUE] <- 0 # replace NAs with zeroes
colSums(v)
v$efec <- round(rowSums(v), 0)
dat$efec <- v$efec
v$tot <- dat$efec + dat$nr + dat$nulos
dat$tot <- v$tot
rm(v)

## # julio: lista de datos faltantes y si tengo votos brutos que falta sistematizar.
## #        [4nov2017] No veo esfuerzo alguno de parte tuya...
## tla2013 buscar voz y voto
## ver2013 pdf difícil

# Reduce columnas de san2012aymu.csv
setwd("~/Downloads")
d <- read.csv("san2012aymu.csv", stringsAsFactors = FALSE)
head(d)
sel1 <- grep("^v[0-9]+", colnames(d))
colnames(d)[sel1]
v <- d[,sel1]    # extract vote columns
v[is.na(v)] <- 0 # change NAs with 0
head(v)
d[,sel1] <- v    # return to data
check <- rowSums(v) # to verify all went well

# select pair of columns to manipulate here
v.left <-  d$v23; l.left  <- d$l23
v.right <- d$v24; l.right <- d$l24
sel <-  which(v.left==0); sel
sel1 <- which(v.right>0 & v.left==0); sel1
if (length(sel1)>0) {
    v.left[sel1] <- v.right[sel1]; v.right[sel1] <- 0
    l.left[sel1] <- l.right[sel1]; l.right[sel1] <- "0"
    d$v23 <- v.left;  d$l23 <- l.left
    d$v24 <- v.right; d$l24 <- l.right
}
# select pair of columns to manipulate here
v.left <-  d$v22; l.left  <- d$l22
v.right <- d$v24; l.right <- d$l24
sel <-  which(v.left==0); sel
sel1 <- which(v.right>0 & v.left==0); sel1
if (length(sel1)>0) {
    v.left[sel1] <- v.right[sel1]; v.right[sel1] <- 0
    l.left[sel1] <- l.right[sel1]; l.right[sel1] <- "0"
    d$v22 <- v.left;  d$l22 <- l.left
    d$v24 <- v.right; d$l24 <- l.right
}
d$v24
d$v24 <- d$l24 <- NULL

# select pair of columns to manipulate here
v.left <-  d$v22; l.left  <- d$l22
v.right <- d$v23; l.right <- d$l23
sel <-  which(v.left==0); sel
sel1 <- which(v.right>0 & v.left==0); sel1
if (length(sel1)>0) {
    v.left[sel1] <- v.right[sel1]; v.right[sel1] <- 0
    l.left[sel1] <- l.right[sel1]; l.right[sel1] <- "0"
    d$v22 <- v.left;  d$l22 <- l.left
    d$v23 <- v.right; d$l23 <- l.right
}
# select pair of columns to manipulate here
v.left <-  d$v21; l.left  <- d$l21
v.right <- d$v23; l.right <- d$l23
sel <-  which(v.left==0); sel
sel1 <- which(v.right>0 & v.left==0); sel1
if (length(sel1)>0) {
    v.left[sel1] <- v.right[sel1]; v.right[sel1] <- 0
    l.left[sel1] <- l.right[sel1]; l.right[sel1] <- "0"
    d$v21 <- v.left;  d$l21 <- l.left
    d$v23 <- v.right; d$l23 <- l.right
}
d$v23
d$v23 <- d$l23 <- NULL

# select pair of columns to manipulate here
v.left <-  d$v21; l.left  <- d$l21
v.right <- d$v22; l.right <- d$l22
sel <-  which(v.left==0); sel
sel1 <- which(v.right>0 & v.left==0); sel1
if (length(sel1)>0) {
    v.left[sel1] <- v.right[sel1]; v.right[sel1] <- 0
    l.left[sel1] <- l.right[sel1]; l.right[sel1] <- "0"
    d$v21 <- v.left;  d$l21 <- l.left
    d$v22 <- v.right; d$l22 <- l.right
}
# select pair of columns to manipulate here
v.left <-  d$v20; l.left  <- d$l20
v.right <- d$v22; l.right <- d$l22
sel <-  which(v.left==0); sel
sel1 <- which(v.right>0 & v.left==0); sel1
if (length(sel1)>0) {
    v.left[sel1] <- v.right[sel1]; v.right[sel1] <- 0
    l.left[sel1] <- l.right[sel1]; l.right[sel1] <- "0"
    d$v20 <- v.left;  d$l20 <- l.left
    d$v22 <- v.right; d$l22 <- l.right
}
d$v22
d$v22 <- d$l22 <- NULL

# select pair of columns to manipulate here
v.left <-  d$v20; l.left  <- d$l20
v.right <- d$v21; l.right <- d$l21
sel <-  which(v.left==0); sel
sel1 <- which(v.right>0 & v.left==0); sel1
if (length(sel1)>0) {
    v.left[sel1] <- v.right[sel1]; v.right[sel1] <- 0
    l.left[sel1] <- l.right[sel1]; l.right[sel1] <- "0"
    d$v20 <- v.left;  d$l20 <- l.left
    d$v21 <- v.right; d$l21 <- l.right
}
# select pair of columns to manipulate here
v.left <-  d$v19; l.left  <- d$l19
v.right <- d$v21; l.right <- d$l21
sel <-  which(v.left==0); sel
sel1 <- which(v.right>0 & v.left==0); sel1
if (length(sel1)>0) {
    v.left[sel1] <- v.right[sel1]; v.right[sel1] <- 0
    l.left[sel1] <- l.right[sel1]; l.right[sel1] <- "0"
    d$v19 <- v.left;  d$l19 <- l.left
    d$v21 <- v.right; d$l21 <- l.right
}
d$v21
d$v21 <- d$l21 <- NULL

# select pair of columns to manipulate here
v.left <-  d$v19; l.left  <- d$l19
v.right <- d$v20; l.right <- d$l20
sel <-  which(v.left==0); sel
sel1 <- which(v.right>0 & v.left==0); sel1
if (length(sel1)>0) {
    v.left[sel1] <- v.right[sel1]; v.right[sel1] <- 0
    l.left[sel1] <- l.right[sel1]; l.right[sel1] <- "0"
    d$v19 <- v.left;  d$l19 <- l.left
    d$v20 <- v.right; d$l20 <- l.right
}
# select pair of columns to manipulate here
v.left <-  d$v18; l.left  <- d$l18
v.right <- d$v20; l.right <- d$l20
sel <-  which(v.left==0); sel
sel1 <- which(v.right>0 & v.left==0); sel1
if (length(sel1)>0) {
    v.left[sel1] <- v.right[sel1]; v.right[sel1] <- 0
    l.left[sel1] <- l.right[sel1]; l.right[sel1] <- "0"
    d$v18 <- v.left;  d$l18 <- l.left
    d$v20 <- v.right; d$l20 <- l.right
}
d$v20
d$v20 <- d$l20 <- NULL

# select pair of columns to manipulate here
v.left <-  d$v18; l.left  <- d$l18
v.right <- d$v19; l.right <- d$l19
sel <-  which(v.left==0); sel
sel1 <- which(v.right>0 & v.left==0); sel1
if (length(sel1)>0) {
    v.left[sel1] <- v.right[sel1]; v.right[sel1] <- 0
    l.left[sel1] <- l.right[sel1]; l.right[sel1] <- "0"
    d$v18 <- v.left;  d$l18 <- l.left
    d$v19 <- v.right; d$l19 <- l.right
}
# select pair of columns to manipulate here
v.left <-  d$v17; l.left  <- d$l17
v.right <- d$v19; l.right <- d$l19
sel <-  which(v.left==0); sel
sel1 <- which(v.right>0 & v.left==0); sel1
if (length(sel1)>0) {
    v.left[sel1] <- v.right[sel1]; v.right[sel1] <- 0
    l.left[sel1] <- l.right[sel1]; l.right[sel1] <- "0"
    d$v17 <- v.left;  d$l17 <- l.left
    d$v19 <- v.right; d$l19 <- l.right
}
d$v19
d$v19 <- d$l19 <- NULL

# check rowsums
sel1 <- grep("^v[0-9]+", colnames(d))
colnames(d)[sel1]
v <- d[,sel1]    # extract vote columns
rowSums(v)==check # all must be true

# clean zeroes labels
sel1 <- which(d$v02==0); d$l02[sel1] <- "0"
sel1 <- which(d$v03==0); d$l03[sel1] <- "0"
sel1 <- which(d$v04==0); d$l04[sel1] <- "0"
sel1 <- which(d$v05==0); d$l05[sel1] <- "0"
sel1 <- which(d$v06==0); d$l06[sel1] <- "0"
sel1 <- which(d$v07==0); d$l07[sel1] <- "0"
sel1 <- which(d$v08==0); d$l08[sel1] <- "0"
sel1 <- which(d$v09==0); d$l09[sel1] <- "0"
sel1 <- which(d$v10==0); d$l10[sel1] <- "0"
sel1 <- which(d$v11==0); d$l11[sel1] <- "0"
sel1 <- which(d$v12==0); d$l12[sel1] <- "0"
sel1 <- which(d$v13==0); d$l13[sel1] <- "0"
sel1 <- which(d$v14==0); d$l14[sel1] <- "0"
sel1 <- which(d$v15==0); d$l15[sel1] <- "0"
sel1 <- which(d$v16==0); d$l16[sel1] <- "0"
sel1 <- which(d$v17==0); d$l17[sel1] <- "0"
sel1 <- which(d$v18==0); d$l18[sel1] <- "0"

write.csv(d, file = "san2012aymu.csv", row.names = FALSE) 

x
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

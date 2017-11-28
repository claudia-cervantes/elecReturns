rm(list = ls())

dd <- "/home/eric/Desktop/MXelsCalendGovt/elecReturns/"
setwd(dd)

# read raw data file
dat <- read.csv(file = "aymu1977-present.csv", stringsAsFactors = FALSE)

colnames(dat)
sel <- which(dat$dprep==1)
dat$status[sel]

#########################################################################
#########################################################################
##  script ayClean.r has routines used once to save a cleaner dataset  ##
#########################################################################
#########################################################################

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


# verify that coalition member separator is always a - 
sel <- grep("^l[0-9]{2}", colnames(dat))
l <- dat[,sel] # subset label columns
for (i in 1:ncol(l)){
    #i <- 18 # debug
    tmp <- l[,i] # duplicate column for manipulation
    #table(gsub(pattern = "([0-9a-zA-Záéíóúñ])", replacement = "", tmp)) # keep only non-letter-number characters
    tmp <- gsub(pattern = "[ ]", replacement = "", tmp)
    tmp <- gsub(pattern = "[.]", replacement = "-", tmp)
    #sel1 <- grep("[ ]", tmp)
    #tmp[sel1]
    l[,i] <- tmp # return to data
}
dat[,sel] <- l # return to data
rm(l)

# any votes with no labels?
sel.l <- grep("^l[0-9]{2}", colnames(dat))
l <- dat[,sel.l] # subset label columns
sel.v <- grep("^v[0-9]{2}", colnames(dat))
v <- dat[,sel.v] # subset vote columns
for (i in 1:ncol(l)){
    #i <- 2 # debug
    sel <- which(v[,i]>0 & l[,i]=="0")
    if (length(sel)>0) print(paste("Warning!!!  i=", i, sep = ""))
    print(paste("column", i , "ok"))
}
rm(l,v)

# remove useless labels
sel.l <- grep("^l[0-9]{2}", colnames(dat))
l <- dat[,sel.l] # subset label columns
sel.v <- grep("^v[0-9]{2}", colnames(dat))
v <- dat[,sel.v] # subset vote columns
for (i in 1:ncol(l)){
    #i <- 1 # debug
    sel <- which(v[,i]==0 & l[,i]!="0")
    l[sel,i] <- "0"
}
dat[,sel] <- l # return to data
rm(l,v)


#####################################################
#####################################################
# identify coalition by searching for "-" in labels #
#####################################################
#####################################################
sel.l <- grep("^l[0-9]{2}", colnames(dat))
l <- dat[,sel.l] # subset label columns
sel.v <- grep("^v[0-9]{2}", colnames(dat))
v <- dat[,sel.v] # subset vote columns
#
# dummy had at least one coalition
dat$dcoal <- 0
for (i in 1:ncol(l)){
    dat$dcoal[grep("-", l[,i])] <- 1
}

# create objects with vote for coalition(s) added and redudant columns dropped
cv <- v; cv[] <- NA # will receive votes with coalitions aggregated
cl <- l; cl[] <- NA # will keep coalition labels but drop coalition member labels 
ci <- data.frame(dcoal=dat$dcoal, ncoal=NA) # coalition summary info
ci$ncoal[ci$dcoal==0] <- 0 # 0=no coalition
  # n is object reporting how many parties reported in a v/l cell?
  ln1 <- v # duplicate votes
  ln1[] <- 0 # will receive info
  ln2 <- ln1 # duplicate
  # replace each label with its character length
  for (i in 1:ncol(ln1)){
      #i <- 16 # debug
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
  n <- ln1 - ln2 + 1 # 1 means no coalition, single party
  n[l=="0"] <- 0     # empty votes
  rm(i, ln1, ln2, l.tmp, sel, tmp)
#
max.tmp <- apply(n, 1, max) # max parties reported in a row's cell
table(max.tmp) # coal w most members has 7
I <- nrow(v)
c1 <- as.data.frame(matrix("0", I, 7), col.names = paste("p", 1:7, sep = ""), stringsAsFactors = FALSE) # will receive vector of 1st coalition's members
c2 <- as.data.frame(matrix("0", I, 7), col.names = paste("p", 1:7, sep = ""), stringsAsFactors = FALSE) # 2nd coalition's members
c3 <- as.data.frame(matrix("0", I, 7), col.names = paste("p", 1:7, sep = ""), stringsAsFactors = FALSE) # 3rd coalition's members
#
# will receive columns corresponding to coalition members in v/l for use when weighting votes contributed by each member
w1 <- as.list(rep(NA,I))
w2 <- as.list(rep(NA,I))
w3 <- as.list(rep(NA,I))
#
# fill in easy cases with no coalition
sel <- which(dat$dcoal==0)
cv[sel,] <- v[sel,]
cl[sel,] <- l[sel,]
fill c1 c2 c3 also
#
# drop it seems
work  <- which(dat$dcoal==1) # indices of cases that still need manipulation
dwork <- dat$dcoal # cases that still need manipulation
table(dwork)

tail(c1)

# fill in info selecting cases of coalitions with most members 
sel7 <- which(max.tmp>1) 
tmp.v <- v[sel7,] # subset for manipulation
tmp.l <- l[sel7,]
tmp.n <- n[sel7,]
max.tmp <- max.tmp[sel7]


head(tmp.n)
head(tmp.n)

for (i in 1:length(sel7)){
    #i <- 5 # debug
    save.col <- which(tmp.n[i,]==max.tmp[i])[1] # spare this column from erasure in process below (1st if multiple hits)
    save.label <- tmp.l[i, save.col]            # keep coalition full label
    tmp <- strsplit(save.label, split = "-") # break into component character vector
    c1[i,] <- tmp[[1]] # fill in coalition members
    #
    target.cols <- numeric() # initialize empty vector
    for (j in 1:7){
        #j <- 1 # debug
        tmp.target <- grep(pattern = c1[i,j], x = tmp.l[i,])
        if (length(tmp.target)>0) {
            target.cols <- c(target.cols, tmp.target)
        }
    }
    target.cols <- unique(target.cols); target.cols <- target.cols[order(target.cols)]
    w1[[i]] <- target.cols # for use when computing coalition members' contribution
    save.vote <- sum(tmp.v[i,target.cols])
    tmp.v[i, target.cols] <- 0   # erase votes
    tmp.l[i, target.cols] <- "0" # erase labels
    tmp.n[i, target.cols] <- 0   # erase ns
    tmp.v[i, save.col] <- save.vote  # place aggregate vote back in
    tmp.l[i, save.col] <- save.label # place coalition label back in
}

# return to data
cv[sel7,] <- tmp.v
cl[sel7,] <- tmp.l
cn[sel7,] <- tmp.n


# process cases with 2nd coalition
max.tmp <- apply(n, 1, max) # max parties reported in a row's cell
table(max.tmp) # coal w most members has 7
sel7 <- which(max.tmp>1) 
tmp.v <- v[sel7,] # subset for manipulation
tmp.l <- l[sel7,]
tmp.n <- n[sel7,]


# is there another coalition same row?
apply(tmp.n, 1, max)
sel7 <- from thing above
repeat loop





table(gsub(pattern = "([0-9a-zA-Záéíóúñ])", replacement = "", tmp)) # keep only non-letter-number characters

# select a case for experimentation
sel <- which(dat$edon==5 & dat$yr==2002)
tmp <- dat[sel,]





x
## # julio: lista de datos faltantes
## tla2013 buscar voz y voto
## ver2013 pdf difícil







write.csv(dat, file = "aymu1977-present.csv", row.names = FALSE)

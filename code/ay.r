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

# change confusing party labels
sel <- grep("^l[0-9]{2}", colnames(dat))
l <- dat[,sel] # subset labels columns
for (i in 1:ncol(l)){
    l[,i] <- gsub(pattern = "^c$|^cd$|^cdppn$|^pc$|^conver(gencia)?$", replacement = "conve", l[,i])
    l[,i] <- gsub(pattern = "-c-|-cd-|-cdppn-|-pc-|-conver(gencia)?-", replacement = "-conve-", l[,i])
    l[,i] <- gsub(pattern = "-c$|-cd$|-cdppn$|-pc$|-conver(gencia)?$", replacement = "-conve", l[,i])
    }
#
for (i in 1:ncol(l)){
    l[,i] <- gsub(pattern = "^cc$", replacement = "cc1", l[,i])
    l[,i] <- gsub(pattern = "-cc-", replacement = "-cc1-", l[,i])
    l[,i] <- gsub(pattern = "-cc$", replacement = "-cc1", l[,i])
    }
#
for (i in 1:ncol(l)){
    l[,i] <- gsub(pattern = "^mc$", replacement = "pmc", l[,i])
    l[,i] <- gsub(pattern = "-mc-", replacement = "-pmc-", l[,i])
    l[,i] <- gsub(pattern = "-mc$", replacement = "-pmc", l[,i])
    }
#
for (i in 1:ncol(l)){
    l[,i] <- gsub(pattern = "^mp$", replacement = "mexpos", l[,i])
    l[,i] <- gsub(pattern = "-mp-", replacement = "-mexpos-", l[,i])
    l[,i] <- gsub(pattern = "-mp$", replacement = "-mexpos", l[,i])
    }
#
for (i in 1:ncol(l)){
    l[,i] <- gsub(pattern = "^pd$", replacement = "pd1", l[,i])
    l[,i] <- gsub(pattern = "-pd-", replacement = "-pd1-", l[,i])
    l[,i] <- gsub(pattern = "-pd$", replacement = "-pd1", l[,i])
    }
#
for (i in 1:ncol(l)){
    l[,i] <- gsub(pattern = "^pj$", replacement = "pj1", l[,i])
    l[,i] <- gsub(pattern = "-pj-", replacement = "-pj1-", l[,i])
    l[,i] <- gsub(pattern = "-pj$", replacement = "-pj1", l[,i])
    }
#
for (i in 1:ncol(l)){
    l[,i] <- gsub(pattern = "^p?fc$|^fzaciud$|^fuerciud$", replacement = "fc1", l[,i])
    l[,i] <- gsub(pattern = "-p?fc-|-fzaciud-|-fuerciud-", replacement = "-fc1-", l[,i])
    l[,i] <- gsub(pattern = "-p?fc$|-fzaciud$|-fuerciud$", replacement = "-fc1", l[,i])
    }
#
for (i in 1:ncol(l)){
    l[,i] <- gsub(pattern = "^p?asd?c?$|^alter(nativa)?$", replacement = "pasd", l[,i])
    l[,i] <- gsub(pattern = "-p?asd?c?-|-alter(nativa)?-", replacement = "-pasd-", l[,i])
    l[,i] <- gsub(pattern = "-p?asd?c?$|-alter(nativa)?$", replacement = "-pasd", l[,i])
    l[,i] <- gsub(pattern = "^p?asd?c?-|^alter(nativa)?-", replacement = "pasd-", l[,i])
    }
#
for (i in 1:ncol(l)){
    l[,i] <- gsub(pattern = "^pl$", replacement = "pl1", l[,i])
    l[,i] <- gsub(pattern = "-pl-", replacement = "-pl1-", l[,i])
    l[,i] <- gsub(pattern = "-pl$", replacement = "-pl1", l[,i])
    }
#
for (i in 1:ncol(l)){
    l[,i] <- gsub(pattern = "^pp$", replacement = "pp1", l[,i])
    l[,i] <- gsub(pattern = "-pp-", replacement = "-pp1-", l[,i])
    l[,i] <- gsub(pattern = "-pp$", replacement = "-pp1", l[,i])
    }
#
for (i in 1:ncol(l)){
    l[,i] <- gsub(pattern = "^pr$", replacement = "pr1", l[,i])
    l[,i] <- gsub(pattern = "-pr-", replacement = "-pr1-", l[,i])
    l[,i] <- gsub(pattern = "-pr$", replacement = "-pr1", l[,i])
    }
#
for (i in 1:ncol(l)){
    l[,i] <- gsub(pattern = "^ps$", replacement = "ps1", l[,i])
    l[,i] <- gsub(pattern = "-ps-", replacement = "-ps1-", l[,i])
    l[,i] <- gsub(pattern = "-ps$", replacement = "-ps1", l[,i])
    }
#
for (i in 1:ncol(l)){
    l[,i] <- gsub(pattern = "^pt$", replacement = "pt1", l[,i])
    l[,i] <- gsub(pattern = "-pt-", replacement = "-pt1-", l[,i])
    l[,i] <- gsub(pattern = "-pt$", replacement = "-pt1", l[,i])
    l[,i] <- gsub(pattern = "^pt-", replacement = "pt1-", l[,i])
    }
#
for (i in 1:ncol(l)){
    l[,i] <- gsub(pattern = "^pac$", replacement = "pac1", l[,i])
    l[,i] <- gsub(pattern = "-pac-", replacement = "-pac1-", l[,i])
    l[,i] <- gsub(pattern = "-pac$", replacement = "-pac1", l[,i])
    l[,i] <- gsub(pattern = "^pac-", replacement = "pac1-", l[,i])
    }
#
for (i in 1:ncol(l)){
    l[,i] <- gsub(pattern = "^panal$", replacement = "pna", l[,i])
    l[,i] <- gsub(pattern = "-panal-", replacement = "-pna-", l[,i])
    l[,i] <- gsub(pattern = "-panal$", replacement = "-pna", l[,i])
    l[,i] <- gsub(pattern = "^panal-", replacement = "pna-", l[,i])
    }
#
for (i in 1:ncol(l)){
    l[,i] <- gsub(pattern = "^pbc$", replacement = "ppbc", l[,i])
    l[,i] <- gsub(pattern = "-pbc-", replacement = "-ppbc-", l[,i])
    l[,i] <- gsub(pattern = "-pbc$", replacement = "-ppbc", l[,i])
    l[,i] <- gsub(pattern = "^pbc-", replacement = "ppbc-", l[,i])
    }
#
for (i in 1:ncol(l)){
    l[,i] <- gsub(pattern = "^pcd$", replacement = "pcd1", l[,i])
    l[,i] <- gsub(pattern = "-pcd-", replacement = "-pcd1-", l[,i])
    l[,i] <- gsub(pattern = "-pcd$", replacement = "-pcd1", l[,i])
    l[,i] <- gsub(pattern = "^pcd-", replacement = "pcd1-", l[,i])
    }
#
for (i in 1:ncol(l)){
    l[,i] <- gsub(pattern = "^pcm$", replacement = "pcm1", l[,i])
    l[,i] <- gsub(pattern = "-pcm-", replacement = "-pcm1-", l[,i])
    l[,i] <- gsub(pattern = "-pcm$", replacement = "-pcm1", l[,i])
    l[,i] <- gsub(pattern = "^pcm-", replacement = "pcm1-", l[,i])
    }
#
for (i in 1:ncol(l)){
    l[,i] <- gsub(pattern = "^pds$", replacement = "pds1", l[,i])
    l[,i] <- gsub(pattern = "-pds-", replacement = "-pds1-", l[,i])
    l[,i] <- gsub(pattern = "-pds$", replacement = "-pds1", l[,i])
    l[,i] <- gsub(pattern = "^pds-", replacement = "pds1-", l[,i])
    }
#
for (i in 1:ncol(l)){
    l[,i] <- gsub(pattern = "^pfd$", replacement = "pfd1", l[,i])
    l[,i] <- gsub(pattern = "-pfd-", replacement = "-pfd1-", l[,i])
    l[,i] <- gsub(pattern = "-pfd$", replacement = "-pfd1", l[,i])
    l[,i] <- gsub(pattern = "^pfd-", replacement = "pfd1-", l[,i])
    }
#
for (i in 1:ncol(l)){
    l[,i] <- gsub(pattern = "^ppn$", replacement = "ppn1", l[,i])
    l[,i] <- gsub(pattern = "-ppn-", replacement = "-ppn1-", l[,i])
    l[,i] <- gsub(pattern = "-ppn$", replacement = "-ppn1", l[,i])
    l[,i] <- gsub(pattern = "^ppn-", replacement = "ppn1-", l[,i])
    }
#
for (i in 1:ncol(l)){
    l[,i] <- gsub(pattern = "^psd$", replacement = "psd1", l[,i])
    l[,i] <- gsub(pattern = "-psd-", replacement = "-psd1-", l[,i])
    l[,i] <- gsub(pattern = "-psd$", replacement = "-psd1", l[,i])
    l[,i] <- gsub(pattern = "^psd-", replacement = "psd1-", l[,i])
    }
#
for (i in 1:ncol(l)){
    l[,i] <- gsub(pattern = "^udc$", replacement = "pudc", l[,i])
    l[,i] <- gsub(pattern = "-udc-", replacement = "-pudc-", l[,i])
    l[,i] <- gsub(pattern = "-udc$", replacement = "-pudc", l[,i])
    l[,i] <- gsub(pattern = "^udc-", replacement = "pudc-", l[,i])
    }
#
for (i in 1:ncol(l)){
    l[,i] <- gsub(pattern = "^mrps$", replacement = "pmrps", l[,i])
    l[,i] <- gsub(pattern = "-mrps-", replacement = "-pmrps-", l[,i])
    l[,i] <- gsub(pattern = "-mrps$", replacement = "-pmrps", l[,i])
    l[,i] <- gsub(pattern = "^mrps-", replacement = "pmrps-", l[,i])
    }
#
for (i in 1:ncol(l)){
    l[,i] <- gsub(pattern = "^otro$", replacement = "otros", l[,i])
    l[,i] <- gsub(pattern = "-otro-", replacement = "-otros-", l[,i])
    l[,i] <- gsub(pattern = "-otro$", replacement = "-otros", l[,i])
    l[,i] <- gsub(pattern = "^otro-", replacement = "otros-", l[,i])
    }
#
for (i in 1:ncol(l)){
    l[,i] <- gsub(pattern = "^parme.$", replacement = "parm", l[,i])
    l[,i] <- gsub(pattern = "-parme.-", replacement = "-parm-", l[,i])
    l[,i] <- gsub(pattern = "-parme.$", replacement = "-parm", l[,i])
    l[,i] <- gsub(pattern = "^parme.-", replacement = "parm-", l[,i])
    }
#
for (i in 1:ncol(l)){
    l[,i] <- gsub(pattern = "^indep$", replacement = "indep1", l[,i])
    l[,i] <- gsub(pattern = "-indep-", replacement = "-indep1-", l[,i])
    l[,i] <- gsub(pattern = "-indep$", replacement = "-indep1", l[,i])
    l[,i] <- gsub(pattern = "^indep-", replacement = "indep1-", l[,i])
    }
#
for (i in 1:ncol(l)){
    l[,i] <- gsub(pattern = "^alianza$", replacement = "alianza1", l[,i])
    l[,i] <- gsub(pattern = "-alianza-", replacement = "-alianza1-", l[,i])
    l[,i] <- gsub(pattern = "-alianza$", replacement = "-alianza1", l[,i])
    l[,i] <- gsub(pattern = "^alianza-", replacement = "alianza1-", l[,i])
    }
#
dat[,sel] <- l # return to data
rm(l)

## # shorter pty labels included in longer ones (eg pan panal) give false positives in regexes
## # figure which and change them
## sel.l <- grep("^l[0-9]{2}", colnames(dat))
## l <- dat[,sel.l] # subset label columns
## lab.tmp <- c(t(l)) # vectorize
## lab.tmp <- lab.tmp[lab.tmp!="0"] # drop empty cells
## lab.tmp <- unique(lab.tmp)
## lab.tmp <- strsplit(lab.tmp, split = "-") # break into component character vector
## lab.tmp <- unlist(lab.tmp)
## lab.tmp <- unique(lab.tmp)
## lab.tmp <- lab.tmp[lab.tmp!="0"] # drop empty cells
## lab.tmp <- lab.tmp[order(lab.tmp)]        # sort
## lab.tmp <- lab.tmp[order(nchar(lab.tmp))] # put shorter labels first
## # verify that all labels unique
## i <- 1
## i <- i+1; grep(lab.tmp[i], lab.tmp)
## lab.tmp[grep(lab.tmp[i], lab.tmp)]
## x



######################################################
######################################################
# identify coalitions by searching for "-" in labels #
######################################################
######################################################
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
# c1 c2 c3 are pre-filled
w1[sel] <- "noCoal"
w2[sel] <- "noCoal"
w3[sel] <- "noCoal"
#

# fill in info selecting cases of coalitions with most members 
sel7 <- which(max.tmp>1) 
tmp.v <- v[sel7,] # subset for manipulation
tmp.l <- l[sel7,]
tmp.n <- n[sel7,]
max.tmp <- max.tmp[sel7]
tmp.c1 <- c1[sel7,]
tmp.w1 <- w1[sel7]

head(tmp.n)

for (i in 1:length(sel7)){
    #i <- length(sel7) # debug
    message(sprintf("loop %s of %s", i, length(sel7)))
    save.col <- which(tmp.n[i,]==max.tmp[i])[1] # spare this column from erasure in process below (1st if multiple hits)
    save.label <- tmp.l[i, save.col]            # keep coalition full label
    tmp <- strsplit(save.label, split = "-") # break into component character vector
    tmp.c1[i,1:length(tmp[[1]])] <- tmp[[1]] # fill in coalition members
    #
    target.cols <- numeric() # initialize empty vector
    for (j in 1:7){
        #j <- 1 # debug
        if (tmp.c1[i,j]=="0") next
        #pat <- paste("^", tmp.c1[i,j], "$|", tmp.c1[i,j], "-|-", tmp.c1[i,j], sep="") # searches ^pty$, pty- or -pty (avoids panal hit when searching for pan) --- unnecessary given label changes
        #tmp.target <- grep(pattern = pat, x = tmp.l[i,])
        tmp.target <- grep(pattern = tmp.c1[i,j], x = tmp.l[i,]) # version hits panal when searching pan
        if (length(tmp.target)>0) {
            target.cols <- c(target.cols, tmp.target)
        }
    }
    target.cols <- unique(target.cols); target.cols <- target.cols[order(target.cols)]
    tmp.w1[[i]] <- target.cols # for use when computing coalition members' contribution
    save.vote <- sum(tmp.v[i,target.cols])
    tmp.v[i, target.cols] <- 0   # erase votes to keep only aggregate
    tmp.l[i, target.cols] <- "0" # erase labels to keep only full coalition label
    tmp.n[i, target.cols] <- 0   # erase ns
    tmp.v[i, save.col] <- save.vote  # place aggregate vote back in
    tmp.l[i, save.col] <- save.label # place coalition label back in
}

tail(tmp.v)

# return to data
cv[sel7,] <- tmp.v
cl[sel7,] <- tmp.l
n[sel7,] <- tmp.n
c1[sel7,] <- tmp.c1
w1[sel7] <- tmp.w1

tail(w1[sel7])

####################################
# process cases with 2nd coalition #
####################################
max.tmp <- apply(n, 1, max) # max parties reported in a row's cell
table(max.tmp) # coal w most members has 7
sel7 <- which(max.tmp>1) 
tmp.v <- v[sel7,] # subset for manipulation
tmp.l <- l[sel7,]
tmp.n <- n[sel7,]
tmp.c2 <- c2[sel7,]
tmp.w2 <- w2[sel7]
max.tmp <- max.tmp[sel7]

head(tmp.n)

smthg wrong with i <- 70

for (i in 1:length(sel7)){
    #i <- 70 # debug
    #tmp.l[i,] # debug
    #tmp.n[i,] # debug
    message(sprintf("loop %s of %s", i, length(sel7)))
    save.col <- which(tmp.n[i,]==max.tmp[i])[1] # spare this column from erasure in process below (1st if multiple hits)
    save.label <- tmp.l[i, save.col]            # keep coalition full label
    tmp <- strsplit(save.label, split = "-") # break into component character vector
    tmp.c2[i,1:length(tmp[[1]])] <- tmp[[1]] # fill in coalition members
    #
    target.cols <- numeric() # initialize empty vector
    for (j in 1:7){
        #j <- 1 # debug
        if (tmp.c1[i,j]=="0") next
        #pat <- paste("^", tmp.c2[i,j], "$|", tmp.c2[i,j], "-|-", tmp.c2[i,j], sep="") # searches ^pty$, pty- or -pty (avoids panal hit when searching for pan) --- unnecessary given label changes
        #tmp.target <- grep(pattern = pat, x = tmp.l[i,])
        tmp.target <- grep(pattern = tmp.c1[i,j], x = tmp.l[i,]) # version hits panal when searching pan
        if (length(tmp.target)>0) {
            target.cols <- c(target.cols, tmp.target)
        }
    }
    target.cols <- unique(target.cols); target.cols <- target.cols[order(target.cols)]
    tmp.w2[[i]] <- target.cols # for use when computing coalition members' contribution
    save.vote <- sum(tmp.v[i,target.cols])
    tmp.v[i, target.cols] <- 0   # erase votes to keep only aggregate
    tmp.l[i, target.cols] <- "0" # erase labels to keep only full coalition label
    tmp.n[i, target.cols] <- 0   # erase ns
    tmp.v[i, save.col] <- save.vote  # place aggregate vote back in
    tmp.l[i, save.col] <- save.label # place coalition label back in
}

tail(tmp.v)

# return to data
cv[sel7,] <- tmp.v
cl[sel7,] <- tmp.l
n[sel7,] <- tmp.n
c2[sel7,] <- tmp.c2
w2[sel7] <- tmp.w2

tail(w2[sel7])
tail(sel7)

i <- 32152
l[i,]
c2[i,]

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

dd <- "/home/eric/Desktop/data/elecs/MXelsCalendGovt/elecReturns/DatosBrutos/resultCasillas/casillaRes91-on"
setwd(dd)

dat <- read.csv("dip2015.csv", stringsAsFactors = FALSE)
colnames(dat)

# fill missing with 0
tmp <- dat[,c("pan", "pri", "prd", "pvem", "pt", "mc", "panal", "morena", "ph", "ps", "pri_pvem", "prd_pt", "indep1", "indep2", "nr", "nul", "tot", "lisnom")]
tmp[tmp=="-"] <- "0" # source uses "-" (for inapplicable?)
tmp[tmp==" "] <- "0" # source uses " " 
tmp[is.na(tmp)==TRUE] <- 0
table(tmp$pri, useNA = "ifany")
tmp$pri_pvem <- as.integer(tmp$pri_pvem) # was string
tmp$prd_pt <- as.integer(tmp$prd_pt)
tmp$indep1 <- as.integer(tmp$indep1)
tmp$indep2 <- as.integer(tmp$indep2)
str(tmp)
dat[,c("pan", "pri", "prd", "pvem", "pt", "mc", "panal", "morena", "ph", "ps", "pri_pvem", "prd_pt", "indep1", "indep2", "nr", "nul", "tot", "lisnom")] <- tmp
rm(tmp)

# manipulate data to aggregate secciones from casillas
tmp <- dat
tmp$drop <- as.numeric(tmp$TIPO_CASILLA=="S"); tmp <- tmp[tmp$drop==0,] # drop casillas especiales
tmp$drop <- NULL
# así se hace en R un by yr mo: egen tmp=sum(invested) de stata
tmp$pan      <- ave(tmp$pan, as.factor(tmp$edon*10000+tmp$seccion), FUN=sum, na.rm=TRUE)
tmp$pri      <- ave(tmp$pri, as.factor(tmp$edon*10000+tmp$seccion), FUN=sum, na.rm=TRUE)
tmp$prd      <- ave(tmp$prd, as.factor(tmp$edon*10000+tmp$seccion), FUN=sum, na.rm=TRUE)
tmp$pvem     <- ave(tmp$pvem, as.factor(tmp$edon*10000+tmp$seccion), FUN=sum, na.rm=TRUE)
tmp$pt       <- ave(tmp$pt, as.factor(tmp$edon*10000+tmp$seccion), FUN=sum, na.rm=TRUE)
tmp$mc       <- ave(tmp$mc, as.factor(tmp$edon*10000+tmp$seccion), FUN=sum, na.rm=TRUE)
tmp$panal    <- ave(tmp$panal, as.factor(tmp$edon*10000+tmp$seccion), FUN=sum, na.rm=TRUE)
tmp$morena   <- ave(tmp$morena, as.factor(tmp$edon*10000+tmp$seccion), FUN=sum, na.rm=TRUE)
tmp$ph       <- ave(tmp$ph, as.factor(tmp$edon*10000+tmp$seccion), FUN=sum, na.rm=TRUE)
tmp$ps       <- ave(tmp$ps, as.factor(tmp$edon*10000+tmp$seccion), FUN=sum, na.rm=TRUE)
tmp$pri_pvem <- ave(tmp$pri_pvem, as.factor(tmp$edon*10000+tmp$seccion), FUN=sum, na.rm=TRUE)
tmp$prd_pt   <- ave(tmp$prd_pt, as.factor(tmp$edon*10000+tmp$seccion), FUN=sum, na.rm=TRUE)
tmp$indep1   <- ave(tmp$indep1, as.factor(tmp$edon*10000+tmp$seccion), FUN=sum, na.rm=TRUE)
tmp$indep2   <- ave(tmp$indep2, as.factor(tmp$edon*10000+tmp$seccion), FUN=sum, na.rm=TRUE)
tmp$nr       <- ave(tmp$nr, as.factor(tmp$edon*10000+tmp$seccion), FUN=sum, na.rm=TRUE)
tmp$nul      <- ave(tmp$nul, as.factor(tmp$edon*10000+tmp$seccion), FUN=sum, na.rm=TRUE)
tmp$tot      <- ave(tmp$tot, as.factor(tmp$edon*10000+tmp$seccion), FUN=sum, na.rm=TRUE)
tmp$lisnom   <- ave(tmp$lisnom, as.factor(tmp$edon*10000+tmp$seccion), FUN=sum, na.rm=TRUE)

tmp <- tmp[, c("edon","disn","seccion","pan","pri","prd","pvem","pt","mc","panal","morena","ph","ps","pri_pvem","prd_pt","indep1","indep2","nr","nul","tot","lisnom")]

# drop duplicated observations
tmp$drop <- tmp$edon*10000 + tmp$seccion
tmp$drop <- as.numeric(duplicated(tmp$drop))
tmp <- tmp[tmp$drop==0,]
tmp$drop <- NULL
head(tmp)

# export seccion-level data
write.csv(tmp, file = "eum2015dfseccion.csv")




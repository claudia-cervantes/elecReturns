workdir <- c("D:/01/Dropbox/data/elecs/MXelsCalendGovt/elecReturns/DatosBrutos")
setwd(workdir)

tmp <- read.csv( "tla2010aycasilla.csv" );
tmp[is.na(tmp)==TRUE] <- 0
colnames(tmp)
# as� se hace en R un by yr mo: egen tmp=sum(invested) de stata
head(tmp$Pan.panal.pac)
tmp$Pan.panal.pac  <- ave(tmp$Pan.panal.pac, as.factor(tmp$munn), FUN=sum, na.rm=TRUE)
tmp$pri  <- ave(tmp$pri, as.factor(tmp$munn), FUN=sum, na.rm=TRUE)
tmp$Pri.pvem.ps  <- ave(tmp$Pri.pvem.ps, as.factor(tmp$munn), FUN=sum, na.rm=TRUE)
tmp$Pri.ps  <- ave(tmp$Pri.ps, as.factor(tmp$munn), FUN=sum, na.rm=TRUE)
tmp$prd  <- ave(tmp$prd, as.factor(tmp$munn), FUN=sum, na.rm=TRUE)
tmp$Prd.conve  <- ave(tmp$Prd.conve, as.factor(tmp$munn), FUN=sum, na.rm=TRUE)
tmp$Prd.pt  <- ave(tmp$Prd.pt, as.factor(tmp$munn), FUN=sum, na.rm=TRUE)
tmp$Prd.pt.conve  <- ave(tmp$Prd.pt.conve, as.factor(tmp$munn), FUN=sum, na.rm=TRUE)
tmp$pt  <- ave(tmp$pt, as.factor(tmp$munn), FUN=sum, na.rm=TRUE)
tmp$Pt.conve  <- ave(tmp$Pt.conve, as.factor(tmp$munn), FUN=sum, na.rm=TRUE)
tmp$pvem  <- ave(tmp$pvem, as.factor(tmp$munn), FUN=sum, na.rm=TRUE)
tmp$conve  <- ave(tmp$conve, as.factor(tmp$munn), FUN=sum, na.rm=TRUE)
tmp$ps  <- ave(tmp$ps, as.factor(tmp$munn), FUN=sum, na.rm=TRUE)
tmp$pac  <- ave(tmp$pac, as.factor(tmp$munn), FUN=sum, na.rm=TRUE)
tmp$pp  <- ave(tmp$pp, as.factor(tmp$munn), FUN=sum, na.rm=TRUE)
tmp$plt  <- ave(tmp$plt, as.factor(tmp$munn), FUN=sum, na.rm=TRUE)
tmp$ppt  <- ave(tmp$ppt, as.factor(tmp$munn), FUN=sum, na.rm=TRUE)
tmp$nul  <- ave(tmp$nul, as.factor(tmp$munn), FUN=sum, na.rm=TRUE)

tmp <- tmp[duplicated(tmp$munnum)==FALSE,]
tmp$secn <- tmp$casilla <- tmp$tipo <- tmp$ord <- tmp$edon <- NULL

write.csv(file="tmp.csv", tmp)

tmp[,1] nul<- sub(pattern = "DTO LOCAL", replacement = "disn", tmp[,1])
tmp[,1] <- sub(pattern = "CLAVE_MPIO", replacement = "munn", tmp[,1])
tmp[,1] <- sub(pattern = "NOM_MPIO", replacement = "mun", tmp[,1])
tmp[,1] <- sub(pattern = "SECCION", replacement = "secn", tmp[,1])
tmp[,1] <- sub(pattern = "TIP_CAS", replacement = "tipo", tmp[,1])
tmp[,1] <- sub(pattern = "LISTA_NOM", replacement = "lisnom", tmp[,1])
tmp[,1] <- sub(pattern = "NULOS", replacement = "nul", tmp[,1])
tmp[,1] <- sub(pattern = "NO.REG", replacement = "nr", tmp[,1])
tmp[,1] <- sub(pattern = "TOTAL", replacement = "tot", tmp[,1])
tmp[,1] <- sub(pattern = "PAN", replacement = "pan", tmp[,1])
tmp[,1] <- sub(pattern = "PRI", replacement = "pri", tmp[,1])
tmp[,1] <- sub(pattern = "PRD", replacement = "prd", tmp[,1])
tmp[,1] <- sub(pattern = "PC", replacement = "pc", tmp[,1])
tmp[,1] <- sub(pattern = "PT", replacement = "pt", tmp[,1])
tmp[,1] <- sub(pattern = "PVEM", replacement = "pvem", tmp[,1])
tmp[,1] <- sub(pattern = "PPS", replacement = "pps", tmp[,1])
tmp[,1] <- sub(pattern = "PDM", replacement = "pdm", tmp[,1])
tmp <- tmp[,1]; tmp2 <- tmp[1:17]
drop <- grep(pattern = "RESULTADOS AYUNTAMIENTOS", tmp)
tmp <- tmp[-drop]
head(tmp)
4957*17; length(tmp); length(tmp)/17
tmp[84259:84269] <- rep("NA", times=11)
#
locs <- grep(pattern = "[A-Z]{3}", tmp) # ubica renglones con nombre de municipio, nunca missing
tmp1 <- matrix( NA, ncol=17, nrow=length(locs) )
for (i in 1:length(locs)){
    n <- locs[i]-2
    tmp1[i,] <- tmp[n:(n+16)]
}
gua <- data.frame(tmp1);
colnames(gua) <- tmp2

gua$disn <- as.numeric(as.character(gua$disn))
gua$munn <- as.numeric(as.character(gua$munn))
gua$secn <- as.numeric(as.character(gua$secn))
gua$lisnom <- as.numeric(as.character(gua$lisnom))
#
#### Estos los us� para detectar huecos en los datos
## locs <- grep(pattern = "[A-Z]{3}", gua$pan) # ubica renglones con nombre de municipio, que ahora hay que poner a missing
## locs
## locs <- grep(pattern = "[A-Z]{3}", gua$pri)
## locs
## locs <- grep(pattern = "[A-Z]{3}", gua$prd)
## locs
## locs <- grep(pattern = "[A-Z]{3}", gua$pc)
## locs
## locs <- grep(pattern = "[A-Z]{3}", gua$pt)
## locs
## locs <- grep(pattern = "[A-Z]{3}", gua$pvem)
## locs
## locs <- grep(pattern = "[A-Z]{3}", gua$pps)
## locs
## locs <- grep(pattern = "[A-Z]{3}", gua$pdm)
## locs
## locs <- grep(pattern = "[A-Z]{3}", gua$nr)
## locs
## locs <- grep(pattern = "[A-Z]{3}", gua$nul)
## locs
## locs <- grep(pattern = "[A-Z]{3}", gua$tot)
## locs
## gua[locs,]
#
gua$pan <- as.numeric(as.character(gua$pan))
gua$pri <- as.numeric(as.character(gua$pri))
gua$prd <- as.numeric(as.character(gua$prd))
gua$pc <- as.numeric(as.character(gua$pc)) ## NAs by coersion OK
gua$pt <- as.numeric(as.character(gua$pt))
gua$pvem <- as.numeric(as.character(gua$pvem))
gua$pps <- as.numeric(as.character(gua$pps))
gua$pdm <- as.numeric(as.character(gua$pdm))
gua$nr <- as.numeric(as.character(gua$nr))
gua$nul <- as.numeric(as.character(gua$nul))
gua$tot <- as.numeric(as.character(gua$tot))
#
# Corrige huecos en los datos
gua[gua$secn==1434 & gua$tipo=="ES",7:17] <- rep(0,11)
gua[gua$secn==1512 & gua$tipo=="B",7:17] <- rep(0,11)
gua[gua$secn==1718 & gua$tipo=="ES",7:17] <- rep(0,11)
gua[gua$secn==1784 & gua$tipo=="ES",7:17] <- rep(0,11)
gua[gua$secn==81 & gua$tipo=="ES",7:17] <- rep(0,11)
gua[gua$secn==310 & gua$tipo=="B",7:17] <- c(455,1021,99,0,0,19,0,4,0,0,1598)

### lo us� para buscar registros duplicados
## gua$ord <- 1:nrow(gua)
## gua <- gua[order(gua$secn, gua$tipo),]
## gua$dupli <- rep(0, times=nrow(gua))
## for (i in 2:nrow(gua)){
##     gua$dupli[i] <- ifelse(gua$secn[i]==gua$secn[i-1] & gua$tipo[i]==gua$tipo[i-1], 1, 0)
## }
## table(gua$dupli)
## gua <- gua[order(gua$ord),]
## gua[gua$dupli==1,]

gua$ord <- NULL; gua$dupli <- NULL
write.csv(gua, file = "gua1997aycasilla.csv", row.names=FALSE)

gua <- gua[order(gua$munn, gua$secn, gua$tipo),]
drop <- rep(0, nrow(gua))
for (i in 2:nrow(gua)){
    drop[i] <- ifelse(gua$munn[i]==gua$munn[i-1],1,0)
}
# as� se hace en R un by yr mo: egen tmp=sum(invested) de stata
gua$lisnom <- ave(gua$lisnom, as.factor(gua$mun), FUN=sum, na.rm=TRUE)
gua$pan <- ave(gua$pan, as.factor(gua$mun), FUN=sum, na.rm=TRUE)
gua$pri <- ave(gua$pri, as.factor(gua$mun), FUN=sum, na.rm=TRUE)
gua$prd <- ave(gua$prd, as.factor(gua$mun), FUN=sum, na.rm=TRUE)
gua$pc <- ave(gua$pc, as.factor(gua$mun), FUN=sum, na.rm=TRUE)
gua$pt <- ave(gua$pt, as.factor(gua$mun), FUN=sum, na.rm=TRUE)
gua$pvem <- ave(gua$pvem, as.factor(gua$mun), FUN=sum, na.rm=TRUE)
gua$pps <- ave(gua$pps, as.factor(gua$mun), FUN=sum, na.rm=TRUE)
gua$pdm <- ave(gua$pdm, as.factor(gua$mun), FUN=sum, na.rm=TRUE)
gua$nr <- ave(gua$nr, as.factor(gua$mun), FUN=sum, na.rm=TRUE)
gua$nul <- ave(gua$nul, as.factor(gua$mun), FUN=sum, na.rm=TRUE)
gua$tot <- ave(gua$tot, as.factor(gua$mun), FUN=sum, na.rm=TRUE)
gua <- gua[drop==0,]

gua$secn <- NULL; gua$tipo <- NULL
write.csv(gua, file = "gua1997aymu.csv", row.names=FALSE)


  ########################################################
##Using vegan package
########################################################
library(vegan)
x<-matrix(c(0,0,1,1,2,4,5,0),ncol=2)

set.seed(1234)
y<-.3*x+4+rnorm(8,0,2)
y<-y%*%matrix(c(3,-.5,-.5,3),ncol=2)
z<-1.5*x+2+rnorm(8,0,1)
z<-z%*%matrix(c(2,-.8,-.8,2),ncol=2)

plot(0,0,xlim=c(-20,20),ylim=c(0,20),col="white",main="Three shapes")
polygon(x,bor="red",cex=2,lwd=5)
polygon(y,bor="blue",cex=2,lwd=5)
polygon(z,bor="gold",cex=2,lwd=5)

proY<-procrustes(x,y)
proZ<-procrustes(x,z)
summary(proY)
plot(proY)

plot(0,0,xlim=c(-2,2),ylim=c(-5,5),col="white",main="Procrustes modified shapes using vegan::procrustes")
polygon(proY$X,bor="red",lwd=5)
polygon(proY$Yrot,bor="blue",lwd=5)
polygon(proZ$Yrot,bor="gold",lwd=5)


########################################################
##Using shapes package
########################################################
library(shapes)
greg<-array(c(proY$X,proY$Yrot,proZ$Yrot),dim=c(4,2,3))
test<-procGPA(greg)
shapepca(test,type="v",mag=3)
shapepca(test,type="r",mag=3)


plot(0,0,xlim=c(-2,2),ylim=c(-5,5),col="white",main="Procrustes modified shapes using shapes::procGPA")
polygon(test$rotated[,,1],bor="red",lwd=5)
polygon(test$rotated[,,2],bor="blue",lwd=5)
polygon(test$rotated[,,3],bor="gold",lwd=5)

########################################################
##Using shape package
########################################################
#Using Bookstein coordinates
library(shape)
bs2d<-bookstein2d(greg)
plot(0,0,xlim=c(-2,2),ylim=c(-1,1),col="white")
polygon(bs2d$mshape,lwd=10)
polygon(bs2d$bshpv[,,1],bor="red",lwd=5)
polygon(bs2d$bshpv[,,2],bor="blue",lwd=5)
polygon(bs2d$bshpv[,,3],bor="gold",lwd=5)

###########Plot maps, profiles and sections of MEOP ncdf files - E.Pauthenet April 2020 
#Data available : https://www.seanoe.org/data/00343/45461/
library(fields)
library(oce)

setwd("path")

####################Plot a map of the profiles positions
plot(lon,lat,las = 1)
maps::map(add = T,fill = T)  #add lands
grid()  #add a grey grid

####################Plot the profiles against depth
par(mfrow = c(1,2))
matplot(Temp,Pres,lty = 1,col = 1,lwd = 1,typ = 'l'
  ,ylim = c(max(prof),0) #reverse the y axis
  ,xlab = "Temperature",ylab = "Depth")
grid()
matplot(Temp,Pres,lty = 1,col = 1,lwd = 1,typ = 'l'
  ,ylim = c(max(prof),0) #reverse the y axis
  ,xlab = "Salinity",ylab = "Depth")
grid()

####################Plot the profiles in a T-S diagram (oce package)
TS.ctd = oce::as.ctd(Sal,Temp,Pres)   #Transform the data into a ctd object
oce::plotTS(TS.ctd,las = 1,typ = 'l',xlab = "Salinity",ylab = "Temperature") #plot the TS diagram, each line is a profile

####################Plot sections of T and S along number of profile
X11()                    #open a graphic window large enough
par(mfrow = c(2,1))      #create a figure panels of 2 lines and 1 columns
fields::image.plot(1:dim(Temp)[2],prof,t(Temp),las = 1,col = oce.colorsTemperature(200)
  ,ylim = c(max(prof),0) #reverse the y axis
  ,xlab = "# of profiles",ylab = "Depth",main = "Temperature")
fields::image.plot(1:dim(Sal)[2],prof,t(Sal),las = 1,col = oce.colorsSalinity(200)
  ,ylim = c(max(prof),0)
  ,xlab = "# of profiles",ylab = "Depth",main = "Salinity")


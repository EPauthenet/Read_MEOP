###########Load meop ncdf files, plot maps, profiles and sections - E.Pauthenet April 2020 
#Data available : https://www.seanoe.org/data/00343/45461/
library(fields)
library(ncdf4)
library(oce)

setwd("path")

#List the name of the ncdf files in the data folder (here France interp)
data_path = "MEOP-CTD_2018-04-10/FRANCE/DATA_ncARGO_interp/"
lf = list.files(data_path)

#Extract the variables from the n netcdf file
n = 1
ncid = ncdf4::nc_open(paste(data_path,lf[n],sep = ""))  #Get the id of the ncdf
lat = ncdf4::ncvar_get( ncid,'LATITUDE')                #Retrieve variables
lon = ncdf4::ncvar_get( ncid,'LONGITUDE')
Temp = ncdf4::ncvar_get( ncid,'TEMP_ADJUSTED')
Sal = ncdf4::ncvar_get( ncid,'PSAL_ADJUSTED')
Pres = ncdf4::ncvar_get( ncid,'PRES_ADJUSTED')
prof = Pres[,1]  #only for the interp ncdf
Ti = ncdf4::ncvar_get( ncid,'JULD_LOCATION')
Time = as.Date(Ti, origin=as.Date("1950-01-01")) #Transform time in Date format
ncdf4::nc_close(ncid)

####################Plot a map of the profiles positions
#png(paste("Map_",lf[n],".png",sep = ""), width=8,height=8, units="in", res=200)  #save figure as a png
plot(lon,lat,las = 1)
maps::map(add = T,fill = T)  #add lands
grid()  #add a grey grid
#dev.off() #Close graphic window

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


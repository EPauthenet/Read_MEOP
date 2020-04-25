###########Animate meop ncdf files - E.Pauthenet April 2020 
#Data available : https://www.seanoe.org/data/00343/45461/
library(gifski)
library(gtools)

path = "some_empty_folder"
setwd(path)

for(t in 1:length(lon)){
  png(paste(t,".png",sep = ""), width=8,height=8, units="in", res=200)  #save figure as a png
  par(mfrow = c(2,2))
  plot(lon,lat,las = 1,col = 'grey',pch = 20,main = Time[t],typ = 'l'
    ,xlim = c(min(lon)-2,max(lon)+2), ylim = c(min(lat)-2,max(lat)+2))
  points(lon,lat,pch = 20,col = 'grey',cex = 1)
  points(lon[t],lat[t],pch = 20,col = 2,cex = 1.5)
  maps::map(add = T,fill = T) 
  grid()
  #
  TS.ctd = oce::as.ctd(Sal,Temp,Pres)
  oce::plotTS(TS.ctd,las = 1,typ = 'l',xlab = "Salinity",ylab = "Temperature",col = 'grey')
  TS.ctd = oce::as.ctd(Sal[,t],Temp[,t],prof)
  oce::plotTS(TS.ctd,las = 1,typ = 'l',xlab = "Salinity",ylab = "Temperature",col = 2,lwd = 2,add = T)
  #
  plot(Temp,Pres,las = 1,typ = 'l',ylim = c(max(prof),0),xlim = range(Temp,na.rm = T),xlab = "Salinity",ylab = "Depth",col = 'grey')
  lines(Temp[,t],prof,col = 2,lwd = 2)
  grid()
  #
  plot(Sal,Pres,las = 1,typ = 'l',ylim = c(max(prof),0),xlim = range(Sal,na.rm = T),xlab = "Salinity",ylab = "Depth",col = 'grey')
  lines(Sal[,t],prof,col = 2,lwd = 2)
  grid()
  dev.off()
}

#Export in a gif
png_lf = list.files(path, pattern = ".*png$")
png_lf = gtools::mixedsort(sort(png_lf))  #sort in the right order
gifski::gifski(png_lf, gif_file = "animation.gif", width = 800, height = 800, delay = .2)
unlink(png_lf)  #Delete the png files


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

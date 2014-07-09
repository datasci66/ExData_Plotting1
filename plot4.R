## This script will create 4 plots for Feb 1 and 2, 2007, displayed in a 2x2 layout

## download file and unzip it
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "hpc.zip", method = "curl")
unzipped<-unzip("hpc.zip")
f <- file(unzipped)

## read from the file using sqlite db for Feb 1 and 2, 2007
library(sqldf)
DF <- sqldf("select * from f where Date in ('1/2/2007','2/2/2007') ", dbname = tempfile(), 
            file.format = list(sep=";",header = T, row.names = F))

## close connection to unzipped file
close(f)

## create new datetime column out of Date and Time
DF$datetime<-strptime(paste(DF$Date,DF$Time),format="%d/%m/%Y %H:%M:%S")


## create a plot of datetime and submeters 1, 2, and 3
png(file="plot4.png")

## create a 2x2 layout in which to display the plots
par(mfrow = c(2, 2), mar = c(4, 4, 4, 2),oma=c(1,0,0,0))

with(DF, {
     ## datetime and global active power
     plot(datetime,Global_active_power,type="l",ylab="Global Active Power (kilowatts)",xlab="")
     
     ##  datetime and Voltage
     plot(datetime,Voltage,type='l',ylab="Voltage",xlab="datetime")
     
     ## datetime and Submetering, with a legend
     plot(datetime,Sub_metering_1,type="l", xlab="",ylab="Energy Sub Metering")
          points(datetime,Sub_metering_2,col="red",type="l")
          points(datetime,Sub_metering_3,col="blue",type="l")
          legend("topright", bty="n", lty=1, col = c("black", "red", "blue"), 
            legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
     
     ## datetime and Global reactive power
     plot(datetime,Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power")
})

dev.off()
## This script will create a plot of DateTime and energy submetering for meters
## 1, 2, and 3, for Feb 1 and 2, 2007

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
png(file="plot3.png")

with(DF,plot(datetime,Sub_metering_1,type="l", xlab="",ylab="Energy Sub Metering"))
with(DF,points(datetime,Sub_metering_2,col="red",type="l"))
with(DF,points(datetime,Sub_metering_3,col="blue",type="l"))

legend("topright", lty=1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
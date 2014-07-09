## This script will create a plot of DateTime and Global Active Power 
## for Feb 1 and 2, 2007

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

## create a plot of datetime and Global Active Power
png(file="plot2.png")
with (DF, plot(datetime,Global_active_power,type="l",ylab="Global Active Power (kilowatts)",xlab=""))
dev.off()